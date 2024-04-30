const app = require('express')

const router = app.Router()

const menuApi = require('./menu/index')

const orderApi = require('./order/index')

// 菜单相关
router.use('/menu', menuApi)

// 订单相关
router.use('/order', orderApi)

module.exports = router
