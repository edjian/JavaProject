/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
package com.joolun.cloud.weixin.common.entity;

import cn.hutool.json.JSONObject;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import com.joolun.cloud.common.data.mybatis.typehandler.JsonTypeHandler;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.apache.ibatis.type.JdbcType;

import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;

/**
 * 消息自动回复
 *
 * @author JL
 * @date 2019-04-18 15:40:39
 */
@Data
@TableName("wx_auto_reply")
@EqualsAndHashCode(callSuper = true)
public class WxAutoReply extends Model<WxAutoReply> {
private static final long serialVersionUID = 1L;

    /**
   * 主键
   */
	@TableId(type = IdType.ASSIGN_UUID)
    private String id;
    /**
   * 创建者
   */
    private String createId;
    /**
   * 创建时间
   */
    private LocalDateTime createTime;
    /**
   * 更新者
   */
    private String updateId;
    /**
   * 更新时间
   */
    private LocalDateTime updateTime;
    /**
   * 备注
   */
    private String remark;
    /**
   * 逻辑删除标记（0：显示；1：隐藏）
   */
    private String delFlag;
    /**
   * 所属租户
   */
    private String tenantId;
    /**
   * 公众号配置ID、小程序AppID
   */
	@NotNull(message = "公众号不能为空")
    private String appId;
    /**
   * 类型（1、关注时回复；2、消息回复；3、关键词回复）
   */
	@NotNull(message = "类型不能为空")
    private String type;
    /**
   * 关键词
   */
    private String reqKey;
    /**
   * 请求消息类型（text：文本；image：图片；voice：语音；video：视频；shortvideo：小视频；location：地理位置）
   */
    private String reqType;
    /**
   * 回复消息类型（text：文本；image：图片；voice：语音；video：视频；music：音乐；news：图文）
   */
	@NotNull(message = "回复消息类型不能为空")
    private String repType;
    /**
   * 回复类型文本匹配类型（1、全匹配，2、半匹配）
   */
    private String repMate;
    /**
   * 回复类型文本保存文字
   */
    private String repContent;
	/**
	 * 回复的素材名、视频和音乐的标题
	 */
	private String repName;
    /**
   * 回复类型imge、voice、news、video的mediaID或音乐缩略图的媒体id
   */
    private String repMediaId;
    /**
   * 视频和音乐的描述
   */
    private String repDesc;
    /**
   * 链接
   */
    private String repUrl;
    /**
   * 高质量链接
   */
    private String repHqUrl;
	/**
	 * 缩略图的媒体id
	 */
	private String repThumbMediaId;
	/**
	 * 缩略图url
	 */
	private String repThumbUrl;

	/**
	 * 图文消息的内容
	 */
	@TableField(typeHandler = JsonTypeHandler.class, jdbcType= JdbcType.VARCHAR)
	private JSONObject content;

}
