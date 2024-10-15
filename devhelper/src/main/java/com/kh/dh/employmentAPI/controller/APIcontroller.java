package com.kh.dh.employmentAPI.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.dh.employmentAPI.model.service.ApiService;
import com.kh.dh.employmentAPI.model.service.ChatGPTService;
import com.kh.dh.employmentAPI.model.vo.Scrap;
import com.kh.dh.member.model.vo.Member;



@Controller
public class APIcontroller {
	
	private static final String serviceKey = "2mj%2BiKt4iQ0xuf1PfeDRzkWy7KaPiuBO8Ui%2FD8QBuF8Bo4%2BN3i8nYJIOzizmAebj0MaiTJRJFwNahQZ5O1kARA%3D%3D";
	
	@Autowired
	private ApiService apiService;
	
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
	@ResponseBody
	@RequestMapping(value = "scrap.wo" , produces = "application/json; charset=utf-8")
	public int scrapinsert(HttpServletRequest request, HttpSession session) throws IOException {
	    String sn = request.getParameter("sn");
	    String url = "https://apis.data.go.kr/1051000/recruitment/detail";
	    url += "?serviceKey=" + serviceKey;
	    url += "&resultType=json";
	    url += "&sn=" + sn;
	    
	    URL requestUrl = new URL(url);
	    HttpURLConnection urlConnection = (HttpURLConnection) requestUrl.openConnection();
	    urlConnection.setRequestMethod("GET");
	    
	    BufferedReader br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream(), "UTF-8"));
	    
	    StringBuilder responseText = new StringBuilder();
	    String line;
	    
	    while ((line = br.readLine()) != null) {
	        responseText.append(line);
	    }
	    br.close();
	    
	    // JSON 파싱
	    JSONObject jsonResponse = new JSONObject(responseText.toString());
	    JSONObject result = jsonResponse.getJSONObject("result");
	    
	    Member loginMember = (Member) session.getAttribute("loginMember");
	    int memNo = loginMember.getMemNo();
	    //담기
	    Scrap scrap = new Scrap();
	    scrap.setInstNm(result.getString("instNm"));
	    scrap.setRecrutPbancTtl(result.getString("recrutPbancTtl"));
	    scrap.setPbancEndYmd(result.getString("pbancEndYmd"));
	    scrap.setNcsCdNmLst(result.getString("ncsCdNmLst"));
	    scrap.setHireTypeNmLst(result.getString("hireTypeNmLst"));
	    scrap.setReplmprYn(result.getString("replmprYn"));
	    scrap.setRecrutSeNm(result.getString("recrutSeNm"));
	    scrap.setWorkRgnNmLst(result.getString("workRgnNmLst"));
	    scrap.setAplyQlfcCn(result.getString("aplyQlfcCn"));
	    scrap.setPrefCn(result.getString("prefCn"));
	    scrap.setScrnprcdrMthdExpln(result.getString("scrnprcdrMthdExpln"));
	    scrap.setRecrutPblntSn(result.getInt("recrutPblntSn"));
	    scrap.setUserId(memNo);
	    int check = apiService.scrapinsert(scrap);
	    return check;
	}
	
		@Controller
		public class GptController {

	    @Autowired
	    private ChatGPTService gptService;

	    @GetMapping("chat")
	    public String callChatGPT(@RequestParam("prompt") String prompt, Model model) {
	        String response = gptService.callChatGPT(prompt);
	        model.addAttribute("response", response);
	        return "coverletter/chat"; // 결과를 출력할 뷰 이름
	    }
	}
}
