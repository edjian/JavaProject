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
      <el-row :gutter="10">
        <el-col :span="this.clickObj ? 12 : 24">
          <avue-crud ref="crud"
                     v-model="form"
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
                     @search-change="searchChange">
            <template slot-scope="scope"
                      slot="menu">
              <el-button type="text"
                         icon="el-icon-s-claim"
                         size="mini"
                         plain
                         @click="handleItem(scope.row,scope.index)">规格值列表
              </el-button>
            </template>
          </avue-crud>
        </el-col>
        <el-col :span="12" v-if="this.clickObj">
          <el-card class="box-card">
            <div slot="header" class="clearfix">
              <h3><i class="el-icon-document-copy"></i> 规格值列表，所属规格：{{this.clickObj.name}}</h3>
              <el-button style="float: right; padding: 3px 0" type="text" @click="handleItem()">关闭</el-button>
            </div>
            <avue-crud ref="crud2"
                       v-model="form2"
                       :page="page2"
                       :data="tableData2"
                       :permission="permissionList"
                       :before-open="beforeOpen2"
                       :option="tableOption2"
                       :table-loading="tableLoading2"
                       @on-load="getPage2"
                       @row-update="handleUpdate2"
                       @row-save="handleSave2"
                       @row-del="handleDel2"
                       @refresh-change="refreshChange2"
                       @sort-change="sortChange2">
            </avue-crud>
          </el-card>
        </el-col>
      </el-row>
    </basic-container>
  </div>
</template>

<script>
  import { getPage, getObj, addObj, putObj, delObj } from '@/api/mall/goodsspec'
  import { tableOption } from '@/const/crud/mall/goodsspec'
  import { getPage as getPage2, addObj as addObj2, putObj as putObj2, delObj as delObj2 } from '@/api/mall/goodsspecvalue'
  import { tableOption as tableOption2 } from '@/const/crud/mall/goodsspecvalue'
  import { mapGetters } from 'vuex'
  export default {
    name: 'goodsspec',
    data() {
      return {
        form: {},
        tableData: [],
        page: {
          total: 0, // 总页数
          currentPage: 1, // 当前页数
          pageSize: 10, // 每页显示多少条
          ascs: [],//升序字段
          descs: 'create_time'//降序字段
        },
        paramsSearch:{},
        tableLoading: false,
        tableOption: tableOption,
        clickObj: null,
        form2: {},
        tableData2: [],
        page2: {
          total: 0, // 总页数
          currentPage: 1, // 当前页数
          pageSize: 10, // 每页显示多少条
          ascs: [],//升序字段
          descs: 'create_time'//降序字段
        },
        tableLoading2: false,
        tableOption2: tableOption2,
        paramsSearch2:{},
      }
    },
    created() {
    },
    mounted: function() { },
    computed: {
      ...mapGetters(['permissions']),
      permissionList() {
        return {
          addBtn: this.permissions['mall:goodsspec:add'] ? true : false,
          delBtn: this.permissions['mall:goodsspec:del'] ? true : false,
          editBtn: this.permissions['mall:goodsspec:edit'] ? true : false,
          viewBtn: this.permissions['mall:goodsspec:get'] ? true : false
        };
      }
    },
    methods: {
      searchChange(params,done){
        params = this.filterForm(params)
        this.paramsSearch = params
        this.page.currentPage = 1
        this.getPage(this.page,params)
        done()
      },
      sortChange(val){
        let prop = val.prop ? val.prop.replace(/([A-Z])/g,"_$1").toLowerCase() : '';
        if(val.order=='ascending'){
          this.page.descs = []
          this.page.ascs = prop
        }else if(val.order=='descending'){
          this.page.ascs = []
          this.page.descs = prop
        }else{
          this.page.ascs = []
          this.page.descs = []
        }
        this.getPage(this.page)
      },
      getPage(page, params) {
        this.tableLoading = true
        getPage(Object.assign({
          current: page.currentPage,
          size: page.pageSize,
          descs: this.page.descs,
          ascs: this.page.ascs,
        }, params, this.paramsSearch)).then(response => {
          this.tableData = response.data.data.records
          this.page.total = response.data.data.total
          this.page.currentPage = page.currentPage
          this.page.pageSize = page.pageSize
          this.tableLoading = false
        }).catch(() => {
          this.tableLoading=false
        })
      },
      /**
       * @title 数据删除
       * @param row 为当前的数据
       * @param index 为当前删除数据的行数
       *
       **/
      handleDel: function(row, index) {
        var _this = this
        this.$confirm('是否确认删除此数据', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(function() {
            return delObj(row.id)
          }).then(data => {
          _this.$message({
            showClose: true,
            message: '删除成功',
            type: 'success'
          })
          this.getPage(this.page)
        }).catch(function(err) { })
      },
      /**
       * @title 数据更新
       * @param row 为当前的数据
       * @param index 为当前更新数据的行数
       * @param done 为表单关闭函数
       *
       **/
      handleUpdate: function(row, index, done, loading) {
        putObj(row).then(data => {
          this.$message({
            showClose: true,
            message: '修改成功',
            type: 'success'
          })
          done()
          this.getPage(this.page)
        }).catch(() => {
          loading()
        })
      },
      /**
       * @title 数据添加
       * @param row 为当前的数据
       * @param done 为表单关闭函数
       *
       **/
      handleSave: function(row, done, loading) {
        addObj(row).then(data => {
          this.$message({
            showClose: true,
            message: '添加成功',
            type: 'success'
          })
          done()
          this.getPage(this.page)
        }).catch(() => {
          loading()
        })
      },
      /**
       * 刷新回调
       */
      refreshChange(page) {
        this.getPage(this.page)
      },

      handleItem: function (row) {
        if(row){
          this.clickObj = row
          this.page2.currentPage = 1
          this.getPage2(this.page2)
        }else{
          this.clickObj = null
        }
      },
      beforeOpen2(done) {
        this.$set(this.form2,"specId",this.clickObj.id)
        done()
      },
      sortChange2(val){
        let prop = val.prop ? val.prop.replace(/([A-Z])/g,"_$1").toLowerCase() : ''
        if(val.order=='ascending'){
          this.page2.descs = []
          this.page2.ascs = prop
        }else if(val.order=='descending'){
          this.page2.ascs = []
          this.page2.descs = prop
        }else{
          this.page2.ascs = []
          this.page2.descs = []
        }
        this.getPage2(this.page2)
      },
      getPage2(page, params) {
        this.tableLoading2 = true
        getPage2(Object.assign({
          current: page.currentPage,
          size: page.pageSize,
          descs: this.page2.descs,
          ascs: this.page2.ascs,
        }, params, this.paramsSearch2,{
          specId: this.clickObj.id
        })).then(response => {
          this.tableData2 = response.data.data.records
          this.page2.total = response.data.data.total
          this.page2.currentPage = page.currentPage
          this.page2.pageSize = page.pageSize
          this.tableLoading2 = false
        }).catch(() => {
          this.tableLoading2=false
        })
      },
      /**
       * @title 数据删除
       * @param row 为当前的数据
       * @param index 为当前删除数据的行数
       *
       **/
      handleDel2: function(row, index) {
        var _this = this
        this.$confirm('是否确认删除此数据', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(function() {
          return delObj2(row.id)
        }).then(data => {
          _this.$message({
            showClose: true,
            message: '删除成功',
            type: 'success'
          })
          this.getPage2(this.page2)
        }).catch(function(err) { })
      },
      /**
       * @title 数据更新
       * @param row 为当前的数据
       * @param index 为当前更新数据的行数
       * @param done 为表单关闭函数
       *
       **/
      handleUpdate2: function(row, index, done, loading) {
        putObj2(row).then(data => {
          this.$message({
            showClose: true,
            message: '修改成功',
            type: 'success'
          })
          done()
          this.getPage2(this.page2)
        }).catch(() => {
          loading()
        })
      },
      /**
       * @title 数据添加
       * @param row 为当前的数据
       * @param done 为表单关闭函数
       *
       **/
      handleSave2: function(row, done, loading) {
        addObj2(row).then(data => {
          this.$message({
            showClose: true,
            message: '添加成功',
            type: 'success'
          })
          done()
          this.getPage2(this.page2)
        }).catch(() => {
          loading()
        })
      },
      /**
       * 刷新回调
       */
      refreshChange2(val) {
        this.getPage2(this.page2)
      }
    }
  }
</script>

<style lang="scss" scoped>
</style>
