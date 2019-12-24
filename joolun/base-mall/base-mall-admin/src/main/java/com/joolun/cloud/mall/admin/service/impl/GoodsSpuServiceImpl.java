/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
package com.joolun.cloud.mall.admin.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.joolun.cloud.common.core.constant.CommonConstants;
import com.joolun.cloud.mall.common.constant.MallConstants;
import com.joolun.cloud.mall.common.dto.GoodsSkuDTO;
import com.joolun.cloud.mall.common.dto.GoodsSpuDTO;
import com.joolun.cloud.mall.common.entity.*;
import com.joolun.cloud.mall.admin.mapper.GoodsSpuMapper;
import com.joolun.cloud.mall.admin.service.GoodsSkuService;
import com.joolun.cloud.mall.admin.service.GoodsSkuSpecValueService;
import com.joolun.cloud.mall.admin.service.GoodsSpuService;
import com.joolun.cloud.mall.admin.service.GoodsSpuSpecService;
import lombok.AllArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * spu商品
 *
 * @author JL
 * @date 2019-08-12 16:25:10
 */
@Service
@AllArgsConstructor
public class GoodsSpuServiceImpl extends ServiceImpl<GoodsSpuMapper, GoodsSpu> implements GoodsSpuService {

	private final GoodsSkuService goodsSkuService;
	private final GoodsSpuSpecService goodsSpuSpecService;
	private final GoodsSkuSpecValueService goodsSkuSpecValueService;

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean removeById(Serializable id) {
		super.removeById(id);
		//删除SpuSpec、SkuSpecValue、Sku
		goodsSpuSpecService.remove(Wrappers.<GoodsSpuSpec>update().lambda()
				.eq(GoodsSpuSpec::getSpuId, id));
		goodsSkuSpecValueService.remove(Wrappers.<GoodsSkuSpecValue>update().lambda()
				.eq(GoodsSkuSpecValue::getSpuId, id));
		goodsSkuService.remove(Wrappers.<GoodsSku>update().lambda()
				.eq(GoodsSku::getSpuId, id));
		return true;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean save(GoodsSpuDTO goodsSpuDTO) {
		GoodsSpu goodsSpu = new GoodsSpu();
		BeanUtils.copyProperties(goodsSpuDTO,goodsSpu);
		goodsSpu.setPriceDown(null);
		goodsSpu.setPriceUp(null);
		baseMapper.insert(goodsSpu);
		List<GoodsSkuDTO> listGoodsSkuDTO = goodsSpuDTO.getSkus();
		if(listGoodsSkuDTO !=null && listGoodsSkuDTO.size()>0){
			//新增sku
			listGoodsSkuDTO.forEach(goodsSkuDTO -> {
				priceUpDown(goodsSpu,goodsSkuDTO);
				GoodsSku goodsSku = new GoodsSku();
				BeanUtils.copyProperties(goodsSkuDTO,goodsSku);
				goodsSku.setSpuId(goodsSpu.getId());
				goodsSkuService.save(goodsSku);
				goodsSkuDTO.setId(goodsSku.getId());
			});
			baseMapper.updateById(goodsSpu);
			if(MallConstants.SPU_SPEC_TYPE_1.equals(goodsSpu.getSpecType())){//多规格处理
				goodsSpuDTO.setId(goodsSpu.getId());
				addSpec(goodsSpuDTO);
			}
		}
		return true;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean updateById(GoodsSpuDTO goodsSpuDTO) {
		GoodsSpu goodsSpu = new GoodsSpu();
		BeanUtils.copyProperties(goodsSpuDTO,goodsSpu);
		goodsSpu.setPriceDown(null);
		goodsSpu.setPriceUp(null);
		List<GoodsSkuDTO> listGoodsSkuDTO = goodsSpuDTO.getSkus();
		if(listGoodsSkuDTO !=null && listGoodsSkuDTO.size()>0){
			//先删除旧sku
			goodsSkuService.remove(Wrappers.<GoodsSku>update().lambda()
					.eq(GoodsSku::getSpuId, goodsSpuDTO.getId()));
			//新增sku
			listGoodsSkuDTO.forEach(goodsSkuDTO -> {
				priceUpDown(goodsSpu,goodsSkuDTO);
				GoodsSku goodsSku = new GoodsSku();
				BeanUtils.copyProperties(goodsSkuDTO,goodsSku);
				goodsSku.setSpuId(goodsSpuDTO.getId());
				goodsSkuService.saveOrUpdate(goodsSku);
				goodsSkuDTO.setId(goodsSku.getId());
			});
			baseMapper.updateById(goodsSpu);
			//统一删除SpuSpec、SkuSpecValue
			goodsSpuSpecService.remove(Wrappers.<GoodsSpuSpec>update().lambda()
					.eq(GoodsSpuSpec::getSpuId, goodsSpuDTO.getId()));
			goodsSkuSpecValueService.remove(Wrappers.<GoodsSkuSpecValue>update().lambda()
					.eq(GoodsSkuSpecValue::getSpuId, goodsSpuDTO.getId()));
			if(MallConstants.SPU_SPEC_TYPE_1.equals(goodsSpu.getSpecType())) {//多规格处理
				addSpec(goodsSpuDTO);
			}
		}
		return true;
	}

	@Override
	public GoodsSpu getById2(String id) {
		return baseMapper.selectById2(id);
	}

	@Override
	public IPage<GoodsSpu> page2(IPage<GoodsSpu> page, GoodsSpu goodsSpu, CouponGoods couponGoods, CouponInfo couponInfo) {
		return baseMapper.selectPage2(page, goodsSpu, couponGoods, couponInfo);
	}

	/**
	 * 多规格处理
	 * @param goodsSpuDTO
	 */
	void addSpec(GoodsSpuDTO goodsSpuDTO){
		//新增SpuSpec
		List<GoodsSpuSpec> listGoodsSpuSpec = goodsSpuDTO.getSpuSpec().stream().map(spuSpecDTO->{
			GoodsSpuSpec goodsSpuSpec = new GoodsSpuSpec();
			goodsSpuSpec.setSpuId(goodsSpuDTO.getId());
			goodsSpuSpec.setSpecId(spuSpecDTO.getId());
			return goodsSpuSpec;
		}).collect(Collectors.toList());
		goodsSpuSpecService.saveBatch(listGoodsSpuSpec);
		//新增SkuSpecValue
		List<GoodsSkuSpecValue> listGoodsSkuSpecValue = new ArrayList<>();
		goodsSpuDTO.getSkus().forEach(goodsSkuDTO -> {
			goodsSkuDTO.getSpecs().forEach(goodsSkuSpecValueDTO -> {
				GoodsSkuSpecValue goodsSkuSpecValue = new GoodsSkuSpecValue();
				BeanUtils.copyProperties(goodsSkuSpecValueDTO,goodsSkuSpecValue);
				goodsSkuSpecValue.setSpuId(goodsSpuDTO.getId());
				goodsSkuSpecValue.setSkuId(goodsSkuDTO.getId());
				listGoodsSkuSpecValue.add(goodsSkuSpecValue);
			});
		});
		goodsSkuSpecValueService.saveBatch(listGoodsSkuSpecValue);
	}

	/**
	 * 获取商品最高最低价
	 * @param goodsSpu
	 * @param goodsSkuDTO
	 */
	void priceUpDown(GoodsSpu goodsSpu,GoodsSkuDTO goodsSkuDTO){
		if(CommonConstants.YES.equals(goodsSkuDTO.getEnable())){
			BigDecimal priceDown = goodsSpu.getPriceDown();
			if(priceDown == null || priceDown.compareTo(goodsSkuDTO.getSalesPrice()) == 1){
				goodsSpu.setPriceDown(goodsSkuDTO.getSalesPrice());
			}
			BigDecimal priceUp = goodsSpu.getPriceUp();
			if(priceUp == null || priceUp.compareTo(goodsSkuDTO.getSalesPrice()) == -1){
				goodsSpu.setPriceUp(goodsSkuDTO.getSalesPrice());
			}
		}
	}
}
