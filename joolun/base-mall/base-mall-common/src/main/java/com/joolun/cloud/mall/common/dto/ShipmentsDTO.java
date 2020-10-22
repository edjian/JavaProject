package com.joolun.cloud.mall.common.dto;

import com.joolun.cloud.mall.common.constant.ExcelColumn;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
* @Description 发货Excel参数
* @Param
* @Return
* @Author QinZheng
* @Date: 2020/10/19
*/
@Data
@ApiModel(description = "发货所需参数")
public class ShipmentsDTO implements Serializable{
    private static final long serialVersionUID = 1L;

    @ExcelColumn(value = "订单号", col = 1)
    @ApiModelProperty(value = "订单号")
    private String orderId;

    @ExcelColumn(value = "收货人姓名", col = 2)
    @ApiModelProperty(value = "收货人姓名")
    private String userName;

    @ExcelColumn(value = "收货地址", col = 3)
    @ApiModelProperty(value = "收货地址")
    private String address;

    @ExcelColumn(value = "电话", col = 4)
    @ApiModelProperty(value = "电话")
    private String telNum;

    @ExcelColumn(value = "物流id", col = 5)
    @ApiModelProperty(value = "物流id")
    private String logisticsId;
}
