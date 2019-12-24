<!--
  - Copyright (C) 2018-2019
  - All rights reserved, Designed By www.joolun.com
  - 注意：
  - 本软件为www.joolun.com开发研制，未经购买不得使用
  - 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
  - 一经发现盗用、分享等行为，将追究法律责任，后果自负
-->
<template>
  <div class="execution">
    <basic-container>
      <avue-crud ref="crud"
                 :page="page"
                 :data="tableData"
                 :permission="permissionList"
                 :table-loading="tableLoading"
                 :option="tableOption"
                 :before-open="beforeOpen"
                 v-model="form"
                 @on-load="getPage"
                 @refresh-change="refreshChange"
                 @row-update="handleUpdate"
                 @row-save="handleSave"
                 @row-del="handleDel"
                 @sort-change="sortChange"
                 @search-change="searchChange"
                 @selection-change="selectionChange">
        <template slot="menuLeft">
          <el-button type="success"
                     @click="batchShelf('1')"
                     size="small"
                     icon="el-icon-document"
                     v-if="permissions.mall_goodsspu_edit">批量上架</el-button>
          <el-button type="warning"
                     @click="batchShelf('0')"
                     size="small"
                     icon="el-icon-document"
                     v-if="permissions.mall_goodsspu_edit">批量下架</el-button>
        </template>
        <template slot="picUrls" slot-scope="scope">
          <el-image
            style="width: 100px; height: 100px"
            :src="scope.row.picUrls[0]"
            :preview-src-list="scope.row.picUrls">
          </el-image>
        </template>
        <template slot="shelf" slot-scope="scope">
          <el-switch
                  active-value="1"
                  inactive-value="0"
                  v-model="scope.row.shelf"
                  active-color="#13ce66"
                  inactive-color="#ff4949"
                  @change="changeShelf(scope.row)">
          </el-switch>
        </template>
        <template slot="price" slot-scope="scope">
          <div style="color: red">￥{{scope.row.priceDown}}{{scope.row.priceUp == scope.row.priceDown ? '' : '~￥'+
            scope.row.priceUp}}
          </div>
        </template>
        <template slot="descriptionForm" slot-scope="scope">
          <BaseEditor v-model="scope.row.description"/>
        </template>
        <template slot="skusForm" slot-scope="scope">
          <SkuForm :specType="scope.row.specType" :goodsSpec="goodsSpec" :goodsSpuSpec="goodsSpuSpec"
                   :goodsSku="goodsSku" @getGoodsSku="getGoodsSku"></SkuForm>
        </template>
        <template slot="picUrlsForm" slot-scope="scope">
          <div>
            <MaterialList v-model="scope.row.picUrls" type="image" :num=5></MaterialList>
            <p>主图默认第一张</p>
          </div>
        </template>
        <template slot-scope="scope" slot="menu">
          <!--          <el-button icon="el-icon-chat-dot-square"-->
          <!--                     size="small"-->
          <!--                     type="text"-->
          <!--                     @click="openAppraises(scope.row,scope.index)">商品评价</el-button>-->
        </template>
      </avue-crud>
      <el-dialog
        title="商品评价"
        :visible.sync="dialogAppraises"
        width="40%">
        <div v-for="item in goodsAppraises" :key="item.id">
          {{item}}
          <avue-comment :option="optionAppraises" :data="item">
            <i class="el-icon-delete" @click="$message('自定义菜单')"></i>
          </avue-comment>
        </div>
      </el-dialog>
    </basic-container>
  </div>
</template>

<script>
    import {getPage, getObj, addObj, putObj, delObj, putObjShelf} from '@/api/mall/goodsspu'
    import {getList as specList} from '@/api/mall/goodsspec'
    import {getPage as appraisesPage} from '@/api/mall/goodsappraises'
    import {fetchTree} from '@/api/mall/goodsspuspec'
    import {getObj2} from '@/api/mall/pointsconfig'
    import {tableOption} from '@/const/crud/mall/goodsspu'
    import {mapGetters} from 'vuex'
    import BaseEditor from '@/components/editor/BaseEditor.vue'
    import SkuForm from '@/components/sku/sku-form.vue'
    import MaterialList from '@/components/material/list.vue'

    export default {
        name: 'goodsspu',
        components: {
            BaseEditor,
            SkuForm,
            MaterialList
        },
        data() {
            return {
                form: {},
                tableData: [],
                page: {
                    total: 0, // 总页数
                    currentPage: 1, // 当前页数
                    pageSize: 20, // 每页显示多少条
                    ascs: [],//升序字段
                    descs: 'create_time'//降序字段
                },
                paramsSearch: {},
                tableLoading: false,
                tableOption: tableOption,
                goodsSpec: null,
                goodsSpuSpec: null,
                goodsSku: null,
                goodsSkuData: [],
                goodsSpuSpecData: [],
                goodsAppraises: [],
                dialogAppraises: false,
                optionAppraises: {
                    props: {
                        avatar: 'nickName',
                        author: 'headimgUrl',
                        body: 'content'
                    }
                },
              selectionData: '',
              pointsConfig: null
            }
        },
        watch:{
          'form.pointsGiveSwitch'(){
            let column =this.tableOption.group[2].column[1]
            if(this.form.pointsGiveSwitch==='1'){
              column.display = true
            }else{
              column.display = false
            }
          },
          'form.pointsDeductSwitch'(){
            let column =this.tableOption.group[3].column[1]
            let column2 =this.tableOption.group[3].column[2]
            if(this.form.pointsDeductSwitch==='1'){
              column.display = true
              column2.display = true
            }else{
              column.display = false
              column2.display = false
            }
          }
        },
        created() {
        },
        mounted: function () {
        },
        computed: {
            ...mapGetters(['permissions']),
            permissionList() {
                return {
                    addBtn: this.vaildData(this.permissions.mall_goodsspu_add, false),
                    delBtn: this.vaildData(this.permissions.mall_goodsspu_del, false),
                    editBtn: this.vaildData(this.permissions.mall_goodsspu_edit, false),
                    viewBtn: this.vaildData(this.permissions.mall_goodsspu_get, false)
                };
            },
        },
        methods: {
            selectionChange(list){
              this.selectionData = list
            },
            batchShelf(shelf){
              if(this.selectionData.length<=0){
                this.$message.error('请选择商品')
                return
              }
              let selectionIds = ''
              this.selectionData.forEach(item => {
                selectionIds += item.id+ ','
              })
              this.putObjShelf(selectionIds, shelf)
            },
            changeShelf(row){
              this.putObjShelf(row.id, row.shelf)
            },
            putObjShelf(ids, shelf){
                putObjShelf({
                  ids: ids,
                  shelf: shelf
                }).then(data => {
                  this.getPage(this.page)
                })
            },
            openAppraises(row, index) {
                this.goodsAppraises = null
                this.dialogAppraises = true
                appraisesPage({
                    spuId: row.id
                }).then(response => {
                    this.goodsAppraises = response.data.data.records
                })
            },
            getGoodsSku(val, val2) {
                this.goodsSkuData = val
                this.goodsSpuSpecData = val2
            },
            beforeOpen(done,type){
                if(type == 'add'){
                    this.goodsSpuSpec = []
                    this.goodsSku = []
                    this.specList()
                    done()
                }else if(type == 'edit'){
                    this.tableLoading = true
                    this.goodsSpuSpec = null
                    getObj(this.form.id).then(response => {
                      this.$set(this.form,'description', response.data.data.description)
                      this.fetchTree({
                        spuId: this.form.id
                      })
                      this.specList()
                      let skus = response.data.data.skus.filter(val => {
                        val.picUrls = val.picUrl ? [val.picUrl] : []
                        return val
                      })
                      this.goodsSku = skus
                      this.tableLoading = false
                      done()
                    })
                }

            },
            fetchTree(params) {
                fetchTree(params).then(data => {
                    this.goodsSpuSpec = data.data.data
                })
            },
            specList() {
                specList().then(data => {
                    this.goodsSpec = data.data.data
                })
                //自动填充默认积分设置
                if(!this.pointsConfig){
                    getObj2().then(response => {
                      this.pointsConfig = response.data.data ? response.data.data : null
                      if(!this.form.pointsDeductScale){
                        this.form.pointsDeductScale = this.pointsConfig.defaultDeductScale
                        this.form.pointsDeductAmount = this.pointsConfig.defaultDeductAmount
                      }
                    })
                }else{
                  if(!this.form.pointsDeductScale){
                    this.form.pointsDeductScale = this.pointsConfig.defaultDeductScale
                    this.form.pointsDeductAmount = this.pointsConfig.defaultDeductAmount
                  }
                }
            },
            searchChange(params,done) {
                params = this.filterForm(params)
                this.paramsSearch = params
                this.page.currentPage = 1
                this.getPage(this.page, params)
                done()
            },
            sortChange(val) {
                let prop = val.prop ? val.prop.replace(/([A-Z])/g, "_$1").toLowerCase() : '';
                if (val.order == 'ascending') {
                    this.page.descs = []
                    this.page.ascs = prop
                } else if (val.order == 'descending') {
                    this.page.ascs = []
                    this.page.descs = prop
                } else {
                    this.page.ascs = []
                    this.page.descs = []
                }
                this.getPage(this.page)
            },
            getPage(page, params) {
                this.tableLoading = true
                if (this.paramsSearch.categoryId) {
                    this.paramsSearch.categoryFirst = this.paramsSearch.categoryId[0]
                    this.paramsSearch.categorySecond = this.paramsSearch.categoryId[1]
                }
                getPage(Object.assign({
                    current: page.currentPage,
                    size: page.pageSize,
                    descs: this.page.descs,
                    ascs: this.page.ascs,
                }, params, this.paramsSearch)).then(response => {
                    let tableData = response.data.data.records
                    tableData.forEach(function (item, index) {
                        let categoryId = []
                        if(item.categoryFirst){
                          categoryId.push(item.categoryFirst)
                        }
                        if(item.categorySecond){
                          categoryId.push(item.categorySecond)
                        }
                        item.categoryId = categoryId
                    })
                    this.tableData = tableData
                    this.page.total = response.data.data.total
                    this.page.currentPage = page.currentPage
                    this.page.pageSize = page.pageSize
                    this.tableLoading = false
                }).catch(() => {
                    this.tableLoading = false
                })
            },
            /**
             * @title 数据删除
             * @param row 为当前的数据
             * @param index 为当前删除数据的行数
             *
             **/
            handleDel: function (row, index) {
                var _this = this
                this.$confirm('是否确认删除此数据', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(function () {
                    return delObj(row.id)
                }).then(data => {
                    _this.tableData.splice(index, 1)
                    _this.$message({
                        showClose: true,
                        message: '删除成功',
                        type: 'success'
                    })
                    this.getPage(this.page)
                }).catch(function (err) {
                })
            },
            /**
             * @title 数据更新
             * @param row 为当前的数据
             * @param index 为当前更新数据的行数
             * @param done 为表单关闭函数
             *
             **/
            handleUpdate: function (row, index, done) {
                row.skus = this.goodsSkuData
                row.spuSpec = this.goodsSpuSpecData
                row.categoryFirst = row.categoryId[0]
                row.categorySecond = row.categoryId[1]
                row.skus.forEach(function (val, index) {
                    if (val.picUrls && val.picUrls.length > 0) {
                        val.picUrl = val.picUrls[0]
                    }
                })
                putObj(row).then(data => {
                    this.tableData.splice(index, 1, Object.assign({}, row))
                    this.$message({
                        showClose: true,
                        message: '修改成功',
                        type: 'success'
                    })
                    done()
                    this.getPage(this.page)
                }).catch(() => {
                  done()
                })
            },
            /**
             * @title 数据添加
             * @param row 为当前的数据
             * @param done 为表单关闭函数
             *
             **/
            handleSave: function (row, done) {
                row.skus = this.goodsSkuData
                row.spuSpec = this.goodsSpuSpecData
                row.categoryFirst = row.categoryId[0]
                row.categorySecond = row.categoryId[1]
                row.skus.forEach(function (val, index) {
                    if (val.picUrls && val.picUrls.length > 0) {
                        val.picUrl = val.picUrls[0]
                    }
                })
                addObj(row).then(data => {
                    this.tableData.push(Object.assign({}, row))
                    this.$message({
                        showClose: true,
                        message: '添加成功',
                        type: 'success'
                    })
                    done()
                    this.getPage(this.page)
                }).catch(() => {
                  done()
                })
            },
            /**
             * 刷新回调
             */
            refreshChange(val) {
              this.getPage(val.page)
            }
        }
    }
</script>
