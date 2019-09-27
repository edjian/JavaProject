package com.joolun.cloud.mall.common.feign;

import com.github.binarywang.wxpay.bean.request.WxPayUnifiedOrderRequest;
import com.joolun.cloud.common.core.constant.SecurityConstants;
import com.joolun.cloud.common.core.constant.ServiceNameConstants;
import com.joolun.cloud.common.core.util.R;
import com.joolun.cloud.upms.common.entity.SysLog;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;

/**
 * @author
 */
@FeignClient(contextId = "feignWxPayService", value = ServiceNameConstants.WX_ADMIN_SERVICE)
public interface FeignWxPayService {
	/**
	 * 调用统一下单接口，并组装生成支付所需参数对象.
	 *
	 * @param request 统一下单请求参数
	 * @return 返回 {@link com.github.binarywang.wxpay.bean.order}包下的类对象
	 */
	@PostMapping("/wxpay/unifiedOrder")
	R unifiedOrder(@RequestBody WxPayUnifiedOrderRequest request, @RequestHeader(SecurityConstants.FROM) String from);

	/**
	 * 处理支付回调数据
	 * @param xmlData
	 * @return
	 */
	@PostMapping("/wxpay/notifyOrder")
	R notifyOrder(@RequestBody String xmlData, @RequestHeader(SecurityConstants.FROM) String from);
}
