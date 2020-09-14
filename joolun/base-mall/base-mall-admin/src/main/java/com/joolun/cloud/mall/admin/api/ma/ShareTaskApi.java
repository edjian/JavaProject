package com.joolun.cloud.mall.admin.api.ma;

import cn.hutool.core.util.BooleanUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.joolun.cloud.common.core.constant.CommonConstants;
import com.joolun.cloud.common.core.util.R;
import com.joolun.cloud.mall.admin.service.SetMealService;
import com.joolun.cloud.mall.admin.service.ShareRecordService;
import com.joolun.cloud.mall.admin.service.ShareTaskService;
import com.joolun.cloud.mall.admin.service.UserMealService;
import com.joolun.cloud.mall.common.constant.MallConstants;
import com.joolun.cloud.mall.common.entity.SetMeal;
import com.joolun.cloud.mall.common.entity.ShareRecord;
import com.joolun.cloud.mall.common.entity.ShareTask;
import com.joolun.cloud.mall.common.entity.UserMeal;
import com.joolun.cloud.weixin.common.util.ThirdSessionHolder;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

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
    private final UserMealService userMealService;
    private final SetMealService setMealService;

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
        IPage<ShareTask> shareTaskIPage = shareTaskService.page1(page, shareTask);
        shareTaskIPage.getRecords().stream().forEach(record ->
                record.setComplete(Optional.ofNullable(shareRecordService.getOne(Wrappers.<ShareRecord>lambdaQuery()
                        .eq(ShareRecord::getTaskId, record.getId())
                        .eq(ShareRecord::getUserId, ThirdSessionHolder.getMallUserId())
                        .between(ShareRecord::getCreateTime, LocalDate.now().atTime(LocalTime.MIN), LocalDate.now().atTime(LocalTime.MAX))
                )).isPresent())
        );
        Map<String,Object> map = new HashMap<>();
        map.put("share", shareTaskIPage);
        UserMeal userMeal = userMealService.getOne(Wrappers.<UserMeal>lambdaQuery()
                .eq(UserMeal::getUserId, ThirdSessionHolder.getMallUserId())
                .eq(UserMeal::getStatus, CommonConstants.YES)
                .lt(UserMeal::getStartTime, LocalDateTime.now())
                .gt(UserMeal::getEndTime, LocalDateTime.now())
        );
        map.put("identity", -1);//自然人
        if(Optional.ofNullable(userMeal).isPresent()){
            SetMeal setMeal = setMealService.getById(userMeal.getSetMealId());
            long count = shareTaskIPage.getRecords().stream().filter(record -> record.isComplete()).count();
            map.put("count", count >= MallConstants.SHARE_COUNT?MallConstants.SHARE_COUNT:count);
            if(!MallConstants.CITY_PARTNER.equals(setMeal.getPrice().intValue())){
                map.put("identity", 0);//除城市合伙人套餐
                map.put("point", setMeal.getSharePoint());
            }else
                map.put("identity", 1);//城市合伙人
        }
        return R.ok(map);
    }

}
