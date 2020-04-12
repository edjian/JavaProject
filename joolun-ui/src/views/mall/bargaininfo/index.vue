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
                       @search-change="searchChange">
                <template slot="enable" slot-scope="scope">
                    <el-switch
                            active-value="1"
                            inactive-value="0"
                            v-model="scope.row.enable"
                            active-color="#13ce66"
                            inactive-color="#ff4949"
                            @change="changeEnable(scope.row)">
                    </el-switch>
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
    import {getPage, getObj, addObj, putObj, delObj} from '@/api/mall/bargaininfo'
    import {tableOption} from '@/const/crud/mall/bargaininfo'
    import {mapGetters} from 'vuex'
    import MaterialList from '@/components/material/list.vue'

    export default {
        components: {
            MaterialList
        },
        name: 'bargaininfo',
        data() {
            return {
                form: {},
                tableData: [],
                page: {
                    total: 0, // 总页数
                    currentPage: 1, // 当前页数
                    pageSize: 20, // 每页显示多少条
                    ascs: [],//升序字段
                    descs: []//降序字段
                },
                paramsSearch: {},
                tableLoading: false,
                tableOption: tableOption
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
                    addBtn: this.permissions['mall:bargaininfo:add'] ? true : false,
                    delBtn: this.permissions['mall:bargaininfo:del'] ? true : false,
                    editBtn: this.permissions['mall:bargaininfo:edit'] ? true : false,
                    viewBtn: this.permissions['mall:bargaininfo:get'] ? true : false
                };
            }
        },
        methods: {
            changeEnable(row){
                putObj({
                    id: row.id,
                    enable: row.enable
                }).then(data => {

                })
            },
            beforeOpen(done,type){
                if(type == 'add'){
                    this.form.validTime = []
                }else{
                    let validTime = []
                    validTime.push(this.form.validBeginTime)
                    validTime.push(this.form.validEndTime)
                    this.form.validTime = validTime
                }
                if(type == 'add'){
                    this.form.picUrl = []
                }else{
                    this.form.picUrl = [this.form.picUrl]
                }
                done()
            },
            searchChange(params,done) {
                params = this.filterForm(params)
                this.paramsSearch = params
                this.page.currentPage = 1
                this.getPage(this.page, params)
                done()
            },
            sortChange(val) {
                let prop = val.prop ? val.prop.replace(/([A-Z])/g, "_$1").toLowerCase() : ''
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
            handleUpdate: function (row, index, done, loading) {
                row.picUrl = row.picUrl.length > 0 ? row.picUrl[0] : ''
                row.validBeginTime = row.validTime[0]
                row.validEndTime = row.validTime[1]
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
            handleSave: function (row, done, loading) {
                row.picUrl = row.picUrl.length > 0 ? row.picUrl[0] : ''
                row.validBeginTime = row.validTime[0]
                row.validEndTime = row.validTime[1]
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
