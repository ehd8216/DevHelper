package com.kh.dh.api.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.kh.dh.api.model.service.ChatGPTService;

@Controller
public class APIcontroller {
	
	private static final String serviceKey = "2mj%2BiKt4iQ0xuf1PfeDRzkWy7KaPiuBO8Ui%2FD8QBuF8Bo4%2BN3i8nYJIOzizmAebj0MaiTJRJFwNahQZ5O1kARA%3D%3D";

	@ResponseBody
	@RequestMapping(value="work.wo", produces = "application/json; charset=utf-8")
	public String employAPI(
			@RequestParam(value="pageNo",defaultValue="1")int pageNo,
			@RequestParam(value="numOfRows",defaultValue="15")int numOfRows,
			@RequestParam(value="ncsCdLst",defaultValue = "R6000")String ncsCdLst,
			@RequestParam(value="recrutPbancTtl",defaultValue = "")String recrutPbancTtl
			
			) throws IOException {
		
		String url = "https://apis.data.go.kr/1051000/recruitment/list";
		url += "?serviceKey=" + serviceKey;
		url += "&numOfRows=15";
		url += "&pageNo=" + pageNo;
		url += "&workRgnLst=R3010"; // 근무지 서울포함으로 한정
		url += "&ncsCdLst=" + ncsCdLst;
		url += "&recrutPbancTtl=" + URLEncoder.encode(recrutPbancTtl,"utf-8"); // 한글쓸시 무조건 인코딩하기(잘 나오는것같아도)
		
		URL requestUrl = new URL(url);
		HttpURLConnection urlConnection = (HttpURLConnection)requestUrl.openConnection();
		urlConnection.setRequestMethod("GET");
		
		BufferedReader br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream(),"UTF-8"));
		
		String responseText="";
		String line;
		
		while((line = br.readLine())!=null) {
			responseText += line;
		}
		br.close();
		urlConnection.disconnect();
				
		return responseText;
	}
	
	@ResponseBody
	@RequestMapping(value="detailAPI.wo", produces = "application/json; charset=utf-8")
	public String employDetailAPI(@RequestParam(value="sn")int sn) throws IOException {
		
		String url = "https://apis.data.go.kr/1051000/recruitment/detail";
		url += "?serviceKey=" + serviceKey;
		url += "&resultType=json";
		url += "&sn=" + sn;
	
		
		URL requestUrl = new URL(url);
		HttpURLConnection urlConnection = (HttpURLConnection)requestUrl.openConnection();
		urlConnection.setRequestMethod("GET");
		
		BufferedReader br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream(),"UTF-8"));
		
		String responseText="";
		String line;
		
		while((line = br.readLine())!=null) {
			responseText += line;
		}
		br.close();
		urlConnection.disconnect();
	
		
				
		return responseText;
	}
	
	
	    @Autowired
	    private ChatGPTService gptService;
	    
	    // @GetMapping("chat")
	    @ResponseBody
	    @RequestMapping(value="chat", produces = "application/json; charset=utf-8")
	    public String callChatGPT(@RequestBody Map<String, String> requestData) {
	    	
	        String companyName = requestData.get("companyName");
	        String jobTitle = requestData.get("jobTitle");
	        String maxLength = requestData.get("maxLength");
	        String motivation = requestData.get("motivation");
	        String question = requestData.get("question");
	        String experience = requestData.get("experience");

	        String generatedText = gptService.callChatGPT(companyName, jobTitle, maxLength, motivation, question, experience);
	        
	       
	        return "{\"response\": \"" + generatedText + "\"}";
	    }
}

