package com.kh.dh.repository.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.kohsuke.github.GHRepository;
import org.kohsuke.github.GitHub;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.dh.repository.model.vo.Repository;

@Controller
public class RepoController {
	
	private GitHub github; 
	
	// 전체 레파지토리 조회
	@RequestMapping("myRepo.re")
	public String myRepo(HttpSession session) throws IOException {
		String token = (String)session.getAttribute("token");
		github = GitHub.connectUsingOAuth(token);
		
		ArrayList<Repository> repoList = new ArrayList();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
		Map<String , GHRepository> list = github.getMyself().getRepositories();
		
		for (Map.Entry<String, GHRepository> entry : list.entrySet()) {
            GHRepository repo = entry.getValue();
            Repository r = new Repository();
            r.setRepoName(repo.getName());
		    r.setRepoDescription(repo.getDescription());
		    r.setVisibility(repo.getVisibility().toString());
		    r.setCreateDate(sdf.format(repo.getCreatedAt()));
            repoList.add(r);
        }
		session.setAttribute("repoList", repoList);
		
		return "repository/repository";
	}
	
	@RequestMapping("repoDetail.re")
	public String repoDetail() {
		return "repository/repoDetail";
	}
	

}
