<template>
  <div class="top-menu">
    <el-menu :default-active="topMenuIndex+''"
             mode="horizontal"
             :active-text-color="theme">
      <template v-for="(item,index) in menu">
        <el-menu-item :index="index+''"
                      @click.native="openMenu(index)"
                      :key="index">
          <template slot="title">
            <i :class="item.icon"></i>
            <span>{{item.label}}</span>
          </template>
        </el-menu-item>
      </template>
    </el-menu>
  </div>
</template>
<script>
import { mapGetters } from "vuex";
export default {
  name: "top-menu",
  data() {
    return {
    };
  },
  created() {
  },
  computed: {
    ...mapGetters(["tagCurrent", "menu", "theme", "topMenuIndex"])
  },
  methods: {
    openMenu(index) {
      this.$store.commit("SET_TOP_MENU_INDEX", index)
    }
  }
};
</script>
