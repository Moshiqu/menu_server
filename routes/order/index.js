const app = require('express')

const router = app.Router()

const { orderConfirmHandler, getProcessingOrderHandler, getOrderByDateHandler } = require('../../api_handler/order/index')

// 订单生成
router.post('/orderConfirm', orderConfirmHandler)

// 获取进行中的订单
router.post('/getProcessingOrder', getProcessingOrderHandler)

// 根据日期获取订单
router.post("/getOrderByDate", getOrderByDateHandler)

module.exports = router
