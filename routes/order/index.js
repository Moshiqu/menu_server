const app = require('express')

const router = app.Router()

const { orderConfirmHandler, getClassicOrderHandler } = require('../../api_handler/order/index')

// 订单生成
router.post('/orderConfirm', orderConfirmHandler)

// 获取饭店订单
router.post('/getClassicOrder', getClassicOrderHandler)

module.exports = router
