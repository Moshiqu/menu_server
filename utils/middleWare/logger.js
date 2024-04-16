const logger = require('morgan')
const FileStreamRotator = require('file-stream-rotator')
const fs = require('fs')
const path = require('path')

const logDirectory = path.join(__dirname, '../../run_log')
//确保存储的路径存在
fs.existsSync(logDirectory) || fs.mkdirSync(logDirectory)
// 创建输出流
const errorLogStream = FileStreamRotator.getStream({
  date_format: 'YYYYMMDD', //日期类型
  filename: path.join(logDirectory, '%DATE%-error.log'), //文件名
  frequency: 'daily', //每天的频率
  verbose: false
})
// 创建输出流
const accessLogStream = FileStreamRotator.getStream({
  date_format: 'YYYYMMDD',
  filename: path.join(logDirectory, '%DATE%-access.log'),
  frequency: 'daily',
  verbose: false
})

// 自定义token
logger.token('localDate', function getDate(req) {
  let date = new Date()
  return date.toLocaleString()
})

logger.token('query', function getDate(req) {
  return JSON.stringify(req.query)
})

logger.token('params', function getDate(req) {
  return JSON.stringify(req.params)
})

logger.token('body', function getDate(req) {
  return JSON.stringify(req.body)
})

// 自定义format
logger.format(
  'joke',
  ':localDate :remote-addr :method :url :status :query :params :body - :response-time ms'
)

//写正常访问请求的log日志
const loggerAccess = { stream: accessLogStream }
//写访问出错的log日志
const loggerError = {
  skip: function (req, res) {
    return res.statusCode < 400
  },
  stream: errorLogStream
}

module.exports = {
  loggerName: 'joke',
  loggerAccess,
  loggerError
}
