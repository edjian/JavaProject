package com.joolun.cloud.common.swagger.annotation;

import com.joolun.cloud.common.swagger.config.SwaggerAutoConfiguration;
import org.springframework.context.annotation.Import;

import java.lang.annotation.*;

/**
 * @author JL
 * @date 2018/7/21
 * 开启 swagger
 */
@Target({ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Inherited
@Import({SwaggerAutoConfiguration.class})
public @interface BaseEnableSwagger {
}
