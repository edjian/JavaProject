<template>
  <div class="avue-top">
    <div class="top-bar__left">
      <div class="avue-breadcrumb"
           v-if="showCollapse">
        <i class="icon-navicon avue-breadcrumb_collapse" style="font-size: 35px!important"
           :class="[{ 'avue-breadcrumb_collapse--right': isCollapse }]"
           @click="setCollapse"></i>
      </div>
    </div>
    <h1 class="top-bar__title">
      <div class="top-bar__item top-bar__item--show"
           v-if="showMenu">
        <top-menu></top-menu>
      </div>
      <span class="top-bar__item"
            v-if="showSearch">
        <top-search></top-search>
      </span>
    </h1>
    <div class="top-bar__right">
      <el-tooltip effect="dark"
                  content="了解源码"
                  placement="bottom">
        <div class="top-bar__item">
          <el-link type="success" href="http://www.joolun.com/" target="_blank">获取源码</el-link>
        </div>
      </el-tooltip>
      <el-tooltip v-if="showColor"
                  effect="dark"
                  content="主题色"
                  placement="bottom">
        <div class="top-bar__item">
          <top-color></top-color>
        </div>
      </el-tooltip>
      <el-tooltip v-if="showDebug"
                  effect="dark"
                  :content="logsFlag?'没有错误日志':`${logsLen}条错误日志`"
                  placement="bottom">
        <div class="top-bar__item">
          <top-logs></top-logs>
        </div>
      </el-tooltip>
      <el-tooltip v-if="showLock"
                  effect="dark"
                  content="锁屏"
                  placement="bottom">
        <div class="top-bar__item">
          <top-lock></top-lock>
        </div>
      </el-tooltip>
      <el-tooltip v-if="showTheme"
                  effect="dark"
                  content="特色主题"
                  placement="bottom">
        <div class="top-bar__item">
          <top-theme></top-theme>
        </div>
      </el-tooltip>
      <div class="top-bar__item">
        <top-msg @showMsg="showMsg"></top-msg>
        <el-dialog title="用户消息" :visible.sync="dialogMsgVisible" width="40%">
          <WxMsg :appId="appId" :wxUserId="wxUserId" v-if="dialogMsgVisible"></WxMsg>
        </el-dialog>
      </div>
      <el-tooltip v-if="showFullScren"
                  effect="dark"
                  :content="isFullScren?'退出全屏':'全屏'"
                  placement="bottom">
        <div class="top-bar__item">
          <i :class="isFullScren?'icon-tuichuquanping':'icon-quanping'"
             @click="handleScreen"></i>
        </div>
      </el-tooltip>
      <el-tooltip v-if="this.userInfo.avatar"
                  effect="dark"
                  content="用户头像"
                  placement="bottom">
        <div class="top-bar__item" style="margin-right: -5px">
          <img id="thumbnail"
             class="top-bar__img" :src="userInfo.avatar">
        </div>
      </el-tooltip>
      <el-dropdown>
        <span class="el-dropdown-link">
          <div class="top-bar__item">
          {{userInfo.username}}
          </div>
          <i class="el-icon-arrow-down el-icon--right"></i>
        </span>
        <el-dropdown-menu slot="dropdown">
          <el-dropdown-item>
            <router-link to="/">首页</router-link>
          </el-dropdown-item>
          <el-dropdown-item>
            <router-link to="/info/index">个人信息</router-link>
          </el-dropdown-item>
          <el-dropdown-item>
            <div @click="showMenuTree">我的权限</div>
          </el-dropdown-item>
          <el-dropdown-item @click.native="logout"
                            divided>退出系统
          </el-dropdown-item>
        </el-dropdown-menu>
        <el-dialog title="我的权限"
                   :visible.sync="dialogMenuTree">
          <el-tree class="filter-tree"
                   :data="menuTree"
                   node-key="id"
                   highlight-current
                   :props="defaultProps"
                   ref="menuTree">
          </el-tree>
        </el-dialog>
      </el-dropdown>
      <div class="top-bar__item">
        <top-setting ref="seting"></top-setting>
      </div>
    </div>
  </div>
</template>
<script>
  import { mapGetters, mapState } from "vuex";
  import { fullscreenToggel, listenfullscreen } from "@/util/util";
  import topLock from "./top-lock";
  import topMenu from "./top-menu";
  import topSearch from "./top-search";
  import topBreadcrumb from "./top-breadcrumb";
  import topColor from "./top-color";
  import topTheme from "./top-theme";
  import topLogs from "./top-logs";
  import topSetting from "./top-setting";
  import topMsg from "./top-msg";
  import WxMsg from '@/components/wx-msg/main.vue'
  import {fetchMenuTree} from "@/api/admin/menu"

  export default {
    components: { topLock, topMenu, topSearch, topBreadcrumb, topColor, topTheme, topLogs, topSetting, topMsg, WxMsg },
    name: "top",
    data() {
      return {
        dialogMsgVisible: false,
        appId: '',
        wxUserId: '',
        dialogMenuTree: false,
        menuTree: [],
        defaultProps: {
          label: "name",
          value: 'id'
        },
      };
    },
    filters: {},
    created() {

    },
    mounted() {
      listenfullscreen(this.setScreen);
    },
    computed: {
      ...mapState({
        showDebug: state => state.common.showDebug,
        showColor: state => state.common.showColor,
        showTheme: state => state.common.showTheme,
        showLock: state => state.common.showLock,
        showFullScren: state => state.common.showFullScren,
        showCollapse: state => state.common.showCollapse,
        showSearch: state => state.common.showSearch,
        showMenu: state => state.common.showMenu
      }),
      ...mapGetters([
        "userInfo",
        "isFullScren",
        "tagWel",
        "tagList",
        "isCollapse",
        "tag",
        "logsLen",
        "logsFlag"
      ]),
    },
    methods: {
      showMenuTree(){
        this.dialogMenuTree = true
        fetchMenuTree()
          .then(response => {
            let menuTree  = response.data.data
            this.menuTree = menuTree
          })
      },
      showMsg(row){
        this.dialogMsgVisible = true
        this.wxUserId = row.wxUserId
        this.appId = row.appId
      },
      handleScreen() {
        fullscreenToggel();
      },
      setCollapse() {
        this.$store.commit("SET_COLLAPSE");
      },
      setScreen() {
        this.$store.commit("SET_FULLSCREN");
      },
      logout() {
        this.$confirm("是否退出系统, 是否继续?", "提示", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(() => {
          this.$store.dispatch("LogOut").then(() => {
            this.$router.push({path: "/login"});
          });
        });
      }
    }
  };
</script>

<style lang="scss" scoped>
</style>
