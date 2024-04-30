const app = require('express')

const router = app.Router()

const { orderConfirmHandler } = require('../../api_handler/order/index')

// 获取首页菜单
router.post('/orderConfirm', orderConfirmHandler)

module.exports = router
