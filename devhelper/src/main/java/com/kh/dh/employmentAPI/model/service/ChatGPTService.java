package com.kh.dh.employmentAPI.model.service;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.*;
import java.util.*;

@Service
public class ChatGPTService {

	private final String OPENAI_API_KEY = System.getenv("OPENAI_API_KEY");
    private final String OPENAI_API_URL = "https://api.openai.com/v1/chat/completions"; // OpenAI API endpoint

    public String getChatGPTResponse(String prompt) {
        RestTemplate restTemplate = new RestTemplate();

        // Set up the headers
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.setBearerAuth(OPENAI_API_KEY);

        // Set up the request body
        Map<String, Object> requestBody = new HashMap<>();
        requestBody.put("model", "gpt-3.5-turbo");  // or use another model like "gpt-4" if available
        requestBody.put("messages", Collections.singletonList(Map.of("role", "user", "content", prompt)));

        // Wrap it in HttpEntity to send it with headers
        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(requestBody, headers);

        // Make the POST request
        ResponseEntity<Map> response = restTemplate.exchange(OPENAI_API_URL, HttpMethod.POST, entity, Map.class);

        // Process the response to extract the content
        Map<String, Object> choices = (Map<String, Object>) ((List) response.getBody().get("choices")).get(0);
        return (String) ((Map) choices.get("message")).get("content");
    }
}
