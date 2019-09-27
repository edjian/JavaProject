<template>
  <div>
    <basic-container>
      <iframe src="http://www.joolun.com" class="iframe-home"></iframe>
    </basic-container>
  </div>
</template>

<script>
  import {mapGetters} from 'vuex';

  export default {
    name: 'wel',
    data() {
      return {
      }
    },
    computed: {
      ...mapGetters(['website'])
    },
    methods: {
    }
  }
</script>

<style scoped="scoped" lang="scss">
  .iframe-home {
    width: 100%;
    height: 800px;
    border: unset;
  }
</style>
