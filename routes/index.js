const express = require('express')

const { FILE_TEMP_NAME } = require('../utils/setting')

const router = express.Router()

const uerApi = require('./user/index')

const menuApi = require('./menu/index')

const orderApi = require('./order/index')

const fileUpload = require('../utils/middleWare/fileUpload')

// 用户相关
router.use('/user', uerApi)

// 菜单相关
router.use('/menu', menuApi)

// 订单相关
router.use('/order', orderApi)

// 上传文件
router.post('/upload', fileUpload, (req, res) => {
  if (req.body.file) {
    return res.output(200, '文件保存成功', { url: `${FILE_TEMP_NAME}/${req.body.file}` })
  }
  return res.output(500, '文件保存失败')
})

module.exports = router
