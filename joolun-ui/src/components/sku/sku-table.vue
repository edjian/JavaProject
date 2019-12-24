<template>
  <basic-container>
    <div class="sku-table">
      <el-row :gutter="10" v-if="skuData.length > 0">
        <el-col :span="2.5">批量设置</el-col>
        <el-col :span="2.5"><el-input size="mini" placeholder="sku编码" clearable v-model="batchAddObj.skuCode"> </el-input></el-col>
        <el-col :span="2.5"><el-input-number size="mini" controls-position="right" placeholder="销售价(元)" v-model="batchAddObj.salesPrice" :precision="2" :step="0.1" :min="0" :max="99999999"> </el-input-number></el-col>
        <el-col :span="2.5"><el-input-number size="mini" controls-position="right" placeholder="市场价(元)" v-model="batchAddObj.marketPrice" :precision="2" :step="0.1" :min="0" :max="99999999"> </el-input-number></el-col>
        <el-col :span="2.5"><el-input-number size="mini" controls-position="right" placeholder="成本价(元)" v-model="batchAddObj.costPrice" :precision="2" :step="0.1" :min="0" :max="99999999"> </el-input-number></el-col>
        <el-col :span="2.5"><el-input-number size="mini" controls-position="right" placeholder="库存" v-model="batchAddObj.stock" :precision="0" :step="1" :min="0" :max="99999999"> </el-input-number></el-col>
        <el-col :span="2.5"><el-input-number size="mini" controls-position="right" placeholder="重量(kg)" v-model="batchAddObj.weight" :precision="2" :step="0.1" :min="0" :max="99999999"> </el-input-number></el-col>
        <el-col :span="2.5"><el-input-number size="mini" controls-position="right" placeholder="体积(m³)" v-model="batchAddObj.volume" :precision="2" :step="0.1" :min="0" :max="99999999"> </el-input-number></el-col>
        <el-col :span="4"><el-button type="primary" size="mini" @click="batchAdd">确认</el-button></el-col>
      </el-row>
      <br>
      <el-table
        :data="skuData"
        size="mini"
        border
      >
        <el-table-column v-for="(item,index) in specData" :key="item.id" :prop="item.id" :label="item.value" align="center">
          <template slot-scope="scope">
            {{scope.row.specs[index].specValueName}}
          </template>
        </el-table-column>
        <el-table-column prop="picUrl" label="图片" align="center">
          <template slot-scope="scope">
            <MaterialList v-model="scope.row.picUrls" type="image" :num=1 :width=60 :height=60></MaterialList>
          </template>
        </el-table-column>
        <el-table-column prop="skuCode" label="sku编码" align="center">
          <template slot-scope="scope">
            <el-input size="mini" clearable v-model="scope.row['skuCode']" :disabled="!scope.row['enable']"> </el-input>
          </template>
        </el-table-column>
        <el-table-column prop="salesPrice" align="center">
          <template slot="header" slot-scope="scope">
            销售价(元)<span style="color: red;margin-left: 5px;font-size: large;">*</span>
          </template>
          <template slot-scope="scope">
            <el-input-number size="mini" controls-position="right" v-model="scope.row['salesPrice']" :precision="2" :step="0.1" :min="0" :max="99999999" :disabled="!scope.row['enable']"> </el-input-number>
          </template>
        </el-table-column>
        <el-table-column prop="marketPrice" label="市场价(元)" align="center">
          <template slot-scope="scope">
            <el-input-number size="mini" controls-position="right" v-model="scope.row['marketPrice']" :precision="2" :step="0.1" :min="0" :max="99999999" :disabled="!scope.row['enable']"> </el-input-number>
          </template>
        </el-table-column>
        <el-table-column prop="costPrice" label="成本价(元)" align="center">
          <template slot-scope="scope">
            <el-input-number size="mini" controls-position="right" v-model="scope.row['costPrice']" :precision="2" :step="0.1" :min="0" :max="99999999" :disabled="!scope.row['enable']"> </el-input-number>
          </template>
        </el-table-column>
        <el-table-column prop="stock" label="库存" align="center">
          <template slot="header" slot-scope="scope">
            库存<span style="color: red;margin-left: 5px;font-size: large;">*</span>
          </template>
          <template slot-scope="scope">
            <el-input-number size="mini" controls-position="right" v-model="scope.row['stock']" :precision="0" :step="1" :min="0" :max="99999999" :disabled="!scope.row['enable']"> </el-input-number>
          </template>
        </el-table-column>
        <el-table-column prop="weight" label="重量(kg)" align="center">
          <template slot-scope="scope">
            <el-input-number size="mini" controls-position="right" v-model="scope.row['weight']" :precision="2" :step="0.1" :min="0" :max="99999999" :disabled="!scope.row['enable']"> </el-input-number>
          </template>
        </el-table-column>
        <el-table-column prop="volume" label="体积(m³)" align="center">
          <template slot-scope="scope">
            <el-input-number size="mini" controls-position="right" v-model="scope.row['volume']" :precision="2" :step="0.1" :min="0" :max="99999999" :disabled="!scope.row['enable']"> </el-input-number>
          </template>
        </el-table-column>
        <el-table-column label="是否启用" align="center" width="70">
          <template slot-scope="scope">
            <el-switch
              active-value="1"
              inactive-value="0"
              v-model="scope.row['enable']"
              active-color="#13ce66"
              inactive-color="#ff4949">
            </el-switch>
          </template>
        </el-table-column>
      </el-table>
      {{skuData.length}}条
    </div>
  </basic-container>
</template>

<script>
import { flatten } from '../../util/sku'
import { diffArary } from '../../util'
import MaterialList from '@/components/material/list.vue'

export default {
  components: {
    MaterialList
  },
  props: {
    specData: {
      type: Array,
      default() {
        return []
      },
    },
    goodsSku: {
      type: Array
    },
  },
  computed: {
    skusList() {
      let skusList = flatten(this.specData).map(item => ({
        specs: item.specs,
        specIds: item.specs.reduce((total, prev, index) => `${total}${prev.specId}-${prev.specValueId}${index === item.specs.length - 1 ? '' : '_'}`, '')
      }))
      let skusList2 = this.goodsSku.map(item => ({
        ...item,
        specIds: item.specs.reduce((total, prev, index) => `${total}${prev.specId}-${prev.specValueId}${index === item.specs.length - 1 ? '' : '_'}`, '')
      }))
      let that = this
      skusList.forEach(function (item,index) {
        skusList2.forEach(function (item2,index2) {
          let itemList = item.specIds.split('_')
          let item2List = item2.specIds.split('_')
          let is = true
          itemList.forEach(function (item3,index2) {
            if(!item2List.find(c=>c==item3)){is = false}
          })
          if(is){
            that.$set(item,'id',item2.id ? item2.id : undefined)
            that.$set(item,'picUrl',item2.picUrl ? item2.picUrl : '')
            that.$set(item,'picUrls',item2.picUrl ? [item2.picUrl] : [])
            that.$set(item,'skuCode',item2.skuCode ? item2.skuCode : undefined)
            that.$set(item,'salesPrice',item2.salesPrice)
            that.$set(item,'marketPrice',item2.marketPrice)
            that.$set(item,'costPrice',item2.costPrice)
            that.$set(item,'stock',item2.stock)
            that.$set(item,'weight',item2.weight)
            that.$set(item,'volume',item2.volume)
            that.$set(item,'enable',item2.enable)
          }
        })
      })
      return skusList
    }
  },
  watch: {
    skuData: {
      deep: true,
      immediate: true,
      handler(newSkus, oldSkus) {
        this.$emit('getGoodsSku', newSkus)
      }
    },
    skusList: {
      deep: true,
      immediate: true,
      handler(newSkus, oldSkus) {
        if (!newSkus.length) return this.skuData = []
        if (!oldSkus || !oldSkus.length) {
          return this.skuData = newSkus.map(item => ({
            ...item,
            // 初始化属性
            id: item.id ? item.id : undefined,
            picUrl: item.picUrl ? item.picUrl : '',
            picUrls: item.picUrls ? item.picUrls : [],
            skuCode: item.skuCode ? item.skuCode : undefined,
            salesPrice: item.salesPrice ? item.salesPrice : 0,
            marketPrice: item.marketPrice ? item.marketPrice : undefined,
            costPrice: item.costPrice ? item.costPrice : undefined,
            stock: item.stock ? item.stock : 0,
            weight: item.weight ? item.weight : undefined,
            volume: item.volume ? item.volume : undefined,
            enable: item.enable ? item.enable : '1'
          }))
        }
        // 当规格名的数量发生了变化
        if (newSkus[0].specs.length !== oldSkus[0].specs.length) {
          return this.skuData = newSkus.map(item => ({
            ...item,
            // 初始化属性
            id: undefined,
            picUrl: '',
            picUrls: [],
            skuCode: undefined,
            salesPrice: 0,
            marketPrice: undefined,
            costPrice: undefined,
            stock: 0,
            weight: undefined,
            volume: undefined,
            enable: '1'
          }))
        }
        if (newSkus.length === oldSkus.length) {
          // 当规格名和规格值数量未发生变化，更新 specs 即可
          return this.skuData = newSkus.map((item, index) => ({
            ...this.skuData[index],
            ...item,
          }))
        }

        const diffIds = this.diffIds(newSkus, oldSkus)
        if (newSkus.length > oldSkus.length) {
          // 当添加了规格值
          let data = []
          newSkus.forEach(item => {
            const sku = this.skuData.find(_item => _item.specIds === item.specIds)
            if (sku) {
              data.push(sku)
            } else {
              data.push({
                ...item,
                id: undefined,
                picUrl: '',
                picUrls: [],
                skuCode: undefined,
                salesPrice: 0,
                marketPrice: undefined,
                costPrice: undefined,
                stock: 0,
                weight: undefined,
                volume: undefined,
                enable: '1'
              })
            }
          })
          this.skuData = data
        } else {
          // 当删除了规格值
          this.skuData = this.skuData.filter(_item => !diffIds.includes(_item.specIds))
        }
      },
    }
  },
  data: () => ({
    batchAddObj: {},
    skuData: [],
    coefficient: {
      purchase_coefficient: 0,
      guide_coefficient: 0,
    }
  }),

  methods: {
    batchAdd(){
      let that = this
      this.skuData.forEach(function (val,index) {
        if(val.enable == '1'){
          if(that.batchAddObj.skuCode){
            that.$set(val,'skuCode',that.batchAddObj.skuCode)
          }
          if(that.batchAddObj.salesPrice >= 0){
            that.$set(val,'salesPrice',that.batchAddObj.salesPrice)
          }
          if(that.batchAddObj.marketPrice >= 0){
            that.$set(val,'marketPrice',that.batchAddObj.marketPrice)
          }
          if(that.batchAddObj.costPrice >= 0){
            that.$set(val,'costPrice',that.batchAddObj.costPrice)
          }
          if(that.batchAddObj.stock >= 0){
            that.$set(val,'stock',that.batchAddObj.stock)
          }
          if(that.batchAddObj.weight >= 0){
            that.$set(val,'weight',that.batchAddObj.weight)
          }
          if(that.batchAddObj.volume >= 0){
            that.$set(val,'volume',that.batchAddObj.volume)
          }
        }
      })
    },
    diffIds(skusList1, skusList2) {
      // 两个数据的 id 进行相差
      skusList1 = skusList1.map(item => item.specIds)
      skusList2 = skusList2.map(item => item.specIds)
      return diffArary(skusList1, skusList2)
    },
    objectSpanMethod({ row, column, rowIndex, columnIndex }) {
      if (columnIndex === 0) {
        if (rowIndex % 2 === 0) {
          return {
            rowspan: 2,
            colspan: 1
          };
        } else {
          return {
            rowspan: 0,
            colspan: 0
          };
        }
      }
    }
  },
}
</script>
<style lang="scss" scoped>
  .sku-table .avue-upload__avatar{
    width: 60px;
    height: 60px;
  }
  .sku-table .avue-upload__icon {
    width: 60px;
    height: 60px;
    line-height: 60px!important;
  }
  .sku-table .el-upload__tip{
    margin-top:unset;
  }
  .sku-table .avue-group__item{
    background-color:unset;
  }
  .sku-table .avue-group__item {
    margin-bottom: unset;
  }
  .sku-table .el-form-item {
    margin-bottom: unset;
  }
  .sku-table .el-col {
    margin-bottom: unset;
  }
  .sku-table .el-table .el-input-number--mini {
    width: 120px;
  }
</style>
