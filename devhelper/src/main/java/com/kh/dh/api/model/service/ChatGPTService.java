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
	private String API_KEY;
	
	private static final String API_URL = "https://api.openai.com/v1/chat/completions";
    

    public String callChatGPT(String companyName, String jobTitle, String maxLength, String motivation, String question, String experience) {
    	  int attempts = 0;
          while (attempts < 8) {
              try {
                  URL url = new URL(API_URL);
                  HttpURLConnection connection = (HttpURLConnection) url.openConnection();
                  connection.setRequestMethod("POST");
                  connection.setRequestProperty("Authorization", "Bearer " + API_KEY);
                  connection.setRequestProperty("Content-Type", "application/json");
                  
                  String userMsg = 
                		  "내가 지원하는 회사 : " + companyName + "이고 이곳에서"
                		  + "내 희망 직무 : " + jobTitle + "이야."
                		  + "내가 이 회사에 희망하는 이유는" + motivation + "이고," 
                		  + "이 회사에서 나에게 물어보는 질문은 : " + question +"이야."
                		  + "이 질문에 대한 내 경험은 : " + experience +"야."
                		  + "/n 이 질문들과 답변들을 토대로 실제로 제출하기에 좋을정도의 퀄리티를 가진 자기소개서를 " + maxLength + "글자 내외로 작성해줘";                
                  String body = "{\"model\": \"gpt-4o-mini\", \"messages\": [{\"role\": \"user\", \"content\": \"" + userMsg + "\"}]}";
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
