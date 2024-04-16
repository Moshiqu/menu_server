const app = require('express')

const router = app.Router()

const {
  getMenuHandler,
  updateProductionSortHandler,
  updateProductionDetailHandler,
  deleteProductHandler,
  addProductionDetailHandler,
  addMaterialStepHandler2,
  updateMaterialStepHandler,
  getMaterialStepHandler,
  addCategoryHandler,
  getCategoryHandler,
  updateCategoryHandler,
  deleteCategoryHandler,
  updateCategorySortHandler
} = require('../../api_handler/menu/index')

// 获取首页菜单
router.get('/getMenu', getMenuHandler)

// 产品排序修改
router.post('/updateSort', updateProductionSortHandler)

// 产品详情修改
router.post('/updateDetail', updateProductionDetailHandler)

// 产品详情新增
router.post('/addDetail', addProductionDetailHandler)

// 产品删除
router.delete('/deleteProduct', deleteProductHandler)

// 材料步骤新增
router.post('/addMaterialStep', addMaterialStepHandler2)

// 材料步骤修改
router.post('/updateMaterialStep', updateMaterialStepHandler)

// 步骤材料获取
router.get('/getMaterialStep', getMaterialStepHandler)

// 新增分类
router.post('/addCategory', addCategoryHandler)

// 查询分类
router.get('/getCategory', getCategoryHandler)

// 修改分类名
router.post('/updateCategory', updateCategoryHandler)

// 删除分类
router.delete('/deleteCategory', deleteCategoryHandler)

// 分类排序修改
router.post('/updateCategorySort', updateCategorySortHandler)





module.exports = router
