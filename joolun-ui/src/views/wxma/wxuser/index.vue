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
                 :table-loading="tableLoading"
                 :option="tableOption"
                 :permission="permissionList"
                 @on-load="getPage"
                 @refresh-change="refreshChange"
                 @row-update="handleUpdate"
                 @row-save="handleSave"
                 @row-del="handleDel"
                 @sort-change="sortChange"
                 @search-change="searchChange"
                 @current-change="currentChange">
        <template slot="sex" slot-scope="scope" >
          <el-tag v-if="scope.row.sex" size="mini" effect="light" :type="scope.row.sex == '1' ? '' : scope.row.sex == '2' ? 'danger' : 'warning'">{{scope.row.$sex}}</el-tag>
        </template>
      </avue-crud>
    </basic-container>
  </div>
</template>

<script>
  import { getPage, getObj, addObj, putObj, delObj} from '@/api/wxma/wxuser'
  import { mapGetters } from 'vuex'
  export default {
    name: 'wxuser',
    data() {
      return {
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
        tableOption: {
          dialogDrag:true,
          border: true,
          index: false,
          indexLabel: '序号',
          stripe: true,
          menuAlign: 'center',
          align: 'center',
          editBtn: false,
          delBtn: false,
          addBtn: false,
          excelBtn: true,
          printBtn: true,
          viewBtn: true,
          searchShow: false,
          menuWidth: 150,
          menuType:'text',
          defaultSort:{
            prop: 'createTime',
            order: 'descending'
          },
          column: [
            {
              label: '用户标识',
              prop: 'openId',
              editDisplay:false
            },
            {
              label: '头像',
              prop: 'headimgUrl',
              type:'upload',
              imgWidth:50,
              listType:'picture-img',
              editDisplay:false
            },
            {
              label: '昵称',
              prop: 'nickName',
              width:100,
              sortable:true,
              search:true,
              editDisplay:false
            },
            {
              label: '性别',
              prop: 'sex',
              width: 60,
              type: 'select',
              sortable:true,
              search:true,
              editDisplay:false,
              slot:true,
              dicUrl: '/admin/dict/type/wx_sex'
            },
            {
              label: '所在国家',
              prop: 'country',
              sortable:true,
              search:true,
              editDisplay:false
            },
            {
              label: '所在省份',
              prop: 'province',
              sortable:true,
              editDisplay:false
            },
            {
              label: '所在城市',
              prop: 'city',
              sortable:true,
              search:true,
              editDisplay:false
            },
            {
              label: '用户语言',
              prop: 'language',
              sortable:true,
              editDisplay:false
            },
            {
              label: '用户备注',
              prop: 'remark',
              hide:true
            },
            {
              label: 'union_id',
              prop: 'unionId',
              hide:true,
              editDisplay:false
            },
            {
              label: '创建时间',
              prop: 'createTime',
              type: 'datetime',
              sortable:true,
              editDisplay:false
            },
            {
              label: '更新时间',
              prop: 'updateTime',
              type: 'datetime',
              sortable:true,
              hide:true,
              editDisplay:false
            }
          ]
        },
        appId:this.$route.query.id,
        selectionData:[],
        dialogTagging:false,
        checkedTags:[],
        userTagsData:[],
        taggingType:'',
        tagId: ''
      }
    },
    created() {
      this.listUserTags()
    },
    mounted: function() { },
    computed: {
      ...mapGetters(['permissions']),
      permissionList() {
        return {
          addBtn: this.vaildData(this.permissions.wxmp_wxuser_add, false),
          delBtn: this.vaildData(this.permissions.wxmp_wxuser_del, false),
          editBtn: this.vaildData(this.permissions.wxmp_wxuser_edit, false),
          viewBtn: this.vaildData(this.permissions.wxmp_wxuser_get, false)
        }
      }
    },
    methods: {
      currentChange(currentPage){
        this.page.currentPage = currentPage
      },
      searchChange(params){
        params = this.filterForm(params)
        this.paramsSearch = params
        this.page.currentPage = 1
        this.getPage(this.page,params)
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
          appId:this.appId,
          tagId: this.tagId
        }, params, this.paramsSearch)).then(response => {
          this.tableData = response.data.data.records
          this.page.total = response.data.data.total
          this.tableLoading = false
        }).catch(() => {
          this.tableLoading = false
        })
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
          _this.tableData.splice(index, 1)
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
      handleUpdate: function(row, index, done) {
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
      handleSave: function(row, done) {
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

<style lang="scss" scoped>
</style>
