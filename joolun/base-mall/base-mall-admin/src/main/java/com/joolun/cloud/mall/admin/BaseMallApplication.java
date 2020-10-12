/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
package com.joolun.cloud.mall.admin;

import cn.hutool.core.util.IdUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.joolun.cloud.common.core.util.LocalDateTimeUtils;
import com.joolun.cloud.common.security.annotation.EnableBaseFeignClients;
import com.joolun.cloud.common.security.annotation.EnableBaseResourceServer;
import com.joolun.cloud.common.swagger.annotation.BaseEnableSwagger;
import com.joolun.cloud.mall.admin.service.GoodsSpuService;
import com.joolun.cloud.mall.admin.service.OrderInfoService;
import com.joolun.cloud.mall.admin.service.OrderLogisticsService;
import com.joolun.cloud.mall.admin.service.UserAddressService;
import com.joolun.cloud.mall.common.constant.MallConstants;
import com.joolun.cloud.mall.common.entity.GoodsSpu;
import com.joolun.cloud.mall.common.entity.OrderInfo;
import com.joolun.cloud.mall.common.entity.OrderLogistics;
import com.joolun.cloud.mall.common.entity.UserAddress;
import com.joolun.cloud.mall.common.enums.OrderLogisticsEnum;
import com.joolun.cloud.mall.common.util.SpringUtil;
import lombok.AllArgsConstructor;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.cloud.client.SpringCloudApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.web.client.RestTemplate;

import java.io.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.*;

/**
 * @author JL
 * @date 2019/07/29
 * 商城模块
 */
@BaseEnableSwagger
@ServletComponentScan
@SpringCloudApplication
@EnableBaseFeignClients
@EnableBaseResourceServer
@EnableScheduling
public class BaseMallApplication {

	public static void main(String[] args) throws IOException {
		SpringApplication.run(BaseMallApplication.class, args);
//		String s=readJsonFile("C:\\Users\\14408\\Downloads\\bannedwords-master\\pub_sms_banned_words.txt");
//		System.out.println(s);
//		Base64.getDecoder();
//		ApplicationContext applicationContext = SpringUtil.getApplicationContext();
//		BankContrastService bankContrastService= applicationContext.getBean(BankContrastService.class);
//		String s=readJsonFile("C:\\Users\\14408\\Desktop\\b.txt");
//		JSONObject jobj = JSON.parseObject(s);
////		JSONArray movies = jobj.getJSONArray("RECORDS");//构建JSONArray数组
//		jobj.entrySet().stream().forEach((entry)->{
//			BankContrast bankContrast=new BankContrast();
//			bankContrast.setBank(entry.getKey());
//			bankContrast.setBankName(entry.getValue().toString());
//			bankContrastService.save(bankContrast);
//		});
	}

	public static String readJsonFile(String fileName) {
		String jsonStr = "";
		try {
			File jsonFile = new File(fileName);
			FileReader fileReader = new FileReader(jsonFile);
			BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(jsonFile),"utf-8"));
			String ch = null;
			StringBuffer sb = new StringBuffer();
			while ((ch = reader.readLine()) != null) {
				sb.append(new String(Base64.getDecoder().decode(ch),"UTF-8"));
			}
			fileReader.close();
			reader.close();
			jsonStr = sb.toString();
			return jsonStr;
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}
	}

	@Bean(name="remoteRestTemplate")
	public RestTemplate restTemplateRemote(){
		return new RestTemplate();
	}
}
