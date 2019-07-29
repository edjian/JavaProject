package com.joolun.cloud.upms.admin.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.joolun.cloud.upms.admin.mapper.SysOrganMapper;
import com.joolun.cloud.upms.admin.service.SysOrganRelationService;
import com.joolun.cloud.upms.admin.service.SysOrganService;
import com.joolun.cloud.upms.common.dto.OrganTree;
import com.joolun.cloud.upms.common.entity.SysOrgan;
import com.joolun.cloud.upms.common.entity.SysOrganRelation;
import com.joolun.cloud.upms.common.vo.TreeUtil;

import java.util.Comparator;

import com.joolun.cloud.common.core.constant.CommonConstants;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 机构管理
 *
 * @author
 */
@Service
@AllArgsConstructor
public class SysOrganServiceImpl extends ServiceImpl<SysOrganMapper, SysOrgan> implements SysOrganService {
	private final SysOrganRelationService sysOrganRelationService;

	/**
	 * 添加信息机构
	 *
	 * @param organ 机构
	 * @return
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public Boolean saveOrgan(SysOrgan organ) {
		SysOrgan sysOrgan = new SysOrgan();
		BeanUtil.copyProperties(organ, sysOrgan);
		this.save(sysOrgan);
		sysOrganRelationService.insertOrganRelation(sysOrgan);
		return Boolean.TRUE;
	}


	/**
	 * 删除机构
	 *
	 * @param id 机构 ID
	 * @return 成功、失败
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public Boolean removeOrganById(String id) {
		//级联删除机构
		List<String> idList = sysOrganRelationService
				.list(Wrappers.<SysOrganRelation>query().lambda()
						.eq(SysOrganRelation::getAncestor, id))
				.stream()
				.map(SysOrganRelation::getDescendant)
				.collect(Collectors.toList());

		if (CollUtil.isNotEmpty(idList)) {
			this.removeByIds(idList);
		}

		//删除机构级联关系
		sysOrganRelationService.deleteAllOrganRealtion(id);
		return Boolean.TRUE;
	}

	/**
	 * 更新机构
	 *
	 * @param sysOrgan 机构信息
	 * @return 成功、失败
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public Boolean updateOrganById(SysOrgan sysOrgan) {
		//更新机构状态
		this.updateById(sysOrgan);
		//更新机构关系
		SysOrganRelation relation = new SysOrganRelation();
		relation.setAncestor(sysOrgan.getParentId());
		relation.setDescendant(sysOrgan.getId());
		sysOrganRelationService.updateOrganRealtion(relation);
		return Boolean.TRUE;
	}

	/**
	 * 查询全部机构树
	 *
	 * @return 树
	 */
	@Override
	public List<OrganTree> selectTree() {
		return getOrganTree(this.list(Wrappers.emptyWrapper()));
	}

	/**
	 * 构建机构树
	 *
	 * @param organs 机构
	 * @return
	 */
	private List<OrganTree> getOrganTree(List<SysOrgan> organs) {
		List<OrganTree> treeList = organs.stream()
				.filter(organ -> !organ.getId().equals(organ.getParentId()))
				.sorted(Comparator.comparingInt(SysOrgan::getSort))
				.map(organ -> {
					OrganTree node = new OrganTree();
					BeanUtil.copyProperties(organ,node);
					return node;
				}).collect(Collectors.toList());
		return TreeUtil.build(treeList, CommonConstants.TENANT_PARENT_ID);
	}
}
