module.exports = (req, res, next) => {
  res.output = (code, message = '请求失败', data) => {
    let result = null
    if (code === 200) {
      result = {
        data,
        code,
        message: message instanceof Error ? message.message : message
      }
    } else {
      result = {
        code,
        message: message instanceof Error ? message.message : message
      }
    }
    res.send(result)
  }
  req.method === 'OPTIONS' ? res.status(204).end() : next()
}
