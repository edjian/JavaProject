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
                 :data="tableData"
                 :permission="permissionList"
                 :table-loading="tableLoading"
                 :option="tableOption"
                 @on-load="getPage"
                 @refresh-change="refreshChange"
                 @row-update="handleUpdate"
                 @row-save="handleSave"
                 @row-del="handleDel"
                 @current-change="currentChange">
        <template slot="parentIdForm"
                  slot-scope="scope">
          <avue-input v-model="scope.row.parentId"
                      type="tree"
                      placeholder="请选择所属机构"
                      :disabled="scope.row.id != undefined && scope.row.parentId != ''"
                      :dic="parentTreeData"
                      :props="categoryProps"></avue-input>
        </template>
        <template slot="picUrlForm"
                  slot-scope="scope">
          <MaterialList v-model="scope.row.picUrl" type="image" :num=1 :width='scope.row.parentId == "0" ? 300 : 150' :height=150></MaterialList>
        </template>
        <template slot="picUrl" slot-scope="scope">
          <img
            style="height: 100px"
            :src="scope.row.picUrl">
        </template>
      </avue-crud>
    </basic-container>
  </div>
</template>

<script>
    import {getPage, fetchTree, fetchParentTree, getObj, addObj, putObj, delObj} from '@/api/mall/goodscategory'
    import {tableOption} from '@/const/crud/mall/goodscategory'
    import {mapGetters} from 'vuex'
    import MaterialList from '@/components/material/list.vue'

    export default {
        components: {
            MaterialList
        },
        name: 'goodscategory',
        data() {
            return {
                tableData: [],
                tableLoading: false,
                tableOption: tableOption,
                parentTreeData: [],
                categoryProps: {
                    label: 'name',
                    value: 'id'
                }
            }
        },
        created() {
            this.fetchParentTree()
        },
        mounted: function () {
        },
        computed: {
            ...mapGetters(['permissions']),
            permissionList() {
                return {
                    addBtn: this.vaildData(this.permissions.mall_goodscategory_add, false),
                    delBtn: this.vaildData(this.permissions.mall_goodscategory_del, false),
                    editBtn: this.vaildData(this.permissions.mall_goodscategory_edit, false),
                    viewBtn: this.vaildData(this.permissions.mall_goodscategory_get, false)
                };
            }
        },
        methods: {
            fetchParentTree() {
                fetchParentTree().then(response => {
                    this.parentTreeData = response.data.data
                })
            },
            currentChange(currentPage) {
                this.page.currentPage = currentPage
            },
            getPage() {
                this.tableLoading = true
                fetchTree().then(response => {
                    let tableData = response.data.data
                    tableData.forEach(item => {
                        item.picUrl = [item.picUrl]
                        if(item.children){
                            item.children.forEach(item2 => {
                                item2.picUrl = [item2.picUrl]
                            })
                        }
                    })
                    this.tableData = tableData
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
                    this.getPage()
                    this.fetchParentTree()
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
                row.picUrl = row.picUrl[0]
                putObj(row).then(data => {
                    this.tableData.splice(index, 1, Object.assign({}, row))
                    this.$message({
                        showClose: true,
                        message: '修改成功',
                        type: 'success'
                    })
                    done()
                    this.getPage()
                    this.fetchParentTree()
                })
            },
            /**
             * @title 数据添加
             * @param row 为当前的数据
             * @param done 为表单关闭函数
             *
             **/
            handleSave: function (row, done) {
                row.picUrl = row.picUrl[0]
                addObj(row).then(data => {
                    this.tableData.push(Object.assign({}, row))
                    this.$message({
                        showClose: true,
                        message: '添加成功',
                        type: 'success'
                    })
                    done()
                    this.getPage()
                    this.fetchParentTree()
                })
            },
            /**
             * 刷新回调
             */
            refreshChange() {
                this.getPage()
                this.fetchParentTree()
            }
        }
    }
</script>

<style lang="scss" scoped>
</style>
