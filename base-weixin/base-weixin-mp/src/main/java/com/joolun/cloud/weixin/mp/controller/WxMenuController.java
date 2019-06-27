package com.joolun.cloud.weixin.mp.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.joolun.cloud.common.core.util.R;
import com.joolun.cloud.common.log.annotation.SysLog;
import com.joolun.cloud.weixin.common.constant.WxReturnCode;
import com.joolun.cloud.weixin.mp.service.WxMenuService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import me.chanjar.weixin.common.error.WxErrorException;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

/**
 * 自定义菜单
 *
 * @author JL
 * @date 2019-03-27 16:52:10
 */
@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("/wxmenu")
public class WxMenuController {

  private final  WxMenuService wxMenuService;

  /**
   * 通过appId查询自定义菜单
   * @param appId
   * @return R
   */
  @GetMapping("/list")
  @PreAuthorize("@pms.hasPermission('wxmp_wxmenu_get')")
  public R getWxMenuButton(String appId){
    return R.ok(wxMenuService.getWxMenuButton(appId));
  }
  /**
   * 保存并发布菜单
   * @param
   * @return R
   */
  @SysLog("保存并发布菜单")
  @PostMapping
  @PreAuthorize("@pms.hasPermission('wxmp_wxmenu_add')")
  public R saveAndRelease(@RequestBody String data){
	  JSONObject jSONObject = JSON.parseObject(data);
	  String strWxMenu = jSONObject.getString("strWxMenu");
	  String appId = jSONObject.getString("appId");
	  try {
		  wxMenuService.saveAndRelease(appId,strWxMenu);
		  return R.ok(Boolean.TRUE);
	  } catch (WxErrorException e) {
		  e.printStackTrace();
		  log.error("发布自定义菜单失败appID:"+appId+":"+e.getMessage());
		  return WxReturnCode.wxErrorExceptionHandler(e);
	  }
  }
}
