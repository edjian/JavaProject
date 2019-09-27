<template>
  <div class="login-container pull-height"
       @keyup.enter.native="handleLogin">
    <div class="login-logo animated fadeIn" onclick="window.open('http://www.joolun.com','_self')">
      <img src="/svg/logo.svg"
           alt="">
    </div>
    <div class="login-weaper">
      <div class="login-left animated fadeInLeft">
        <div class="login-info">
          <h2 class="login-info-title">JooLun微信快速开发平台</h2>
          <ul class="login-info-list">
            <li class="login-info-item">
              Spring Cloud微服务化开发，采用Nacos注册和配置中心，统一授权、认证
            </li>
            <li class="login-info-item">
              前后端完全分离框架
            </li>
            <li class="login-info-item">
              前端封装微信专用vue组件，开发中实现灵活调用，杜绝重复造轮子，让前端开发更容易
            </li>
            <li class="login-info-item">
              支持多公众号多账号管理，redis全局缓存access_token
            </li>
            <li class="login-info-item">
              支持第三方平台全网发布
            </li>
            <li class="login-info-item">
              代码简洁，架构清晰，restful接口规范，适合学习、毕设、实际项目等使用
            </li>
            <li class="login-info-item">
              源码采用私服GIT管理，终身免费升级更新
            </li>
            <li class="login-info-item">
              <el-link type="primary" href="http://www.joolun.com">了解更多</el-link>
            </li>
          </ul>
        </div>
      </div>
      <div class="login-border  animated fadeInRight">
        <div class="login-main">
          <userLogin v-if="activeName==='user'"></userLogin>
          <codeLogin v-else-if="activeName==='code'"></codeLogin>
          <thirdLogin v-else-if="activeName==='third'"></thirdLogin>
<!--          <register v-else-if="activeName==='register'"></register>-->
	  </div>
          <div class="login-menu">
            <a href="#"
               @click.stop="activeName='user'">账号登录</a>
            <a href="#"
               @click.stop="activeName='code'">手机号登录</a>
            <a href="#"
               @click.stop="activeName='third'">第三方登录</a>
<!--            <a href="#"-->
<!--               @click.stop="activeName='register'">免费注册</a>-->
          </div>
        </div>
    </div>
  </div>
</template>
<script>
  import userLogin from "./userlogin";
  import codeLogin from "./codelogin";
  import thirdLogin from "./thirdlogin";
  import register from "./register";
  import {mapGetters} from "vuex";
  import {getStore, setStore} from "@/util/store";
  import {dateFormat} from "@/util/date";
  import {validatenull} from "@/util/validate";
  import topColor from "@/page/index/top/top-color";

  export default {
    name: "login",
    components: {
      userLogin,
      codeLogin,
      thirdLogin,
      register,
      topColor
    },
    data() {
      return {
        time: "",
        active: "",
        activeName: this.$route.meta.activeName,
        thirdPartyForm: {}
      };
    },
    watch: {
      $route: {
        handler() {
          const params = this.$route.query
          if (validatenull(params.state) && validatenull(params.code)) return

          this.thirdPartyForm.state = params.state
          this.thirdPartyForm.code = params.code
          const loading = this.$loading({
            lock: true,
            text: `登录中,请稍后。。。`,
            spinner: 'el-icon-loading'
          })
          this.$store.dispatch('LoginByThirdParty', this.thirdPartyForm).then(
            () => {
              loading.close()
              this.$store.commit("SET_TOP_MENU_INDEX", 0)
              this.$router.push({path: this.tagWel.value});
            }).catch(() => {
            loading.close()
          })
        },
        immediate: true
      }
    },
    created() {
      this.active = getStore({name: "tenantId"});
      this.getTime();
      setInterval(() => {
        this.getTime();
      }, 1000);
    },
    mounted() {
    },
    computed: {
      ...mapGetters(["website",'tagWel'])
    },
    props: [],
    methods: {
      getTime() {
        this.time = dateFormat(new Date());
      }
    }
  };
</script>

<style lang="scss">
.login-container {
  width: 100%;
  margin: 0 auto;
}
.login-weaper {
  position: absolute;
  top: 50%;
  left: 0;
  width: 100%;
  height: 500px;
  margin-top: -200px;
}
.login-container::before {
  z-index: -1024;
  content: "";
  position: absolute;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  background-image: url("/img/login.png");
  background-size: cover;
}
.login-left {
  float: left;
  width: 50%;
  position: relative;
}
.login-logo {
  position: absolute;
  top: 0;
  left: 0;
  padding-top: 150px;
  font-size: 24px;
  color: #333;
  margin-left: 120px;
}
.login-info {
  padding-left: 140px;
}
.login-info-title {
  line-height: 90px;
  color: rgb(52, 58, 64);
}
.login-info-item {
  font-size: 14px;
  line-height: 2.5;
  color: rgb(33, 37, 41);
}
.login-border {
  width: 50%;
  float: left;
  box-sizing: border-box;
}
.login-main {
  margin: 0 auto;
  width: 50%;
  box-sizing: border-box;
}
.login-main > h3 {
  margin-bottom: 20px;
}
.login-main > p {
  color: #76838f;
}
.login-title {
  margin-bottom: 40px;
  font-weight: 500;
  font-size: 22px;
  text-align: center;
  letter-spacing: 4px;
}
.login-menu {
  width: 100%;
  text-align: center;
  a {
    color: rgb(153, 153, 153);
    font-size: 12px;
    margin: 0px 8px;
  }
}
.login-index {
  margin-top: 40px !important;
  width: 180px;
  height: 48px;
  text-align: center;
  border-radius: 50px !important;
  background: transparent !important;
  color: #333 !important;
  font-size: 16px !important;
  border: 1px solid rgb(152, 22, 244);
}
.login-submit {
  display: block !important;
  margin: 40px auto 10px auto !important;
  width: 200px;
  height: 48px;
  font-size: 14px !important;
  text-align: center;
  border-radius: 50px !important;
  border: 0px;
  box-shadow: rgba(152, 22, 244, 0.19) 0px 5px 10px 2px;
}
.login-form {
  margin: 10px 0;
  i {
    color: #999;
  }
  .el-form-item__content {
    width: 100%;
  }
  .el-form-item {
    margin-bottom: 12px;
  }
  .el-input {
    input {
      padding-bottom: 10px;
      text-indent: 5px;
      background: transparent;
      border: none;
      border-radius: 0;
      color: #333;
      border-bottom: 1px solid rgb(235, 237, 242);
    }
    .el-input__prefix {
      i {
        padding: 0 5px;
        font-size: 16px !important;
      }
    }
  }
}
.login-code {
  display: flex;
  align-items: center;
  justify-content: space-around;
  margin: 0 0 0 10px;
}
.login-code-img {
  margin-top: 2px;
  width: 100px;
  height: 38px;
  background-color: #fdfdfd;
  border: 1px solid #f0f0f0;
  color: #333;
  font-size: 14px;
  font-weight: bold;
  letter-spacing: 5px;
  line-height: 38px;
  text-indent: 5px;
  text-align: center;
}
.login-select {
  input {
    color: #333;
    font-size: 18px;
    font-weight: 400;
    border: none;
    text-align: center;
  }
}
</style>

