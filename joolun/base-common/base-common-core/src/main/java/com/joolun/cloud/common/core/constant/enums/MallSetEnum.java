package com.joolun.cloud.common.core.constant.enums;

import lombok.Getter;

@Getter
public enum MallSetEnum {
    DeliveryPlaceMapperSelectPage("com.joolun.cloud.mall.admin.mapper.DeliveryPlaceMapper.selectPage"),
//    DeliveryPlaceMapperInsert("com.joolun.cloud.mall.admin.mapper.DeliveryPlaceMapper.insert"),
    EnsureMapperSelectPage("com.joolun.cloud.mall.admin.mapper.EnsureMapper.selectPage"),
//    EnsureMapperInsert("com.joolun.cloud.mall.admin.mapper.EnsureMapper.insert"),
    FreightTemplatMapperSelectPage("com.joolun.cloud.mall.admin.mapper.FreightTemplatMapper.selectPage"),
//    FreightTemplatMapperInsert("com.joolun.cloud.mall.admin.mapper.FreightTemplatMapper.insert")
    MaterialMapperSelectPage("com.joolun.cloud.mall.admin.mapper.MaterialMapper.selectPage"),
    MaterialGroupMapperSelectPage("com.joolun.cloud.mall.admin.mapper.MaterialGroupMapper.selectPage"),
    ;

    private String mapperId;

    MallSetEnum(String mapperId) {
        this.mapperId = mapperId;
    }
}
