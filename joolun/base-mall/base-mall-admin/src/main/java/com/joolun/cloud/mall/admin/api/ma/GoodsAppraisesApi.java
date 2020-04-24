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
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.joolun.cloud.common.core.constant.SecurityConstants;
import com.joolun.cloud.common.core.util.R;
import com.joolun.cloud.mall.admin.service.GoodsAppraisesService;
import com.joolun.cloud.mall.admin.service.OrderInfoService;
import com.joolun.cloud.mall.common.constant.MyReturnCode;
import com.joolun.cloud.mall.common.entity.GoodsAppraises;
import com.joolun.cloud.mall.common.entity.OrderInfo;
import com.joolun.cloud.mall.common.enums.OrderInfoEnum;
import com.joolun.cloud.mall.common.feign.FeignWxUserService;
import com.joolun.cloud.weixin.common.entity.WxUser;
import com.joolun.cloud.weixin.common.util.ThirdSessionHolder;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * 商品评价
 *
 * @author JL
 * @date 2019-09-23 15:51:01
 */
@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("/api/ma/goodsappraises")
@Api(value = "goodsappraises", tags = "商品评价Api")
public class GoodsAppraisesApi {

	private final OrderInfoService orderInfoService;
    private final GoodsAppraisesService goodsAppraisesService;
	private final FeignWxUserService feignWxUserService;

	/**
    * 分页查询
    * @param page 分页对象
    * @param goodsAppraises 商品评价
    * @return
    */
	@ApiOperation(value = "分页查询")
    @GetMapping("/page")
    public R getGoodsAppraisesPage(Page page, GoodsAppraises goodsAppraises) {
		goodsAppraises.setUserId(ThirdSessionHolder.getMallUserId());
        return R.ok(goodsAppraisesService.page(page,Wrappers.query(goodsAppraises)));
    }

    /**
    * 通过id查询商品评价
    * @param id
    * @return R
    */
	@ApiOperation(value = "通过id查询商品评价")
    @GetMapping("/{id}")
    public R getById(@PathVariable("id") String id){
        return R.ok(goodsAppraisesService.getById(id));
    }

    /**
    * 新增商品评价
    * @param listGoodsAppraises 商品评价
    * @return R
    */
	@ApiOperation(value = "新增商品评价")
    @PostMapping
    public R save(@RequestBody List<GoodsAppraises> listGoodsAppraises){
    	WxUser wxUser = new WxUser();
		wxUser.setAppId(ThirdSessionHolder.getThirdSession().getAppId());
		wxUser.setId(ThirdSessionHolder.getThirdSession().getWxUserId());
		wxUser.setSessionKey(ThirdSessionHolder.getThirdSession().getSessionKey());
		wxUser.setOpenId(ThirdSessionHolder.getThirdSession().getOpenId());
		wxUser.setMallUserId(ThirdSessionHolder.getThirdSession().getMallUserId());
		OrderInfo orderInfo = orderInfoService.getById(listGoodsAppraises.get(0).getOrderId());
		if(!OrderInfoEnum.STATUS_3.getValue().equals(orderInfo.getStatus())){
			return R.failed(MyReturnCode.ERR_70001.getCode(), MyReturnCode.ERR_70001.getMsg());
		}
		R r = feignWxUserService.getById(wxUser.getId(), SecurityConstants.FROM_IN);
		Map map = (Map<Object, Object>)r.getData();
		listGoodsAppraises.forEach(goodsAppraises -> {
			goodsAppraises.setUserId(wxUser.getId());
			goodsAppraises.setHeadimgUrl(map.get("headimgUrl")!=null ? String.valueOf(map.get("headimgUrl")) : null);
			goodsAppraises.setNickName(map.get("nickName")!=null ? String.valueOf(map.get("nickName")) : null);
		});
		goodsAppraisesService.doAppraises(listGoodsAppraises);
        return R.ok();
    }

    /**
    * 修改商品评价
    * @param goodsAppraises 商品评价
    * @return R
    */
	@ApiOperation(value = "修改商品评价")
    @PutMapping
    public R updateById(@RequestBody GoodsAppraises goodsAppraises){
		goodsAppraises.setUserId(ThirdSessionHolder.getMallUserId());
        return R.ok(goodsAppraisesService.updateById(goodsAppraises));
    }

    /**
    * 通过id删除商品评价
    * @param id
    * @return R
    */
	@ApiOperation(value = "通过id删除商品评价")
    @DeleteMapping("/{id}")
    public R removeById(@PathVariable String id){
		return R.ok(goodsAppraisesService.removeById(id));
    }

}
