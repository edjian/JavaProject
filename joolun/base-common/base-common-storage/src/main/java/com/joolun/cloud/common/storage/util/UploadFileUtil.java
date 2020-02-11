package com.joolun.cloud.common.storage.util;

import com.joolun.cloud.common.storage.entity.StorageConfig;
import com.joolun.cloud.upms.common.entity.SysConfigStorage;
import java.io.File;

/**
 * @JL
 * 文件上传工具类
 */
public class UploadFileUtil {

	/**
	 * 上传文件
	 * @param file
	 * @param dir 用户上传文件时指定的文件夹。
	 * @param sysConfigStorage
	 */
	public static String uploadFile(File file, String dir, SysConfigStorage sysConfigStorage) throws Exception {
		StorageConfig storageConfig = new StorageConfig();
		storageConfig.setAccessKeyId(sysConfigStorage.getAccessKeyId());
		storageConfig.setAccessKeySecret(sysConfigStorage.getAccessKeySecret());
		storageConfig.setEndpoint(sysConfigStorage.getEndpoint());
		storageConfig.setBucket(sysConfigStorage.getBucket());
		if("1".equals(sysConfigStorage.getStorageType())){//阿里OSS
			AliOssUtil aliOssUtil = new AliOssUtil(storageConfig);
			return aliOssUtil.uploadFile(file,dir);
		}else if("2".equals(sysConfigStorage.getStorageType())){//七牛云
			QiNiuUtil qiNiuUtil = new QiNiuUtil(storageConfig);
			return qiNiuUtil.uploadFile(file,dir);
		}else if("3".equals(sysConfigStorage.getStorageType())){//minio
			MinioUtil minioUtil = new MinioUtil(storageConfig);
			return minioUtil.uploadFile(file,dir);
		}
		return "";
	}
}
