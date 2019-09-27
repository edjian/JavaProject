/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
package com.joolun.cloud.mall.admin.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.joolun.cloud.common.core.util.R;
import com.joolun.cloud.common.log.annotation.SysLog;
import com.joolun.cloud.mall.common.dto.GoodsSpuDTO;
import com.joolun.cloud.mall.common.entity.GoodsSpu;
import com.joolun.cloud.mall.admin.service.GoodsSpuService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.access.prepost.PreAuthorize;
import io.swagger.annotations.Api;

/**
 * spu商品
 *
 * @author JL
 * @date 2019-08-12 16:25:10
 */
@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("/goodsspu")
@Api(value = "goodsspu", tags = "spu商品管理")
public class GoodsSpuController {

    private final GoodsSpuService goodsSpuService;

    /**
    * 分页查询
    * @param page 分页对象
    * @param goodsSpu spu商品
    * @return
    */
    @GetMapping("/page")
    @PreAuthorize("@ato.hasAuthority('mall_goodsspu_index')")
    public R getGoodsSpuPage(Page page, GoodsSpu goodsSpu) {
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
						.like(GoodsSpu::getName, StrUtil.isNotBlank(name) ? name : "")
				)
		);
    }

    /**
    * 通过id查询spu商品
    * @param id
    * @return R
    */
    @GetMapping("/{id}")
    @PreAuthorize("@ato.hasAuthority('mall_goodsspu_get')")
    public R getById(@PathVariable("id") String id){
        return R.ok(goodsSpuService.getById2(id));
    }

    /**
    * 新增spu商品
    * @param goodsSpuDTO spu商品
    * @return R
    */
    @SysLog("新增spu商品")
    @PostMapping
    @PreAuthorize("@ato.hasAuthority('mall_goodsspu_add')")
    public R save(@RequestBody GoodsSpuDTO goodsSpuDTO){
        return R.ok(goodsSpuService.save(goodsSpuDTO));
    }

    /**
    * 修改spu商品
    * @param goodsSpuDTO spu商品
    * @return R
    */
    @SysLog("修改spu商品")
    @PutMapping
    @PreAuthorize("@ato.hasAuthority('mall_goodsspu_edit')")
    public R updateById(@RequestBody GoodsSpuDTO goodsSpuDTO){
        return R.ok(goodsSpuService.updateById(goodsSpuDTO));
    }

    /**
    * 通过id删除spu商品
    * @param id
    * @return R
    */
    @SysLog("删除spu商品")
    @DeleteMapping("/{id}")
    @PreAuthorize("@ato.hasAuthority('mall_goodsspu_del')")
    public R removeById(@PathVariable String id){
        return R.ok(goodsSpuService.removeById(id));
    }

}
