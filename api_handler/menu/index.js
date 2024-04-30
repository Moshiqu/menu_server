const db = require('../../sql/db')

exports.getMenuHandler = (req, res) => {
    // 获取所有分类
    db.query('SELECT category_name, id, sort_index FROM category WHERE is_active = 1 ORDER BY sort_index ASC', (err, categories) => {
        if (err) return res.output(500, err.code)
        // 获取分类下的产品
        let category_id = categories.map(item => item.id)

        if (!category_id.length) {
            return res.output(200, '获取成功', [])
        } else if (category_id.length === 1) {
            category_id = category_id[0]
        }

        const placeholders = Array(category_id.length).fill('?').join(','); // 生成占位符字符串，例如 '?,?,?,?,?' 

        db.query(
            `SELECT category_id, id, img_src, product_description, product_name, sold_num, sort_index, product_price, like_num, like_not_num FROM production WHERE category_id in (${placeholders}) AND is_active = 1 ORDER BY sort_index ASC`,
            category_id,
            (err, productions) => {
                if (err) return res.output(500, err.code)

                productions.forEach(production => {
                    categories.forEach(category => {
                        if (!category.children) category.children = []
                        if (category.id === production.category_id) {
                            category.children.push(production)
                        }
                    })
                })

                res.output(200, '获取成功', categories)
            }
        )
    })
}

exports.updateProductionSortHandler = (req, res) => {
    const { value1, value2 } = req.body
    if (!value1 && !value2) return res.output(400, '缺少必要参数')

    const { id: id1, sortIndex: sort_index1 } = value1
    const { id: id2, sortIndex: sort_index2 } = value2
    if (!id1 || !id2 || !sort_index1 || !sort_index2) return res.output(400, '缺少必要参数')

    const sql = `UPDATE production SET sort_index = CASE id WHEN ? THEN  ? WHEN ? THEN ? END WHERE id IN (?,?)`

    db.query(sql, [id1, sort_index1, id2, sort_index2, id1, id2], (err, result) => {
        if (err) return res.output(500, err)
        res.output(200, '修改成功')
    })
}

exports.updateProductionDetailHandler = (req, res) => {
    const {
        id,
        productName: product_name,
        productDescription: product_description,
        cateId: category_id,
        productPrice: product_price
    } = req.body

    if (!id || !category_id || !product_name) return res.output(400, '缺少必要参数')

    db.query(
        'UPDATE production SET ? WHERE id = ?',
        [{ product_name, product_description: product_description || null, category_id, product_price: product_price || null }, id],
        (err, result) => {
            if (err) return res.output(500, err.code)
            res.output(200, '修改成功', { id })
        }
    )
}

exports.addProductionDetailHandler = (req, res) => {
    const {
        productName: product_name,
        productDescription: product_description,
        cateId: category_id,
        productPrice: product_price
    } = req.body

    if (!category_id || !product_name) return res.output(400, '缺少必要参数')

    // 查找当前分类中最大的sort_index
    db.query(`SELECT MAX(sort_index) sort_index FROM production WHERE category_id = ?`, [category_id], (err, result) => {
        if (err) return res.output(500, err.code)

        let sort_index = 1
        if (result.length) {
            sort_index = result[result.length - 1].sort_index + 1
        }
        // 插入新的商品
        db.query('INSERT INTO production SET ?', { product_name, product_description: product_description || null, category_id, product_price: product_price || null, sort_index }, (err, result) => {
            if (err) return res.output(500, err.code)
            res.output(200, '添加成功', { id: result.insertId })
        })
    })


}

exports.deleteProductHandler = (req, res) => {
    const { id } = req.body
    if (!id) return res.output(400, '缺少必要参数')

    db.query('UPDATE production SET ? WHERE id = ?', [{ is_active: 0 }, id], (err, result) => {
        if (err) return res.output(500, err.code)

        res.output(200, '删除成功', result)
    })
}

// mysql 不使用事务
exports.addMaterialStepHandler = (req, res) => {
    const { material, step, id: production_id } = req.body
    if (!production_id) return res.output(400, '缺少必要参数')

    const materialObj = material || []
    const addMaterial = (materialObj, production_id) => {
        return new Promise((resolve, reject) => {
            if (!materialObj.length) return resolve(true)

            // 构建值列表
            const materialValues = materialObj
                .map(item => {
                    const { material_name, material_quantity } = item
                    return `('${material_name}', '${material_quantity}', ${production_id})`
                })
                .join(',')

            // 构建完整的 SQL 语句
            const sql = `INSERT INTO material (material_name, material_quantity, production_id) VALUES ${materialValues}`

            // 执行 SQL 语句
            db.query(sql, (err, rows, fields) => {
                if (err) return reject(err)
                resolve(rows)
            })
        })
    }

    const stepObj = step || []
    const addStep = (stepObj, production_id) => {
        return new Promise((resolve, reject) => {
            if (!stepObj.length) return reject('步骤不能为空')
            // 构建值列表
            const stepValues = stepObj
                .map((item, index) => {
                    const { stepDescription, stepImg } = item
                    return `('${stepDescription}', '${stepImg}', '${index + 1}', ${production_id})`
                })
                .join(',')

            // 构建完整的 SQL 语句
            const sql = `INSERT INTO step (step_description, step_img, step_index, production_id) VALUES ${stepValues}`

            db.query(sql, (err, rows, fields) => {
                if (err) return reject(err)
                resolve(rows)
            })
        })
    }

    Promise.all([addMaterial(materialObj, production_id), addStep(stepObj, production_id)])
        .then(values => {
            res.output(200, '添加成功')
        })
        .catch(err => {
            res.output(500, err)
        })
}

// mysql2 使用事务
exports.addMaterialStepHandler2 = (req, res) => {
    const { material, step, id: production_id } = req.body
    if (!production_id) return res.output(400, '缺少必要参数')

    // 构建材料sql
    const materialObj = material || []
    const materialValues = materialObj
        .map(item => {
            const { material_name, material_quantity } = item
            return `('${material_name}', '${material_quantity}', ${production_id})`
        })
        .join(',')

    // 构建步骤sql
    const stepObj = step || []
    if (!stepObj.length) return res.output(500, '步骤不能为空')
    const stepValues = stepObj
        .map((item, index) => {
            const { step_description, step_img } = item
            return `('${step_description}', '${step_img}', '${index + 1}', ${production_id})`
        })
        .join(',')

    // 构建完整的 SQL 语句
    const materialSql = materialValues ? `INSERT INTO material (material_name, material_quantity, production_id) VALUES ${materialValues}` : `SELECT id FROM material WHERE id = ${production_id}`
    const stepSql = `INSERT INTO step (step_description, step_img, step_index, production_id) VALUES ${stepValues}`

    const queries = [{ sql: materialSql }, { sql: stepSql }]
    db.transaction(queries)
        .then(results => {
            res.output(200, '添加成功')
        })
        .catch(err => {
            res.output(500, err)
        })
}

exports.updateMaterialStepHandler = (req, res) => {
    const { material, step, id: production_id } = req.body
    if (!production_id) return res.output(400, '缺少必要参数')

    // 构建材料sql
    const materialObj = material || []
    const materialValues = materialObj
        .map(item => {
            const { material_name, material_quantity } = item
            return `('${material_name}', '${material_quantity}', ${production_id})`
        })
        .join(',')

    // 构建步骤sql
    const stepObj = step || []
    if (!stepObj.length) return res.output(500, '步骤不能为空')
    const stepValues = stepObj
        .map((item, index) => {
            const { step_description, step_img } = item
            return `('${step_description}', '${step_img}', '${index + 1}', ${production_id})`
        })
        .join(',')

    // 构建完整的 SQL 语句
    const deleteMaterialSql = `UPDATE material SET is_active = ? WHERE production_id = ?`
    const deleteStepSql = `UPDATE step SET is_active = ? WHERE production_id = ?`
    const materialSql = `INSERT INTO material (material_name, material_quantity, production_id) VALUES ${materialValues}`
    const stepSql = `INSERT INTO step (step_description, step_img, step_index, production_id) VALUES ${stepValues}`

    const queries = [
        { sql: deleteMaterialSql, params: [0, production_id] },
        { sql: deleteStepSql, params: [0, production_id] },
        { sql: materialSql },
        { sql: stepSql }
    ]
    db.transaction(queries)
        .then(results => {
            res.output(200, '修改成功')
        })
        .catch(err => {
            res.output(500, err)
        })
}

exports.getMaterialStepHandler = (req, res) => {
    const { id: production_id } = req.query

    if (!production_id) return res.output(400, '缺少必要参数')

    const queryMaterial = production_id => {
        return new Promise((resolve, reject) => {
            db.query(
                'SELECT material_name, material_quantity FROM material WHERE production_id = ? AND is_active = ?',
                [production_id, 1],
                (err, rows, fields) => {
                    if (err) return reject(err)
                    resolve(rows)
                }
            )
        })
    }

    const queryStep = production_id => {
        return new Promise((resolve, reject) => {
            db.query(
                'SELECT step_description, step_img FROM step WHERE production_id = ? AND is_active = ? ORDER BY step_index ASC',
                [production_id, 1],
                (err, rows, fields) => {
                    if (err) return reject(err)
                    resolve(rows)
                }
            )
        })
    }

    Promise.all([queryMaterial(production_id), queryStep(production_id)])
        .then(values => {
            res.output(200, '获取成功', { material: values[0], step: values[1] })
        })
        .catch(err => {
            res.output(500, err)
        })
}

exports.addCategoryHandler = (req, res) => {
    const { cateName: category_name, userId: user_id } = req.body
    if (!category_name || !user_id) return res.output(400, '缺少必要参数')

    // 查找当前用户最大的sort_index
    db.query(`SELECT MAX(sort_index) sort_index FROM category WHERE user_id = ?`, [user_id], (err, result) => {
        if (err) return res.output(500, err.code)

        let sort_index = 1
        if (result.length) {
            sort_index = result[result.length - 1].sort_index + 1
        }
        // 插入新的分类
        db.query(`INSERT INTO category SET ?`, { category_name, user_id, sort_index }, (err, result) => {
            if (err) return res.output(500, err.code)
            res.output(200, '添加成功')
        })
    })
}

exports.getCategoryHandler = (req, res) => {
    const { userId: user_id } = req.query
    if (!user_id) return res.output(400, '缺少必要参数')

    db.query(
        `SELECT category_name, id, sort_index FROM category WHERE is_active = 1 AND user_id = ? ORDER BY sort_index ASC`,
        [user_id],
        (err, result) => {
            if (err) return res.output(500, err.code)
            res.output(200, '获取成功', result)
        }
    )
}

exports.updateCategoryHandler = (req, res) => {
    const { id: category_id, categoryName: category_name } = req.body

    if (!category_id || !category_name) return res.output(400, '缺少必要参数')

    db.query(`UPDATE category SET ? WHERE id = ?`, [{ category_name }, category_id], (err, result) => {
        if (err) return res.output(500, err.code)
        res.output(200, '修改成功', result)
    })
}

exports.deleteCategoryHandler = (req, res) => {
    const { id: category_id } = req.body
    if (!category_id) return res.output(400, '缺少必要参数')

    db.query(`UPDATE category SET ? WHERE id = ?`, [{ is_active: 0 }, category_id], (err, result) => {
        if (err) return res.output(500, err.code)

        res.output(200, '删除成功', category_id)
    })
}

exports.updateCategorySortHandler = (req, res) => {
    const { value1, value2 } = req.body
    if (!value1 && !value2) return res.output(400, '缺少必要参数')

    const { id: id1, sortIndex: sort_index1 } = value1
    const { id: id2, sortIndex: sort_index2 } = value2

    const sql = `UPDATE category SET sort_index = CASE id WHEN ? THEN  ? WHEN ? THEN ? END WHERE id IN (?,?)`

    db.query(sql, [id1, sort_index1, id2, sort_index2, id1, id2], (err, result) => {
        if (err) return res.output(500, err)
        res.output(200, '修改成功', result)
    })
}

exports.getProductHandler = (req, res) => {
    const { productionId: id } = req.query
    if (!id) return res.output(400, '缺少必要参数')

    const getProduct = new Promise((resolve, reject) => {
        db.query('SELECT id,product_name,product_description,sold_num,img_src,product_price FROM production WHERE is_active = 1 AND id = ?', id, (err, production) => {
            if (err) return reject(err)
            return resolve(production)
        })
    })

    const getMaterial = new Promise((resolve, reject) => {
        db.query('SELECT material_name,material_quantity FROM material WHERE is_active = 1 AND production_id = ?', id, (err, material) => {
            if (err) return reject(err)
            return resolve(material)
        })
    })

    const getStep = new Promise((resolve, reject) => {
        db.query('SELECT step_description,step_img FROM step WHERE is_active = 1 AND production_id = ? ORDER BY step_index ASC', id, (err, step) => {
            if (err) return reject(err)
            return resolve(step)
        })
    })

    Promise.all([getProduct, getMaterial, getStep]).then(results => {
        const productionResult = results[0][0]
        const materialResult = results[1]
        const stepResult = results[2]

        productionResult.materialList = materialResult
        productionResult.stepList = stepResult

        return res.output(200, '获取商品详情成功', productionResult)
    }).catch(err => {
        return res.output(500, err)
    })
}