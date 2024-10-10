package com.kh.dh.employmentAPI.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class APIcontroller {
	
	private static final String serviceKey = "2mj%2BiKt4iQ0xuf1PfeDRzkWy7KaPiuBO8Ui%2FD8QBuF8Bo4%2BN3i8nYJIOzizmAebj0MaiTJRJFwNahQZ5O1kARA%3D%3D";

	@ResponseBody
	@RequestMapping(value="work.wo", produces = "application/json; charset=utf-8")
	public String employAPI(
			@RequestParam(value="pageNo",defaultValue="1")int pageNo,
			@RequestParam(value="numOfRows",defaultValue="15")int numOfRows,
			@RequestParam(value="ncsCdLst",defaultValue = "R6000")String ncsCdLst
			
			) throws IOException {
		
		String url = "https://apis.data.go.kr/1051000/recruitment/list";
		url += "?serviceKey=" + serviceKey;
		url += "&numOfRows=15";
		url += "&pageNo=" + pageNo;
		url += "&workRgnLst=R3010"; // 근무지 서울포함으로 한정
		url += "&ncsCdLst=" + ncsCdLst;
		
		
		
		
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
}
