const app = require('express')

const router = app.Router()

const { orderConfirmHandler,
    getProcessingOrderHandler,
    getOrderByDateHandler,
    getOrderDateHandler,
    deleteOrderHandler,
    startMakeHandler,
    finishMakeHandler,
    finishOrderHandler,
    getHistoryOrderHandler,
    getOrderDetailHandler } = require('../../api_handler/order/index')

// 订单生成
router.post('/orderConfirm', orderConfirmHandler)

// 获取进行中的订单
router.post('/getProcessingOrder', getProcessingOrderHandler)

// 根据日期获取订单
router.post("/getOrderByDate", getOrderByDateHandler)

// 获取有订单的日期
router.post("/getOrderDate", getOrderDateHandler)

// 修改订单状态 商家取消订单
router.post("/deleteOrder", deleteOrderHandler)

// 修改订单状态 待制作->制作中
router.post("/startMake", startMakeHandler)

// 修改订单状态 制作中->制作完成
router.post("/finishMake", finishMakeHandler)

// 修改订单状态 制作完成->订单完成
router.post("/finishOrder", finishOrderHandler)

// 获取历史订单
router.post("/getHistoryOrder", getHistoryOrderHandler)

// 获取订单详情
router.get("/getOrderDetail", getOrderDetailHandler)

module.exports = router
