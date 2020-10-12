/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
package com.joolun.cloud.mall.admin.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.joolun.cloud.common.core.util.R;
import com.joolun.cloud.mall.common.entity.ShareTask;

/**
 * 分享任务表
 *
 * @author zq
 * @date 2020-07-09 15:36:56
 */
public interface ShareTaskService extends IService<ShareTask> {

    IPage<ShareTask> page1(IPage<ShareTask> page,ShareTask shareTask);

    /**
     * 分享任务回调
     */
    void shareCallback(String inviteUserId);

    /**
     * 判断是否已完成任务
     */
    boolean completeTask();
}
