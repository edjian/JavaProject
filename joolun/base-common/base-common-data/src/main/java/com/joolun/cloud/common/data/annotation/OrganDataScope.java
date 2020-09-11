package com.joolun.cloud.common.data.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target({ElementType.METHOD, ElementType.PARAMETER})

@Retention(RetentionPolicy.RUNTIME)
public @interface OrganDataScope {
    boolean flag()default true;
}
