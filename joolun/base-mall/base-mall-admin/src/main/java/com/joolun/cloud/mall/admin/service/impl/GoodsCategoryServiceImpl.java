/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
package com.joolun.cloud.mall.admin.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.joolun.cloud.common.core.constant.CommonConstants;
import com.joolun.cloud.mall.admin.mapper.GoodsSpuMapper;
import com.joolun.cloud.mall.admin.service.GoodsSpuService;
import com.joolun.cloud.mall.common.entity.GoodsCategory;
import com.joolun.cloud.mall.common.entity.GoodsCategoryTree;
import com.joolun.cloud.mall.admin.mapper.GoodsCategoryMapper;
import com.joolun.cloud.mall.admin.service.GoodsCategoryService;
import com.joolun.cloud.mall.common.entity.GoodsSpu;
import com.joolun.cloud.mall.common.entity.GoodsSpuTree;
import com.joolun.cloud.upms.common.util.TreeUtil;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 商品类目
 *
 * @author JL
 * @date 2019-08-12 11:46:28
 */
@Service
@AllArgsConstructor
public class GoodsCategoryServiceImpl extends ServiceImpl<GoodsCategoryMapper, GoodsCategory> implements GoodsCategoryService {

	private final GoodsSpuMapper goodsSpuMapper;

	@Override
	public List<GoodsCategoryTree> selectTree(GoodsCategory goodsCategory) {
		return getTree2(this.list(Wrappers.lambdaQuery(goodsCategory)));
	}

	@Override
	public List<GoodsCategoryTree> selectTreeMerchant(GoodsCategory goodsCategory) {
		return getTree(baseMapper.selectTreeMerchant(Wrappers.lambdaQuery(goodsCategory)));
	}

	/**
	 * 构建树
	 *
	 * @param entitys
	 * @return
	 */
	private List<GoodsCategoryTree> getTree(List<GoodsCategory> entitys) {
		List<GoodsCategoryTree> treeList = entitys.stream()
				.filter(entity -> !entity.getId().equals(entity.getParentId()))
				.sorted(Comparator.comparingInt(GoodsCategory::getSort))
				.map(entity -> {
					GoodsCategoryTree node = new GoodsCategoryTree();
					BeanUtil.copyProperties(entity,node);
					return node;
				}).collect(Collectors.toList());
		return TreeUtil.build(treeList, CommonConstants.PARENT_ID);
	}

	/**
	 * 构建树2:显示所有产品
	 *
	 * @param entitys
	 * @return
	 */
	private List<GoodsCategoryTree> getTree2(List<GoodsCategory> entitys){
		return entitys.stream()
				.sorted(Comparator.comparingInt(GoodsCategory::getSort))
				.map(entity -> {
					GoodsCategoryTree node = new GoodsCategoryTree();
					BeanUtil.copyProperties(entity,node);
					GoodsSpu goodsSpu = new GoodsSpu();
					goodsSpu.setCategoryFirst(node.getId());
					IPage<GoodsSpu> goodsSpuList = goodsSpuMapper.selectPage3(new Page<>(1,15),goodsSpu);
					goodsSpuList.getRecords().stream().forEach(goodsSpu1 -> {
						GoodsSpuTree goodsSpuTree = new GoodsSpuTree();
						BeanUtil.copyProperties(goodsSpu1, goodsSpuTree);
						node.addChildren(goodsSpuTree);
					});
					return node;
				}).collect(Collectors.toList());
	}

	@Override
	public boolean removeById(Serializable id) {
		super.removeById(id);
		remove(Wrappers.<GoodsCategory>query()
				.lambda().eq(GoodsCategory::getParentId, id));
		return true;
	}
}
