package com.joolun.cloud.mall.admin.api.ma;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.joolun.cloud.common.core.constant.CommonConstants;
import com.joolun.cloud.common.core.util.R;
import com.joolun.cloud.mall.admin.service.ShareRecordService;
import com.joolun.cloud.mall.admin.service.ShareTaskService;
import com.joolun.cloud.mall.common.entity.ShareRecord;
import com.joolun.cloud.mall.common.entity.ShareTask;
import com.joolun.cloud.weixin.common.util.ThirdSessionHolder;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 分享任务表
 *
 * @author zq
 * @date 2020-07-09 15:36:56
 */
@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("/api/ma/sharetask")
@Api(value = "sharetask", tags = "分享任务表管理")
public class ShareTaskApi {
    private final ShareTaskService shareTaskService;
    private final ShareRecordService shareRecordService;

    /**
     * 分页列表
     *
     * @param page      分页对象
     * @param shareTask 分享任务表
     * @return
     */
    @ApiOperation(value = "分页列表")
    @GetMapping("/page")
    public R getPage(Page page, ShareTask shareTask) {
        shareTask.setEnable(CommonConstants.YES);
        shareTask.setUserId(ThirdSessionHolder.getMallUserId());
        return R.ok(shareTaskService.page1(page, shareTask));
    }

    /**
     * 任务分享回调新增积分明细
     *
     * @return
     */
    @ApiOperation(value = "任务分享回调新增积分明细")
    @GetMapping("/shareCallback")
    public R shareCallback() {
        shareTaskService.shareCallback();
        return R.ok();
    }
}
