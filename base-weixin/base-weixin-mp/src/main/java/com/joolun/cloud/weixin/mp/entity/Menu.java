package com.joolun.cloud.weixin.mp.entity;

import com.alibaba.fastjson.JSON;
import lombok.Data;
import me.chanjar.weixin.common.bean.menu.WxMenuRule;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * 自定义菜单模型
 *
 * @author JL
 */
@Data
public class Menu implements Serializable {
  private static final long serialVersionUID = -7083914585539687746L;

  private List<MenuButton> button = new ArrayList<>();

  private WxMenuRule matchRule;

  /**
   * 反序列化
   */
  public static Menu fromJson(String json) {
	  return JSON.parseObject(json,Menu.class);
  }

  public String toJson() {
    return JSON.toJSONString(this);
  }

  @Override
  public String toString() {
    return this.toJson();
  }

}
