<template>
    <div>
        <codePhone type="1" @handleDone="handleLogin"/>
    </div>
</template>

<script>

    import {mapGetters} from "vuex";
    import codePhone from '@/components/code-phone/main.vue'

    export default {
        name: "codelogin",
        components: {
            codePhone
        },
        data() {
            return {};
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
            handleLogin(loginForm) {
                this.$store.dispatch("LoginByPhone", loginForm).then(() => {
                    this.$store.commit("SET_TOP_MENU_INDEX", 0)
                    this.$router.push({path: this.tagWel.value});
                });
            }
        }
    };
</script>

<style>
    .msg-text {
        display: block;
        width: 60px;
        font-size: 12px;
        text-align: center;
        cursor: pointer;
    }

    .msg-text.display {
        color: #ccc;
    }
</style>
