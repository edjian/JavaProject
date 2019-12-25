<template>
  <div class="sku-form">
    <div v-if="specType == '0'">
      <el-form ref="form" :model="goodsSkuOne" label-width="80px">
        <el-form-item label="销售价(元)">
          <el-input-number size="mini" v-model="goodsSkuOne.salesPrice" :precision="2" :step="0.1" :min="0" :max="99999999"></el-input-number>
        </el-form-item>
        <el-form-item label="市场价(元)">
          <el-input-number size="mini" v-model="goodsSkuOne.marketPrice" :precision="2" :step="0.1" :min="0" :max="99999999"> </el-input-number>
        </el-form-item>
        <el-form-item label="成本价(元)">
          <el-input-number size="mini" v-model="goodsSkuOne.costPrice" :precision="2" :step="0.1" :min="0" :max="99999999"> </el-input-number>
        </el-form-item>
        <el-form-item label="库存">
          <el-input-number size="mini" v-model="goodsSkuOne.stock" :precision="0" :step="1" :min="0" :max="99999999"> </el-input-number>
        </el-form-item>
        <el-form-item label="重量(kg)">
          <el-input-number size="mini" v-model="goodsSkuOne.weight" :precision="2" :step="0.1" :min="0" :max="99999999"> </el-input-number>
        </el-form-item>
        <el-form-item label="体积(m³)">
          <el-input-number size="mini" v-model="goodsSkuOne.volume" :precision="2" :step="0.1" :min="0" :max="99999999"> </el-input-number>
        </el-form-item>
      </el-form>
    </div>
    <div v-if="specType == '1'">
      <el-tabs type="border-card">
        <el-tab-pane label="商品规格">
          <div v-if="goodsSpuSpec == null || goodsSpuSpec.length <=0 " class="el-table__empty-block">
            <span class="el-table__empty-text">暂无数据</span>
          </div>
          <div class="box-card el-card"
               style="margin-bottom: 5px"
               v-for="(item,index) in goodsSpuSpec"
               :key="item.id">
            <div class="el-card__header" style="padding: 5px 20px;">
              <div class="clearfix"><span>{{item.value}}</span>
                <el-button style="float: right; padding: 3px 0" type="text" @click="delGoodsSpuSpec(index)">移除</el-button>
              </div>
            </div>
            <div class="el-card__body" style="padding: 5px 20px;">
              <el-tag
                v-for="(item2,index2) in item.leaf"
                :key="item2.id"
                type="info"
                size="small"
                closable
                @close="delGoodsSpuSpecValue(index,index2)">
                {{item2.value}}
              </el-tag>
              <br>
              <el-popover
                placement="bottom"
                width="200"
                trigger="click">
                <el-select
                  v-model="goodsSpecValueAdd"
                  filterable
                  allow-create
                  default-first-option
                  placeholder="请输入规格值"
                  @change="goodsSpecValueChange">
                  <el-option
                    v-for="item in goodsSpecValue"
                    :key="item.id"
                    :label="item.name"
                    :value="item.id"
                    :disabled="item.disabled">
                  </el-option>
                </el-select>
                <el-button slot="reference" type="text" @click="addSpecValue(item.id)" style="margin-left: 5px">添加规格值
                </el-button>
              </el-popover>
            </div>
          </div>
          <div style="text-align: center">
            <el-popover
              placement="bottom"
              width="200"
              trigger="click">
              <el-select
                v-model="goodsSpecAdd"
                filterable
                allow-create
                default-first-option
                placeholder="请输入规格"
                @change="goodsSpecChange">
                <el-option
                  v-for="item in goodsSpec"
                  :key="item.id"
                  :label="item.name"
                  :value="item.id"
                  :disabled="item.disabled">
                </el-option>
              </el-select>
              <el-button slot="reference" type="text" @click="addSpec">添加规格</el-button>
            </el-popover>
          </div>
        </el-tab-pane>
      </el-tabs>
      <el-tabs type="border-card" style="margin-top: 5px">
        <el-tab-pane label="商品SKU">
          <SkuTable :specData="goodsSpuSpecFilter" :goodsSku="goodsSku" v-if="goodsSpuSpec" @getGoodsSku="getGoodsSku"></SkuTable>
        </el-tab-pane>
      </el-tabs>
    </div>
  </div>
</template>

<script>
  import {getList as specValueList, addObj as addSpecValue} from '@/api/mall/goodsspecvalue'
  import SkuTable from '@/components/sku/sku-table.vue'
  import { addObj as addSpec } from '@/api/mall/goodsspec'

  export default {
    components: {
      SkuTable
    },
    props: {
      goodsSpec: {
        type: Array
      },
      goodsSpuSpec: {
        type: Array
      },
      goodsSku: {
        type: Array
      },
      specType: {
        type: String
      }
    },
    created() {
      if(this.goodsSku.length > 0){
        this.goodsSkuOne = this.goodsSku[0]
        this.goodsSkuOne.enable = '1'
      }else{
        this.goodsSkuOne = {
          salesPrice: 0,
          marketPrice: undefined,
          costPrice: undefined,
          stock: 0,
          weight: undefined,
          volume: undefined,
          enable: '1'
        }
      }
    },
    computed: {
      // 过滤掉属性名和属性值为空的数据规格项目
      goodsSpuSpecFilter() {
        return this.goodsSpuSpec.filter(item => item.value && item.leaf != null && item.leaf.length)
      },
    },
    watch: {
      goodsSkuOne: {
        deep: true,
        immediate: true,
        handler(newSkus, oldSkus) {
          this.$emit('getGoodsSku', [newSkus])
        }
      }
    },
    data(){
      return{
        goodsSpecAdd: null,
        goodsSpecValueAdd: null,
        goodsSpecValue: null,
        goodsSpuSpecIndex: null,
        goodsSkuOne: null
      }
    },
    methods: {
      getGoodsSku(val){
        this.$emit('getGoodsSku', val ,this.goodsSpuSpec)
      },
      delGoodsSpuSpecValue(indexSpec, indexSpecValue) {
        this.goodsSpuSpec[indexSpec].leaf.splice(indexSpecValue, 1)
      },
      delGoodsSpuSpec(index) {
        let id = this.goodsSpuSpec[index].id
        this.goodsSpuSpec.splice(index, 1)
        let that = this
        that.goodsSpec.forEach(function (val, index) {
          if (val.id == id) {
            that.$set(val, 'disabled', false)
          }
        })
      },
      addSpecValue(specId) {
        specValueList({
          specId: specId
        }).then(data => {
          let that = this
          this.goodsSpecValue = data.data.data
          this.goodsSpuSpec.forEach(function (val, index) {
            if (val.id == specId) {
              that.goodsSpuSpecIndex = index
              that.goodsSpecValue.forEach(function (val2, index2) {
                val.leaf.forEach(function (val3, index3) {
                  if (val2.id == val3.id) {
                    that.$set(val2, 'disabled', true)
                  }
                })
              })
            }
          })
        })
      },
      goodsSpecValueChange(id) {
        this.goodsSpecValueAdd = null
        let that = this
        let isNew = true
        this.goodsSpecValue.forEach(function (val, index) {
          if (val.id == id) {
            isNew = false
            that.$set(val, 'disabled', true)
            that.goodsSpuSpec[that.goodsSpuSpecIndex].leaf.push({
              id: val.id,
              value: val.name
            })
          }
        })
        if (isNew) {//需新增
          addSpecValue({
            specId: this.goodsSpuSpec[this.goodsSpuSpecIndex].id,
            name: id
          }).then(data => {
            this.goodsSpecValue.push({
              id: data.data.data.id,
              name: data.data.data.name,
              disabled: true
            })
            that.goodsSpuSpec[that.goodsSpuSpecIndex].leaf.push({
              id: data.data.data.id,
              value: data.data.data.name
            })
          })
        }
      },
      goodsSpecChange(id) {
        this.goodsSpecAdd = null
        let that = this
        let isNew = true
        this.goodsSpec.forEach(function (val, index) {
          if (val.id == id) {
            isNew = false
            that.$set(val, 'disabled', true)
            that.goodsSpuSpec.push({
              id: val.id,
              value: val.name,
              leaf: []
            })
          }
        })
        if (isNew) {//需新增
          addSpec({
            name: id
          }).then(data => {
            this.goodsSpec.push({
              id: data.data.data.id,
              name: data.data.data.name,
              disabled: true
            })
            this.goodsSpuSpec.push({
              id: data.data.data.id,
              value: data.data.data.name,
              leaf: []
            })
          })
        }
      },
      addSpec() {
        let that = this
        that.goodsSpec.forEach(function (val, index) {
          that.goodsSpuSpec.forEach(function (val2, index2) {
            if (val.id == val2.id) {
              that.$set(val, 'disabled', true)
            }
          })
        })
      },
    },
  }
</script>

<style lang="scss" scoped>
  .sku-form .el-tag + .el-tag {
    margin-left: 10px;
  }
</style>
