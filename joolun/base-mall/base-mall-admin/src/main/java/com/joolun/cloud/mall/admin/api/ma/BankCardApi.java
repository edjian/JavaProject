package com.joolun.cloud.mall.admin.api.ma;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.joolun.cloud.common.core.util.R;
import com.joolun.cloud.mall.admin.service.BankCardService;
import com.joolun.cloud.mall.admin.service.BankContrastService;
import com.joolun.cloud.mall.common.constant.MyReturnCode;
import com.joolun.cloud.mall.common.entity.BankCard;
import com.joolun.cloud.mall.common.entity.BankContrast;
import com.joolun.cloud.weixin.common.util.ThirdSessionHolder;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import javax.servlet.http.HttpServletRequest;
import java.sql.SQLIntegrityConstraintViolationException;

@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping(value = "/api/ma/bankCard")
@Api(value = "bankCard", tags = "银行卡")
public class BankCardApi {

    private final BankCardService bankCardService;
    private final BankContrastService bankContrastService;
    @Autowired
    @Qualifier("remoteRestTemplate")
    private RestTemplate rest;
    //银行图标
    private static final String ALI_BANK = "https://apimg.alipay.com/combo.png?d=cashier&t=";
    //银行信息
    private final static String ALI_BANK_UNION_PAY_GET = "https://ccdcapi.alipay.com/validateAndCacheCardInfo.json?_input_charset=utf-8&cardBinCheck=true&cardNo=";


    /**
     * 分页列表
     * @param page 分页对象
     * @param bankCard 银行卡号
     * @return
     */
    @ApiOperation(value = "分页列表")
    @GetMapping("/page")
    public R getPage(Page page, BankCard bankCard) {
        bankCard.setUserId(ThirdSessionHolder.getMallUserId());
        return R.ok(bankCardService.page(page, Wrappers.query(bankCard)));
    }

    /**
     * 银行卡号查询
     * @param id
     * @return R
     */
    @ApiOperation(value = "银行卡号查询")
    @GetMapping("/{id}")
    public R getById(@PathVariable("id") String id) {
        return R.ok(bankCardService.getById(id));
    }

    /**
     * 银行卡号新增
     * @param bankCard 银行卡号
     * @return R
     */
    @ApiOperation(value = "银行卡号新增")
    @PostMapping
    public R save(@RequestBody BankCard bankCard) {
        bankCard.setUserId(ThirdSessionHolder.getMallUserId());
        try {
            bankCardService.save(bankCard);
        }catch (DuplicateKeyException e){
            return R.failed(MyReturnCode.ERR_91000.getCode(), MyReturnCode.ERR_91000.getMsg());
        }
        return R.ok();
    }

    /**
     * 银行卡号修改
     * @param bankCard 银行卡号
     * @return R
     */
    @ApiOperation(value = "银行卡号修改")
    @PutMapping
    public R updateById(@RequestBody BankCard bankCard) {
        return R.ok(bankCardService.updateById(bankCard));
    }

    /**
     * 银行卡号删除
     * @param id
     * @return R
     */
    @ApiOperation(value = "银行卡号删除")
    @DeleteMapping("/{id}")
    public R removeById(@PathVariable String id) {
        return R.ok(bankCardService.removeById(id));
    }

    @ApiOperation(value = "银行卡信息查询")
    @GetMapping("/card/{bankAccountNumber}")
    public R getAliCardMessage(HttpServletRequest request,@PathVariable String bankAccountNumber){
        ResponseEntity<String> entity = rest.getForEntity(ALI_BANK_UNION_PAY_GET + bankAccountNumber, String.class);
        if (StringUtils.isNotBlank(entity.getBody())) {
            BankCard bankCard=JSON.parseObject(entity.getBody(), BankCard.class);
            if(!"DC".equalsIgnoreCase(bankCard.getCardType()))
                throw new NullPointerException("请输入储蓄卡");
            BankContrast bankContrast=bankContrastService.getOne(Wrappers.<BankContrast>lambdaQuery().eq(BankContrast::getBank,bankCard.getBank()));
            if(bankContrast != null){
                bankCard.setBankName(bankContrast.getBankName());
                bankCard.setIconUrl(ALI_BANK+bankCard.getBank());
            }
            return R.ok(bankCard);
        }
        throw new NullPointerException("银联查询失败");
    }
}
