/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
package com.joolun.cloud.mall.admin.api.ma;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.joolun.cloud.common.core.util.R;
import com.joolun.cloud.mall.admin.mapper.UserCollectMapper;
import com.joolun.cloud.mall.admin.service.GoodsSpuService;
import com.joolun.cloud.mall.common.constant.MallConstants;
import com.joolun.cloud.mall.common.entity.GoodsSpu;
import com.joolun.cloud.mall.common.entity.UserCollect;
import com.joolun.cloud.mall.common.vo.GoodsSpuVO;
import io.swagger.annotations.Api;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;

/**
 * 商品api
 *
 * @author JL
 * @date 2019-08-12 16:25:10
 */
@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("/api/ma/goodsspu")
@Api(value = "goods", tags = "商品接口")
public class GoodsSpuApi {

    private final GoodsSpuService goodsSpuService;
	private final UserCollectMapper userCollectMapper;

    /**
    * 分页查询
    * @param page 分页对象
    * @param goodsSpu spu商品
    * @return
    */
    @GetMapping("/page")
    public R getGoodsSpuPage(HttpServletRequest request, Page page, GoodsSpu goodsSpu) {
		R checkThirdSession = BaseApi.checkThirdSession(null, request);
		if(!checkThirdSession.isOk()) {//检验失败，直接返回失败信息
			return checkThirdSession;
		}
    	String name = goodsSpu.getName();
		goodsSpu.setName(null);
        return R.ok(goodsSpuService.page(page, Wrappers.query(goodsSpu).lambda()
				.select(GoodsSpu::getId,
						GoodsSpu::getName,
						GoodsSpu::getTenantId,
						GoodsSpu::getSpuCode,
						GoodsSpu::getSellPoint,
						GoodsSpu::getCategoryFirst,
						GoodsSpu::getCategorySecond,
						GoodsSpu::getPicUrls,
						GoodsSpu::getShelf,
						GoodsSpu::getSort,
						GoodsSpu::getPriceDown,
						GoodsSpu::getPriceUp,
						GoodsSpu::getSaleNum,
						GoodsSpu::getCreateTime,
						GoodsSpu::getUpdateTime,
						GoodsSpu::getSpecType)
				.like(GoodsSpu::getName,StrUtil.isNotBlank(name) ? name : "")
				.eq(GoodsSpu::getShelf,MallConstants.SPU_SHELF_0)
			)
		);
    }

    /**
    * 通过id查询spu商品
    * @param id
    * @return R
    */
    @GetMapping("/{id}")
    public R getById(HttpServletRequest request, @PathVariable("id") String id){
		UserCollect userCollect = new UserCollect();
		R checkThirdSession = BaseApi.checkThirdSession(userCollect, request);
		if(!checkThirdSession.isOk()) {//检验失败，直接返回失败信息
			return checkThirdSession;
		}
		//查询用户是否收藏
		GoodsSpuVO goodsSpuVO = goodsSpuService.getById2(id);
		userCollect.setType(MallConstants.COLLECT_TYPE_1);
		userCollect.setRelationId(id);
		goodsSpuVO.setCollectId(userCollectMapper.selectCollectId(userCollect));
        return R.ok(goodsSpuVO);
    }

}
