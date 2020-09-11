package com.joolun.cloud.common.data.datascope;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.ReflectUtil;
import com.baomidou.mybatisplus.core.toolkit.PluginUtils;
import com.baomidou.mybatisplus.extension.handlers.AbstractSqlParserHandler;
import com.joolun.cloud.common.core.constant.CommonConstants;
import com.joolun.cloud.common.core.exception.CheckedException;
import com.joolun.cloud.common.data.annotation.OrganDataScope;
import com.joolun.cloud.common.security.entity.BaseUser;
import com.joolun.cloud.common.security.util.SecurityUtils;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.ParameterMapping;
import org.apache.ibatis.mapping.SqlCommandType;
import org.apache.ibatis.plugin.*;
import org.apache.ibatis.reflection.MetaObject;
import org.apache.ibatis.reflection.SystemMetaObject;

import javax.sql.DataSource;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.util.List;
import java.util.Properties;

@Slf4j
@AllArgsConstructor
@Intercepts({@Signature(type = StatementHandler.class, method = "prepare", args = {Connection.class, Integer.class})})
public class OrganScopeInterceptor extends AbstractSqlParserHandler implements Interceptor{
    private final DataSource dataSource;

    private final DataScopeProperties dataScopeProperties;

    @Override
    public Object intercept(Invocation invocation) throws Throwable {

        StatementHandler statementHandler = PluginUtils.realTarget(invocation.getTarget());
        MetaObject metaObject = SystemMetaObject.forObject(statementHandler);
        this.sqlParser(metaObject);
        MappedStatement mappedStatement = (MappedStatement) metaObject.getValue("delegate.mappedStatement");
        if(mappedStatement.getSqlCommandType().equals(SqlCommandType.INSERT)){
            //注解逻辑判断  添加了注解并且为false时则不进行拦截
            Class<?> classType = Class.forName(mappedStatement.getId().substring(0, mappedStatement.getId().lastIndexOf(".")));
            String mName = mappedStatement.getId().substring(mappedStatement.getId().lastIndexOf(".") + 1, mappedStatement.getId().length());
            //查询数据权限配置
            List<String> mapperIds = dataScopeProperties.getMapperIds();
            //未配置数据权限，直接放行
            if (mapperIds==null || mapperIds.size()<=0) {
                return invocation.proceed();
            }else{
                String mappedStatementId = mappedStatement.getId();
                if(!CollUtil.contains(mapperIds,mappedStatementId)){
                    return invocation.proceed();
                }
            }
            BaseUser user = SecurityUtils.getUser();
            if (user == null) {
                log.error("用户信息为空");
                throw new CheckedException("用户信息为空");
            }
            for (Method method : classType.getMethods()) {
                if ((!method.isAnnotationPresent(OrganDataScope.class)) && mName.equals(method.getName())) {
                    resetInsertSql(statementHandler.getBoundSql(), mappedStatement, user);
                }
                if (method.isAnnotationPresent(OrganDataScope.class) && mName.equals(method.getName())) {
                    OrganDataScope interceptorAnnotation = method.getAnnotation(OrganDataScope.class);
                    if (interceptorAnnotation.flag()) {
                        resetInsertSql(statementHandler.getBoundSql(), mappedStatement, user);
                    }
                }
            }
        }
        return invocation.proceed();
    }

    @Override
    public Object plugin(Object target) {
        if (target instanceof StatementHandler) {
            return Plugin.wrap(target, this);
        } else {
            return target;
        }
    }

    @Override
    public void setProperties(Properties properties) {

    }

    private void resetInsertSql(BoundSql boundSql, MappedStatement mappedStatement, BaseUser user){
        String originSql = boundSql.getSql();
        String[] paramSql = originSql.split("[)]\\s*VALUES");
        StringBuilder newSql= new StringBuilder(paramSql[0] );
        newSql.append(", ")
                .append(CommonConstants.SCOPENAME)
                .append( " ) VALUES");
        String[] endSql = paramSql[1].split("[)]");
        newSql.append(endSql[0])
                .append(",?)");
        ReflectUtil.setFieldValue(boundSql, "sql", newSql.toString());
        ReflectUtil.setFieldValue(boundSql.getParameterObject(), CommonConstants.SCOPENAME_ENTITY, user.getOrganId());
        List<ParameterMapping> parameterMappings = boundSql.getParameterMappings();
        if(parameterMappings.size() > 0){
            parameterMappings.add(parameterMappings.size(), new ParameterMapping.Builder(mappedStatement.getConfiguration(),CommonConstants.SCOPENAME_ENTITY,String.class).build());
        }
    }
}
