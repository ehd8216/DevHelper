package com.kh.dh.employmentAPI.model.service;
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
	private String API_KEY;
	
	private static final String API_URL = "https://api.openai.com/v1/chat/completions";
    

    public String callChatGPT(String prompt) {
    	  int attempts = 0;
          while (attempts < 5) {
              try {
                  URL url = new URL(API_URL);
                  HttpURLConnection connection = (HttpURLConnection) url.openConnection();
                  connection.setRequestMethod("POST");
                  connection.setRequestProperty("Authorization", "Bearer " + API_KEY);
                  connection.setRequestProperty("Content-Type", "application/json");

                  String body = "{\"model\": \"gpt-3.5-turbo\", \"messages\": [{\"role\": \"user\", \"content\": \"" + prompt + "\"}]}";
                  connection.setDoOutput(true);
                  try (OutputStreamWriter writer = new OutputStreamWriter(connection.getOutputStream())) {
                      writer.write(body);
                      writer.flush();
                  }

                  int responseCode = connection.getResponseCode();
                  if (responseCode == HttpURLConnection.HTTP_OK) {
                      StringBuilder response = new StringBuilder();
                      try (BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream()))) {
                          String line;
                          while ((line = br.readLine()) != null) {
                              response.append(line);
                          }
                      }
                      return extractMessageFromJSONResponse(response.toString());
                  } else if (responseCode == 429) {
                      Thread.sleep((long) Math.pow(2, attempts) * 1000);
                      attempts++;
                  } else {
                      throw new IOException("서버에서 HTTP 응답 코드: " + responseCode);
                  }
              } catch (IOException | InterruptedException e) {
                  throw new RuntimeException("API 호출 중 오류 발생: " + e.getMessage(), e);
              }
          }
          throw new RuntimeException("최대 재시도 횟수에 도달했습니다.");
      }

      private String extractMessageFromJSONResponse(String response) {
          // Parse the JSON response using Gson
          Gson gson = new Gson();
          JsonObject jsonObject = gson.fromJson(response, JsonObject.class);

          // Extract the 'choices' array and find the 'content' field
          JsonArray choices = jsonObject.getAsJsonArray("choices");
          if (choices != null && choices.size() > 0) {
              JsonObject firstChoice = choices.get(0).getAsJsonObject();
              JsonObject message = firstChoice.getAsJsonObject("message");
              return message.get("content").getAsString();
          }
          return "No content found";
      }
}
