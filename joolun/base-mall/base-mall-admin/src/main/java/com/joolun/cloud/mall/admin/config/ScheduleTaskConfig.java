package com.joolun.cloud.mall.admin.config;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.joolun.cloud.common.core.constant.CommonConstants;
import com.joolun.cloud.mall.admin.mapper.GoodsSpuMapper;
import com.joolun.cloud.mall.admin.service.GoodsSpuService;
import com.joolun.cloud.mall.admin.service.ShareTaskService;
import com.joolun.cloud.mall.common.entity.GoodsSpu;
import com.joolun.cloud.mall.common.entity.ShareTask;
import lombok.AllArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.*;
import java.util.stream.Stream;

@Configuration
@Component
@AllArgsConstructor
public class ScheduleTaskConfig {

    private final GoodsSpuMapper goodsSpuMapper;
    private final ShareTaskService shareTaskService;

    @Scheduled(cron = "0 0 0 * * ?")
    public void shareTaskChangeByDay() {
        Random ran = new Random();
        LinkedHashSet<Integer> set = new LinkedHashSet<>();

        GoodsSpu goodsSpu = new GoodsSpu();
        goodsSpu.setShelf(CommonConstants.YES);

        List<ShareTask> shareTaskList =
                shareTaskService.list(Wrappers.<ShareTask>lambdaQuery().eq(ShareTask::getTaskState, CommonConstants.NO));
        List<GoodsSpu> goodsSpuList =
                goodsSpuMapper.selectListByShelf(goodsSpu);
        while (true) {
            int a = ran.nextInt(goodsSpuList.size());
            set.add(a);
            if (set.size() > shareTaskList.size()) {
                break;
            }
        }
        List<GoodsSpu> goodsSpuList1 = new ArrayList<>();
        set.stream().forEach(temp -> goodsSpuList1.add(goodsSpuList.get(temp)));
        Stream.iterate(0, i -> i + 1).limit(shareTaskList.size()).forEach(index -> {
            ShareTask shareTask = shareTaskList.get(index);
            GoodsSpu goodsSpu1 = goodsSpuList1.get(index);
            shareTask.setName(goodsSpu1.getName().length() > 40 ? goodsSpu1.getName().substring(0, 39) : goodsSpu1.getName());
            shareTask.setShareUrl("/pages/goods/goods-detail/index?id=" + goodsSpu1.getId());
            shareTask.setPicUrl(goodsSpu1.getPicUrls()[0]);
        });
        shareTaskService.updateBatchById(shareTaskList);
    }
}
