package com.ruoyi.framework.ai;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;
import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.common.config.AiSystemProperties;

@Component
public class AiSystemClient
{
    private static final Logger log = LoggerFactory.getLogger(AiSystemClient.class);

    private final RestTemplate restTemplate;
    private final AiSystemProperties props;

    public AiSystemClient(RestTemplate restTemplate, AiSystemProperties props)
    {
        this.restTemplate = restTemplate;
        this.props = props;
    }

    /**
     * ai-system 的 /api/ai/chat 要求 sessionId 存在；因此这里会先创建会话，再发送 chat。
     */
    public JSONObject chat(String userId, String sessionTitle, List<JSONObject> messages)
    {
        String baseUrl = normalizeBaseUrl(props.getBaseUrl());
        JSONObject session = ensureSession(userId, baseUrl, sessionTitle);
        if (session == null || !Boolean.TRUE.equals(session.getBoolean("success")))
        {
            JSONObject err = new JSONObject();
            err.put("success", false);
            err.put("message", session == null ? "ai-system 会话创建失败" : session.getString("message"));
            if (session != null)
            {
                err.put("details", session);
            }
            return err;
        }
        String sessionId = session.getString("sessionId");

        String url = baseUrl + "/api/ai/chat";

        Map<String, Object> payload = new HashMap<>();
        if (props.getProvider() != null && props.getProvider().trim().length() > 0)
        {
            payload.put("provider", props.getProvider());
        }
        payload.put("sessionId", sessionId);
        payload.put("messages", messages);
        if (props.getModel() != null && props.getModel().trim().length() > 0)
        {
            payload.put("model", props.getModel());
        }
        if (props.getTemperature() != null)
        {
            payload.put("temperature", props.getTemperature());
        }
        // 对工单场景默认开启动作判断（完成工单等）
        payload.put("enableWorkOrderAction", Boolean.TRUE);
        payload.put("stream", false);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set(HttpHeaders.ACCEPT, MediaType.APPLICATION_JSON_VALUE);
        headers.set(props.getUserHeader(), userId);

        try
        {
            HttpEntity<String> entity = new HttpEntity<>(JSON.toJSONString(payload), headers);
            ResponseEntity<String> resp = restTemplate.postForEntity(url, entity, String.class);
            return JSON.parseObject(resp.getBody());
        }
        catch (HttpStatusCodeException e)
        {
            JSONObject err = new JSONObject();
            err.put("success", false);
            err.put("message", "ai-system 调用失败：" + e.getStatusCode());
            err.put("body", safeParseJson(e.getResponseBodyAsString()));
            return err;
        }
        catch (RestClientException e)
        {
            log.error("调用 ai-system 失败: {}", url, e);
            JSONObject err = new JSONObject();
            err.put("success", false);
            err.put("message", "ai-system 调用失败");
            return err;
        }
    }

    private JSONObject ensureSession(String userId, String baseUrl, String title)
    {
        String url = baseUrl + "/api/ai/sessions";
        Map<String, Object> payload = new HashMap<>();
        payload.put("title", (title == null || title.trim().isEmpty()) ? "工单智能辅助" : title);
        payload.put("provider", props.getProvider() == null ? "deepseek" : props.getProvider());

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set(HttpHeaders.ACCEPT, MediaType.APPLICATION_JSON_VALUE);
        headers.set(props.getUserHeader(), userId);

        try
        {
            HttpEntity<String> entity = new HttpEntity<>(JSON.toJSONString(payload), headers);
            ResponseEntity<String> resp = restTemplate.postForEntity(url, entity, String.class);
            JSONObject json = JSON.parseObject(resp.getBody());
            JSONObject data = json == null ? null : json.getJSONObject("data");
            if (data != null)
            {
                JSONObject ok = new JSONObject();
                ok.put("success", true);
                ok.put("sessionId", data.getString("id"));
                return ok;
            }
            JSONObject err = new JSONObject();
            err.put("success", false);
            err.put("message", "ai-system 会话创建返回为空");
            err.put("body", json);
            return err;
        }
        catch (HttpStatusCodeException e)
        {
            JSONObject err = new JSONObject();
            err.put("success", false);
            err.put("message", "ai-system 会话创建失败：" + e.getStatusCode());
            err.put("body", safeParseJson(e.getResponseBodyAsString()));
            return err;
        }
        catch (RestClientException e)
        {
            log.error("创建 ai-system 会话失败: {}", url, e);
            JSONObject err = new JSONObject();
            err.put("success", false);
            err.put("message", "ai-system 会话创建失败（网络/服务不可用）");
            return err;
        }
    }

    private static Object safeParseJson(String body)
    {
        if (body == null) return null;
        String v = body.trim();
        if (v.isEmpty()) return "";
        try
        {
            return JSON.parse(v);
        }
        catch (Exception ignore)
        {
            return v;
        }
    }

    private static String normalizeBaseUrl(String baseUrl)
    {
        if (baseUrl == null || baseUrl.trim().isEmpty())
        {
            return "http://localhost:4000";
        }
        String v = baseUrl.trim();
        while (v.endsWith("/"))
        {
            v = v.substring(0, v.length() - 1);
        }
        return v;
    }
}

