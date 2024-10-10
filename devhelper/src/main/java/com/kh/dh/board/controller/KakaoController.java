package com.kh.dh.board.controller;

import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

public class KakaoController {

	public static void main(String[] args) {
        try {
            String accessToken = "4a27d49b197b36e675ecc5f986d40c88";
            String urlString = "https://kapi.kakao.com/v1/api/talk/friends/message/default/send";
            URL url = new URL(urlString);
            HttpURLConnection connection = (HttpURLConnection)url.openConnection();

            // Set up the connection
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            connection.setRequestProperty("Authorization", "Bearer " + accessToken);
            connection.setDoOutput(true);

            // Prepare the request body
            String receiverUuids = "[\"abcdefg0001\",\"abcdefg0002\",\"abcdefg0003\"]";
            String templateObject = "{"
                + "\"object_type\": \"text\","
                + "\"text\": \"텍스트 영역입니다. 최대 200자 표시 가능합니다.\","
                + "\"link\": {"
                + "\"web_url\": \"https://developers.kakao.com\","
                + "\"mobile_web_url\": \"https://developers.kakao.com\""
                + "},"
                + "\"button_title\": \"바로 확인\""
                + "}";

            String requestBody = String.format(
                "receiver_uuids=%s&template_object=%s",
                receiverUuids,
                templateObject
            );

            // Send the request
            try (OutputStream os = connection.getOutputStream()) {
                os.write(requestBody.getBytes("UTF-8"));
                os.flush();
            }

            // Get the response
            int responseCode = connection.getResponseCode();
            System.out.println("Response Code: " + responseCode);
            // Handle response (if needed)

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
	
}
