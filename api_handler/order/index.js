const db = require('../../sql/db')
const uuid = require('node-uuid')

exports.orderConfirmHandler = (req, res) => {
  const { ownerId, consumerId } = req.body
  let orderList = req.body.orderList

  if (!ownerId) return res.output(400, '商家id不能为空')

  if (!consumerId) return res.output(400, '消费者id不能为空')

  if (ownerId === consumerId) return res.output(400, '商家和消费者不能为同一人')

  orderList = JSON.parse(orderList)

  if (!orderList || !Array.isArray(orderList) || !orderList.length) {
    return res.output(400, '订单格式不正确')
  }

  // 创建uuid
  const order_id = uuid.v4().replace(/-/g, '')

  // 新建订单
  const ordersSql = `INSERT INTO orders (id, owner_id, consumer_id) VALUES ('${order_id}', ${ownerId}, ${consumerId})`

  // 新建订单商品
  const orderProductSql = `INSERT INTO order_products (product_id, product_num, order_id) VALUES (?,?,?)`

  const orderProductValues = orderList.map(item => {
    const { productId: product_id, productNum: product_num } = item
    return [product_id, product_num, order_id]
  })

  const batchQueryObj = orderProductValues.map(item => {
    return {
      sql: orderProductSql,
      params: item
    }
  })

  batchQueryObj.push({
    sql: ordersSql
  })

  db.transaction(batchQueryObj)
    .then(results => {
      res.output(200, '添加成功')
    })
    .catch(err => {
      res.output(500, err)
    })
}
