package com.joolun.cloud.mall.admin.api.ma;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.joolun.cloud.common.core.constant.CommonConstants;
import com.joolun.cloud.common.core.util.R;
import com.joolun.cloud.mall.admin.service.ShareRecordService;
import com.joolun.cloud.mall.admin.service.ShareTaskService;
import com.joolun.cloud.mall.common.constant.MallConstants;
import com.joolun.cloud.mall.common.entity.ShareRecord;
import com.joolun.cloud.mall.common.entity.ShareTask;
import com.joolun.cloud.weixin.common.util.ThirdSessionHolder;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/api/ma/shareRecord")
@Api(value = "shareRecord", tags = "积分分享记录")
public class ShareRecordApi {

    private final ShareRecordService shareRecordService;
    private final ShareTaskService shareTaskService;

    /**
     * 分页列表
     *
     * @param page        分页对象
     * @param shareRecord 用户分享任务记录表
     * @return
     */
    @ApiOperation(value = "分页列表")
    @GetMapping("/page")
    public R getPage(Page page, ShareRecord shareRecord) {
        return R.ok(shareRecordService.page(page, Wrappers.query(shareRecord)));
    }

    /**
     * 用户分享任务记录表查询
     *
     * @param id
     * @return R
     */
    @ApiOperation(value = "用户分享任务记录表查询")
    @GetMapping("/{id}")
    public R getById(@PathVariable("id") String id) {
        return R.ok(shareRecordService.getById(id));
    }

    /**
     * 用户分享任务记录表新增
     *
     * @param shareRecord 用户分享任务记录表
     * @return R
     */
    @ApiOperation(value = "用户分享任务记录表新增")
    @PostMapping
    public R save(@RequestBody ShareRecord shareRecord) {
        shareRecord.setUserId(ThirdSessionHolder.getMallUserId());
        return R.ok(shareRecordService.save(shareRecord));
    }

    /**
     * 用户分享任务记录表修改
     *
     * @param shareRecord 用户分享任务记录表
     * @return R
     */
    @ApiOperation(value = "用户分享任务记录表修改")
    @PutMapping
    public R updateById(@RequestBody ShareRecord shareRecord) {
        return R.ok(shareRecordService.updateById(shareRecord));
    }

    /**
     * 用户分享任务回调接口
     *
     * @param shareRecord
     * @return
     */
    @ApiOperation(value = "用户分享任务回调接口")
    @GetMapping("/shareCallback")
    public R shareCallback(ShareRecord shareRecord) {

        ShareRecord shareRecord1 = shareRecordService.getOne(Wrappers.<ShareRecord>lambdaQuery()
                .eq(ShareRecord::getUserId, ThirdSessionHolder.getMallUserId())
                .eq(ShareRecord::getTaskId, shareRecord.getTaskId())
                .like(ShareRecord::getCreateTime, LocalDate.now()));
        if (shareRecord1 != null)
            return R.ok();
        shareRecord.setUserId(ThirdSessionHolder.getMallUserId());
        shareRecord.setCreateTime(LocalDateTime.now());
        shareRecord.setStatus(MallConstants.SHARE_RECORD_YES);
        shareRecordService.save(shareRecord);
        if (shareTaskService.completeTask())
            shareTaskService.shareCallback();
        return R.ok();
    }

    /**
     * 任务完成情况
     * @return
     */
    @ApiOperation(value = "任务完成情况")
    @GetMapping("/completeTask")
    public R completeTask(){
        return R.ok(shareTaskService.completeTask());
    }
}
