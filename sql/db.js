var mysql = require('mysql')
var dbConfig = require('./db.config')
var mysql2 = require('mysql2/promise')

module.exports = {
  query: function (sql, params, callback) {
    //每次使用的时候需要创建链接，数据操作完成之后要关闭连接
    var pool = mysql.createPool(dbConfig)
    pool.getConnection(function (err) {
      if (err) {
        console.log('数据库链接失败')
        throw err
      }
      //开始数据操作
      pool.query(sql, params, function (err, results, fields) {
        //将查询出来的数据返回给回调函数，这个时候就没有必要使用错误前置的思想了，
        // 因为我们在这个文件中已经对错误进行了处理，如果数据检索报错，直接就会阻塞到这个文件中
        callback && callback(err, results, fields)
        //results作为数据操作后的结果，fields作为数据库连接的一些字段
        //停止链接数据库，必须再查询语句后，要不然一调用这个方法，就直接停止链接，数据操作就会失败
        pool.end(function (err) {
          if (err) {
            console.log('关闭数据库连接失败！')
            throw err
          }
        })
      })
    })
  },
  transaction: async function (queries) {
    const pool = mysql2.createPool(dbConfig)
    let connection
    try {
      // 从连接池中获取连接
      connection = await pool.getConnection()
      await connection.beginTransaction()

      // 依次执行查询
      for (const query of queries) {
        await connection.execute(query.sql, query.params)
      }

      // 提交事务
      const result = await connection.commit()
      return result
    } catch (error) {
      // 如果有错误，回滚事务
      if (connection && connection.rollback) {
        await connection.rollback()
      }
      throw new Error(error) // 重新抛出错误以便在调用处处理
    } finally {
      // 释放连接回连接池
      if (connection && connection.release) {
        connection.release()
      }
    }
  }
}
