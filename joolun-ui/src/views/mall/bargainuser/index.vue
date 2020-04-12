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
                       v-model="form"
                       @on-load="getPage"
                       @refresh-change="refreshChange"
                       @row-update="handleUpdate"
                       @row-save="handleSave"
                       @row-del="handleDel"
                       @sort-change="sortChange"
                       @search-change="searchChange">
                <template slot-scope="scope" slot="userId">
                    <el-row v-if="scope.row.userInfo">
                        <el-col :span="8" style="text-align: right">
                            <el-image :src="scope.row.userInfo.headimgUrl" style="width: 50px">
                                <div slot="error" class="image-slot">
                                    <i class="el-icon-picture-outline"></i>
                                </div>
                            </el-image>
                        </el-col>
                        <el-col :span="16" style="text-align: left; padding-left: 10px">
                            <div>昵称：{{scope.row.userInfo.nickName ? scope.row.userInfo.nickName : '匿名'}}</div>
                            <div>编号：{{scope.row.userInfo.userCode}}</div>
                        </el-col>
                    </el-row>
                </template>
                <template slot-scope="scope" slot="status">
                    <el-tag size="mini" :type="scope.row.status == '0' ? 'warning' : scope.row.status == '1' ? 'success' : 'danger'" effect="dark">{{scope.row.$status}}</el-tag>
                </template>
                <template slot-scope="scope" slot="havBargainAmount">
                    <div @click="showCut(scope.row.id)">
                        <i style="color: red">{{scope.row.havBargainAmount}}</i>
                        <i class="el-icon-view" style="margin-left: 10px">明细</i>
                    </div>
                </template>
            </avue-crud>
            <el-dialog
                    title="帮砍明细"
                    :visible.sync="dialogVisibleCut"
                    width="60%">
                <avue-crud ref="crud"
                           :page="page2"
                           :data="tableData2"
                           :table-loading="tableLoading2"
                           :option="tableOption2"
                           @on-load="getPage2">
                    <template slot-scope="scope" slot="userId">
                        <el-row>
                            <el-col :span="8" style="text-align: right">
                                <el-image :src="scope.row.headimgUrl" style="width: 50px">
                                    <div slot="error" class="image-slot">
                                        <i class="el-icon-picture-outline"></i>
                                    </div>
                                </el-image>
                            </el-col>
                            <el-col :span="16" style="text-align: left; padding-left: 10px">
                                <div>昵称：{{scope.row.nickName}}</div>
                            </el-col>
                        </el-row>
                    </template>
                </avue-crud>
            </el-dialog>
        </basic-container>
    </div>
</template>

<script>
    import {getPage, getObj, addObj, putObj, delObj} from '@/api/mall/bargainuser'
    import {tableOption} from '@/const/crud/mall/bargainuser'
    import {getPage as getPage2} from '@/api/mall/bargaincut'
    import {tableOption2} from '@/const/crud/mall/bargaincut'
    import {mapGetters} from 'vuex'

    export default {
        name: 'bargainuser',
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
                dialogVisibleCut: false,
                tableData2: [],
                page2: {
                    total: 0, // 总页数
                    currentPage: 1, // 当前页数
                    pageSize: 10, // 每页显示多少条
                    ascs: [],//升序字段
                    descs: 'create_time'//降序字段
                },
                tableLoading2: false,
                tableOption2: tableOption2
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
                    addBtn: this.permissions['mall:bargainuser:add'] ? true : false,
                    delBtn: this.permissions['mall:bargainuser:del'] ? true : false,
                    editBtn: this.permissions['mall:bargainuser:edit'] ? true : false,
                    viewBtn: this.permissions['mall:bargainuser:get'] ? true : false
                };
            }
        },
        methods: {
            getPage2(page, params) {
                if(params && params.bargainUserId) {
                    this.tableLoading2 = true
                    getPage2(Object.assign({
                        current: page.currentPage,
                        size: page.pageSize,
                        descs: this.page2.descs,
                        ascs: this.page2.ascs,
                    }, params)).then(response => {
                        this.tableData2 = response.data.data.records
                        this.page2.total = response.data.data.total
                        this.page2.currentPage = page.currentPage
                        this.page2.pageSize = page.pageSize
                        this.tableLoading2 = false
                    }).catch(() => {
                        this.tableLoading2 = false
                    })
                }
            },
            showCut(bargainUserId) {
                this.tableData2 = []
                this.dialogVisibleCut = true
                this.getPage2(this.page2, {
                    bargainUserId: bargainUserId
                })
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
