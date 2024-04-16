const express = require('express')
const { hostname, port } = require('./utils/host')
const logger = require('morgan')
const { loggerName, loggerAccess, loggerError } = require('./utils/middleWare/logger.js')
const resExtra = require('./utils/middleWare/unifyResFormat')

const app = express()

//写正常访问请求的log日志
app.use(logger(loggerName, loggerAccess))
//写访问出错的log日志
app.use(logger(loggerName, loggerError))

// 挂载同一返回格式
app.use(resExtra)

// 解析请求体 content-type: application/json 赋值给 req.body
app.use(express.json())

// 解析请求体 content-type: application/x-www-form-urlencoded 赋值给 req.body
app.use(express.urlencoded({ extended: true }))

// 路由
app.use('/api', require('./routes/index'))

// 未匹配到路由
app.all('*', (req, res) => res.output(500, '未匹配到路由'))

// 错误处理中间件
app.use((err, req, res, next) => {
  res.output(500, err)
  next()
})

app.listen(port, () => {
  console.log(`Server running at http://${hostname}:${port}/`)
})
