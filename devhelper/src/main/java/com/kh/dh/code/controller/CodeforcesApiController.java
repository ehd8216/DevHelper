package com.kh.dh.code.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.kh.dh.code.model.vo.Contest;
import com.kh.dh.code.model.vo.Problem;
import com.kh.dh.code.model.vo.User;

@WebServlet("/codeforces")
public class CodeforcesApiController extends HttpServlet {

    private static final String API_URL = "https://codeforces.com/api/problemset.problems";
    private static final String CONTEST_API_URL = "https://codeforces.com/api/contest.list";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
        // Codeforces 사용자 정보 (예시)
        ArrayList<User> codeforcesUsers = getUsers(request);

        // 문제 목록 가져오기
        ArrayList<Problem> problems = getProblems(request);

        // 대회 목록 가져오기
        ArrayList<Contest> contests = getContests();

        // JSP에 데이터 전달
        request.setAttribute("codeforcesUsers", codeforcesUsers);
        request.setAttribute("problems", problems);
        request.setAttribute("contests", contests);

        // JSP 페이지로 포워딩
        request.getRequestDispatcher("/WEB-INF/views/code/codings.jsp").forward(request, response);
    }

    private ArrayList<Problem> getProblems(HttpServletRequest request) throws IOException {
    	
        ArrayList<Problem> problemList = new ArrayList<>();
        List<String> tags = new ArrayList<>(); // 태그 리스트 추가
        URL url = new URL(API_URL + "?tags=implementation");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");

        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        StringBuilder response = new StringBuilder();
        String inputLine;

        while ((inputLine = in.readLine()) != null) {
            response.append(inputLine);
        }
        
        in.close();

        Gson gson = new Gson();
        JsonObject jsonResponse = gson.fromJson(response.toString(), JsonObject.class);
        
        if (jsonResponse.get("status").getAsString().equals("OK")) {
        	
            JsonArray problems = jsonResponse.getAsJsonObject("result").getAsJsonArray("problems");
            
            for (int i = 0; i < problems.size(); i++) {
            	
                JsonObject problem = problems.get(i).getAsJsonObject();
                String problemName = problem.get("name").getAsString();
                String contestId = problem.get("contestId").getAsString();
                String index = problem.get("index").getAsString();

                JsonArray tagsArray = problem.getAsJsonArray("tags");
                List<String> problemTags = new ArrayList<>();
                
                for (int j = 0; j < tagsArray.size(); j++) {
                    String tag = tagsArray.get(j).getAsString();
                    problemTags.add(tag);
                    
                    if (!tags.contains(tag)) {
                        tags.add(tag); 
                    }
                    
                }
                
                String rating = problem.has("rating") ? problem.get("rating").getAsString() : "N/A";
                problemList.add(new Problem(problemName, contestId, index, problemTags, rating));
                
            }
            
            Collections.sort(problemList, new Comparator<Problem>() {
            	
            	@Override
            	public int compare(Problem p1, Problem p2) {
            		
            		Integer rating1 = p1.getRating().equals("N/A") ? 4000 : Integer.valueOf(p1.getRating());
            		Integer rating2 = p2.getRating().equals("N/A") ? 4000 : Integer.valueOf(p2.getRating());
            		
            		return rating1.compareTo(rating2);
            		
            	}
            	
			});
            
        }

        request.setAttribute("tags", tags); // 태그 리스트를 요청에 추가
        return problemList;
        
    }
    
    private ArrayList<User> getUsers(HttpServletRequest request) throws IOException {
    	
        ArrayList<User> userList = new ArrayList<>();
        URL url = new URL("https://codeforces.com/api/user.ratedList?activeOnly=true&includeRetired=false"); // 사용자 정보를 가져오는 API URL
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");

        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        StringBuilder response = new StringBuilder();
        String inputLine;

        while ((inputLine = in.readLine()) != null) {
            response.append(inputLine);
        }
        
        in.close();

        Gson gson = new Gson();
        JsonObject jsonResponse = gson.fromJson(response.toString(), JsonObject.class);
        
        if (jsonResponse.get("status").getAsString().equals("OK")) {
        	
            JsonArray users = jsonResponse.getAsJsonArray("result"); // users는 result 배열에 직접 포함됨
            
            for (int i = 0; i < Math.min(users.size(), 100); i++) {
            	
                JsonObject user = users.get(i).getAsJsonObject(); // JsonArray에서 JsonObject로 가져오기
                String handle = user.get("handle").getAsString();
                String rank = user.get("rating").getAsString();
                
                userList.add(new User(handle, rank)); 
                
            }
            
            Collections.sort(userList, new Comparator<User>() {
            	
            	@Override
            	public int compare(User u1, User u2) {
            		
            		Integer rank1 = Integer.valueOf(u1.getRank());
            		Integer rank2 = Integer.valueOf(u2.getRank());
            		
            		return rank2.compareTo(rank1);
            		
            	}
            	
            });
            
        }

        request.setAttribute("users", userList); // 사용자 리스트를 요청에 추가
        return userList;
    }

    private ArrayList<Contest> getContests() throws IOException {
    	
        ArrayList<Contest> contestList = new ArrayList<>();
        URL url = new URL(CONTEST_API_URL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");

        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        StringBuilder response = new StringBuilder();
        String inputLine;

        while ((inputLine = in.readLine()) != null) {
            response.append(inputLine);
        }
        in.close();

        Gson gson = new Gson();
        JsonObject jsonResponse = gson.fromJson(response.toString(), JsonObject.class);
        
        if (jsonResponse.get("status").getAsString().equals("OK")) {
        	
            JsonArray contests = jsonResponse.getAsJsonArray("result");
            
            for (int i = 0; i < Math.min(contests.size(), 10); i++) {
            	
                JsonObject contest = contests.get(i).getAsJsonObject();
                String contestName = contest.get("name").getAsString();
                String contestId = contest.get("id").getAsString();
                long startTime = contest.get("startTimeSeconds").getAsLong(); // UNIX timestamp

                // Contest 객체 생성 후 리스트에 추가
                contestList.add(new Contest(contestName, contestId, startTime)); // startTime은 그대로 사용
                
            }
            
        }
        
        return contestList;
        
    }

}