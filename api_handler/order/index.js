const db = require('../../sql/db')
const uuid = require('node-uuid')
const moment = require('moment')

exports.orderConfirmHandler = (req, res) => {
    const { ownerId, orderPrice, makeTime, orderMakeTime, remark } = req.body
    const { userId: consumerId } = req.auth.user

    let products = req.body.products

    if (!ownerId) return res.output(400, '商家id不能为空')

    if (!consumerId) return res.output(400, '消费者id不能为空')

    if (ownerId === consumerId) return res.output(400, '不能给自己下单哦~')


    if (!orderMakeTime) return res.output(400, '请选择制作时间')

    if (orderMakeTime === 'time' && !makeTime) return res.output(400, '请选择预约时间')

    let makeTime_formatted = ""
    try {
        if (orderMakeTime === 'time' && makeTime) {
            const [hour, minutes] = makeTime.split(":")
            const momentObj = moment().set('hour', hour).set('minutes', minutes)
            makeTime_formatted = momentObj.format('YYYY-MM-DD HH:mm:00')
        }
    } catch (error) {
        return res.output(400, '预约时间格式错误')
    }

    if (!products || !Array.isArray(products) || !products.length) return res.output(400, '订单格式不正确')

    if (remark && remark.length > 50) return res.output(400, '备注不能超过50个字')

    // 创建uuid
    const order_id = uuid.v4().replace(/-/g, '')

    // 新建订单
    const ordersSql = `INSERT INTO orders (id, owner_id, consumer_id, order_price, make_type, make_time, remark) VALUES (?, ?, ?, ?, ?, ?, ?)`

    const orderValue = [order_id, ownerId, consumerId, orderPrice || 0, orderMakeTime, makeTime_formatted || moment().format('YYYY-MM-DD HH:mm:ss'), remark || null]

    // 新建订单商品
    const orderProductSql = `INSERT INTO order_products (product_id, product_name, product_num, product_price, order_id) VALUES (?,?,?,?,?)`

    const orderProductValues = products.map(item => {
        const [product_id, product_name, product_num, product_price] = item
        return [product_id, product_name, product_num, product_price, order_id]
    })

    const batchQueryObj = orderProductValues.map(item => {
        return {
            sql: orderProductSql,
            params: item
        }
    })

    batchQueryObj.push({
        sql: ordersSql,
        params: orderValue
    })

    db.transaction(batchQueryObj)
        .then(results => {
            res.output(200, '下单成功')
        })
        .catch(err => {
            res.output(500, err)
        })
}

exports.getProcessingOrderHandler = (req, res) => {
    const { classic } = req.body
    const { userId } = req.auth.user

    // classic 1 饭店订单; 2 个人订单;
    if (!classic) return res.output(400, '缺少订单类型参数')

    // classic为1, userId则是owner_id; classic为2, 则是consumer_id
    db.query(
        `SELECT order_status, order_price, created_time, id, remark, make_time, owner_id, consumer_id FROM orders WHERE ${classic == 1 ? 'owner_id' : 'consumer_id'} = ? AND order_status IN (1,2,3) AND is_active = 1 AND order_status in (1,2,3,4)ORDER BY created_time DESC`,
        [userId],
        (err, orders) => {

            if (err) return res.output(500, err.code)

            if (!orders.length) return res.output(200, '暂无订单', [])


            // 获取涉及到的用户列表
            const userInfoPromise = () => {
                return new Promise((resolve, reject) => {
                    // 所有用户的id集合
                    const usersIdsSet = new Set()

                    orders.forEach(item => {
                        usersIdsSet.add(item.owner_id)
                        usersIdsSet.add(item.consumer_id)
                    })

                    const usersIdsList = Array.from(usersIdsSet)

                    const usersIdsStr = new Array(usersIdsList.length).fill('?').join(',')

                    db.query(`SELECT id, nick_name, wx_avatar FROM user WHERE is_active = 1 AND id in (${usersIdsStr})`, usersIdsList, (err, userList) => {
                        if (err) reject(err)

                        if (!userList.length) resolve([])

                        resolve(userList)
                    })
                })
            }

            // 获取涉及到的订单商品
            const productListPromise = () => {
                const orderIds = orders
                    .map(item => `${item.id}`)
                    .reduce((acc, cur, index) => {
                        if (index) return `${acc}, "${cur}"`
                        return `"${cur}"`
                    }, '')

                return new Promise((resolve, reject) => {
                    db.query(
                        `SELECT product_id, product_name, product_num, product_price, order_id FROM order_products WHERE is_active = 1 AND order_id IN (${orderIds})`,
                        (err, orderProductsList) => {
                            if (err) reject(err)

                            if (!orderProductsList.length) resolve([])

                            resolve(orderProductsList)
                        }
                    )
                })
            }

            Promise.all([userInfoPromise(), productListPromise()]).then(results => {
                const [userList, orderProducts] = results
                if (!userList.length || !orderProducts.length) return res.output(200, '获取成功', [])


                const productIds = orderProducts.map(item => item.product_id)

                db.query(`SELECT * FROM production WHERE is_active = 1 AND id IN (${productIds.join(',')})`, (err, product) => {
                    if (err) return res.output(500, err.code)

                    orders.forEach(item => {
                        item.ownerInfo = userList.find(userItem => userItem.id == item.owner_id)
                        item.consumerInfo = userList.find(userItem => userItem.id == item.consumer_id)
                        item.orderProducts = orderProducts.filter(orderProductItem => orderProductItem.order_id === item.id)
                        item.orderProducts.forEach(orderProductItem => {
                            orderProductItem.detail = product.find(item => item.id === orderProductItem.product_id)
                        })
                    })

                    return res.output(200, '获取成功', orders)
                })
            }).catch(errs => {
                return res.output(500, errs.code)
            })
        }
    )
}

exports.getOrderByDateHandler = (req, res) => {
    const { classic, date } = req.body
    const { userId } = req.auth.user

    // classic 1 饭店订单; 2 个人订单;
    if (!classic) return res.output(400, '缺少订单类型参数')

    if (!date) return res.output(400, '请选择日期')

    const setYearMonthDay = (str) => {
        // str 2024-05-22
        const strList = str.split('-')
        const [year, month, day] = strList

        return {
            year: Number(year),
            month: Number(month) - 1,
            date: Number(day)
        }
    }

    // 搜索订单的日期范围
    let dateStart = null
    let dateEnd = null

    try {
        dateStart = moment().set(setYearMonthDay(date)).format('YYYY-MM-DD 00:00:00')
        dateEnd = moment().set(setYearMonthDay(date)).format('YYYY-MM-DD 23:59:59')
    } catch (error) {
        return res.output(500, '日期格式有误')
    }

    // classic为1, userId则是owner_id; classic为2, 则是consumer_id
    db.query(
        `SELECT order_status, order_price, created_time, id, remark, make_time, owner_id, consumer_id FROM orders WHERE ${classic == 1 ? 'owner_id' : 'consumer_id'} = ? AND is_active = 1 AND (created_time BETWEEN ? AND ?) ORDER BY created_time DESC`,
        [userId, dateStart, dateEnd],
        (err, orders) => {
            if (err) return res.output(500, err.code)
            if (!orders.length) return res.output(200, '暂无订单', [])

            // 获取涉及到的用户列表
            const userInfoPromise = () => {
                return new Promise((resolve, reject) => {
                    // 所有用户的id集合
                    const usersIdsSet = new Set()

                    orders.forEach(item => {
                        usersIdsSet.add(item.owner_id)
                        usersIdsSet.add(item.consumer_id)
                    })

                    const usersIdsList = Array.from(usersIdsSet)

                    const usersIdsStr = new Array(usersIdsList.length).fill('?').join(',')

                    db.query(`SELECT id, nick_name, wx_avatar FROM user WHERE is_active = 1 AND id in (${usersIdsStr})`, usersIdsList, (err, userList) => {
                        if (err) reject(err)

                        if (!userList.length) resolve([])

                        resolve(userList)
                    })
                })
            }

            // 获取涉及到的订单商品
            const productListPromise = () => {
                const orderIds = orders
                    .map(item => `${item.id}`)
                    .reduce((acc, cur, index) => {
                        if (index) return `${acc}, "${cur}"`
                        return `"${cur}"`
                    }, '')

                return new Promise((resolve, reject) => {
                    db.query(
                        `SELECT product_id, product_name, product_num, product_price, order_id FROM order_products WHERE is_active = 1 AND order_id IN (${orderIds})`,
                        (err, orderProductsList) => {
                            if (err) reject(err)

                            if (!orderProductsList.length) resolve([])

                            resolve(orderProductsList)
                        })
                })
            }

            Promise.all([userInfoPromise(), productListPromise()]).then(results => {
                const [userList, orderProducts] = results

                if (!userList.length || !orderProducts.length) return res.output(200, '获取成功', [])

                const productIds = orderProducts.map(item => item.product_id)

                db.query(`SELECT * FROM production WHERE is_active = 1 AND id IN (${productIds.join(',')})`, (err, product) => {
                    if (err) return res.output(500, err.code)

                    orders.forEach(item => {
                        item.ownerInfo = userList.find(userItem => userItem.id == item.owner_id)
                        item.consumerInfo = userList.find(userItem => userItem.id == item.consumer_id)
                        item.orderProducts = orderProducts.filter(orderProductItem => orderProductItem.order_id === item.id)
                        item.orderProducts.forEach(orderProductItem => {
                            orderProductItem.detail = product.find(item => item.id === orderProductItem.product_id)
                        })
                    })

                    res.output(200, '获取成功', orders)
                })
            })

        }
    )
}

exports.getOrderDateHandler = (req, res) => {
    const { userId } = req.auth.user

    db.query(`SELECT DATE(CONVERT_TZ(created_time, '+00:00', '+08:00')) AS formattedDate FROM orders WHERE is_active = 1 AND ( owner_id = ? or consumer_id = ? )GROUP BY formattedDate`, [userId, userId], (err, orderList) => {
        if (err) return res.output(500, err.code)

        if (!orderList.length) return res.output(200, '获取成功', [])

        const orderListFormatted = orderList.map(item => {
            return {
                date: moment.utc(item.formattedDate).format('YYYY-MM-DD')
            }
        })

        return res.output(200, '获取成功', orderListFormatted)
    })

}