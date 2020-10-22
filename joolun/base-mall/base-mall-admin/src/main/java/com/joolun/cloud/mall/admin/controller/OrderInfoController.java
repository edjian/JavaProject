/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
package com.joolun.cloud.mall.admin.controller;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.joolun.cloud.common.core.constant.CommonConstants;
import com.joolun.cloud.common.core.constant.SecurityConstants;
import com.joolun.cloud.common.core.util.R;
import com.joolun.cloud.common.log.annotation.SysLog;
import com.joolun.cloud.common.security.entity.BaseUser;
import com.joolun.cloud.common.security.util.SecurityUtils;
import com.joolun.cloud.mall.admin.service.OrderLogisticsService;
import com.joolun.cloud.mall.admin.service.UserInfoService;
import com.joolun.cloud.mall.common.constant.MallConstants;
import com.joolun.cloud.mall.common.constant.MyReturnCode;
import com.joolun.cloud.mall.common.dto.ShipmentsDTO;
import com.joolun.cloud.mall.common.entity.OrderInfo;
import com.joolun.cloud.mall.admin.service.OrderInfoService;
import com.joolun.cloud.mall.common.entity.OrderItem;
import com.joolun.cloud.mall.common.entity.OrderLogistics;
import com.joolun.cloud.mall.common.enums.OrderInfoEnum;
import com.joolun.cloud.mall.common.feign.FeignWxAppService;
import com.joolun.cloud.mall.common.util.ExcelUtil;
import com.joolun.cloud.upms.common.dto.UserInfo;
import com.joolun.cloud.upms.common.entity.SysRoleMenu;
import com.joolun.cloud.upms.common.entity.SysUserRole;
import com.joolun.cloud.upms.common.feign.FeignUserService;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.access.prepost.PreAuthorize;
import io.swagger.annotations.Api;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 商城订单
 *
 * @author JL
 * @date 2019-09-10 15:21:22
 */
@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("/orderinfo")
@Api(value = "orderinfo", tags = "商城订单管理")
public class OrderInfoController {

    private final OrderInfoService orderInfoService;
	private final UserInfoService userInfoService;
	private final FeignWxAppService feignWxAppService;
	private final OrderLogisticsService orderLogisticsService;
	private final FeignUserService feignUserService;

    /**
    * 分页查询
    * @param page 分页对象
    * @param orderInfo 商城订单
    * @return
    */
	@ApiOperation(value = "分页查询")
    @GetMapping("/page")
    @PreAuthorize("@ato.hasAuthority('mall:orderinfo:index')")
    public R getOrderInfoPage(Page page, OrderInfo orderInfo) {
        return R.ok(orderInfoService.page1(page, Wrappers.query(orderInfo)));
    }

	/**
	 * 查询数量
	 * @param orderInfo
	 * @return
	 */
	@ApiOperation(value = "查询数量")
	@GetMapping("/count")
	public R getCount(OrderInfo orderInfo) {
		BaseUser baseUser = SecurityUtils.getUser();
		R<UserInfo> userInfoR = feignUserService.info(baseUser.getUsername(), SecurityConstants.FROM_IN);
		long count = Arrays.stream(userInfoR.getData().getRoles()).filter(role-> !feignUserService.judeAdmin(role, SecurityConstants.FROM_IN)).count();
		if(count < 1){
			orderInfo.setOrganId(baseUser.getOrganId());
		}
		return R.ok(orderInfoService.count(Wrappers.query(orderInfo)));
	}

    /**
    * 通过id查询商城订单
    * @param id
    * @return R
    */
	@ApiOperation(value = "通过id查询商城订单")
    @GetMapping("/{id}")
    @PreAuthorize("@ato.hasAuthority('mall:orderinfo:get')")
    public R getById(@PathVariable("id") String id){
		OrderInfo orderInfo = orderInfoService.getById(id);
		R r2 = feignWxAppService.getById(orderInfo.getAppId(), SecurityConstants.FROM_IN);
		orderInfo.setUserInfo(userInfoService.getById(orderInfo.getUserId()));
		orderInfo.setApp((Map<Object, Object>)r2.getData());
		OrderLogistics orderLogistics = orderLogisticsService.getById(orderInfo.getLogisticsId());
		orderInfo.setOrderLogistics(orderLogistics);
        return R.ok(orderInfo);
    }

    /**
    * 新增商城订单
    * @param orderInfo 商城订单
    * @return R
    */
	@ApiOperation(value = "新增商城订单")
    @SysLog("新增商城订单")
    @PostMapping
    @PreAuthorize("@ato.hasAuthority('mall:orderinfo:add')")
    public R save(@RequestBody OrderInfo orderInfo){
        return R.ok(orderInfoService.save(orderInfo));
    }

    /**
    * 修改商城订单
    * @param orderInfo 商城订单
    * @return R
    */
	@ApiOperation(value = "修改商城订单")
    @SysLog("修改商城订单")
    @PutMapping
    @PreAuthorize("@ato.hasAuthority('mall:orderinfo:edit')")
    public R updateById(@RequestBody OrderInfo orderInfo){
        return R.ok(orderInfoService.updateById(orderInfo));
    }

    /**
    * 通过id删除商城订单
    * @param id
    * @return R
    */
	@ApiOperation(value = "通过id删除商城订单")
    @SysLog("删除商城订单")
    @DeleteMapping("/{id}")
    @PreAuthorize("@ato.hasAuthority('mall:orderinfo:del')")
    public R removeById(@PathVariable String id){
        return R.ok(orderInfoService.removeById(id));
    }

	/**
	 * 修改商城订单价格
	 * @param orderItem
	 * @return R
	 */
	@ApiOperation(value = "修改商城订单价格")
	@SysLog("修改商城订单价格")
	@PutMapping("/editPrice")
	@PreAuthorize("@ato.hasAuthority('mall:orderinfo:edit')")
	public R editPrice(@RequestBody OrderItem orderItem){
		orderInfoService.editPrice(orderItem);
		return R.ok();
	}

	/**
	 * 取消商城订单
	 * @param id 商城订单
	 * @return R
	 */
	@ApiOperation(value = "取消商城订单")
	@SysLog("取消商城订单")
	@PutMapping("/cancel/{id}")
	@PreAuthorize("@ato.hasAuthority('mall:orderinfo:edit')")
	public R orderCancel(@PathVariable String id){
		OrderInfo orderInfo = orderInfoService.getById(id);
		if(orderInfo == null){
			return R.failed(MyReturnCode.ERR_70005.getCode(), MyReturnCode.ERR_70005.getMsg());
		}
		if(!CommonConstants.NO.equals(orderInfo.getIsPay())){//只有未支付订单能取消
			return R.failed(MyReturnCode.ERR_70001.getCode(), MyReturnCode.ERR_70001.getMsg());
		}
		orderInfoService.orderCancel(orderInfo);
		return R.ok();
	}

	/**
	 * 商城订单自提
	 * @param id 商城订单ID
	 * @return R
	 */
	@ApiOperation(value = "商城订单自提")
	@PutMapping("/takegoods/{id}")
	@PreAuthorize("@ato.hasAuthority('mall:orderinfo:edit')")
	public R takeGoods(@PathVariable String id){
		OrderInfo orderInfo = orderInfoService.getById(id);
		if(orderInfo == null){
			return R.failed(MyReturnCode.ERR_70005.getCode(), MyReturnCode.ERR_70005.getMsg());
		}
		if(!MallConstants.DELIVERY_WAY_2.equals(orderInfo.getDeliveryWay())
				&& !OrderInfoEnum.STATUS_1.getValue().equals(orderInfo.getStatus())){//只有待自提订单能确认收货
			return R.failed(MyReturnCode.ERR_70001.getCode(), MyReturnCode.ERR_70001.getMsg());
		}
		orderInfoService.orderReceive(orderInfo);
		return R.ok();
	}

	/**
	 * 待发货订单Excel导出
	 * @param response
	 * @param orderInfo
	 */
	@ApiOperation(value = "待发货订单Excel导出")
	@GetMapping("/sendOrderInfo/excelExport")
	public void excelExport(HttpServletResponse response, OrderInfo orderInfo){
		orderInfo.setStatus("1");
		List<OrderInfo> orderInfoList = orderInfoService.page1(Wrappers.query(orderInfo));
		List<ShipmentsDTO> shipmentsDTOList = orderInfoList.stream().map(orderInfo1 -> {
			ShipmentsDTO shipmentsDTO = new ShipmentsDTO();
			shipmentsDTO.setOrderId(orderInfo1.getId());
//			BeanUtil.copyProperties(shipmentsDTO, orderInfo1.getOrderLogistics());
			return shipmentsDTO;
		}).collect(Collectors.toList());
		ExcelUtil.writeExcel(response, shipmentsDTOList, ShipmentsDTO.class);
	}

	/**
	 * 待发货订单单号Excel导入
	 * @param file
	 */
	@ApiOperation(value = "待发货订单单号Excel导入")
	@PostMapping("/readOrderInfo/readExcel")
	public void readExcel(MultipartFile file){
		List<ShipmentsDTO> shipmentsDTOList = ExcelUtil.readExcel("", ShipmentsDTO.class, file);
		shipmentsDTOList.forEach(s-> System.out.println(s.toString()));
	}
}
