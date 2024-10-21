package com.kh.dh.api.model.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;

@Service
public class ChatGPTService {

    @Value("${OPENAI_API_KEY}")
    private String apiKey;

    private static final String API_URL = "https://api.openai.com/v1/chat/completions";
    
    // OpenAI API 호출 메서드
    public String callChatGPT(String companyName, String jobTitle, String maxLength, String motivation, String question, String experience, String skill) {
        try {
            HttpURLConnection connection = createConnection();
            String userMsg = createUserMessage(companyName, jobTitle, motivation, question, experience, maxLength,skill);
            sendRequest(connection, userMsg);
            
            int responseCode = connection.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                return extractMessageFromResponse(connection);
            } else {
                throw new IOException("서버에서 HTTP 응답 코드: " + responseCode);
            }
        } catch (IOException e) {
            throw new RuntimeException("API 호출 중 오류 발생: " + e.getMessage(), e);
        }
    }

    // HttpURLConnection 생성 메서드
    private HttpURLConnection createConnection() throws IOException {
        URL url = new URL(API_URL);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("POST");
        connection.setRequestProperty("Authorization", "Bearer " + apiKey);
        connection.setRequestProperty("Content-Type", "application/json");
        connection.setDoOutput(true);
        return connection;
    }

    // 사용자 메시지 생성 메서드
    private String createUserMessage(String companyName, String jobTitle, String motivation, String question, String experience, String maxLength, String skill) {
    	return "내가 지원하는 회사 : " + companyName + "이고 이곳에서" +
                "내 희망 직무 : " + jobTitle + "이야." +
        		"내가 가지고 있는 개발스택은 " + skill + "들이고 " + 
                "내가 이 회사에 희망하는 이유는" + motivation + "이고," +
                "이 회사에서 나에게 물어보는 질문은 : " + question + "이야." +
                "이 질문에 대한 내 경험은 : " + experience + "야." +
                "/n 이 질문들과 답변들을 토대로 실제로 제출하기에 좋을정도의 퀄리티를 가진 자기소개서를 제한 글자" + maxLength + "글자로 만들어줘";
    }

    // API 요청 전송 메서드
    private void sendRequest(HttpURLConnection connection, String userMsg) throws IOException {
        String body = "{\"model\": \"gpt-4o-mini\", \"messages\": [{\"role\": \"user\", \"content\": \"" + userMsg + "\"}]}";
        try (OutputStreamWriter writer = new OutputStreamWriter(connection.getOutputStream())) {
            writer.write(body);
            writer.flush();
        }
    }

    // 응답에서 메시지 추출 메서드
    private String extractMessageFromResponse(HttpURLConnection connection) throws IOException {
        StringBuilder response = new StringBuilder();
        try (BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream()))) {
            String line;
            while ((line = br.readLine()) != null) {
                response.append(line);
            }
        }

        return extractMessageFromJSONResponse(response.toString());
    }

    // JSON 응답에서 메시지 추출 메서드
    private String extractMessageFromJSONResponse(String response) {
        Gson gson = new Gson();
        JsonObject jsonObject = gson.fromJson(response, JsonObject.class);

        JsonArray choices = jsonObject.getAsJsonArray("choices");
        if (choices != null && choices.size() > 0) {
            JsonObject firstChoice = choices.get(0).getAsJsonObject();
            JsonObject message = firstChoice.getAsJsonObject("message");
            return message.get("content").getAsString();
        }
        return "No content found";
    }
}
