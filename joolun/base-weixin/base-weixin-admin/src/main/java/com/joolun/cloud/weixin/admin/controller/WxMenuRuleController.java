/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
package com.joolun.cloud.weixin.admin.controller;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.joolun.cloud.common.core.util.R;
import com.joolun.cloud.common.log.annotation.SysLog;
import com.joolun.cloud.weixin.common.entity.WxMenuRule;
import com.joolun.cloud.weixin.admin.service.WxMenuRuleService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.access.prepost.PreAuthorize;
import io.swagger.annotations.Api;

/**
 * 微信自定义菜单分组
 *
 * @author JL
 * @date 2020-02-22 19:34:22
 */
@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("/wxmenurule")
@Api(value = "wxmenurule", tags = "微信自定义菜单分组管理")
public class WxMenuRuleController {

    private final WxMenuRuleService wxMenuRuleService;

    /**
     * 分页列表
     * @param page 分页对象
     * @param wxMenuRule 微信自定义菜单分组
     * @return
     */
    @GetMapping("/page")
    @PreAuthorize("@ato.hasAuthority('wxmp_wxmenurule_index')")
    public R getPage(Page page, WxMenuRule wxMenuRule) {
        return R.ok(wxMenuRuleService.page(page, Wrappers.query(wxMenuRule)));
    }

    /**
     * 微信自定义菜单分组查询
     * @param id
     * @return R
     */
    @GetMapping("/{id}")
    @PreAuthorize("@ato.hasAuthority('wxmp_wxmenurule_get')")
    public R getById(@PathVariable("id") String id) {
        return R.ok(wxMenuRuleService.getById(id));
    }

    /**
     * 微信自定义菜单分组新增
     * @param wxMenuRule 微信自定义菜单分组
     * @return R
     */
    @SysLog("新增微信自定义菜单分组")
    @PostMapping
    @PreAuthorize("@ato.hasAuthority('wxmp_wxmenurule_add')")
    public R save(@RequestBody WxMenuRule wxMenuRule) {
        return R.ok(wxMenuRuleService.save(wxMenuRule));
    }

    /**
     * 微信自定义菜单分组修改
     * @param wxMenuRule 微信自定义菜单分组
     * @return R
     */
    @SysLog("修改微信自定义菜单分组")
    @PutMapping
    @PreAuthorize("@ato.hasAuthority('wxmp_wxmenurule_edit')")
    public R updateById(@RequestBody WxMenuRule wxMenuRule) {
        return R.ok(wxMenuRuleService.updateById(wxMenuRule));
    }

    /**
     * 微信自定义菜单分组删除
     * @param id
     * @return R
     */
    @SysLog("删除微信自定义菜单分组")
    @DeleteMapping("/{id}")
    @PreAuthorize("@ato.hasAuthority('wxmp_wxmenurule_del')")
    public R removeById(@PathVariable String id) {
        return R.ok(wxMenuRuleService.removeById(id));
    }

}
