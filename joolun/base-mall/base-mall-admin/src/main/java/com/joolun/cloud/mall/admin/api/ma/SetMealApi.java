package com.joolun.cloud.mall.admin.api.ma;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.joolun.cloud.common.core.constant.CommonConstants;
import com.joolun.cloud.common.core.util.R;
import com.joolun.cloud.mall.admin.service.SetMealService;
import com.joolun.cloud.mall.admin.service.UserMealService;
import com.joolun.cloud.mall.common.constant.MallConstants;
import com.joolun.cloud.mall.common.entity.SetMeal;
import com.joolun.cloud.mall.common.entity.UserMeal;
import com.joolun.cloud.weixin.common.util.ThirdSessionHolder;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;

/**
 * 套餐
 *
 * @author zq
 * @date 2020-07-08 13:53:21
 */
@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("/api/ma/setMeal")
@Api(value = "setMeal", tags = "套餐管理")
public class SetMealApi {

    private final SetMealService setMealService;
    private final UserMealService userMealService;

    /**
     * 分页列表
     *
     * @param page    分页对象
     * @param setMeal 套餐
     * @return
     */
    @ApiOperation(value = "分页列表")
    @GetMapping("/page")
    public R getPage(Page page, SetMeal setMeal) {
        return R.ok(setMealService.page(page, Wrappers.query(setMeal)));
    }

    /**
     * 套餐查询
     *
     * @param id
     * @return R
     */
    @ApiOperation(value = "套餐查询")
    @GetMapping("/{id}")
    public R getById(@PathVariable("id") String id) {
        return R.ok(setMealService.getById(id));
    }

    /**
     * 套餐列表
     *
     * @return R
     */
    @ApiOperation(value = "套餐列表")
    @GetMapping("/setMealList")
    public R getSetMealList() {
        HashMap<String, Object> map = new HashMap<>();
        SetMeal flagShipSetMeal = setMealService.getOne(Wrappers.<SetMeal>lambdaQuery().eq(SetMeal::getPrice, MallConstants.FLAGSHIP_MEAL));
        map.put("setMealList", setMealService.getSetMealList(Wrappers.query()));
        UserMeal userMeal = userMealService.getOne(Wrappers.<UserMeal>lambdaQuery()
                .eq(UserMeal::getUserId, ThirdSessionHolder.getMallUserId())
                .eq(UserMeal::getAccountStatus, CommonConstants.NO)
                .eq(UserMeal::getStatus, MallConstants.UNDER_WAY));
        map.put("userMeal", userMeal);
        map.put("spread", MallConstants.FLAGSHIP_MEAL);
        if(userMeal != null && !flagShipSetMeal.getId().equals(userMeal.getSetMealId())){
            map.put("spread", MallConstants.FLAGSHIP_MEAL-MallConstants.BASICS_MEAL);
        }
        return R.ok(map);
    }

}
