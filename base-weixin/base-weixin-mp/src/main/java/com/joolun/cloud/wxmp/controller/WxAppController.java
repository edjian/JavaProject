/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码，并且可以商用（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
package com.joolun.cloud.wxmp.controller;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.joolun.cloud.common.core.util.R;
import com.joolun.cloud.common.log.annotation.SysLog;
import com.joolun.cloud.weixin.common.constant.ConfigConstant;
import com.joolun.cloud.weixin.common.constant.WxReturnCode;
import com.joolun.cloud.wxmp.config.WxMpConfiguration;
import com.joolun.cloud.weixin.common.entity.WxApp;
import com.joolun.cloud.wxmp.service.WxAppService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import me.chanjar.weixin.common.error.WxErrorException;
import me.chanjar.weixin.mp.api.WxMpDataCubeService;
import me.chanjar.weixin.mp.api.WxMpQrcodeService;
import me.chanjar.weixin.mp.api.WxMpService;
import me.chanjar.weixin.mp.bean.result.WxMpQrCodeTicket;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.Map;

/**
 * 微信账号配置
 *
 * @author JL
 * @date 2019-03-23 21:26:35
 */
@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("/wxapp")
public class WxAppController {

	private final WxAppService wxAppService;

	/**
	 * 分页查询
	 *
	 * @param page  分页对象
	 * @param wxApp 微信账号配置
	 * @return
	 */
	@GetMapping("/page")
	@PreAuthorize("@pms.hasPermission('wxmp_wxapp_index')")
	public R getWxAppPage(Page page, WxApp wxApp) {
		return R.ok(wxAppService.page(page, Wrappers.query(wxApp)));
	}


	/**
	 * 通过id查询微信账号配置
	 *
	 * @param id
	 * @return R
	 */
	@GetMapping("/{id}")
	@PreAuthorize("@pms.hasPermission('wxmp_wxapp_get')")
	public R getById(@PathVariable("id") String id) {
		return R.ok(wxAppService.getById(id));
	}

	/**
	 * 新增微信账号配置
	 *
	 * @param wxApp 微信账号配置
	 * @return R
	 */
	@SysLog("新增微信账号配置")
	@PostMapping
	@PreAuthorize("@pms.hasPermission('wxmp_wxapp_add')")
	public R save(@RequestBody WxApp wxApp) {
		wxApp.setAppType(ConfigConstant.WX_APP_TYPE_2);
		try {
			WxMpQrcodeService wxMpQrcodeService = WxMpConfiguration.getMpService(wxApp).getQrcodeService();
			String sceneStr = "1";
			WxMpQrCodeTicket wxMpQrCodeTicket = wxMpQrcodeService.qrCodeCreateLastTicket(sceneStr);
			wxApp.setQrCode(wxMpQrCodeTicket.getUrl());
		} catch (WxErrorException e) {
			e.printStackTrace();
			log.error("新增微信账号配置失败appID:" + wxApp.getId() + ":" + e.getMessage());
		}
		return R.ok(wxAppService.save(wxApp));
	}

	/**
	 * 修改微信账号配置
	 *
	 * @param wxApp 微信账号配置
	 * @return R
	 */
	@SysLog("修改微信账号配置")
	@PutMapping
	@PreAuthorize("@pms.hasPermission('wxmp_wxapp_edit')")
	public R updateById(@RequestBody WxApp wxApp) {
		try {
			WxMpQrcodeService wxMpQrcodeService = WxMpConfiguration.getMpService(wxApp).getQrcodeService();
			String sceneStr = "1";
			WxMpQrCodeTicket wxMpQrCodeTicket = wxMpQrcodeService.qrCodeCreateLastTicket(sceneStr);
			wxApp.setQrCode(wxMpQrCodeTicket.getUrl());
		} catch (WxErrorException e) {
			e.printStackTrace();
			log.error("修改微信账号配置失败appID:" + wxApp.getId() + ":" + e.getMessage());
		}
		return R.ok(wxAppService.updateById(wxApp));
	}

	/**
	 * 通过id删除微信账号配置
	 *
	 * @param id
	 * @return R
	 */
	@SysLog("删除微信账号配置")
	@DeleteMapping("/{id}")
	@PreAuthorize("@pms.hasPermission('wxmp_wxapp_del')")
	public R removeById(@PathVariable String id) {
		return R.ok(wxAppService.removeById(id));
	}

	@SysLog("生成公众号二维码")
	@PostMapping("/qrCode")
	@PreAuthorize("@pms.hasPermission('wxmp_wxapp_index')")
	public R createQrCode(@RequestBody Map<String,String> param) {
		try {
			String id = param.get("id");
			String sceneStr = param.get("sceneStr");
			WxMpQrcodeService wxMpQrcodeService = WxMpConfiguration.getMpService(id).getQrcodeService();
			WxMpQrCodeTicket wxMpQrCodeTicket = wxMpQrcodeService.qrCodeCreateLastTicket(sceneStr);
			WxApp wxApp = new WxApp();
			wxApp.setId(id);
			wxApp.setQrCode(wxMpQrCodeTicket.getUrl());
			return R.ok(wxAppService.updateById(wxApp));
		} catch (WxErrorException e) {
			e.printStackTrace();
			log.error("生成公众号二维码失败appID:" + param.get("id") + ":" + e.getMessage());
			return WxReturnCode.wxErrorExceptionHandler(e);
		}
	}

	@SysLog("微信接口次数进行清零")
	@PutMapping("/quota")
	@PreAuthorize("@pms.hasPermission('wxmp_wxapp_index')")
	public R clearQuota(@RequestBody WxApp wxApp) {
		try {
			WxMpService wxMpService = WxMpConfiguration.getMpService(wxApp.getId());
			wxMpService.clearQuota(wxApp.getId());
			return new R<>();
		} catch (WxErrorException e) {
			e.printStackTrace();
			log.error("微信接口次数进行清零失败appID:" + wxApp.getId() + ":" + e.getMessage());
			return WxReturnCode.wxErrorExceptionHandler(e);
		}
	}

	/**
	 * 获取access-token
	 * @param wxApp
	 * @return
	 */
	@GetMapping("/access-token")
	@PreAuthorize("@pms.hasPermission('wxmp_wxapp_index')")
	public R getAccessToken(WxApp wxApp) {
		try {
			WxMpService wxMpService = WxMpConfiguration.getMpService(wxApp.getId());
			return R.ok(wxMpService.getAccessToken());
		} catch (WxErrorException e) {
			e.printStackTrace();
			log.error("获取access-token失败appID:" + wxApp.getId() + ":" + e.getMessage());
			return WxReturnCode.wxErrorExceptionHandler(e);
		}
	}

	/**
	 * 获取用户增减数据
	 * @param appId
	 * @param startDate
	 * @param endDate
	 * @return
	 */
	@GetMapping("/usersummary")
	@PreAuthorize("@pms.hasPermission('wxmp_wxapp_index')")
	public R getUsersummary(String appId, String startDate, String endDate) {
		try {
			WxMpService wxMpService = WxMpConfiguration.getMpService(appId);
			WxMpDataCubeService wxMpDataCubeService = wxMpService.getDataCubeService();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			return R.ok(wxMpDataCubeService.getUserSummary(sdf.parse(startDate), sdf.parse(endDate)));
		} catch (WxErrorException e) {
			e.printStackTrace();
			log.error("获取用户增减数据失败",e);
			return WxReturnCode.wxErrorExceptionHandler(e);
		}catch (Exception e) {
			e.printStackTrace();
			log.error("获取用户增减数据失败",e);
			return R.failed("获取用户增减数据失败");
		}
	}

	/**
	 * 获取累计用户数据
	 * @param appId
	 * @param startDate
	 * @param endDate
	 * @return
	 */
	@GetMapping("/usercumulate")
	@PreAuthorize("@pms.hasPermission('wxmp_wxapp_index')")
	public R getUserCumulate(String appId, String startDate, String endDate){
		try {
			WxMpService wxMpService = WxMpConfiguration.getMpService(appId);
			WxMpDataCubeService wxMpDataCubeService = wxMpService.getDataCubeService();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			return R.ok(wxMpDataCubeService.getUserCumulate(sdf.parse(startDate), sdf.parse(endDate)));
		} catch (WxErrorException e) {
			e.printStackTrace();
			log.error("获取累计用户数据失败",e);
			return WxReturnCode.wxErrorExceptionHandler(e);
		}catch (Exception e) {
			e.printStackTrace();
			log.error("获取用户增减数据失败",e);
			return R.failed("获取用户增减数据失败");
		}
	}

	/**
	 * 获取接口分析数据
	 * @param appId
	 * @param startDate
	 * @param endDate
	 * @return
	 */
	@GetMapping("/interfacesummary")
	@PreAuthorize("@pms.hasPermission('wxmp_wxapp_index')")
	public R getInterfaceSummary(String appId, String startDate, String endDate){
		try {
			WxMpService wxMpService = WxMpConfiguration.getMpService(appId);
			WxMpDataCubeService wxMpDataCubeService = wxMpService.getDataCubeService();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			return R.ok(wxMpDataCubeService.getInterfaceSummary(sdf.parse(startDate), sdf.parse(endDate)));
		} catch (WxErrorException e) {
			e.printStackTrace();
			log.error("获取接口分析数据失败",e);
			return WxReturnCode.wxErrorExceptionHandler(e);
		}catch (Exception e) {
			e.printStackTrace();
			log.error("获取接口分析数据失败",e);
			return R.failed("获取接口分析数据失败");
		}
	}
}
