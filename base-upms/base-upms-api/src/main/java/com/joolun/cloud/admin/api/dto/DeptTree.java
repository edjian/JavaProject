package com.joolun.cloud.admin.api.dto;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author
 * 部门树
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class DeptTree extends TreeNode {
	private String name;
}
