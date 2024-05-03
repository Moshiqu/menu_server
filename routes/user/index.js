const app = require('express')

const router = app.Router()

const { getOpenIdHandler, checkHandler, getUserHandler } = require('../../api_handler/user/index')

// 获取openid
router.get('/getOpenId', getOpenIdHandler)

// 检查用户
router.get('/check', checkHandler)

// 搜索用户
router.get('/getUser', getUserHandler)

module.exports = router
