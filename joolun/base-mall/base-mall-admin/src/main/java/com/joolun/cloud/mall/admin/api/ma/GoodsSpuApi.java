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
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.joolun.cloud.common.core.constant.CommonConstants;
import com.joolun.cloud.common.core.util.R;
import com.joolun.cloud.mall.admin.mapper.UserCollectMapper;
import com.joolun.cloud.mall.admin.service.CouponUserService;
import com.joolun.cloud.mall.admin.service.GoodsSpuService;
import com.joolun.cloud.mall.common.constant.MallConstants;
import com.joolun.cloud.mall.common.constant.MyReturnCode;
import com.joolun.cloud.mall.common.entity.CouponUser;
import com.joolun.cloud.mall.common.entity.GoodsSpu;
import com.joolun.cloud.mall.common.entity.UserCollect;
import com.joolun.cloud.weixin.common.util.ThirdSessionHolder;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Set;
import java.util.stream.Collectors;

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
@Api(value = "goodsspu", tags = "商品接口API")
public class GoodsSpuApi {

    private final GoodsSpuService goodsSpuService;
    private final UserCollectMapper userCollectMapper;
    private final CouponUserService couponUserService;

    /**
     * 分页查询
     *
     * @param page     分页对象
     * @param goodsSpu spu商品
     * @return
     */
    @ApiOperation(value = "分页查询")
    @GetMapping("/page")
    public R getGoodsSpuPage(Page page, GoodsSpu goodsSpu, String couponUserId) {
        goodsSpu.setShelf(CommonConstants.YES);
        CouponUser couponUser = null;
        if (StrUtil.isNotBlank(couponUserId)) {
            couponUser = couponUserService.getById(couponUserId);
        }
        return R.ok(goodsSpuService.page2(page, goodsSpu, couponUser));
    }

    /**
     * 分页查询首页随机
     *
     * @param page
     * @param goodsSpu
     * @param couponUserId
     * @return
     */
    @ApiOperation(value = "分页查询首页随机")
    @GetMapping("/pages")
    public R getGoodsSpuPages(Page page, GoodsSpu goodsSpu, String couponUserId) {
        goodsSpu.setShelf(CommonConstants.YES);
        CouponUser couponUser = null;
        if (StrUtil.isNotBlank(couponUserId)) {
            couponUser = couponUserService.getById(couponUserId);
        }
        IPage<GoodsSpu> iPage = goodsSpuService.page2(page, goodsSpu, couponUser);
        Set<GoodsSpu> goodsSpuSet = iPage.getRecords().stream().collect(Collectors.toSet());
        iPage.setRecords(goodsSpuSet.stream().collect(Collectors.toList()));
        return R.ok(iPage);
    }

    /**
     * 通过id查询spu商品
     *
     * @param id
     * @return R
     */
    @ApiOperation(value = "通过id查询spu商品")
    @GetMapping("/{id}")
    public R getById(@PathVariable("id") String id) {
        UserCollect userCollect = new UserCollect();
        userCollect.setUserId(ThirdSessionHolder.getMallUserId());
        GoodsSpu goodsSpu = goodsSpuService.getById2(id);
        if (goodsSpu == null) {
            return R.failed(MyReturnCode.ERR_80004.getCode(), MyReturnCode.ERR_80004.getMsg());
        }
        //查询用户是否收藏
        userCollect.setType(MallConstants.COLLECT_TYPE_1);
        userCollect.setRelationId(id);
        goodsSpu.setCollectId(userCollectMapper.selectCollectId(userCollect));

        if (goodsSpu.getVoidNum() <= MallConstants.VOID_NUM) {
            goodsSpu.setSaleNum(goodsSpu.getSaleNum() + 1);
            goodsSpu.setVoidNum(goodsSpu.getVoidNum() + 1);
            goodsSpuService.updateById(goodsSpu);
        }
        return R.ok(goodsSpu);
    }

}
