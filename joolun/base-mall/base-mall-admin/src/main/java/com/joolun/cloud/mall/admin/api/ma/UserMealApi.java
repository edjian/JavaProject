package com.joolun.cloud.mall.admin.api.ma;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.json.JSON;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.github.binarywang.wxpay.bean.notify.WxPayNotifyResponse;
import com.github.binarywang.wxpay.bean.notify.WxPayOrderNotifyResult;
import com.github.binarywang.wxpay.bean.request.WxPayUnifiedOrderRequest;
import com.github.binarywang.wxpay.exception.WxPayException;
import com.joolun.cloud.common.core.constant.CommonConstants;
import com.joolun.cloud.common.core.constant.SecurityConstants;
import com.joolun.cloud.common.core.util.LocalDateTimeUtils;
import com.joolun.cloud.common.core.util.R;
import com.joolun.cloud.common.data.tenant.TenantContextHolder;
import com.joolun.cloud.mall.admin.config.MallConfigProperties;
import com.joolun.cloud.mall.admin.service.InviteNewService;
import com.joolun.cloud.mall.admin.service.SetMealService;
import com.joolun.cloud.mall.admin.service.UserMealService;
import com.joolun.cloud.mall.common.constant.MallConstants;
import com.joolun.cloud.mall.common.constant.MyReturnCode;
import com.joolun.cloud.mall.common.dto.UserMealDataDTO;
import com.joolun.cloud.mall.common.entity.*;
import com.joolun.cloud.mall.common.feign.FeignWxPayService;
import com.joolun.cloud.weixin.common.entity.ThirdSession;
import com.joolun.cloud.weixin.common.entity.WxUser;
import com.joolun.cloud.weixin.common.util.ThirdSessionHolder;
import com.joolun.cloud.weixin.common.util.WxMaUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

/**
 * 商城用户套餐
 *
 * @author zq
 * @date 2020/7/17
 */
@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("/api/ma/userMeal")
@Api(value = "/userMeal", tags = "商城用户套餐API")
public class UserMealApi {

    private final Logger logger = LoggerFactory.getLogger(UserMealApi.class);
    private final UserMealService userMealService;
    private final FeignWxPayService feignWxPayService;
    private final MallConfigProperties mallConfigProperties;
    private final InviteNewService inviteNewService;
    private final SetMealService setMealService;

    /**
     * 用户套餐表查询
     *
     * @param id
     * @return R
     */
    @ApiOperation(value = "用户套餐表查询")
    @GetMapping("/{id}")
    public R getById(@PathVariable("id") String id) {
        return R.ok(userMealService.getById(id));
    }

    /**
     * 商家入驻判断是否缴费3980
     *
     * @return R
     */
    @ApiOperation(value = "商家入驻判断是否缴费3980")
    @GetMapping("/flagShip")
    public R getFlagShip() {
        SetMeal flagShipSetMeal = setMealService.getOne(Wrappers.<SetMeal>lambdaQuery().eq(SetMeal::getPrice, MallConstants.FLAGSHIP_MEAL));
        SetMeal basicsSetMeal = setMealService.getOne(Wrappers.<SetMeal>lambdaQuery().eq(SetMeal::getPrice, MallConstants.BASICS_MEAL));
        Map<String, Object> map = new HashMap<>();
        UserMeal userMeal = userMealService.getOne(Wrappers.<UserMeal>lambdaQuery()
                .eq(UserMeal::getUserId, ThirdSessionHolder.getMallUserId())
                .eq(UserMeal::getAccountStatus, CommonConstants.NO)
                .eq(UserMeal::getStatus, MallConstants.UNDER_WAY));
        map.put("spread", MallConstants.FLAGSHIP_MEAL);
        if (userMeal != null) {
            if (basicsSetMeal.getId().equals(userMeal.getSetMealId())) {
                map.put("spread", MallConstants.FLAGSHIP_MEAL - MallConstants.BASICS_MEAL);
            }
        }
        map.put("userMeal", userMeal);
        map.put("setMealId", flagShipSetMeal.getId());
        return R.ok(map);
    }

    /**
     * 查询用户套餐是否支付
     * 区分套餐
     *
     * @param userMeal
     * @return
     */
    @ApiOperation(value = "查询用户套餐是否支付")
    @GetMapping("/mealStatus")
    public R getUserMealIsPay(UserMeal userMeal) {
        userMeal.setUserId(ThirdSessionHolder.getMallUserId());
        return userMealService.getUserMealIsPay(userMeal);
    }

    /**
     * 新增用户套餐
     *
     * @param userMealDataDTO
     * @return com.joolun.cloud.common.core.util.R
     */
    @ApiOperation(value = "新增用户套餐")
    @PostMapping
    public R userMealSave(@RequestBody UserMealDataDTO userMealDataDTO) {
        UserMeal userMeal = new UserMeal();
        BeanUtil.copyProperties(userMealDataDTO, userMeal);
        userMeal.setUserId(ThirdSessionHolder.getMallUserId());
        SetMeal nowSetMeal = setMealService.getOne(Wrappers.<SetMeal>lambdaQuery().eq(SetMeal::getId, userMeal.getSetMealId()));
        UserMeal oldUserMeal = userMealService.getOne(Wrappers.<UserMeal>lambdaQuery()
                .eq(UserMeal::getUserId, ThirdSessionHolder.getMallUserId())
                .eq(UserMeal::getAccountStatus, CommonConstants.NO)
                .eq(UserMeal::getStatus, MallConstants.UNDER_WAY));
        if (oldUserMeal != null) {
            SetMeal oldSetMeal = setMealService.getOne(Wrappers.<SetMeal>lambdaQuery().eq(SetMeal::getId, oldUserMeal.getSetMealId()));
            if (nowSetMeal.getPrice().compareTo(oldSetMeal.getPrice()) <= 0)
                return R.failed(MyReturnCode.ERR_90001.getCode(), MyReturnCode.ERR_90001.getMsg());
        }
        userMeal.setSetMeal(nowSetMeal);
        if (oldUserMeal == null) {
            inviteNewService.remove(Wrappers.<InviteNew>lambdaQuery()
                    .eq(InviteNew::getUserId, ThirdSessionHolder.getMallUserId())
                    .eq(!StringUtils.isEmpty(userMealDataDTO.getInviteUserId()),InviteNew::getUserIdFirst, userMealDataDTO.getInviteUserId()));

            //这个还要加后续条件，如果是升级套餐的话有多条记录
            UserMeal firstUserMeal = userMealService.getOne(Wrappers.<UserMeal>lambdaQuery()
                    .eq(UserMeal::getUserId, userMealDataDTO.getInviteUserId())
                    .eq(UserMeal::getStatus, CommonConstants.YES));

            InviteNew inviteNew = new InviteNew();
            inviteNew.setUserId(userMeal.getUserId());
            inviteNew.setCreateTime(LocalDateTime.now());
            inviteNew.setStatus(CommonConstants.NO);
            if (firstUserMeal != null) {
                inviteNew.setUserIdFirst(firstUserMeal.getUserId());
                InviteNew firstInviteNew = inviteNewService.getOne(Wrappers.<InviteNew>lambdaQuery()
                        .eq(InviteNew::getUserId, firstUserMeal.getUserId())
                        .isNotNull(InviteNew::getUserIdFirst));
                if (firstInviteNew != null) {
                    inviteNew.setUserIdSecond(firstInviteNew.getUserIdFirst());
                }
            }
            inviteNewService.save(inviteNew);
        }
        userMeal = userMealService.userMealSave(userMeal, userMealDataDTO.getInviteUserId());
        if (userMeal == null) {
            return R.failed(MyReturnCode.ERR_70005.getCode(), MyReturnCode.ERR_70005.getMsg());
        }
        return R.ok(userMeal);
    }

    /**
     * 调用统一下单接口，并组装生成支付所需参数对象.
     *
     * @param userMeal 统一下单请求参数
     * @return 返回 {@link com.github.binarywang.wxpay.bean.order}包下的类对象
     */
    @ApiOperation(value = "调用统一用户套餐接口")
    @PostMapping("/unifiedUserMeal")
    public R unifiedUserMeal(HttpServletRequest request, @RequestBody UserMeal userMeal) {
        //检验用户session登录
        WxUser wxUser = new WxUser();
        wxUser.setAppId(ThirdSessionHolder.getThirdSession().getAppId());
        wxUser.setId(ThirdSessionHolder.getThirdSession().getWxUserId());
        wxUser.setSessionKey(ThirdSessionHolder.getThirdSession().getSessionKey());
        wxUser.setOpenId(ThirdSessionHolder.getThirdSession().getOpenId());
        wxUser.setMallUserId(ThirdSessionHolder.getThirdSession().getMallUserId());
        String inviteUserId = userMeal.getInviteUserId();
        userMeal = userMealService.getByConditional(userMeal);
        UserMeal oldUserMeal = userMealService.getOne(Wrappers.<UserMeal>lambdaQuery()
                .eq(UserMeal::getUserId, ThirdSessionHolder.getMallUserId())
                .eq(UserMeal::getStatus, MallConstants.UNDER_WAY));
        if (userMeal == null) {
            return R.failed(MyReturnCode.ERR_70005.getCode(), MyReturnCode.ERR_70005.getMsg());
        }
        if (!CommonConstants.NO.equals(userMeal.getIsPay())) {//只有未支付的详单能发起支付
            return R.failed(MyReturnCode.ERR_70004.getCode(), MyReturnCode.ERR_70004.getMsg());
        }

        Map<String, Object> map = new HashMap<>();
        map.put("inviteUserId", inviteUserId);
        map.put("upgrade", false);
        String appId = WxMaUtil.getAppId(request);
        WxPayUnifiedOrderRequest wxPayUnifiedOrderRequest = new WxPayUnifiedOrderRequest();
        wxPayUnifiedOrderRequest.setAppid(appId);
        wxPayUnifiedOrderRequest.setBody(userMeal.getSetMeal().getName().length() > 40 ? userMeal.getSetMeal().getName().substring(0, 39) : userMeal.getSetMeal().getName());
        wxPayUnifiedOrderRequest.setTradeType("JSAPI");
        wxPayUnifiedOrderRequest.setOutTradeNo(userMeal.getOrderNo());
//        wxPayUnifiedOrderRequest.setTotalFee(userMeal.getSetMeal().getPrice().multiply(new BigDecimal(100)).intValue());
        //测试金额
        if(MallConstants.BASICS_MEAL.equals(userMeal.getSetMeal().getPrice().intValue())){
            wxPayUnifiedOrderRequest.setTotalFee(1);
        }else if(MallConstants.FLAGSHIP_MEAL.equals(userMeal.getSetMeal().getPrice().intValue())){
            wxPayUnifiedOrderRequest.setTotalFee(2);
        }
        wxPayUnifiedOrderRequest.setNotifyUrl(mallConfigProperties.getNotifyHost() + "/mall/api/ma/orderinfo/notify-order");
        wxPayUnifiedOrderRequest.setSpbillCreateIp("127.0.0.1");
        if (oldUserMeal != null) {
            map.put("upgrade", true);
//            wxPayUnifiedOrderRequest.setTotalFee(userMeal.getSetMeal().getPrice().subtract(new BigDecimal(MallConstants.BASICS_MEAL)).multiply(new BigDecimal(100)).intValue());
            wxPayUnifiedOrderRequest.setTotalFee(1);
        }
        JSONObject jsonObject = new JSONObject(map);
        wxPayUnifiedOrderRequest.setAttach(jsonObject.toString());
        wxPayUnifiedOrderRequest.setOpenid(wxUser.getOpenId());
        return feignWxPayService.unifiedOrder(wxPayUnifiedOrderRequest, SecurityConstants.FROM_IN);
    }


    //不知道为啥回调不到
//    /**
//     * 支付回调
//     *
//     * @param xmlData
//     * @return
//     * @throws WxPayException
//     */
//    @ApiOperation(value = "套餐支付回调")
//    @PostMapping("/notify-order")
//    public String notifyOrder(@RequestBody String xmlData) {
//        log.info("支付回调:" + xmlData);
//        R<WxPayOrderNotifyResult> r = feignWxPayService.notifyOrder(xmlData, SecurityConstants.FROM_IN);
//        if (r.isOk()) {
//            TenantContextHolder.setTenantId(r.getMsg());
//            WxPayOrderNotifyResult notifyResult = r.getData();
//            UserMeal userMeal = userMealService.getOne(Wrappers.<UserMeal>lambdaQuery()
//                    .eq(UserMeal::getOrderNo, notifyResult.getOutTradeNo()));
//            SetMeal setMeal = setMealService.getOne(Wrappers.<SetMeal>lambdaQuery().eq(SetMeal::getId, userMeal.getSetMealId()));
//            if (userMeal != null) {
//                HashMap<String, Object> map = com.alibaba.fastjson.JSON.parseObject(notifyResult.getAttach(), HashMap.class);
//                if (Boolean.FALSE.equals(map.get("upgrade"))) {
//                    if (setMeal.getPrice().multiply(new BigDecimal(100)).intValue() == notifyResult.getTotalFee()||notifyResult.getTotalFee()==1) {
//                        String timeEnd = notifyResult.getTimeEnd();
//                        LocalDateTime paymentTime = LocalDateTimeUtils.parse(timeEnd);
//                        LocalDateTime endTime = paymentTime.plusDays(MallConstants.DEFAULT_TIME);
//                        userMeal.setStartTime(paymentTime);
//                        userMeal.setEndTime(endTime);
//                        userMeal.setTransactionId(notifyResult.getTransactionId());
//                        userMealService.notifyOrder(userMeal, map.get("inviteUserId").toString());
//                        return WxPayNotifyResponse.success("成功");
//                    } else {
//                        return WxPayNotifyResponse.fail("付款金额与订单金额不等");
//                    }
//                }
//                if(setMeal.getPrice().subtract(new BigDecimal(MallConstants.BASICS_MEAL)).multiply(new BigDecimal(100)).intValue() == notifyResult.getTotalFee()||notifyResult.getTotalFee()==1){
//                    String timeEnd = notifyResult.getTimeEnd();
//                    LocalDateTime paymentTime = LocalDateTimeUtils.parse(timeEnd);
//                    LocalDateTime endTime = paymentTime.plusDays(MallConstants.MINE_UPGRADE_TIME);
//                    userMeal.setStartTime(paymentTime);
//                    userMeal.setEndTime(endTime);
//                    userMeal.setTransactionId(notifyResult.getTransactionId());
//                    userMealService.notifyOrder(userMeal, map.get("inviteUserId").toString());
//                    return WxPayNotifyResponse.success("成功");
//                }
//                return WxPayNotifyResponse.fail("付款金额与订单金额不等");
//            } else {
//                return WxPayNotifyResponse.fail("无此订单");
//            }
//        } else {
//            return WxPayNotifyResponse.fail(r.getMsg());
//        }
//    }
}
