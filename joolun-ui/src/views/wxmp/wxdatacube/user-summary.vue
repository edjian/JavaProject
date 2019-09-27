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
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span class="demonstration">时间范围</span>
        <el-date-picker
          format="yyyy-MM-dd"
          v-model="dateValues"
          type="daterange"
          :picker-options="datePickerOptions"
          @change="changeDate"
          range-separator="至"
          start-placeholder="开始日期"
          end-placeholder="结束日期">
        </el-date-picker>
      </div>
      <el-row>
        <el-col :span="12">
          <div id="userSummaryChart" :style="{width: '100%', height: '700px'}"></div>
        </el-col>
        <el-col :span="12">
          <div id="userCumulateChart" :style="{width: '100%', height: '700px'}"></div>
        </el-col>
      </el-row>
    </el-card>
  </div>
</template>

<script>
  // 引入基本模板
  let echarts = require('echarts/lib/echarts')
  // 引入柱状图组件
  require('echarts/lib/chart/bar')
  // 引入柱拆线组件
  require('echarts/lib/chart/line')
  // 引入提示框和title组件
  require('echarts/lib/component/tooltip')
  require('echarts/lib/component/title')
  require('echarts/lib/component/legend')
  import { getUserSummary, getUserCumulate } from '@/api/wxmp/wxapp'

  export default {
    name: 'wxUserSummary',
    data() {
      return {
        datePickerOptions: {
          disabledDate(date) {
            return date >= new Date(new Date() - 3600 * 1000 * 24)
          }
        },
        startDate: this.$moment().add(-7,'days').format('YYYY-MM-DD'),
        endDate: this.$moment().add(-1,'days').format('YYYY-MM-DD'),
        dateValues : [this.$moment().add(-7,'days').format('YYYY-MM-DD'), this.$moment().add(-1,'days').format('YYYY-MM-DD')],
        xAxisData: [],
        seriesData1: [],
        seriesData2: [],
        seriesData3: []
      }
    },
    created() {
      this.getUserSummary()
    },
    mounted: function() { },
    computed: {

    },
    methods: {
      changeDate(){
        let startDate = new Date(this.dateValues[0])
        let endDate = new Date(this.dateValues[1])
        if (this.$moment(endDate).diff(this.$moment(startDate), 'day') > 6) {
          this.$message.error('时间间隔7天以内，请重新选择')
          return false
        }else{
          this.startDate = this.$moment(startDate).format('YYYY-MM-DD')
          this.endDate = this.$moment(endDate).format('YYYY-MM-DD')
          this.xAxisData = []
          this.seriesData1 = []
          this.seriesData2 = []
          this.getUserSummary()
        }
      },
      getUserSummary(){
        let days = this.$moment(this.endDate).diff(this.$moment(this.startDate), 'day')//相差天数
        for(let i = 0; i<= days; i++){
          this.xAxisData.push(this.$moment(this.startDate).add(i,'days').format('YYYY-MM-DD'))
          this.seriesData1.push(0)
          this.seriesData2.push(0)
        }
        getUserSummary({
          appId:this.$route.query.id,
          startDate: this.startDate,
          endDate: this.endDate
        }).then(response => {
          this.xAxisData.forEach((item, index, arr) => {
            response.data.data.forEach((item2, index2, arr2) => {
              if(item2.refDate.indexOf(item) >= 0){
                this.$set(this.seriesData1, index, this.seriesData1[index] + item2.newUser)
                this.$set(this.seriesData2, index, this.seriesData2[index] + item2.cancelUser)
              }
            })
          })
          // 基于准备好的dom，初始化echarts实例
          let userSummaryChart = echarts.init(document.getElementById('userSummaryChart'))
          // 绘制图表
          userSummaryChart.setOption({
            title: { text: '用户增减数据' },
            color: ['#67C23A', '#e5323e'],
            legend: {
              data: ['新增用户','取消关注的用户']
            },
            tooltip: {},
            xAxis: {
              data: this.xAxisData
            },
            yAxis: {},
            series: [{
              name: '新增用户',
              type: 'bar',
              label: {
                normal: {
                  show: true
                }
              },
              barGap: 0,
              data: this.seriesData1
            },
            {
              name: '取消关注的用户',
              type: 'bar',
              label: {
                normal: {
                  show: true
                }
              },
              data: this.seriesData2
            }]
          })
        }).catch(() => {
        })

        getUserCumulate({
          appId:this.$route.query.id,
          startDate: this.startDate,
          endDate: this.endDate
        }).then(response => {
          response.data.data.forEach((item, index, arr) => {
            this.$set(this.seriesData3, index, item.cumulateUser)
          })
          // 基于准备好的dom，初始化echarts实例
          let userCumulateChart = echarts.init(document.getElementById('userCumulateChart'))
          // 绘制图表
          userCumulateChart.setOption({
            title: { text: '累计用户数据' },
            legend: {
              data: ['累计用户量']
            },
            xAxis: {
              type: 'category',
              data: this.xAxisData
            },
            yAxis: {
              type: 'value'
            },
            series: [{
              name:'累计用户量',
              data: this.seriesData3,
              type: 'line',
              smooth: true,
              label: {
                normal: {
                  show: true
                }
              }
            }]
          })
        }).catch(() => {
        })
      }
    }
  }
</script>

<style lang="scss" scoped>
  .demonstration{
    font-size: 15px;
    margin-right: 10px;
  }
</style>
