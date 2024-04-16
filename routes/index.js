const app = require('express')

const router = app.Router()

const getMenu = require('./menu/index')

// 菜单页面
router.use('/menu', getMenu)

module.exports = router
