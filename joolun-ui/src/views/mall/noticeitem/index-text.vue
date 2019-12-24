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
      <el-row :span="24" :gutter="20">
        <el-col :xs="24"
                :sm="24"
                :md="6">
          <el-card class="box-card">
            <div slot="header" class="clearfix">
              <span>手机预览</span>
              <span style="margin-left: 10px;font-size: 12px;color: #72767b">效果仅供参考，以实际手机效果为准</span>
            </div>
            <el-carousel height="35px" indicator-position="outside">
              <div style="background-color: #E6A23C;height: 100%;line-height: 35px;">
                <i class="el-icon-bell" style="margin-left: 5px"></i>
                <el-carousel-item v-for="(item,index) in tableData" :key="index" v-if="item.enable == '1'" style="padding-left: 30px;width: 85%">
                  <div style="font-size: 14px"><el-tag size="mini" type="danger">{{item.tag}}</el-tag> {{item.content}}</div>
                </el-carousel-item>
              </div>
            </el-carousel>
          </el-card>
        </el-col>
        <el-col :xs="24"
                :sm="24"
                :md="18">
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
                     @search-change="searchChange">
            <template slot="urlForm"
                      slot-scope="scope">
              <MaterialList v-model="scope.row.url" type="image" :num=1 :width=300 :height=150></MaterialList>
            </template>
            <template slot="url" slot-scope="scope">
              <img
                style="height: 100px"
                :src="scope.row.url">
            </template>
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
          </avue-crud>
        </el-col>
      </el-row>
    </basic-container>
  </div>
</template>

<script>
    import {getPage, getObj, addObj, putObj, delObj} from '@/api/mall/noticeitem'
    import {tableOption2} from '@/const/crud/mall/noticeitem'
    import {mapGetters} from 'vuex'
    import MaterialList from '@/components/material/list.vue'

    export default {
        components: {
            MaterialList
        },
        name: 'noticeitem',
        data() {
            return {
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
                tableOption: tableOption2,
                appId: this.$route.query.id,
                noticeType: this.$route.query.noticeType
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
                    addBtn: this.vaildData(this.permissions.mall_noticeitem_add, false),
                    delBtn: this.vaildData(this.permissions.mall_noticeitem_del, false),
                    editBtn: this.vaildData(this.permissions.mall_noticeitem_edit, false),
                    viewBtn: this.vaildData(this.permissions.mall_noticeitem_get, false)
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
                getPage(Object.assign({
                    current: page.currentPage,
                    size: page.pageSize,
                    descs: this.page.descs,
                    ascs: this.page.ascs,
                    appId: this.appId,
                    noticeType: this.noticeType
                }, params, this.paramsSearch)).then(response => {
                    let tableData = response.data.data.records
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
                addObj(Object.assign({
                    appId: this.appId,
                    noticeType: this.noticeType,
                    type: '2'
                }, row)).then(data => {
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

<style lang="scss" scoped>
</style>
