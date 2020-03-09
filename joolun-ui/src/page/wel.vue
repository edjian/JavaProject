<template>
  <div>
    <basic-container class="wel-view">
      <!--<iframe src="http://www.joolun.com" class="iframe-home"></iframe>-->
      <el-card class="box-card">
        <div slot="header" class="clearfix">
          <span>商城统计</span>
        </div>
        <avue-data-tabs :option="option1"></avue-data-tabs>
      </el-card>
      <el-card class="box-card" style="margin-top: 5px">
        <div slot="header" class="clearfix">
          <span>公众号数据分析</span>
        </div>
        <div class="data-view-content">
          <el-row :span="24" :gutter="10">
            <el-col :xs="24"
                    :sm="24"
                    :md="3"
                    v-if="treeWxAppData.length > 1">
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
                    :md="21">
              <div class="change-layout">
                <a
                        href="javascript:;"
                        class="change-item"
                        @click="handleChangeDataViewFilter({ value: '', name: ''})"
                        :class="currentDataViewFilter === '' ? 'active' : '' ">
                  全部
                </a>
                <a
                        href="javascript:;"
                        class="change-item"
                        v-for="item in dataViewFilterDict"
                        :key="item.value"
                        @click="handleChangeDataViewFilter(item)"
                        :class="currentDataViewFilter === item.value ? 'active' : '' ">
                  {{ item.label }}
                </a>
              </div>
              <div
                      class="wel-data-view"
                      id="wel-data-view"
                      ref="welDataView"
                      style="width: 100%; height: 400px;">
              </div>
            </el-col>
          </el-row>
        </div>
      </el-card>
      <el-alert
              title="Powered by www.joolun.com"
              type="info"
              :closable="false"
              center
              show-icon>
      </el-alert>
    </basic-container>
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
  import {mapGetters} from 'vuex'
  import { getList as getWxAppList } from '@/api/wxmp/wxapp'
  import { getUserSummary, getUserCumulate } from '@/api/wxmp/wxsummary'
  import { getCount as getCountGoodsspu } from '@/api/mall/goodsspu'
  import { getCount as getCountOrderinfo } from '@/api/mall/orderinfo'
  import { getCount as getCountUserinfo } from '@/api/mall/userinfo'

  export default {
    name: 'wel',
    data() {
      return {
        option1: {
          data: [
            {
              click: function (item) {
                // alert(JSON.stringify(item))
              },
              title: '商品总量',
              subtitle: '实时',
              count: 0,
              text: '当前商品总数量',
              color: 'rgb(27, 201, 142)',
              key: '商'
            },
            {
              click: function (item) {
                // alert(JSON.stringify(item));
              },
              title: '用户总量',
              subtitle: '实时',
              count: 0,
              text: '当前用户总数量',
              color: 'rgb(230, 71, 88)',
              key: '用'
            },
            {
              click: function (item) {
                // alert(JSON.stringify(item));
              },
              title: '订单总量',
              subtitle: '实时',
              count: 0,
              text: '已付款订单总数量',
              color: 'rgb(178, 159, 255)',
              key: '订'
            }
          ]
        },
        filterText: '',
        treeWxAppProps: {
          label: 'name',
          value: 'id'
        },
        treeWxAppData: [],
        appId: null,
        startDate: this.$moment().add(-7,'days').format('YYYY-MM-DD'),
        endDate: this.$moment().add(-1,'days').format('YYYY-MM-DD'),
        currentDataViewFilter: "",
        dataViewFilterDict: [
          {
            label: "新增人数",
            value: "1",
            name: "plus"
          }, {
            label: "取消关注人数",
            value: "2",
            name: "reduce"
          }, {
            label: "净增人数",
            value: "3",
            name: "netGrowth"
          }, {
            label: "累计人数",
            value: "4",
            name: "count"
          }
        ],
        xAxisData: [],
        selected: {
          '新增人数': true,
          '取消关注人数': true,
          '净增人数': true,
          '累计人数': true,
        },
        myChart: undefined,
      }
    },
    computed: {
      ...mapGetters(['website'])
    },
    watch: {
      filterText(val) {
        this.$refs.tree.filter(val)
      }
    },
    created() {
      this.getMallSummary()
      this.getWxAppList()
      this.$notify({
        title: '扫码查看商城演示小程序',
        dangerouslyUseHTMLString: true,
        duration: 45000,
        message: '<div>' +
          '<el-row>' +
            '<el-col :span="12"><div><img src="https://joolun-blog.oss-cn-zhangjiakou.aliyuncs.com/portal/gh_d01b456ef38a_258.jpg" style="width: 200px"></div></el-col>' +
            '<el-col :span="12">' +
              '<div style="">演示小程序的数据与演示后台数据互通</div>'+
            '</el-col>' +
          '</el-row>' +
          '</div>'
      })
    },
    methods: {
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
              id: data[0].id
            })
          }
        }).catch(() => {

        })
      },
      nodeClick(data) {
        if(this.appId != data.id){
          this.$nextTick(() => {
            if(this.$refs.tree){
              this.$refs.tree.setCurrentKey(data.id)
            }
          })
          this.appId = data.id
          this.xAxisData = []
          this.getSummary()
        }
      },
      getSummary(){
        let days = this.$moment(this.endDate).diff(this.$moment(this.startDate), 'day')//相差天数
        for(let i = 0; i<= days; i++){
          this.xAxisData.push({
            date: this.$moment(this.startDate).add(i,'days').format('YYYY-MM-DD'),
            plus: 0,
            reduce: 0,
            netGrowth: 0,
            count: 0
          })
        }
        getUserSummary({
          appId: this.appId,
          startDate: this.startDate,
          endDate: this.endDate
        }).then(response => {
          let xAxisData = this.xAxisData
          let data = response.data.data
          xAxisData.forEach((item, index, arr) => {
            data.forEach((item2, index2, arr2) => {
              if(item2.refDate.indexOf(item.date) >= 0){
                item.plus = item2.newUser
                item.reduce = item2.cancelUser
                item.netGrowth = item2.newUser - item2.cancelUser
              }
            })
          })
          this.xAxisData = xAxisData
          getUserCumulate({
            appId: this.appId,
            startDate: this.startDate,
            endDate: this.endDate
          }).then(response => {
            let xAxisData2 = this.xAxisData
            let data2 = response.data.data
            xAxisData2.forEach((item2, index, arr) => {
              data2.forEach((item3, index2, arr2) => {
                if(item3.refDate.indexOf(item2.date) >= 0){
                  item2.count = item3.cumulateUser
                }
              })
            })
            this.xAxisData = xAxisData
            this.myChart = echarts.init(this.$refs['welDataView'])
            this.handleDrawViews()
          }).catch(() => {
          })
        }).catch(() => {
        })
      },
      handleChangeDataViewFilter ({ value, name }) {
        this.currentDataViewFilter = value
        switch (value) {
          case '1':
            this.selected = {
              '新增人数': true,
              '取消关注人数': false,
              '净增人数': false,
              '累计人数': false,
            }
            break;
          case '2':
            this.selected = {
              '新增人数': false,
              '取消关注人数': true,
              '净增人数': false,
              '累计人数': false,
            }
            break;
          case '3':
            this.selected = {
              '新增人数': false,
              '取消关注人数': false,
              '净增人数': true,
              '累计人数': false,
            }
            break;
          case '4':
            this.selected = {
              '新增人数': false,
              '取消关注人数': false,
              '净增人数': false,
              '累计人数': true,
            }
            break;
          default:
            this.selected = {
              '新增人数': true,
              '取消关注人数': true,
              '净增人数': true,
              '累计人数': true,
            }
            break;
        }
        this.handleDrawViews()
      },
      handleDrawViews () {
        this.myChart.setOption({
          tooltip: {},
          legend: {
            show: true,
            selected: this.selected
          },
          xAxis: {
            data: this.xAxisData.map(item => item.date)
          },
          yAxis: [
            {
              type: 'value',
              interval: 5,
              min: 0,
              axisLine: {
                show: false
              },
              splitLine: {
                lineStyle: {
                  color: 'rgba(0, 204, 153, 0.5)'
                }
              },
              axisTick: {
                show: false,
              }
            }, {
              type: 'value',
              interval: 10,
              min: 0,
              axisLine: {
                show: false,
              },
              splitLine: {
                show: false
              },
              axisTick: {
                show: false,
              }
            }
          ],
          series: [{
            name: '新增人数',
            type: 'line',
            data: this.xAxisData.map(item => item.plus),
            symbol: 'circle',
            symbolSize: 5,
            yAxisIndex: 0,
            lineStyle: {
              color: "#44B549"
            },
            itemStyle: {
              color: "#44B549",
              borderColor: "#44B549"
            },
            label: {
              show: true
            }
          }, {
            name: '取消关注人数',
            type: 'line',
            data: this.xAxisData.map(item => item.reduce),
            yAxisIndex: 0,
            lineStyle: {
              color: "#FF6633"
            },
            itemStyle: {
              color: "#FF6633",
              borderColor: "#FF6633"
            },
            label: {
              show: true
            }
          }, {
            name: '净增人数',
            type: 'line',
            data: this.xAxisData.map(item => item.netGrowth),
            yAxisIndex: 0,
            lineStyle: {
              color: "#00CC99"
            },
            itemStyle: {
              color: "#00CC99",
              borderColor: "#00CC99"
            },
            label: {
              show: true
            }
          }, {
            name: '累计人数',
            type: 'bar',
            data: this.xAxisData.map(item => item.count),
            barWidth: 30,
            yAxisIndex: 1,
            lineStyle: {
              color: "#33CCFF"
            },
            itemStyle: {
              color: "#33CCFF",
              borderColor: "#33CCFF"
            },
            label: {
              show: true,
              position: 'top'
            }
          }]
        });
      },
      getMallSummary(){
        getCountGoodsspu().then(response => {
          let data = response.data.data
          this.option1.data[0].count = data
        }).catch(() => {

        })
        getCountUserinfo().then(response => {
          let data = response.data.data
          this.option1.data[1].count = data
        }).catch(() => {

        })
        getCountOrderinfo({
          isPay: '1'
        }).then(response => {
          let data = response.data.data
          this.option1.data[2].count = data
        }).catch(() => {

        })
      }
    }
  }
</script>

<style lang="scss">
  .wel-view {
    height: calc(100% - 30px);
    overflow-y: scroll;
    .el-card__body {
      padding: 5px;
    }
    .data-view-content {
      padding: 10px;
      .change-layout {
        display: flex;
        flex-direction: row;
        .change-item + .change-item {
          border-left: none;
        }
        .change-item {
          padding: 0 10px;
          border: 1px solid #EEEEEE;
          line-height: 30px;
          text-decoration: none;
          outline: none;
          &.active {
            background: #44B549;
            color: #FFFFFF;
          }
        }
      }
    }
  }
</style>