const db = require('../../sql/db')
const uuid = require('node-uuid')
const moment = require('moment')

exports.orderConfirmHandler = (req, res) => {
    // TODO 改造订单生成接口
    const { ownerId, orderPrice, makeTime, orderMakeTime, remark } = req.body
    const { userId: consumerId } = req.auth.user

    let products = req.body.products

    if (!ownerId) return res.output(400, '商家id不能为空')

    if (!consumerId) return res.output(400, '消费者id不能为空')

    if (ownerId === consumerId) return res.output(400, '不能给自己下单哦~')


    if (!orderMakeTime) return res.output(400, '请选择制作时间')

    if (orderMakeTime === 'time' && !makeTime) return res.output(400, '请选择预约时间')

    let makeTime_formatted = 0
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
    const orderProductSql = `INSERT INTO order_products (product_id, product_num, product_price, order_id) VALUES (?,?,?,?)`

    const orderProductValues = products.map(item => {
        const [product_id, product_num, product_price] = item
        return [product_id, product_num, product_price, order_id]
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

exports.getClassicOrderHandler = (req, res) => {
    const { classic, userId } = req.body
    // classic 1 饭店订单; 2 个人订单;
    if (!classic) return res.output(400, '缺少订单类型参数')

    // classic为1, 则是owner_id; classic为2, 则是consumer_id
    if (!userId) return res.output(400, '缺少用户id参数')

    db.query(
        `SELECT order_status, order_price, created_time, id FROM orders WHERE ${classic == 1 ? 'owner_id' : 'consumer_id'} = ? AND order_status IN (1,2,3,4) AND is_active = 1 ORDER BY created_time DESC`,
        userId,
        (err, orders) => {
            if (err) return res.output(500, err.code)
            if (!orders.length) return res.output(200, '暂无订单', [])

            const orderIds = orders
                .map(item => `${item.id}`)
                .reduce((acc, cur, index) => {
                    if (index) return `${acc}, "${cur}"`
                    return `"${cur}"`
                }, '')

            db.query(
                `SELECT product_id, product_num, product_price, order_id FROM order_products WHERE is_active = 1 AND order_id IN (${orderIds})`,
                (err, orderProducts) => {
                    if (err) return res.output(500, err.code)
                    if (!orderProducts.length) return res.output(200, '订单为空', [])

                    const productIds = orderProducts.map(item => item.product_id)

                    db.query(`SELECT * FROM production WHERE is_active = 1 AND id IN (${productIds.join(',')})`, (err, product) => {
                        if (err) return res.output(500, err.code)

                        orders.forEach(item => {
                            item.orderProducts = orderProducts.filter(orderProductItem => orderProductItem.order_id === item.id)
                            item.orderProducts.forEach(orderProductItem => {
                                orderProductItem.detail = product.find(item => item.id === orderProductItem.product_id)
                            })
                        })

                        res.output(200, '获取成功', orders)
                    })
                }
            )
        }
    )
}
