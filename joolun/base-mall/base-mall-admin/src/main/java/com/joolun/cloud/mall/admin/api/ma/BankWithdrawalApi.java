package com.joolun.cloud.mall.admin.api.ma;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.joolun.cloud.common.core.util.R;
import com.joolun.cloud.mall.admin.service.BankWithdrawalService;
import com.joolun.cloud.mall.common.constant.MallConstants;
import com.joolun.cloud.mall.common.entity.BankWithdrawal;
import com.joolun.cloud.weixin.common.util.ThirdSessionHolder;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
* @Description 银行提现表API
* @Author QinZheng
* @Date: 2020/8/21
*/
@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("/api/ma/bankwithdrawal")
@Api(value = "bankwithdrawal", tags = "银行提现表API")
public class BankWithdrawalApi {

    private final BankWithdrawalService bankWithdrawalService;

    /**
     * 分页列表
     * @param page 分页对象
     * @param judge 银行提现表
     * @return
     */
    @ApiOperation(value = "分页列表")
    @GetMapping("/page")
    public R getPage(Page page, boolean judge) {
        QueryWrapper<BankWithdrawal> queryWrapper =new QueryWrapper<>();
        if(judge){
            queryWrapper.lambda()
                    .eq(BankWithdrawal::getStatus, MallConstants.BANK_WITHDRAWAL_STATUS_4)
                    .eq(BankWithdrawal::getUserId, ThirdSessionHolder.getMallUserId());
        }else{
            queryWrapper.lambda()
                    .ne(BankWithdrawal::getStatus, MallConstants.BANK_WITHDRAWAL_STATUS_4)
                    .eq(BankWithdrawal::getUserId, ThirdSessionHolder.getMallUserId());
        }
        return R.ok(bankWithdrawalService.page(page, queryWrapper));
    }

    /**
     * 银行提现表查询
     * @param id
     * @return R
     */
    @ApiOperation(value = "银行提现表查询")
    @GetMapping("/{id}")
    public R getById(@PathVariable("id") String id) {
        return R.ok(bankWithdrawalService.getById(id));
    }

    /**
     * 银行提现表新增
     * @param bankWithdrawal 银行提现表
     * @return R
     */
    @ApiOperation(value = "银行提现表新增")
    @PostMapping
    public R save(@RequestBody BankWithdrawal bankWithdrawal) {

        return R.ok(bankWithdrawalService.save1(bankWithdrawal));
    }

    /**
     * 银行提现表修改
     * @param bankWithdrawal 银行提现表
     * @return R
     */
    @ApiOperation(value = "银行提现表修改")
    @PutMapping
    public R updateById(@RequestBody BankWithdrawal bankWithdrawal) {
        bankWithdrawalService.updateById(bankWithdrawal);
        return R.ok(bankWithdrawalService.getById(bankWithdrawal.getId()));
    }

}
