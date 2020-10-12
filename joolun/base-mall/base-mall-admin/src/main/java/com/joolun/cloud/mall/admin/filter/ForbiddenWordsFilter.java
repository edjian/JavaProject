package com.joolun.cloud.mall.admin.filter;

import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.joolun.cloud.common.core.constant.CommonConstants;
import com.joolun.cloud.mall.common.entity.ForbiddenWords;
import lombok.AllArgsConstructor;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.MediaType;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@AllArgsConstructor
@WebFilter(filterName = "ForbiddenWordsFilter", urlPatterns = "/api/ma/goodsappraises")
public class ForbiddenWordsFilter implements Filter {

    private final static Logger logger = LoggerFactory.getLogger(ForbiddenWordsFilter.class);
    private final RedisTemplate redisTemplate;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
//        logger.info("================进入过滤器======================");
        HttpServletRequest request = (HttpServletRequest) servletRequest;

        String contentType = request.getContentType();
        if (contentType.equals(MediaType.APPLICATION_JSON_UTF8_VALUE)
                || contentType.equals(MediaType.APPLICATION_JSON_VALUE)) {
            //获取request的body参数
            String postContent = getBody(request);
            //如果body中存在数据放入HttpServletRequest
            if (StringUtils.isNotEmpty(postContent)) {
                //参数中放入新的参数
                List parseObject = JSONUtil.parseArray(postContent);
                List<ForbiddenWords> list = (ArrayList)redisTemplate.opsForValue().get(CommonConstants.REDIS_FORBIDDEN_WORDS_KEY);
                postContent = parseObject.stream().map(parse -> {
                    JSONObject jsonObject = JSONUtil.parseObj(parse);
                    String content = jsonObject.get("content").toString();
                    if (list.stream()
                            .anyMatch(li -> content.contains(li.getContent()))) {
                        jsonObject.set("content", IntStream.range(0,content.length()).mapToObj(i->"*").collect(Collectors.joining()));
                    }
                    return jsonObject;
                }).collect(Collectors.toList()).toString();
                //将参数放入重写的方法中
                request = new BodyRequestWrapper(request, postContent);
            }
            //form表单形式
        } else if ((contentType.equals(MediaType.APPLICATION_FORM_URLENCODED_VALUE) || contentType.contains(MediaType.MULTIPART_FORM_DATA_VALUE))
                && !request.getParameterMap().isEmpty()) {
//            String body = "{\"name\":\"zhangsan\",\"age\":1,\"gender\":2}";
            //重新添加几个数据
            Map<String, String[]> parameterMap = new HashMap<>();
//            parameterMap.put("name", new String[]{"zhangsan"});
//            parameterMap.put("age", new String[]{"1"});
//            parameterMap.put("gender", new String[]{"2"});
            //将参数放入重写的方法中
            request = new ParameterRequestWrapper(request, parameterMap);
        }
        filterChain.doFilter(request, servletResponse);
        
    }

    private String getBody(ServletRequest request){
        StringBuilder stringBuilder = new StringBuilder();
        BufferedReader bufferedReader = null;
        InputStream inputStream = null;

        try {
            inputStream = request.getInputStream();
            if(Optional.ofNullable(inputStream).isPresent()){
                bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
                char[] charBuffer = new char[128];
                int bytesRead = -1;
                while((bytesRead = bufferedReader.read(charBuffer)) > 0){
                    stringBuilder.append(charBuffer, 0, bytesRead);
                }
            }else{
                stringBuilder.append("");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            if(Optional.ofNullable(inputStream).isPresent()){
                try {
                    inputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if(Optional.ofNullable(bufferedReader).isPresent()){
                try {
                    bufferedReader.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return stringBuilder.toString();
    }

    @Override
    public void destroy() {

    }
}
