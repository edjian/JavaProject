<template>
  <el-form class="login-form"
           status-icon
           :rules="registerRules"
           ref="registerForm"
           :model="registerForm"
           label-width="100px">
    <el-form-item label="邮箱"
                  prop="email">
      <el-input
                v-model="registerForm.email"
                placeholder="请输入邮箱">
      </el-input>
    </el-form-item>
    <el-form-item label="验证码"
                  prop="code">
      <el-input v-model="registerForm.code"
                placeholder="请输入验证码">
        <template slot="append">
          <span @click="handleSend"
                class="msg-text"
                :class="[{display:msgKey}]">{{msgText}}</span>
        </template>
      </el-input>
    </el-form-item>
<!--    <el-form-item label="用户名"-->
<!--                  prop="username">-->
<!--      <el-input-->
<!--        v-model="registerForm.username"-->
<!--        placeholder="请输入用户名">-->
<!--      </el-input>-->
<!--    </el-form-item>-->
    <el-form-item label="密码"
                  prop="newpassword1">
      <el-input type="password"
                v-model="registerForm.newpassword1"></el-input>
    </el-form-item>
    <el-form-item label="确认密码"
                  prop="newpassword2">
      <el-input type="password"
                v-model="registerForm.newpassword2"></el-input>
    </el-form-item>
    <el-form-item label="公司名"
                  prop="organname">
      <el-input
        v-model="registerForm.organname"
        placeholder="请输入公司名">
      </el-input>
    </el-form-item>
    <el-form-item>
      <el-button type="primary"
                 size="small"
                 @click.native.prevent="handleRegister"
                 class="login-submit">提交</el-button>
    </el-form-item>
  </el-form>
</template>

<script>
  import {mapGetters} from "vuex";
  import request from '@/router/axios'
  import { register } from '@/api/login'

  const MSGINIT = "发送验证码",
    MSGSCUCCESS = "${time}秒后可重发",
    MSGTIME = 60;

  export default {
    name: "register",
    data() {
      var validatePass = (rule, value, callback) => {
        if (value !== this.registerForm.newpassword1) {
          callback(new Error('两次输入密码不一致!'))
        } else {
          callback()
        }
      }
      return {
        msgText: MSGINIT,
        msgTime: MSGTIME,
        msgKey: false,
        registerForm: {},
        checked: false,
        registerRules: {
          email: [{required: true, message: "请输入邮箱", trigger: "blur"}],
          username: [{required: true, message: "请输入用户名", trigger: "blur"}],
          code: [{required: true, message: "请输入验证码", trigger: "blur"}],
          newpassword1: [{required: true, min: 6, message: '不少于6位', trigger: 'change'}],
          newpassword2: [{required: true, validator: validatePass, trigger: 'blur'}],
          organname: [{required: true, message: "请输入公司名", trigger: "blur"}]
        },
        passwordType: "password"
      };
    },
    created() {

    },
    mounted() {
    },
    computed: {
      ...mapGetters(["tagWel"])
    },
    props: [],
    methods: {
      handleSend() {
        if (this.msgKey) return
        if(this.registerForm.email==''){
          this.$message.error("请输入正确的邮箱")
          return
        }
        request({
          url: '/upms/email/' + this.registerForm.email+'?type=register',
          method: 'get'
        }).then(response => {
          if (response.data.code == '0') {
            this.$message.success('验证码发送成功')
            this.msgText = MSGSCUCCESS.replace('${time}', this.msgTime)
            this.msgKey = true
            const time = setInterval(() => {
              this.msgTime--
              this.msgText = MSGSCUCCESS.replace('${time}', this.msgTime)
              if (this.msgTime == 0) {
                this.msgTime = MSGTIME
                this.msgText = MSGINIT
                this.msgKey = false
                clearInterval(time)
              }
            }, 1000)
          } else {
            this.$message.error(response.data.msg)
          }
        })
      },
      handleRegister() {
        this.$refs.registerForm.validate(valid => {
          if (valid) {
            register(Object.assign({
              password: this.registerForm.newpassword1,
              username: this.registerForm.email
            }, this.registerForm)).then(response => {
              this.$confirm('恭喜你注册成功，登录名：'+this.registerForm.email, '提示', {
                confirmButtonText: '确定',
                type: 'success'
              }).then(() => {
                this.$router.push({path: "/login"})
              })
            }).catch(() => {})
          }
        })
      }
    }
  }
</script>

<style>
</style>
