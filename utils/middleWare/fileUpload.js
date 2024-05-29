const multer = require('multer')
const path = require('path')
const uuid = require('node-uuid')
const { FILE_TEMP_NAME } = require('../setting')

module.exports = (req, res, next) => {
  let filename = ''
  const dest = path.join(__dirname, '../../' + FILE_TEMP_NAME)
  const storage = multer.diskStorage({
    // 设置上传文件的存储目录
    destination: dest,
    filename: function (req, file, cb) {
      filename = uuid.v4() + path.extname(file.originalname)
      cb(null, filename)
    }
  })
  //上传单张图片
  const upload = multer({ storage }).single('file')

  upload(req, res, err => {
    if (err instanceof multer.MulterError) {
      res.output(500, err)
    } else if (err) {
      res.output(500, 'err:' + err)
    } else {
      //上传成功后，将图片写在req.body.photo中，继续住下执行
      req.body.file = filename
      next()
    }
  })
}
