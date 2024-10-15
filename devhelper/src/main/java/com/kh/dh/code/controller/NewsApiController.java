package com.kh.dh.code.controller;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

@WebServlet("/searchNews")
public class NewsApiController extends HttpServlet {
    private static final String CLIENT_ID = "p8qwR1oxzfCJqMtKn5rc"; // 애플리케이션 클라이언트 아이디
    private static final String CLIENT_SECRET = "qSgc2FjvKA"; // 애플리케이션 클라이언트 시크릿

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("query");
        if (query == null || query.isEmpty()) {
            query = "뉴스"; // 기본 검색어
        }

        String text = URLEncoder.encode(query, "UTF-8");
        String apiURL = "https://openapi.naver.com/v1/search/news.json?query=" + text + "&display=50"; // JSON 결과
        Map<String, String> requestHeaders = new HashMap<String, String>();
        requestHeaders.put("X-Naver-Client-Id", CLIENT_ID);
        requestHeaders.put("X-Naver-Client-Secret", CLIENT_SECRET);

        String responseBody = get(apiURL, requestHeaders);

        // JSON 파싱하여 items 추출
        JSONParser parser = new JSONParser();
        JSONArray filteredItems = new JSONArray();
        
        try {
            JSONObject jsonObject = (JSONObject) parser.parse(responseBody);
            JSONArray items = (JSONArray) jsonObject.get("items");

            // 이미지가 없는 경우 필터링
            for (Object item : items) {
                JSONObject jsonItem = (JSONObject) item;
                if (jsonItem.containsKey("title")) {
                    filteredItems.add(jsonItem); // 제목이 있는 경우만 추가
                }
            }
        } catch (ParseException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "JSON parsing error: " + e.getMessage());
        }

        request.setAttribute("items", filteredItems); // Set items as request attribute for EL access
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/community/community.jsp");
        dispatcher.forward(request, response); // Forward to result page
    }

    private String get(String apiUrl, Map<String, String> requestHeaders) {
        HttpURLConnection con = connect(apiUrl);
        try {
            con.setRequestMethod("GET");
            for (Map.Entry<String, String> header : requestHeaders.entrySet()) {
                con.setRequestProperty(header.getKey(), header.getValue());
            }

            int responseCode = con.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
                return readBody(con.getInputStream());
            } else { // 오류 발생
                return readBody(con.getErrorStream());
            }
        } catch (IOException e) {
            throw new RuntimeException("API 요청과 응답 실패", e);
        } finally {
            con.disconnect();
        }
    }

    private HttpURLConnection connect(String apiUrl) {
        try {
            URL url = new URL(apiUrl);
            return (HttpURLConnection) url.openConnection();
        } catch (MalformedURLException e) {
            throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
        } catch (IOException e) {
            throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
        }
    }

    private String readBody(InputStream body) {
        InputStreamReader streamReader = new InputStreamReader(body);
        try (BufferedReader lineReader = new BufferedReader(streamReader)) {
            StringBuilder responseBody = new StringBuilder();
            String line;
            while ((line = lineReader.readLine()) != null) {
                responseBody.append(line);
            }
            return responseBody.toString();
        } catch (IOException e) {
            throw new RuntimeException("API 응답을 읽는 데 실패했습니다.", e);
        }
    }
}
