<!--
  - Copyright (C) 2018-2019
  - All rights reserved, Designed By www.joolun.com
  - 注意：
  - 本软件为www.joolun.com开发研制，未经购买不得使用
  - 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
  - 一经发现盗用、分享等行为，将追究法律责任，后果自负
-->
<template>
  <div class="execution wx-menu-main">
    <basic-container>
      <el-row :span="24" :gutter="10">
        <el-col :xs="24"
                :sm="24"
                :md="3">
          <el-card shadow="never">
            <div slot="header">
              <span>公众号名称</span>
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
                :md="21"
                style="background-color: #F7F7F7">
          <el-tabs type="border-card" v-model="tabsValue" editable @edit="handleTabsEdit">
            <el-tab-pane
                    v-for="item in menuRuleData"
                    :key="item.name"
                    :label="item.name"
                    :name="item.name">
              <wx-menu :appId="appId" :menuName="menuName" :wxUserTags="wxUserTags" :menuRule="item" v-if="hackResetMenu"></wx-menu>
            </el-tab-pane>
          </el-tabs>
        </el-col>
      </el-row>
    </basic-container>
  </div>
</template>

<script>
  import { getPage as getPageMenuRule, addObj as addMenuRule, delObj as delMenuRule } from '@/api/wxmp/wxmenurule'
  import { delByRuleId } from '@/api/wxmp/wxmenu'
  import { getList as getWxAppList } from '@/api/wxmp/wxapp'
  import { getList as getWxUserTagsList } from '@/api/wxmp/wxusertags'
  import WxMenu from "@/components/wx-menu/main";

  export default {
    name: 'wxmenu',
    components: {
      WxMenu,
    },
    data(){
      return{
        filterText: '',
        treeWxAppProps: {
          label: 'name',
          value: 'id'
        },
        treeWxAppData: [],
        tabsValue: '',
        menuRuleData: [],
        appId: null,
        menuName: '',
        wxUserTags: [],
        hackResetMenu: true
      }
    },
    watch: {
      filterText(val) {
        this.$refs.tree.filter(val)
      }
    },
    created() {
    },
    mounted() {
      this.getWxAppList()
    },
    filters:{
    },
    computed: {
    },
    methods:{
      filterNode(value, data) {
        if (!value) return true
        return data.name.indexOf(value) !== -1
      },
      //加载公众号列表
      getWxAppList(){
        getWxAppList({
          appType: '2'
        }).then(response => {
          let data = response.data
          this.treeWxAppData = data
          if(data && data.length > 0){
            //默认加载第一个公众号的素材
            this.nodeClick({
              id: data[0].id,
              name: data[0].name
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
          this.appId = data.id
          this.menuName = data.name
          this.tabsValue = '默认菜单'
          this.menuRuleData = []
          this.wxUserTags = []
          this.getMenuRule()//获取菜单组列表
          this.getWxUserTagsList()//获取用户标签
        }
      },
      //获取菜单组列表
      getMenuRule(){
        getPageMenuRule({
          total: 0, // 总页数
          currentPage: 1, // 当前页数
          pageSize: 100,
          ascs: 'create_time',
          appId : this.appId
        }).then(response => {
          let data = response.data.data.records
          if(data == null || data.length <= 0){
            let mrc = {
              name: '默认菜单',
              menuType: '1',
              tag_id: ''
            }
            data.push(mrc)
          }
          this.menuRuleData = data
        }).catch(() => {

        })
      },
      getWxUserTagsList(){
        getWxUserTagsList({
          appId : this.appId
        }).then(response => {
          this.wxUserTags = response.data.data
        }).catch(() => {

        })
      },
      handleTabsEdit(targetName, action) {
        if (action === 'add') {
          let that = this
          this.$prompt('请输入名称', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            inputValidator: function(value){
              let b = that.menuRuleData.filter(tab => tab.name === value)
              if(b.length > 0){
                return('名称不能重复')
              }
            }
          }).then(({ value }) => {
            let newMenuRule = {
              name: value,
              menuType: '2',
              tag_id: ''
            }
            this.menuRuleData.push(newMenuRule)
            this.tabsValue = value
          }).catch(() => {

          })
        }
        if (action === 'remove') {
          let menuRule = this.menuRuleData.filter(tab => tab.name === targetName)[0]
          let str = '确定要删除菜单吗?'
          if(menuRule.menuType == '1'){
            str = '该菜单为【普通菜单】，将会删除所有【个性化菜单】，确定删除吗？'
          }
          this.$confirm(str, '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {
            if(menuRule.id){
              this.delByRuleId(menuRule)
            }else{
              this.delTab(targetName,menuRule)
            }
          })
        }
      },
      delByRuleId(menuRule){
        delByRuleId(menuRule.id).then(response => {
          this.delTab(menuRule.name,menuRule)
        }).catch(() => {

        })
      },
      delTab(targetName,menuRule){
        let tabs = this.menuRuleData
        let activeName = this.tabsValue
        if (activeName === targetName) {
          tabs.forEach((tab, index) => {
            if (tab.name === targetName) {
              let nextTab = tabs[index + 1] || tabs[index - 1]
              if (nextTab) {
                activeName = nextTab.name
              }
            }
          })
        }
        this.tabsValue = activeName
        if(menuRule.menuType == '1'){
          this.menuRuleData = []
        }else{
          this.menuRuleData = tabs.filter(tab => tab.name !== targetName)
        }
        if(this.menuRuleData.length <= 0){
          this.hackResetMenu = false//销毁组件
          this.$nextTick(() => {
            this.hackResetMenu = true//重建组件
          })
          this.tabsValue = '默认菜单'
          let mrc = {
            name: '默认菜单',
            menuType: '1',
            tag_id: ''
          }
          this.menuRuleData.push(mrc)
        }
      }
    }
  }
</script>

<style lang="scss">
  .wx-menu-main{
    .el-tabs__new-tab{
      margin: 12px 10px 9px 10px;
    }
  }
</style>