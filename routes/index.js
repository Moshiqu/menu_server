const express = require('express')

const router = express.Router()

const uerApi = require('./user/index')

const menuApi = require('./menu/index')

const orderApi = require('./order/index')

// 用户相关
router.use('/user',uerApi)

// 菜单相关
router.use('/menu', menuApi)

// 订单相关
router.use('/order', orderApi)

module.exports = router
