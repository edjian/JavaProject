package com.joolun.cloud.mall.common.constant;

/**
 * 全局返回码
 * 商城用7开头，例70001
 * @author JL
 * 2019年7月25日
 */
public enum MyReturnCode {

	ERR_70000(70000, "系统错误，请稍候再试"){},//其它错误
	ERR_70001(70001, "该状态订单不允许操作"){},
	ERR_70002(70002, "请选择付款方式"){},
	ERR_70003(70003, "没有符合下单条件的规格商品"){},
	ERR_70004(70004, "只有待支付的详单能发起支付"){},
	ERR_70005(70005, "无效订单"){},
	;

	MyReturnCode(int code, String msg) {
		this.code = code;
		this.msg = msg;
	}

	private int code;
	private String msg;

	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}

	@Override
	public String toString() {
		return "MyReturnCode{" + "code='" + code + '\'' + "msg='" + msg + '\'' + '}';
	}

}
