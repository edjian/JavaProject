package com.joolun.cloud.upms.common.dto;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

/**
 * @author
 */
@Data
public class TreeNode {
	protected String id;
	protected String parentId;
	protected List<TreeNode> children = new ArrayList<TreeNode>();

	public void add(TreeNode node) {
		children.add(node);
	}
}
