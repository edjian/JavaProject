<template>
  <div>
    <el-alert
      title="账号：test；密码：123456"
      type="success"
      :closable="false"
      show-icon
      style="margin-bottom: 30px">
    </el-alert>
    <avue-login :option="option" @refresh="refresh" :codesrc="codesrc" @submit="submit">
    </avue-login>
  </div>
</template>

<script>
  import {randomLenNum} from "@/util/util";
  import {mapGetters} from "vuex";

    export default {
        name: "userlogin",
        data() {
            return {
                codesrc: '',
                option: {
                    width: 400,
                    codeType: 'img',
                    column: {
                        username: {
                            label: '用户名',
                            placeholder: '用户名',
                            autocomplete: 'off',
                            rules: { required: true, message: '请输入用户名', trigger: 'blur' }
                        },
                        password: {
                            label: '密码',
                            autocomplete: 'off',
                            rules: { required: true, message: '请输入密码', trigger: 'blur' }
                        },
                        code: {
                            label: '验证码',
                            tip: '点击图片可以刷新验证码',
                            autocomplete: 'off',
                            rules: { required: true, message: '请输验证码', trigger: 'blur' }
                        }
                    }
                },
            };
        },
        created() {
            this.refresh();
        },
        mounted() {
        },
        computed: {
            ...mapGetters(["tagWel"])
        },
        props: [],
        methods: {
            refresh() {
                this.randomStr = randomLenNum(4, true)
                this.codesrc = `${window.location.origin}/code?randomStr=`+ this.randomStr
            },
            submit(loginForm) {
                this.$store.dispatch("LoginByUsername", Object.assign({
                    randomStr: this.randomStr
                },loginForm)).then(() => {
                    this.$store.commit("SET_TOP_MENU_INDEX", 0)
                    this.$router.push({path: this.tagWel.value})
                }).catch(() => {
                    this.refresh()
                })
            }
        }
    };
</script>

<style>
</style>
