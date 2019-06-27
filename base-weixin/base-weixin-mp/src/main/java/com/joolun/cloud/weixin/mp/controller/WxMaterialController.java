package com.joolun.cloud.weixin.mp.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.joolun.cloud.common.core.util.R;
import com.joolun.cloud.common.log.annotation.SysLog;
import com.joolun.cloud.weixin.common.constant.WxReturnCode;
import com.joolun.cloud.weixin.mp.config.WxMpConfiguration;
import com.joolun.cloud.common.core.util.FileUtil;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import me.chanjar.weixin.common.api.WxConsts;
import me.chanjar.weixin.common.error.WxErrorException;
import me.chanjar.weixin.mp.api.WxMpMaterialService;
import me.chanjar.weixin.mp.bean.material.*;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import java.io.*;
import java.net.URLEncoder;
import java.util.List;

/**
 * 微信素材
 *
 * @author JL
 * @date 2019-03-23 21:26:35
 */
@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("/wxmaterial")
public class WxMaterialController {

	/**
	 * 上传非图文微信素材
	 * @param mulFile
	 * @param appId
	 * @param mediaType
	 * @return
	 */
	@PostMapping("/materialFileUpload")
	//	@PreAuthorize("@pms.hasPermission('wxmp_wxmaterial_add')")
	public R materialFileUpload(@RequestParam("file") MultipartFile mulFile,
								@RequestParam("title") String title,
								@RequestParam("introduction") String introduction,
								@RequestParam("appId") String appId,
								@RequestParam("mediaType") String mediaType) {
		try {
			WxMpMaterial material = new WxMpMaterial();
			material.setName(mulFile.getOriginalFilename());
			if(WxConsts.MediaFileType.VIDEO.equals(mediaType)){
				material.setVideoTitle(title);
				material.setVideoIntroduction(introduction);
			}
			File file = FileUtil.multipartFileToFile(mulFile);
			material.setFile(file);
			WxMpMaterialService wxMpMaterialService = WxMpConfiguration.getMpService(appId).getMaterialService();
			WxMpMaterialUploadResult wxMpMaterialUploadResult = wxMpMaterialService.materialFileUpload(mediaType,material);
			WxMpMaterialFileBatchGetResult.WxMaterialFileBatchGetNewsItem wxMpMaterialFileBatchGetResult = new WxMpMaterialFileBatchGetResult.WxMaterialFileBatchGetNewsItem();
			wxMpMaterialFileBatchGetResult.setName(file.getName());
			wxMpMaterialFileBatchGetResult.setMediaId(wxMpMaterialUploadResult.getMediaId());
			wxMpMaterialFileBatchGetResult.setUrl(wxMpMaterialUploadResult.getUrl());
			return R.ok(wxMpMaterialFileBatchGetResult);
		} catch (WxErrorException e) {
			e.printStackTrace();
			log.error("上传非图文微信素材失败" + e);
			return WxReturnCode.wxErrorExceptionHandler(e);
		} catch (Exception e) {
			e.printStackTrace();
			log.error("上传失败", e);
			return R.failed(e.getLocalizedMessage());
		}
	}

	/**
	 * 新增图文消息
	 * @param data
	 * @return
	 */
	@PostMapping("/materialNews")
	@PreAuthorize("@pms.hasPermission('wxmp_wxmaterial_add')")
	public R materialNewsUpload(@RequestBody JSONObject data) {
		try {
			String appId = data.getString("appId");
			JSONArray jSONArray = data.getJSONArray("articles");
			List<WxMpMaterialNews.WxMpMaterialNewsArticle> articles = jSONArray.toJavaList(WxMpMaterialNews.WxMpMaterialNewsArticle.class);
			WxMpMaterialNews news = new WxMpMaterialNews();
			news.setArticles(articles);
			WxMpMaterialService wxMpMaterialService = WxMpConfiguration.getMpService(appId).getMaterialService();
			WxMpMaterialUploadResult wxMpMaterialUploadResult = wxMpMaterialService.materialNewsUpload(news);
			return R.ok(wxMpMaterialUploadResult);
		} catch (WxErrorException e) {
			e.printStackTrace();
			log.error("新增图文失败" + e.getMessage());
			return WxReturnCode.wxErrorExceptionHandler(e);
		} catch (Exception e) {
			e.printStackTrace();
			log.error("新增图文失败", e);
			return R.failed(e.getLocalizedMessage());
		}
	}

	/**
	 *修改图文消息
	 * @param data
	 * @return
	 */
	@PutMapping("/materialNews")
	@PreAuthorize("@pms.hasPermission('wxmp_wxmaterial_edit')")
	public R materialNewsUpdate(@RequestBody JSONObject data) {
		try {
			String appId = data.getString("appId");
			String mediaId = data.getString("mediaId");
			JSONArray jSONArray = data.getJSONArray("articles");
			List<WxMpMaterialNews.WxMpMaterialNewsArticle> articles = jSONArray.toJavaList(WxMpMaterialNews.WxMpMaterialNewsArticle.class);
			WxMpMaterialService wxMpMaterialService = WxMpConfiguration.getMpService(appId).getMaterialService();
			WxMpMaterialArticleUpdate wxMpMaterialArticleUpdate = new WxMpMaterialArticleUpdate();
			wxMpMaterialArticleUpdate.setMediaId(mediaId);
			int index = 0;
			for(WxMpMaterialNews.WxMpMaterialNewsArticle article : articles){
				wxMpMaterialArticleUpdate.setIndex(index);
				wxMpMaterialArticleUpdate.setArticles(article);
				wxMpMaterialService.materialNewsUpdate(wxMpMaterialArticleUpdate);
				index++;
			}
			return new R<>();
		} catch (WxErrorException e) {
			e.printStackTrace();
			log.error("修改图文失败" + e);
			return WxReturnCode.wxErrorExceptionHandler(e);
		} catch (Exception e) {
			e.printStackTrace();
			log.error("修改图文失败", e);
			return R.failed(e.getLocalizedMessage());
		}
	}

	/**
	 * 上传图文消息内的图片获取URL
	 * @param mulFile
	 * @return
	 */
	@PostMapping("/newsImgUpload")
	//	@PreAuthorize("@pms.hasPermission('wxmp_wxmaterial_add')")
	public R newsImgUpload(@RequestParam("file") MultipartFile mulFile,@RequestParam("appId") String appId) {
		try {
			File file = FileUtil.multipartFileToFile(mulFile);
			WxMpMaterialService wxMpMaterialService = WxMpConfiguration.getMpService(appId).getMaterialService();
			WxMediaImgUploadResult wxMediaImgUploadResult = wxMpMaterialService.mediaImgUpload(file);
			return R.ok(wxMediaImgUploadResult);
		} catch (WxErrorException e) {
			e.printStackTrace();
			log.error("上传图文消息内的图片获取URL失败" + e);
			return WxReturnCode.wxErrorExceptionHandler(e);
		} catch (Exception e) {
			e.printStackTrace();
			log.error("上传图文消息内的图片获取URL失败", e);
			return R.failed(e.getLocalizedMessage());
		}
	}

	/**
	 * 通过id删除微信素材
	 * @param
	 * @return R
	 */
	@SysLog("删除微信素材")
	@DeleteMapping
	@PreAuthorize("@pms.hasPermission('wxmp_wxmaterial_del')")
	public R materialDel(String id,String appId){
		WxMpMaterialService wxMpMaterialService = WxMpConfiguration.getMpService(appId).getMaterialService();
		try {
			return  R.ok(wxMpMaterialService.materialDelete(id));
		} catch (WxErrorException e) {
			e.printStackTrace();
			log.error("删除微信素材失败", e);
			return WxReturnCode.wxErrorExceptionHandler(e);
		}
	}

	/**
	* 分页查询
	* @param page 分页对象
	* @param type
	* @return
	*/
	@GetMapping("/page")
	@PreAuthorize("@pms.hasPermission('wxmp_wxmaterial_index')")
	public R getWxMaterialPage(Page page,String appId, String type) {
		try {
		  WxMpMaterialService wxMpMaterialService = WxMpConfiguration.getMpService(appId).getMaterialService();
		  int count = (int)page.getSize();
		  int offset = (int)page.getCurrent()*count-count;
		  if(WxConsts.MaterialType.NEWS.equals(type)){
			  return  R.ok(wxMpMaterialService.materialNewsBatchGet(offset,count));
		  }else{
			  return  R.ok(wxMpMaterialService.materialFileBatchGet(type,offset,count));
		  }
		} catch (WxErrorException e) {
			e.printStackTrace();
			log.error("查询素材失败", e);
			return WxReturnCode.wxErrorExceptionHandler(e);
		}
	}

	/**
	* 获取微信视频素材
	* @param
	* @return R
	*/
	@GetMapping("/materialVideo")
	@PreAuthorize("@pms.hasPermission('wxmp_wxmaterial_get')")
	public R getMaterialVideo(String appId,String mediaId){
	  WxMpMaterialService wxMpMaterialService = WxMpConfiguration.getMpService(appId).getMaterialService();
	  try {
		  return  R.ok(wxMpMaterialService.materialVideoInfo(mediaId));
	  } catch (WxErrorException e) {
		  e.printStackTrace();
		  log.error("获取微信视频素材失败", e);
		  return WxReturnCode.wxErrorExceptionHandler(e);
	  }
	}

	/**
	 * 获取微信素材直接文件
	 * @param
	 * @return R
	 */
	@GetMapping("/materialOther")
	@PreAuthorize("@pms.hasPermission('wxmp_wxmaterial_get')")
	public ResponseEntity<byte[]> getMaterialOther(String appId, String mediaId,String fileName) throws Exception {
		try {
			WxMpMaterialService wxMpMaterialService = WxMpConfiguration.getMpService(appId).getMaterialService();
			//获取文件
			InputStream is = wxMpMaterialService.materialImageOrVoiceDownload(mediaId);
			byte[] body = new byte[is.available()];
			is.read(body);
			HttpHeaders headers = new HttpHeaders();
			//设置文件类型
			headers.add("Content-Disposition", "attchement;filename=" +  URLEncoder.encode(fileName, "UTF-8"));
			headers.add("Content-Type", "application/octet-stream");
			HttpStatus statusCode = HttpStatus.OK;
			//返回数据
			ResponseEntity<byte[]> entity = new ResponseEntity<byte[]>(body, headers, statusCode);
			return entity;
		} catch (WxErrorException e) {
			e.printStackTrace();
			log.error("获取微信素材直接文件失败", e);
			return null;
		}
	}

	/**
	 * 获取微信临时素材直接文件
	 * @param
	 * @return R
	 */
	@GetMapping("/tempMaterialOther")
	@PreAuthorize("@pms.hasPermission('wxmp_wxmsg_index')")
	public ResponseEntity<byte[]> getTempMaterialOther(String appId, String mediaId,String fileName) throws Exception {
		try {
			WxMpMaterialService wxMpMaterialService = WxMpConfiguration.getMpService(appId).getMaterialService();
			//获取文件
			InputStream is = new FileInputStream(wxMpMaterialService.mediaDownload(mediaId));
			byte[] body = new byte[is.available()];
			is.read(body);
			HttpHeaders headers = new HttpHeaders();
			//设置文件类型
			headers.add("Content-Disposition", "attchement;filename=" +  URLEncoder.encode(fileName, "UTF-8"));
			headers.add("Content-Type", "application/octet-stream");
			HttpStatus statusCode = HttpStatus.OK;
			//返回数据
			ResponseEntity<byte[]> entity = new ResponseEntity<byte[]>(body, headers, statusCode);
			return entity;
		} catch (WxErrorException e) {
			e.printStackTrace();
			log.error("获取微信素材直接文件失败", e);
			return null;
		}
	}
}
