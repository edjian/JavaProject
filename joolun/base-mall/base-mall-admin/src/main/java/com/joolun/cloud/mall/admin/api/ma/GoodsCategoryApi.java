/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
package com.joolun.cloud.mall.admin.api.ma;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.joolun.cloud.common.core.constant.CommonConstants;
import com.joolun.cloud.common.core.util.R;
import com.joolun.cloud.mall.admin.service.GoodsCategoryService;
import com.joolun.cloud.mall.common.entity.GoodsCategory;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;


/**
 * 商品类目
 *
 * @author JL
 * @date 2019-08-12 11:46:28
 */
@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("/api/ma/goodscategory")
@Api(value = "goodscategory", tags = "商品类目API")
public class GoodsCategoryApi {

    private final GoodsCategoryService goodsCategoryService;

    /**
    * 返回树形集合
    */
	@ApiOperation(value = "返回树形集合")
    @GetMapping("/tree")
    public R goodsCategoryTree() {
//	    二级
//	    return R.ok(goodsCategoryService.selectTree(null));
        GoodsCategory goodsCategory = new GoodsCategory();
        goodsCategory.setParentId(CommonConstants.PARENT_ID);
	    return R.ok(goodsCategoryService.selectTree(goodsCategory));
    }

    /**
     * 类目模糊查询
     *
     * @param param
     * @return
     */
    @ApiOperation(value = "类目模糊查询")
    @GetMapping("/blur/{param}")
    public R goodsCategoryByBlur(@PathVariable("param") String param){
	    return R.ok(goodsCategoryService.getOne(Wrappers.<GoodsCategory>lambdaQuery()
                .eq(GoodsCategory::getParentId, CommonConstants.PARENT_ID)
                .like(GoodsCategory::getName, param)));
    }
}
