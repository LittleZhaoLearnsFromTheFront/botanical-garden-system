package com.ruoyi.common.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * ai-system 对接配置（Java 中间层转发使用）。
 */
@Component
@ConfigurationProperties(prefix = "ai-system")
public class AiSystemProperties
{
    /**
     * ai-system server baseUrl，例如：http://localhost:4000
     */
    private String baseUrl = "http://localhost:4000";

    /**
     * ai-system 认证头（ai-system 默认使用 X-User）。
     */
    private String userHeader = "X-User";

    /**
     * 默认 provider（例如 deepseek/openai/anthropic）。
     */
    private String provider = "openai";

    /**
     * 默认模型（可空，ai-system 会使用其默认值）。
     */
    private String model;

    /**
     * 默认温度（可空，ai-system 会使用其默认值）。
     */
    private Double temperature;

    /**
     * ai-system 回调 Java 时使用的共享密钥（用于保护内部接口）。
     */
    private String callbackSecret;

    /**
     * 回调鉴权头名称（默认 X-AI-SECRET）。
     */
    private String callbackHeader = "X-AI-SECRET";

    public String getBaseUrl()
    {
        return baseUrl;
    }

    public void setBaseUrl(String baseUrl)
    {
        this.baseUrl = baseUrl;
    }

    public String getUserHeader()
    {
        return userHeader;
    }

    public void setUserHeader(String userHeader)
    {
        this.userHeader = userHeader;
    }

    public String getProvider()
    {
        return provider;
    }

    public void setProvider(String provider)
    {
        this.provider = provider;
    }

    public String getModel()
    {
        return model;
    }

    public void setModel(String model)
    {
        this.model = model;
    }

    public Double getTemperature()
    {
        return temperature;
    }

    public void setTemperature(Double temperature)
    {
        this.temperature = temperature;
    }

    public String getCallbackSecret()
    {
        return callbackSecret;
    }

    public void setCallbackSecret(String callbackSecret)
    {
        this.callbackSecret = callbackSecret;
    }

    public String getCallbackHeader()
    {
        return callbackHeader;
    }

    public void setCallbackHeader(String callbackHeader)
    {
        this.callbackHeader = callbackHeader;
    }
}

