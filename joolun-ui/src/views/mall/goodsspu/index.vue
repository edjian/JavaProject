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
                 @on-load="getPage"
                 @refresh-change="refreshChange"
                 @row-update="handleUpdate"
                 @row-save="handleSave"
                 @row-del="handleDel"
                 @sort-change="sortChange"
                 @search-change="searchChange"
                 @current-change="currentChange">
        <template slot="menuLeft">
          <el-button type="primary"
                     size="small"
                     icon="el-icon-plus"
                     v-if="permissions.mall_goodsspu_add" @click="openAdd">添加商品
          </el-button>
        </template>
        <template slot="picUrls" slot-scope="scope">
          <el-image
            style="width: 100px; height: 100px"
            :src="scope.row.picUrls[0]"
            :preview-src-list="scope.row.picUrls">
          </el-image>
        </template>
        <template slot="shelf" slot-scope="scope">
          <el-tag :type="scope.row.shelf=='0' ? 'success' : 'danger'" effect="dark" size="mini"> {{ scope.row.shelf=='0'
            ? '已上架' : '已下架' }}
          </el-tag>
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
          <el-button icon="el-icon-edit"
                     size="small"
                     type="text"
                     v-if="permissions.mall_goodsspu_edit"
                     @click="openEdit(scope.row,scope.index)">编辑
          </el-button>
          <!--          <el-button icon="el-icon-chat-dot-square"-->
          <!--                     size="small"-->
          <!--                     type="text"-->
          <!--                     @click="openAppraises(scope.row,scope.index)">商品评价</el-button>-->
          <el-button type="text"
                     v-if="permissions.mall_goodsspu_del"
                     icon="el-icon-delete"
                     size="small"
                     plain
                     @click="handleDel(scope.row)">删除
          </el-button>
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
    import {getPage, getObj, addObj, putObj, delObj} from '@/api/mall/goodsspu'
    import {getList as specList} from '@/api/mall/goodsspec'
    import {getPage as appraisesPage} from '@/api/mall/goodsappraises'
    import {fetchTree} from '@/api/mall/goodsspuspec'
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
            openAdd() {
                this.goodsSpuSpec = []
                this.goodsSku = []
                this.$refs.crud.rowAdd()
                this.specList()
            },
            openEdit(row, index) {
                this.tableLoading = true
                this.goodsSpuSpec = null
                getObj(row.id).then(response => {
                    row.description = response.data.data.description
                    this.$refs.crud.rowEdit(row, index)
                    this.fetchTree({
                        spuId: row.id
                    })
                    this.specList()
                    let skus = response.data.data.skus.filter(val => {
                        val.picUrls = val.picUrl ? [val.picUrl] : []
                        return val
                    })
                    this.goodsSku = skus
                    this.tableLoading = false
                })
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
            },

            currentChange(currentPage) {
                this.page.currentPage = currentPage
            },
            searchChange(params) {
                params = this.filterForm(params)
                this.paramsSearch = params
                this.page.currentPage = 1
                this.getPage(this.page, params)
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
                })
            },
            /**
             * 刷新回调
             */
            refreshChange() {
                this.getPage(this.page)
            }
        }
    }
</script>
