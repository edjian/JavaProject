package com.joolun.cloud.mall.admin.api.ma;

import com.joolun.cloud.common.core.util.R;
import com.joolun.cloud.mall.admin.service.BankContrastService;
import com.joolun.cloud.mall.common.entity.BankContrast;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/api/ma/bankContrast")
@Api(value = "bankContrast", tags = "银行关联表")
public class BankContrastApi {
    private final BankContrastService bankContrastService;

    /**
     * 银行关联表查询
     * @param id
     * @return R
     */
    @ApiOperation(value = "银行关联表查询")
    @GetMapping("/{id}")
    public R getById(@PathVariable("id") String id) {
        return R.ok(bankContrastService.getById(id));
    }

    /**
     * 银行关联表新增
     * @param bankContrast 银行关联表
     * @return R
     */
    @ApiOperation(value = "银行关联表新增")
    @PostMapping
    public R save(@RequestBody BankContrast bankContrast) {
        return R.ok(bankContrastService.save(bankContrast));
    }

}
