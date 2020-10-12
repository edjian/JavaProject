package com.joolun.cloud.mall.admin.config;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.joolun.cloud.common.core.constant.CommonConstants;
import com.joolun.cloud.mall.admin.mapper.GoodsSpuMapper;
import com.joolun.cloud.mall.admin.service.ForbiddenWordsService;
import com.joolun.cloud.mall.admin.service.ShareTaskService;
import com.joolun.cloud.mall.common.entity.GoodsSpu;
import com.joolun.cloud.mall.common.entity.ShareTask;
import lombok.AllArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Random;
import java.util.stream.Stream;

@Configuration
@Component
@AllArgsConstructor
public class ScheduleTaskConfig {

    private final GoodsSpuMapper goodsSpuMapper;
    private final ShareTaskService shareTaskService;
    private final ForbiddenWordsService forbiddenWordsService;
    private final RedisTemplate redisTemplate;
    private static int salesCount;
    private static final int defaultCount = 17;

    /**
     * 每天0点更新任务列表
     */
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
        goodsSpuList.stream().forEach(goodsSpu1 -> {
            goodsSpu1.setVoidNum(0);
            goodsSpuMapper.updateById(goodsSpu1);
        });
        redisTemplate.opsForValue().set(CommonConstants.REDIS_FORBIDDEN_WORDS_KEY, forbiddenWordsService.list());
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

    /**
     * 每天的更新销量值
     */
    @Scheduled(cron = "0 1 0 * * ?")
    public void salesCount(){
        salesCount = randomInt(50,100);
    }

    /**
     * 商品销量展示设置动态变更，从早8点开始到当天0点。期间每隔一段时间已售数量增长（增长数一天不多于100）
     */
    @Scheduled(cron = "0 0 8,0 * * ?")
    @Transactional
    public void increaseShopsSales() {
        int sales = salesCount/defaultCount;
        GoodsSpu goodsSpu1 =new GoodsSpu();
        goodsSpu1.setShelf(CommonConstants.YES);
        List<GoodsSpu> goodsSpus = goodsSpuMapper.selectListByShelf(goodsSpu1);
        goodsSpus.stream().forEach(goodsSpu ->{
            goodsSpu.setSaleNum(goodsSpu.getSaleNum() + sales);
            goodsSpuMapper.updateById(goodsSpu);
        });
    }

    private static int randomInt(int min, int max) {
        return new Random().nextInt(max) % (max - min + 1) + min;
    }
}
