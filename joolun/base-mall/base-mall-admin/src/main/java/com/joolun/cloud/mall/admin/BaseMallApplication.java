/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
package com.joolun.cloud.mall.admin;

import com.joolun.cloud.common.security.annotation.EnableBaseFeignClients;
import com.joolun.cloud.common.security.annotation.EnableBaseResourceServer;
import com.joolun.cloud.common.swagger.annotation.BaseEnableSwagger;
import org.springframework.boot.SpringApplication;
import org.springframework.cloud.client.SpringCloudApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.web.client.RestTemplate;

import java.io.*;

/**
 * @author JL
 * @date 2019/07/29
 * 商城模块
 */
@BaseEnableSwagger
@SpringCloudApplication
@EnableBaseFeignClients
@EnableBaseResourceServer
@EnableScheduling
public class BaseMallApplication {

	public static void main(String[] args) throws IOException {
		SpringApplication.run(BaseMallApplication.class, args);
//		String jsonStr = "";
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
			Reader reader = new InputStreamReader(new FileInputStream(jsonFile),"utf-8");
			int ch = 0;
			StringBuffer sb = new StringBuffer();
			while ((ch = reader.read()) != -1) {
				sb.append((char) ch);
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
