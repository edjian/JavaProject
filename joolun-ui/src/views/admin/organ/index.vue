<template>
  <div class="app-container calendar-list-container">
    <basic-container>
      <avue-crud
        @on-load="getPage"
        :option="tableOption"
        :data="tableData"
        :permission="permissionList"
        :table-loading="tableLoading"
        @refresh-change="refreshChange"
        @row-update="handleUpdate"
        @row-save="handleSave"
        @row-del="rowDel"
        @current-change="currentChange">
        <template slot="parentIdForm"
                  slot-scope="scope">
          <avue-input v-model="scope.row.parentId"
                      type="tree"
                      placeholder="请选择所属机构"
                      :dic="tableData"
                      :props="organProps"></avue-input>
        </template>
      </avue-crud>
    </basic-container>
  </div>
</template>

<script>
  import {addObj, delObj, fetchTree, getObj, putObj} from '@/api/admin/organ'
  import { tableOption } from '@/const/crud/admin/organ'
  import {mapGetters} from 'vuex'

  export default {
    name: 'organ',
    data() {
      return {
        tableOption: tableOption,
        tableData: [],
        tableLoading: false,
        organProps: {
          label: 'name',
          value: 'id',
        },
      }
    },
    created() {
    },
    computed: {
      ...mapGetters(['permissions']),
      permissionList() {
        return {
          addBtn: this.vaildData(this.permissions.sys_organ_add, false),
          delBtn: this.vaildData(this.permissions.sys_organ_del, false),
          editBtn: this.vaildData(this.permissions.sys_organ_edit, false),
          viewBtn: this.vaildData(this.permissions.sys_organ_get, false)
        }
      }
    },
    methods: {
      currentChange(currentPage){
        this.page.currentPage = currentPage
      },
      getPage() {
        fetchTree().then(response => {
          this.tableData = response.data.data
        })
      },
      rowDel: function(row, index) {
        var _this = this
        this.$confirm('是否确认删除此数据', '提示', {
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
          this.getPage()
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
          this.getPage()
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
          this.getPage()
        })
      },
      /**
       * 刷新回调
       */
      refreshChange() {
        this.getPage()
      }
    }
  }
</script>

