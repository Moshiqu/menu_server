const app = require('express')

const router = app.Router()

const { getOpenIdHandler, checkHandler } = require('../../api_handler/user/index')

// 获取openid
router.get('/getOpenId', getOpenIdHandler)

// 检查用户
router.get('/check', checkHandler)

module.exports = router
