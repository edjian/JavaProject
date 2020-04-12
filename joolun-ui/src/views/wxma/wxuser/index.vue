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
      <el-row :span="24" :gutter="10">
        <el-col :xs="24"
                :sm="24"
                :md="3">
          <el-card shadow="never">
            <div slot="header">
              <span>小程序名称</span>
            </div>
            <el-input
                    placeholder="输入关键字进行过滤"
                    size="mini"
                    v-model="filterText">
            </el-input>
            <el-tree
                    style="margin-top: 5px"
                    :data="treeWxAppData"
                    :props="treeWxAppProps"
                    :filter-node-method="filterNode"
                    node-key="id"
                    default-expand-all
                    ref="tree"
                    @node-click="nodeClick">
            </el-tree>
          </el-card>
        </el-col>
        <el-col :xs="24"
                :sm="24"
                :md="21">
          <avue-crud ref="crud"
                     :page="page"
                     :data="tableData"
                     :table-loading="tableLoading"
                     :option="tableOption"
                     :permission="permissionList"
                     @on-load="getPage"
                     @refresh-change="refreshChange"
                     @row-update="handleUpdate"
                     @row-save="handleSave"
                     @row-del="handleDel"
                     @sort-change="sortChange"
                     @search-change="searchChange">
            <template slot="sex" slot-scope="scope" >
              <el-tag v-if="scope.row.sex" size="mini" effect="light" :type="scope.row.sex == '1' ? '' : scope.row.sex == '2' ? 'danger' : 'warning'">{{scope.row.$sex}}</el-tag>
            </template>
          </avue-crud>
        </el-col>
      </el-row>
    </basic-container>
  </div>
</template>

<script>
  import { getPage, getObj, addObj, putObj, delObj} from '@/api/wxma/wxuser'
  import { getList as getWxAppList } from '@/api/wxmp/wxapp'
  import { tableOption } from '@/const/crud/wxma/wxuser'
  import { mapGetters } from 'vuex'
  export default {
    name: 'wxuser',
    data() {
      return {
        filterText: '',
        treeWxAppProps: {
          label: 'name',
          value: 'id'
        },
        treeWxAppData: [],
        appId: null,
        wxUserId:'',
        tableData: [],
        page: {
          total: 0, // 总页数
          currentPage: 1, // 当前页数
          pageSize: 20, // 每页显示多少条
          ascs: [],
          descs: 'create_time'
        },
        paramsSearch:{},
        tableLoading: false,
        tableOption: tableOption,
        selectionData:[],
        dialogTagging:false,
        checkedTags:[],
        userTagsData:[],
        taggingType:'',
        tagId: ''
      }
    },
    watch: {
      filterText(val) {
        this.$refs.tree.filter(val)
      }
    },
    created() {
      this.getWxAppList()
    },
    mounted: function() { },
    computed: {
      ...mapGetters(['permissions']),
      permissionList() {
        return {
          addBtn: this.permissions['wxmp:wxuser:add'] ? true : false,
          delBtn: this.permissions['wxmp:wxuser:del'] ? true : false,
          editBtn: this.permissions['wxmp:wxuser:edit'] ? true : false,
          viewBtn: this.permissions['wxmp:wxuser:get'] ? true : false
        }
      }
    },
    methods: {
      filterNode(value, data) {
        if (!value) return true
        return data.name.indexOf(value) !== -1
      },
      //加载小程序列表
      getWxAppList(){
        getWxAppList({
          appType: '1'
        }).then(response => {
          let data = response.data
          this.treeWxAppData = data
          if(data && data.length > 0){
            //默认加载第一个小程序的数据
            this.nodeClick({
              id: data[0].id
            })
          }
        }).catch(() => {

        })
      },
      nodeClick(data) {
        if(this.appId != data.id){
          this.$nextTick(() => {
            this.$refs.tree.setCurrentKey(data.id)
          })
          this.page.currentPage = 1
          this.appId = data.id
          this.paramsSearch = {}
          this.$refs.crud.searchReset()
          this.getPage(this.page)
        }
      },
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
        if(this.appId){
          this.tableLoading = true
          getPage(Object.assign({
            current: page.currentPage,
            size: page.pageSize,
            descs: this.page.descs,
            ascs: this.page.ascs,
            appType: '1',
            appId: this.appId,
            tagId: this.tagId
          }, params, this.paramsSearch)).then(response => {
            this.tableData = response.data.data.records
            this.page.total = response.data.data.total
            this.page.currentPage = page.currentPage
            this.page.pageSize = page.pageSize
            this.tableLoading = false
          }).catch(() => {
            this.tableLoading = false
          })
        }
      },
      handleDel: function(row, index) {
        var _this = this
        this.$confirm('是否确认删除', '提示', {
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
      }
    }
  }
</script>

<style lang="scss" scoped>
</style>
