package com.joolun.cloud.mall.admin.api.ma;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.joolun.cloud.common.core.constant.CommonConstants;
import com.joolun.cloud.common.core.util.R;
import com.joolun.cloud.common.log.annotation.SysLog;
import com.joolun.cloud.mall.admin.service.InviteNewService;
import com.joolun.cloud.mall.common.constant.MallConstants;
import com.joolun.cloud.mall.common.entity.InviteNew;
import com.joolun.cloud.mall.common.entity.UserInfo;
import com.joolun.cloud.weixin.common.util.ThirdSessionHolder;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;


/**
 * 邀新表
 *
 * @author zq
 * @date 2020-07-09 15:06:47
 */
@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("/api/ma/inviteNew")
@Api(value = "invitenew", tags = "邀新表管理")
public class InviteNewApi {

    private final InviteNewService inviteNewService;

    /**
     * 分页列表
     * @param page 分页对象
     * @param inviteNew 邀新表
     * @return
     */
    @ApiOperation(value = "分页列表")
    @GetMapping("/page")
    public R getPage(Page page, InviteNew inviteNew) {
        inviteNew.setUserIdFirst(ThirdSessionHolder.getMallUserId());
        return R.ok(inviteNewService.page1(page,inviteNew));
    }

    /**
     * 邀新数据显示
     * @param inviteNew
     * @return
     */
    @ApiOperation(value = "邀新数据显示")
    @GetMapping("/myInviteNew")
    public R myInviteNew(InviteNew inviteNew){
        return R.ok(inviteNewService.myInviteNew(inviteNew));
    }


    @ApiOperation(value = "我的成功邀新")
    @GetMapping("/passMyInviteNew")
    public R successMyInviteNew(){
        return R.ok(inviteNewService.successMyInviteNew());
    }

    @ApiOperation(value = "我的邀请详情")
    @GetMapping("/myInviteNewDetail/{level}")
    public R myInviteNewDetail(@PathVariable()String level, Page page){
        return R.ok(inviteNewService.myInviteNewDetail(level,page));
    }

}
