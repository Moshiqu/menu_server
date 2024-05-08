const db = require('../../sql/db')
const jwt = require('jsonwebtoken')
const { SECRET_KEY } = require('../../utils/setting.js')
const axios = require('axios')

exports.getOpenIdHandler = (req, res) => {
    const { code } = req.query
    if (!code) return res.output(400, '缺少用户code')

    const instance = axios.create({
        baseURL: 'https://api.weixin.qq.com',
        timeout: 2000,
        params: {
            appid: 'wx37ebb8c09348ccd1',        //你的小程序的APPID
            secret: '0e47f0ef1e3fa0742ab03a22ff3dfff3',    //你的小程序秘钥secret,  
            js_code: code,    //wx.login 登录成功后的code
            grant_type: 'authorization_code' //此处为固定值
        }
    })

    instance.get('/sns/jscode2session').then(result => {
        const { data } = result

        db.query(`SELECT * FROM user WHERE openid = ?`, data.openid, (err, result) => {
            if (err) return res.output(500, err.code)

            if (result.length === 1) {
                return res.output(200, '成功', { openid: data.openid })
            } else if (result.length === 0) {
                const getRandomName = (length) => {
                    function randomAccess(min, max) {
                        return Math.floor(Math.random() * (min - max) + max)
                    }
                    let name = ""
                    for (let i = 0; i < length; i++) {
                        name += String.fromCharCode(randomAccess(0x4E00, 0x9FA5))
                    }
                    return name
                }

                // 注册
                db.query(`INSERT INTO user (nick_name, openid) VALUES (?,?)`, [getRandomName(6), data.openid], (err, result2) => {
                    if (err) return res.output(500, err.code)

                    return res.output(200, '成功', { openid: data.openid })
                })
            } else {
                return res.output(500, '用户重复')
            }
        })

    }).catch(err => {
        return res.output(500, '获取用户openid失败', err)
    })
}

exports.checkHandler = (req, res) => {
    const { openid } = req.query
    if (!openid) return res.output(400, '缺少必要参数')

    db.query('SELECT id from user WHERE openid = ?', openid, (err, userInfo) => {
        if (err) return res.output(500, err)

        switch (userInfo.length) {
            case 0:
                return res.output(200, '创建新用户')

            case 1:
                const token = jwt.sign(
                    { user: { userId: userInfo[0].id } },
                    SECRET_KEY,
                    { expiresIn: '3d' }
                )

                return res.output(200, '成功', { token, id: userInfo[0].id })

            default:
                return res.output(500, '用户不唯一')
        }
    })
}

exports.searchStoreHandler = (req, res) => {
    const { value } = req.query
    if (!value) return res.output(400, '缺少必要参数')

    db.query(`SELECT id FROM user WHERE is_active = 1 AND nick_name LIKE ?`, `%${value}%`, (err, usersResult) => {
        if (err) return res.output(500, err)

        if (!usersResult.length) return res.output(200, '请求成功', [])

        const valueId = usersResult.map(item => item.id)

        const placeholders = Array(usersResult.length).fill('?').join(','); // 生成占位符字符串，例如 '?,?,?,?,?' 

        db.query(`SELECT * FROM view_user_products_num WHERE id IN (${placeholders})`, valueId, (err, result) => {
            if (err) return res.output(500, err)

            res.output(200, '请求成功', result)
        })
    })
}

exports.getUserInfoHandler = (req, res) => {
    const { user: { userId } } = req.auth;

    db.query(`SELECT id, nick_name, description, wx_avatar, avatar FROM user WHERE is_active = 1 AND id = ?`, userId, (err, result) => {
        if (err) return res.output(500, err.code)
        res.output(200, '请求成功', result[0] || [])
    })

}
