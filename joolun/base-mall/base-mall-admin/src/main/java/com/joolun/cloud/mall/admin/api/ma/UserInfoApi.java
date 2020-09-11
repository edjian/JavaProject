/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
package com.joolun.cloud.mall.admin.api.ma;

//import cn.hutool.core.codec.Base64;
import cn.hutool.json.JSONObject;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.joolun.cloud.common.core.constant.CommonConstants;
import com.joolun.cloud.common.core.constant.SecurityConstants;
import com.joolun.cloud.common.core.util.R;
import com.joolun.cloud.mall.admin.service.CouponUserService;
import com.joolun.cloud.mall.admin.service.UserInfoService;
import com.joolun.cloud.mall.admin.service.UserMealService;
import com.joolun.cloud.mall.common.constant.MallConstants;
import com.joolun.cloud.mall.common.entity.CouponUser;
import com.joolun.cloud.mall.common.entity.UserInfo;
import com.joolun.cloud.mall.common.entity.UserMeal;
import com.joolun.cloud.mall.common.feign.FeignWxUserService;
import com.joolun.cloud.upms.common.feign.FeignUserService;
import com.joolun.cloud.weixin.common.constant.MyReturnCode;
import com.joolun.cloud.weixin.common.entity.ThirdSession;
import com.joolun.cloud.weixin.common.entity.WxUser;
import com.joolun.cloud.weixin.common.util.ThirdSessionHolder;
import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
//import org.bouncycastle.util.encoders.Base64;
import org.apache.commons.lang.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpServletRequest;
import java.security.spec.AlgorithmParameterSpec;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Optional;

/**
 * 商城用户
 *
 * @author JL
 * @date 2019-12-04 11:09:55
 */
@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("/api/ma/userinfo")
@Api(value = "userinfo", tags = "商城用户API")
public class UserInfoApi {

    private final UserInfoService userInfoService;
	private final CouponUserService couponUserService;
	private final UserMealService userMealService;
	private final FeignWxUserService feignWxUserService;

    /**
     * 查询商城用户
     * @return R
     */
	@ApiOperation(value = "查询商城用户")
    @GetMapping
    public R getById(HttpServletRequest request) {
		HashMap map = new HashMap();
		UserInfo userInfo = new UserInfo();
		userInfo.setId(ThirdSessionHolder.getMallUserId());
		int couponNum = couponUserService.count(Wrappers.<CouponUser>lambdaQuery()
				.eq(CouponUser :: getUserId, userInfo.getId())
				.eq(CouponUser :: getStatus, CommonConstants.NO)
				.gt(CouponUser :: getValidEndTime, LocalDateTime.now()));
		userInfo = userInfoService.getById(userInfo.getId());
		userInfo.setCouponNum(couponNum);
		map.put("userInfo", userInfo);
		UserMeal userMeal = userMealService.getOne(Wrappers.<UserMeal>lambdaQuery()
				.eq(UserMeal::getStatus, MallConstants.UNDER_WAY)
				.eq(UserMeal::getAccountStatus, CommonConstants.NO)
				.eq(UserMeal::getUserId, userInfo.getId()));
		int amount = userInfo.getPointsWithdraw()+userInfo.getPointsCurrent();
		if(userMeal != null){
			amount += userMeal.getSurplusPoint()*2;
		}
		map.put("amount", amount);
        return R.ok(map);
    }

	/**
	 * 手机号码校验
	 * @return
	 */
	@ApiOperation(value = "手机号码校验")
	@GetMapping("/phoneVerification")
	public R phoneVerification(){
		return R.ok(Optional.ofNullable(userInfoService.getOne(Wrappers.<UserInfo>lambdaQuery()
				.eq(UserInfo::getId, ThirdSessionHolder.getMallUserId())
				.isNotNull(UserInfo::getPhone))).isPresent());
	}

	/**
	 * 我的账户积分信息
	 * @return
	 */
	@ApiOperation(value = "我的账户积分信息")
	@GetMapping("/assets")
	public R assets(){
		return R.ok(userInfoService.assets());
	}

	/**
	 * 修改商城用户
	 * @param userInfo 商城用户
	 * @return R
	 */
	@ApiOperation(value = "修改商城用户")
	@PutMapping
	public R updateById(@RequestBody UserInfo userInfo) {
		userInfo.setId(ThirdSessionHolder.getMallUserId());
		return R.ok(userInfoService.updateById(userInfo));
	}

	/**
	 * 解密并且获取用户手机号码
	 * @param encrypdata
	 * @param iv
	 * @param request
	 * @return
	 * @throws Exception 
	 */
	@ApiOperation(value = "解密并且获取用户手机号码")
	@GetMapping("/deciphering")
	public R deciphering(String encrypdata, String iv, HttpServletRequest request) {
		R<WxUser> r = feignWxUserService.getByMallUserIdInside(ThirdSessionHolder.getMallUserId(), SecurityConstants.FROM_IN);
		if(r.isOk()){
			WxUser wxUser = r.getData();
			byte[] encrypData = Base64.decode(encrypdata);
			byte[] ivData = Base64.decode(iv);
			byte[] sessionKey = Base64.decode(wxUser.getSessionKey());
			String str="";
			try {
				str = decrypt(sessionKey,ivData,encrypData);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			JSONObject jsonObject = new JSONObject(str);
			if(StringUtils.isNotBlank(jsonObject.get("phoneNumber").toString())){
				UserInfo userInfo = userInfoService.getById(wxUser.getMallUserId());
				userInfo.setPhone(jsonObject.get("phoneNumber").toString());
				userInfoService.updateById(userInfo);
				return R.ok(this.phoneVerification());
			}
		}
		return R.failed();
	}

	public static String decrypt(byte[] key, byte[] iv, byte[] encData) throws Exception {
		AlgorithmParameterSpec ivSpec = new IvParameterSpec(iv);
		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
		SecretKeySpec keySpec = new SecretKeySpec(key, "AES");
		cipher.init(Cipher.DECRYPT_MODE, keySpec, ivSpec);
		//解析解密后的字符串
		return new String(cipher.doFinal(encData),"UTF-8");
	}
}
