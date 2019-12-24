<!--
  - Copyright (C) 2018-2019
  - All rights reserved, Designed By www.joolun.com
  - 注意：
  - 本软件为www.joolun.com开发研制，未经购买不得使用
  - 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
  - 一经发现盗用、分享等行为，将追究法律责任，后果自负
-->
<template>
  <div v-if="type == 'image'">
    <ul class="el-upload-list el-upload-list--picture-card" v-for="(item,index) in value" :key="index">
      <li tabindex="0" class="el-upload-list__item is-ready" :style="'width: '+width+'px;height: '+height+'px'">
        <div>
          <img :src="item" alt="" class="el-upload-list__item-thumbnail">
          <span class="el-upload-list__item-actions">
            <span class="el-upload-list__item-preview" v-if="index != 0" @click="moveMaterial(index,'up')">
              <i class="el-icon-back"></i>
            </span>
            <span class="el-upload-list__item-preview" @click="zoomMaterial(index)">
              <i class="el-icon-view"></i>
            </span>
            <span class="el-upload-list__item-delete" @click="deleteMaterial(index)">
              <i class="el-icon-delete"></i>
            </span>
            <span class="el-upload-list__item-preview" v-if="index != value.length-1" @click="moveMaterial(index,'down')">
              <i class="el-icon-right"></i>
            </span>
          </span>
        </div>
      </li>
    </ul>
    <div tabindex="0" class="el-upload el-upload--picture-card" v-if="num > value.length" @click="toSeleteMaterial" :style="'width: '+width+'px;height: '+height+'px;'+'line-height:'+height+'px;'">
      <i class="el-icon-plus"></i>
    </div>

    <el-dialog
      append-to-body
      :visible.sync="dialogVisible"
      width="35%">
      <img :src="url" alt="" style="width: 100%">
    </el-dialog>

    <el-dialog
      title="素材库"
      append-to-body
      :visible.sync="listDialogVisible"
      width="70%">
      <el-container>
        <el-aside width="unset">
          <div style="margin-bottom: 10px">
            <el-button
              class="el-icon-plus"
              size="small"
              @click="materialgroupAdd()">
              添加分组
            </el-button>
          </div>
          <el-tabs tab-position="left" v-model="materialgroupObjId" v-loading="materialgroupLoading" @tab-click="tabClick">
            <el-tab-pane v-for="(item,index) in materialgroupList"
                         :key="index"
                         :name="item.id">
              <span slot="label"> {{item.name}}</span>
            </el-tab-pane>
          </el-tabs>
        </el-aside>
        <el-main>
          <el-card>
            <div slot="header">
              <el-row>
                <el-col :span="12">
                  <span>{{materialgroupObj.name}}</span>
                  <span v-if="materialgroupObj.id != '-1'">
                    <el-button size="small" type="text" class="el-icon-edit" style="margin-left: 10px;" @click="materialgroupEdit(materialgroupObj)">重命名</el-button>
                    <el-button size="small" type="text" class="el-icon-delete" style="margin-left: 10px;color: red" @click="materialgroupDelete(materialgroupObj)">删除</el-button>
                  </span>
                </el-col>
                <el-col :span="12" style="text-align: right;">
                  <el-upload
                    action="/admin/file/upload?dir=material/"
                    :headers="headers"
                    :file-list="[]"
                    :on-progress="handleProgress"
                    :before-upload="beforeUpload"
                    :on-success="handleSuccess">
                    <el-button size="small" type="primary">点击上传</el-button>
                  </el-upload>
                </el-col>
              </el-row>
            </div>
            <div v-loading="tableLoading">
              <el-alert
                v-if="tableData.length <= 0"
                title="暂无数据"
                type="info"
                :closable="false"
                center
                show-icon>
              </el-alert>
              <el-row :gutter="5">
                <el-checkbox-group v-model="urls" :max="num - value.length">
                  <el-col :span="4" v-for="(item,index) in tableData" :key="index">
                  <el-card :body-style="{ padding: '5px' }">
                    <el-image
                      style="width: 100%;height: 200px"
                      :src="item.url"
                      fit="contain"
                      :preview-src-list="[item.url]"></el-image>
                    <div>
                      <el-checkbox class="material-name" :label="item.url">{{item.name}}</el-checkbox>
                      <el-row>
                        <el-col :span="6" class="col-do">
                          <el-button type="text" class="button-do" @click="materialRename(item)">改名</el-button>
                        </el-col>
                        <el-col :span="6" class="col-do">
                          <el-button type="text" class="button-do" @click="materialUrl(item)">链接</el-button>
                        </el-col>
                        <el-col :span="6" class="col-do">
                          <el-dropdown trigger="click" @command="handleCommand">
                            <el-button type="text" class="button-do">分组<i class="el-icon-arrow-down"></i></el-button>
                            <el-dropdown-menu slot="dropdown">
                              <el-dropdown-item v-for="(item2,index) in materialgroupList"
                                                v-if="index > 0"
                                                :key="index"
                                                :command="item.id + '-' + item2.id"
                                                :disabled="item.groupId == item2.id">{{item2.name}}</el-dropdown-item>
                            </el-dropdown-menu>
                          </el-dropdown>
                        </el-col>
                        <el-col :span="6" class="col-do">
                          <el-button type="text" class="button-do" style="color: red" @click="materialDel(item)">删除</el-button>
                        </el-col>
                      </el-row>
                    </div>
                  </el-card>
                </el-col>
                </el-checkbox-group>
              </el-row>
              <el-pagination
                @size-change="sizeChange"
                :current-page.sync="page.currentPage"
                :page-sizes="[12, 24]"
                :page-size="page.pageSize"
                layout="total, sizes, prev, pager, next, jumper"
                :total="page.total"
                class="pagination">
              </el-pagination>
            </div>
          </el-card>
        </el-main>
      </el-container>
      <span slot="footer" class="dialog-footer">
        <el-button @click="listDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="sureUrls">确 定</el-button>
      </span>
    </el-dialog>
  </div>

</template>

<script>
  import { getPage as materialgroupPage, addObj as  materialgroupAdd, delObj as materialgroupDel, putObj as materialgroupEdit} from '@/api/mall/materialgroup'
  import { getPage , addObj, delObj, putObj} from '@/api/mall/material'
  import store from "@/store"

  export default {
    name: "materialList",
    props: {
      //素材数据
      value:{
        type: Array,
        default() {
          return []
        },
      },
      //素材类型
      type:{
        type: String,
      },
      //素材限制数量，默认5个
      num:{
        type: Number,
        default() {
          return 5
        },
      },
      //宽度
      width: {
        type: Number,
        default() {
          return 150
        }
      },
      //宽度
      height: {
        type: Number,
        default() {
          return 150
        }
      }
    },
    data() {
      return {
        headers:{
          Authorization: 'Bearer ' + store.getters.access_token
        },
        dialogVisible: false,
        url: '',
        listDialogVisible: false,
        materialgroupList: [],
        materialgroupObjId: '',
        materialgroupObj: {},
        materialgroupLoading: false,
        tableData: [],
        page: {
          total: 0, // 总页数
          currentPage: 1, // 当前页数
          pageSize: 12, // 每页显示多少条
          ascs: [],//升序字段
          descs: 'create_time'//降序字段
        },
        tableLoading: false,
        groupId: null,
        urls: []
      }
    },
    methods:{
      moveMaterial(index,type){
        if(type == 'up'){
          let tempOption = this.value[index - 1]
          this.$set(this.value, index - 1, this.value[index])
          this.$set(this.value, index, tempOption)
        }
        if(type == 'down'){
          let tempOption = this.value[index + 1]
          this.$set(this.value, index + 1, this.value[index])
          this.$set(this.value, index, tempOption)
        }
      },
      zoomMaterial(index){
        this.dialogVisible = true
        this.url = this.value[index]
      },
      deleteMaterial(index){
        let that = this
        this.$confirm('是否确认删除？', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(function() {
          that.value.splice(index,1)
          that.urls = []
        })
      },
      toSeleteMaterial(){
        this.listDialogVisible = true
        if(this.tableData.length <= 0){
          this.materialgroupPage()
        }
      },
      materialgroupPage(){
        this.materialgroupLoading = true
        materialgroupPage({
          total: 0, // 总页数
          currentPage: 1, // 当前页数
          pageSize: 100, // 每页显示多少条
          ascs: [],//升序字段
          descs: 'create_time'//降序字段
        }).then(response => {
          this.materialgroupLoading = false
          let materialgroupList = response.data.data.records
          materialgroupList.unshift({
            id: '-1',
            name: '全部分组'
          })
          this.materialgroupList = materialgroupList
          this.tabClick({
            index: 0
          })
        })
      },
      materialgroupDelete(materialgroupObj){
        let that = this
        this.$confirm('是否确认删除该分组？', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(function() {
          materialgroupDel(materialgroupObj.id)
            .then(function() {
              that.$delete(that.materialgroupList, materialgroupObj.index)
            })
        })
      },
      materialgroupEdit(materialgroupObj){
        let that = this
        this.$prompt('请输入分组名', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          inputValue: materialgroupObj.name,
        }).then(({ value }) => {
          materialgroupEdit({
            id: materialgroupObj.id,
            name: value
          }).then(function() {
            materialgroupObj.name = value
            that.$set(that.materialgroupList, materialgroupObj.index, materialgroupObj)
          })
        }).catch(() => {

        })
      },
      materialgroupAdd(){
        let that = this
        this.$prompt('请输入分组名', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
        }).then(({ value }) => {
          materialgroupAdd({
            name: value
          }).then(function() {
            that.materialgroupPage()
          })
        }).catch(() => {

        })
      },
      tabClick(tab,event){
        this.urls = []
        let index = Number(tab.index)
        let materialgroupObj = this.materialgroupList[index]
        materialgroupObj.index = index
        this.materialgroupObj = materialgroupObj
        this.materialgroupObjId = materialgroupObj.id
        this.page.currentPage = 1
        this.page.total = 0
        if(materialgroupObj.id != '-1'){
          this.groupId = materialgroupObj.id
        }else{
          this.groupId = null
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
        }, {
          groupId: this.groupId
        })).then(response => {
          let tableData = response.data.data.records
          this.page.total = response.data.data.total
          this.page.currentPage = page.currentPage
          this.page.pageSize = page.pageSize
          this.tableData = tableData
          this.tableLoading = false
        }).catch(() => {
          this.tableLoading=false
        })
      },
      sizeChange(val) {
        this.page.currentPage = 1
        this.page.pageSize = val
        this.getPage(this.page)
      },
      materialRename(item){
        let that = this
        this.$prompt('请输入素材名', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          inputValue: item.name,
        }).then(({ value }) => {
          putObj({
            id: item.id,
            name: value
          }).then(function() {
            that.getPage(that.page)
          })
        }).catch(() => {

        })
      },
      materialUrl(item){
        let that = this
        this.$prompt('素材链接', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          inputValue: item.url,
        }).then(({ value }) => {

        }).catch(() => {

        })
      },
      materialDel(item){
        let that = this
        this.$confirm('是否确认删除该素材？', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(function() {
          delObj(item.id)
            .then(function() {
              that.getPage(that.page)
            })
        })
      },
      handleCommand(command) {
        let that = this
        let s = command.split('-')
        putObj({
          id: s[0],
          groupId: s[1]
        }).then(function() {
          that.getPage(that.page)
        })
      },
      handleProgress(event, file, fileList){
        // let uploadProgress = file.percentage.toFixed(0)
        // this.uploadProgress = uploadProgress
      },
      handleSuccess(response, file, fileList){
        let that = this
        this.uploadProgress = 0
        addObj({
          type: '1',
          groupId: this.groupId != '-1' ? this.groupId : null,
          name: file.name,
          url: response.link
        }).then(function() {
          that.getPage(that.page)
        })
      },
      beforeUpload(file){
        const isPic =
          file.type === "image/jpeg" ||
          file.type === "image/png" ||
          file.type === "image/gif" ||
          file.type === "image/jpg"
        const isLt2M = file.size / 1024 / 1024 < 2
        if (!isPic) {
          this.$message.error("上传图片只能是 JPG、JPEG、PNG、GIF 格式!")
          return false
        }
        if (!isLt2M) {
          this.$message.error('上传头像图片大小不能超过 2MB!')
        }
        return isPic && isLt2M
      },
      sureUrls(){
        this.urls.forEach(item => {
          this.$set(this.value,this.value.length, item)
        })
        this.listDialogVisible=false
      }
    }
  };
</script>

<style lang="scss" scoped>
  .material-name{
    padding: 8px 0px;
  }
  .col-do{
    text-align: center;
  }
  .button-do{
    padding: unset!important;
    font-size: 12px;
  }
</style>

