const app = require('express')

const router = app.Router()

const { getOpenIdHandler, checkHandler, searchStoreHandler, getUserInfoHandler } = require('../../api_handler/user/index')

// 获取openid
router.get('/getOpenId', getOpenIdHandler)

// 检查用户
router.get('/check', checkHandler)

// 搜索用户
router.get('/searchStore', searchStoreHandler)

// 获取用户信息
router.get('/getUserInfo', getUserInfoHandler)

module.exports = router
