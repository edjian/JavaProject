package com.joolun.cloud.mall.admin.api.ma;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.joolun.cloud.common.core.constant.CommonConstants;
import com.joolun.cloud.common.core.constant.SecurityConstants;
import com.joolun.cloud.common.core.util.FileUtils;
import com.joolun.cloud.common.core.util.R;
import com.joolun.cloud.common.core.util.WaterMarkUtils;
import com.joolun.cloud.common.data.tenant.TenantContextHolder;
import com.joolun.cloud.common.storage.util.UploadFileUtils;
import com.joolun.cloud.mall.admin.service.MerchantSettledService;
import com.joolun.cloud.mall.common.constant.MyReturnCode;
import com.joolun.cloud.mall.common.constant.ResultCode;
import com.joolun.cloud.mall.common.entity.GoodsSpu;
import com.joolun.cloud.mall.common.entity.MerchantSettled;
import com.joolun.cloud.mall.common.feign.FeignUpmsAdminService;
import com.joolun.cloud.upms.common.entity.SysConfigStorage;
import com.joolun.cloud.weixin.common.util.ThirdSessionHolder;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.awt.*;
import java.io.File;
import java.util.Map;

@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/api/ma/merchantSettled")
@Api(value = "merchantSettled", tags = "商家入驻")
public class MerchantSettledApi {

    private final MerchantSettledService merchantSettledService;
    private final FeignUpmsAdminService feignUpmsAdminService;

    /**
     * 商城入驻信息表查询
     *
     * @param id
     * @return R
     */
    @ApiOperation(value = "商城入驻信息表查询")
    @GetMapping("/{id}")
    public R getById(@PathVariable("id") String id) {
        return R.ok(merchantSettledService.getById(id));
    }

    /**
     * 商城入驻信息表查询
     *
     * @return R
     */
    @ApiOperation(value = "用户ID查询商城入驻信息表")
    @GetMapping
    public R getByUserId() {
        MerchantSettled merchantSettled = new MerchantSettled();
        merchantSettled.setUserId(ThirdSessionHolder.getMallUserId());
        return R.ok(merchantSettledService.getOne(new QueryWrapper<>(merchantSettled)));
    }

    /**
     * 查询商家入驻步骤
     *
     * @return R
     */
    @ApiOperation(value = "查询商家入驻步骤")
    @GetMapping("/getStep")
    public R getStep(MerchantSettled merchantSettled) {
        merchantSettled.setUserId(ThirdSessionHolder.getMallUserId());
        Integer step = merchantSettledService.getStep(merchantSettled);
        return R.ok(step == null ? 1 : step);
    }

    /**
     * 商城入驻信息表新增
     *
     * @param merchantSettled 商城入驻信息表
     * @return R
     */
    @ApiOperation(value = "商城入驻信息表新增")
    @PostMapping
    public R save(@RequestBody MerchantSettled merchantSettled) {
        merchantSettled.setUserId(ThirdSessionHolder.getMallUserId());
        R r = this.getByUserId();
        if (r.getData() != null)
            return R.failed(MyReturnCode.ERR_10003.getCode(), MyReturnCode.ERR_10003.getMsg());
        merchantSettled.setStep(2);
        return R.ok(merchantSettledService.save(merchantSettled));
    }

    /**
     * 商城入驻信息表修改
     *
     * @param merchantSettled 商城入驻信息表
     * @return R
     */
    @ApiOperation(value = "商城入驻信息改表修")
    @PutMapping
    public R updateById(@RequestBody MerchantSettled merchantSettled) {
        return R.ok(merchantSettledService.update(merchantSettled,Wrappers.<MerchantSettled>lambdaUpdate().eq(MerchantSettled::getUserId, ThirdSessionHolder.getMallUserId())));
    }

    /**
     * 商城入驻信息表删除
     *
     * @param id
     * @return R
     */
    @ApiOperation(value = "商城入驻信息表删除")
    @DeleteMapping("/{id}")
    public R removeById(@PathVariable String id) {
        return R.ok(merchantSettledService.removeById(id));
    }

    /**
     * @param merchantSettled
     * @param mulFile
     * @param dir
     * @param param
     * @return
     * @throws Exception
     */
    @ApiOperation(value = "文件上传")
    @PostMapping(value = "/upload")
    public R fileUpload(MerchantSettled merchantSettled, MultipartFile mulFile, String dir, String param) throws Exception {
        SysConfigStorage sysConfigStorage = feignUpmsAdminService.getOne(SecurityConstants.FROM_IN);
        dir = StrUtil.format("{}/{}", TenantContextHolder.getTenantId(), dir);
        if (sysConfigStorage == null) {
            return R.failed(ResultCode.CODE_500.getCode(), "请先配置文件存储信息");
        }
        File file = FileUtils.multipartFileToFile(mulFile);
        if (CommonConstants.FILE_TYPE_IMG.equals(mulFile) &&
                StrUtil.isNotBlank(sysConfigStorage.getWaterMarkContent())) {//图片添加水印
            //添加水印
            file = WaterMarkUtils.markStr(file, Color.GRAY, sysConfigStorage.getWaterMarkContent());
        }
        String url = UploadFileUtils.uploadFile(file, dir, sysConfigStorage);
        if ("idCardFrontUrl".equals(param)) {
            merchantSettled.setIdCardFrontUrl(url);
        } else if ("idCardReverseUrl".equals(param)) {
            merchantSettled.setIdCardReverseUrl(url);
        } else {
            merchantSettled.setBusinessLicenseUrl(url);
        }
        merchantSettled.setUserId(ThirdSessionHolder.getMallUserId());
        merchantSettledService.update(merchantSettled, Wrappers.<MerchantSettled>lambdaUpdate().eq(MerchantSettled::getUserId, merchantSettled.getUserId()));
        return R.ok();
    }



}
