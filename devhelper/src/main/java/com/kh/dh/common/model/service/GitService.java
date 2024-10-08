package com.kh.dh.common.model.service;

import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.WebClient;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.dh.member.model.vo.Member;

@Service
public class GitService {
	
	public String getToken(String code) {
		String url = "https://github.com/login/oauth/access_token";

		String response = WebClient.create()
				.post()
				.uri(url)
				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
				.header(HttpHeaders.ACCEPT, MediaType.APPLICATION_JSON_VALUE)
				.body(BodyInserters.fromFormData("client_id", "Ov23liXFCmu7DAbTXCnZ")
                .with("client_secret", "6e05409f7a9e5dbddebd3a0a33132be0c201b26f")
                .with("code",code))
				.retrieve()
				.bodyToMono(String.class)
				.block();
		
	    ObjectMapper objectMapper = new ObjectMapper();
	    JsonNode jsonNode;
	    
	    String token="";
	    
	    try 
	    {
			jsonNode = objectMapper.readTree(response);
			token = jsonNode.get("access_token").asText();
		} 
	    catch (JsonProcessingException e) 
	    {
			e.printStackTrace();
		}
	    return token;
	}
	public Member getUserInfo(String token) 
	{
		String response = WebClient.create()
				.get()
				.uri("https://api.github.com/user")
				.header(HttpHeaders.AUTHORIZATION, "Bearer "+token)
				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
				.header(HttpHeaders.ACCEPT, "application/vnd.github+json")
				.retrieve()
				.bodyToMono(String.class)
				.block();
		
		
		ObjectMapper objecMapper = new ObjectMapper();
		JsonNode jsonNode = null;
		Member m = new Member();
		
		// login => nickname
		try 
		{
			jsonNode = objecMapper.readTree(response);
			m.setMemId(jsonNode.get("id").asText());
			m.setGitNick(jsonNode.get("login").asText());
			m.setProfile(jsonNode.get("avatar_url").asText());
		}
		catch (JsonProcessingException e) 
		{
			e.printStackTrace();
		}
		return m;
	}
}
