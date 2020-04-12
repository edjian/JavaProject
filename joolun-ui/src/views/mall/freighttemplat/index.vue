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
            </avue-crud>
        </basic-container>
    </div>
</template>

<script>
    import {getPage, getObj, addObj, putObj, delObj} from '@/api/mall/freighttemplat'
    import {tableOption} from '@/const/crud/mall/freighttemplat'
    import {mapGetters} from 'vuex'

    export default {
        name: 'freighttemplat',
        data() {
            return {
                form: {},
                tableData: [],
                page: {
                    total: 0, // 总页数
                    currentPage: 1, // 当前页数
                    pageSize: 20, // 每页显示多少条
                    ascs: 'sort',//升序字段
                    descs: []//降序字段
                },
                paramsSearch: {},
                tableLoading: false,
                tableOption: tableOption
            }
        },
        watch: {
            'form.type'() {
                let column1 = this.tableOption.column[3]
                let column5 = this.tableOption.column[4]
                let column2 = this.tableOption.column[5]
                let column3 = this.tableOption.column[6]
                let column4 = this.tableOption.column[7]
                if (this.form.type === '1') {
                    column1.display = true
                    if(this.form.chargeType){
                        column5.display = true
                        column2.display = true
                        column3.display = true
                        column4.display = true
                    }
                }
                if (!this.form.type || this.form.type === '2') {
                    column1.display = false
                    column2.display = false
                    column3.display = false
                    column4.display = false
                    column5.display = false
                }
            },
            'form.chargeType'() {
                let column1 = this.tableOption.column[4]
                let column2 = this.tableOption.column[5]
                let column3 = this.tableOption.column[6]
                let column4 = this.tableOption.column[7]
                if(this.form.chargeType && this.form.type === '1'){
                    column1.display = true
                    column2.display = true
                    column3.display = true
                    column4.display = true
                }else{
                    column1.display = false
                    column2.display = false
                    column3.display = false
                    column4.display = false
                }
                if (this.form.chargeType === '1') {
                    column1.label = '首件(个)'
                    column3.label = '续件(个)'
                    column1.precision = 0
                    column3.precision = 0
                }
                if (this.form.chargeType === '2') {
                    column1.label = '首重(kg)'
                    column3.label = '续重(kg)'
                    column1.precision = 2
                    column3.precision = 2
                }
                if (this.form.chargeType === '3') {
                    column1.label = '首体积(m³)'
                    column3.label = '续体积(m³)'
                    column1.precision = 2
                    column3.precision = 2
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
                    addBtn: this.permissions['mall:freighttemplat:add'] ? true : false,
                    delBtn: this.permissions['mall:freighttemplat:del'] ? true : false,
                    editBtn: this.permissions['mall:freighttemplat:edit'] ? true : false,
                    viewBtn: this.permissions['mall:freighttemplat:get'] ? true : false
                };
            }
        },
        methods: {
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
