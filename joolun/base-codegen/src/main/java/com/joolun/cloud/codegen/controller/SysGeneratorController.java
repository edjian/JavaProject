package com.joolun.cloud.codegen.controller;

import cn.hutool.core.io.IoUtil;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.joolun.cloud.codegen.entity.GenTable;
import com.joolun.cloud.codegen.service.SysGeneratorService;
import com.joolun.cloud.common.core.util.R;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import org.springframework.http.HttpHeaders;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;

/**
 * 代码生成器
 *
 * @author JL
 * @date 2018-07-30
 */
@RestController
@AllArgsConstructor
@RequestMapping("/generator")
@Api(value = "generator", tags = "代码生成器")
public class SysGeneratorController {
	private final SysGeneratorService sysGeneratorService;

	/**
	 * 列表
	 *
	 * @param tableName 参数集
	 * @param sysDatasourceId        数据源ID
	 * @return 数据库表
	 */
	@ApiOperation(value = "分页查询")
	@GetMapping("/page")
	public R getPage(Page page, String tableName, String sysDatasourceId) {
		return R.ok(sysGeneratorService.getPage(page, tableName, sysDatasourceId));
	}

	/**
	 * 生成代码
	 */
	@ApiOperation(value = "生成代码")
	@SneakyThrows
	@PostMapping("/code")
	public void generatorCode(@RequestBody GenTable genTable, HttpServletResponse response) {
		byte[] data = sysGeneratorService.generatorCode(genTable);

		response.reset();
		response.setHeader(HttpHeaders.CONTENT_DISPOSITION, String.format("attachment; filename=%s.zip", genTable.getTableName()));
		response.addHeader(HttpHeaders.CONTENT_LENGTH, String.valueOf(data.length));
		response.setContentType("application/octet-stream; charset=UTF-8");

		IoUtil.write(response.getOutputStream(), Boolean.TRUE, data);
	}

	/**
	 * 生成代码预览
	 */
	@ApiOperation(value = "生成代码预览")
	@SneakyThrows
	@PostMapping("/view")
	public R generatorView(@RequestBody GenTable genTable) {
		return R.ok(sysGeneratorService.generatorView(genTable));
	}
}
