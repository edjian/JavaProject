package com.joolun.cloud.mall.admin.api.ma;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.joolun.cloud.common.core.constant.CommonConstants;
import com.joolun.cloud.common.core.util.R;
import com.joolun.cloud.mall.admin.service.PointsRecordService;
import com.joolun.cloud.mall.admin.service.ShareRecordService;
import com.joolun.cloud.mall.admin.service.ShareTaskService;
import com.joolun.cloud.mall.admin.service.UserMealService;
import com.joolun.cloud.mall.common.constant.MallConstants;
import com.joolun.cloud.mall.common.entity.ShareRecord;
import com.joolun.cloud.mall.common.entity.UserMeal;
import com.joolun.cloud.weixin.common.util.ThirdSessionHolder;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.Optional;

@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/api/ma/shareRecord")
@Api(value = "shareRecord", tags = "积分分享记录")
public class ShareRecordApi {

    private final ShareRecordService shareRecordService;
    private final ShareTaskService shareTaskService;
    private final UserMealService userMealService;
    private final PointsRecordService pointsRecordService;

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
    public R shareCallback(ShareRecord shareRecord, String inviteUserId) {
        if (MallConstants.SHARE_COUNT <= shareRecordService.count(Wrappers.<ShareRecord>query().select("distinct(task_id)").lambda()
                .eq(ShareRecord::getUserId, inviteUserId)
                .between(ShareRecord::getCreateTime, LocalDate.now().atTime(LocalTime.MIN), LocalDate.now().atTime(LocalTime.MAX))))
            return R.ok();
        if(Optional.ofNullable(inviteUserId).isPresent())
            if(Optional.ofNullable(ThirdSessionHolder.getMallUserId()).isPresent()&&ThirdSessionHolder.getMallUserId().equals(inviteUserId))
                return R.ok();
        if (shareRecordService.list(Wrappers.<ShareRecord>lambdaQuery()
                .eq(ShareRecord::getUserId, ThirdSessionHolder.getMallUserId())
                .eq(ShareRecord::getTaskId, shareRecord.getTaskId())
                .like(ShareRecord::getCreateTime, LocalDate.now())).size() > 0)
            return R.ok();
        UserMeal userMeal = userMealService.getOne(Wrappers.<UserMeal>lambdaQuery()
                .eq(UserMeal::getUserId, inviteUserId)
                .eq(UserMeal::getStatus, MallConstants.UNDER_WAY)
                .eq(UserMeal::getAccountStatus, CommonConstants.YES)
                .lt(UserMeal::getStartTime, LocalDateTime.now())
                .gt(UserMeal::getEndTime, LocalDateTime.now())
        );
        userMeal = Optional.ofNullable(userMeal).isPresent() ? userMeal : userMealService.getOne(Wrappers.<UserMeal>lambdaQuery()
                .eq(UserMeal::getUserId, inviteUserId)
                .eq(UserMeal::getStatus, MallConstants.UNDER_WAY)
                .eq(UserMeal::getAccountStatus, CommonConstants.NO)
                .lt(UserMeal::getStartTime, LocalDateTime.now())
                .gt(UserMeal::getEndTime, LocalDateTime.now())
        );
        if (Optional.ofNullable(userMeal).isPresent()) {
            shareRecord.setUserId(inviteUserId);
            shareRecord.setCreateTime(LocalDateTime.now());
            shareRecord.setStatus(MallConstants.SHARE_RECORD_YES);
            shareRecordService.save(shareRecord);
//            pointsRecordService.getOne();
            if (MallConstants.SHARE_COUNT <= shareRecordService.list(Wrappers.<ShareRecord>lambdaQuery()
                    .eq(ShareRecord::getUserId, inviteUserId)
                    .between(ShareRecord::getCreateTime, LocalDate.now().atTime(LocalTime.MIN), LocalDate.now().atTime(LocalTime.MAX))).size())
                shareTaskService.shareCallback(inviteUserId);
        }
        return R.ok();
    }

    /**
     * 任务完成情况
     *
     * @return
     */
    @ApiOperation(value = "任务完成情况")
    @GetMapping("/completeTask")
    public R completeTask() {
        return R.ok(shareTaskService.completeTask());
    }
}
