const express = require('express')
const { hostname, port } = require('./utils/host')
const logger = require('morgan')
const { loggerName, loggerAccess, loggerError } = require('./utils/middleWare/logger.js')
const resExtra = require('./utils/middleWare/unifyResFormat')
const path = require('path')

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

// 导入校验token的模块, 解析JWT字符串, 还原成 JSON 对象 的模块
const expressJwt = require('express-jwt')
const { SECRET_KEY, NO_AUTHORIZATION_API } = require('./utils/setting')

// 使用中间件解析token
app.use(
    expressJwt.expressjwt({
        secret: SECRET_KEY,
        algorithms: ['HS256'], // 使用何种加密算法解析
    }).unless({ path: NO_AUTHORIZATION_API }) // .unless 排除无需校验的路由(比如: 登录)
)

// 路由
app.use('/api', require('./routes/index'))

// 获取静态资源(图片)
app.use('/images',express.static(path.join(__dirname, 'images')))

// 未匹配到路由
app.all('*', (req, res) => res.output(404, '未匹配到路由'))

// 错误处理中间件
app.use((err, req, res, next) => {
    if (err.name === 'UnauthorizedError' && !req.auth) {
        res.output(401, '未登录')
    } else if (err.name === 'UnauthorizedError') {
        res.output(401, '登录已过期, 请重新登录')
    } else {
        res.output(500, err)
    }
    // next()
})

app.listen(port, () => {
    console.log(`Server running at http://${hostname}:${port}/`)
})
