package com.kh.dh.repository.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.kohsuke.github.GHIssue;
import org.kohsuke.github.GHIssueState;
import org.kohsuke.github.GHPermissionType;
import org.kohsuke.github.GHCreateRepositoryBuilder;
import org.kohsuke.github.GHRepository;
import org.kohsuke.github.GHUser;
import org.kohsuke.github.GitHub;
import org.kohsuke.github.GitHubBuilder;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.servlet.ModelAndView;

import com.kh.dh.member.model.vo.Member;
import com.kh.dh.repository.model.vo.Repository;

@Controller
public class RepoController {
	
	private GitHub github; 
	
	// 전체 레파지토리 조회
	@RequestMapping("myRepo.re")
	public String myRepo(HttpSession session) throws IOException {
		
		if(session.getAttribute("loginMember") == null) {
			session.setAttribute("alertMsg", "로그인 후 이용 가능합니다.");
			return "redirect:/";
		}else {
			String token = (String)session.getAttribute("token");
			github = GitHub.connectUsingOAuth(token);
			
			ArrayList<Repository> repoList = new ArrayList();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
			Map<String , GHRepository> list = github.getMyself().getRepositories();
			
			for (Map.Entry<String, GHRepository> entry : list.entrySet()) {
				GHRepository repo = entry.getValue();
				
				String url = repo.getUrl().toString().substring(29);
				
				Repository r = new Repository();
				r.setRepoName(repo.getName());
				r.setRepoDescription(repo.getDescription());
				r.setVisibility(repo.getVisibility().toString());
				r.setCreateDate(sdf.format(repo.getCreatedAt()));
				r.setRepoUrl(repo.getUrl().toString());
				repoList.add(r);
			}
			session.setAttribute("repoList", repoList);
			
			return "repository/repository";
		}
		
	}
	
	@RequestMapping("repoDetail.re")
	public ModelAndView repoDetail(String repoName,String repoUrl,  ModelAndView mv,HttpSession session) throws IOException {
		github = GitHub.connectUsingOAuth((String)session.getAttribute("token"));
		String url = repoUrl.substring(29);
		 String[] str = url.split("/");

	        // 첫 번째 부분만 출력
	        String writer = str[0];
		GHRepository repo = github.getRepository(url);
		mv.addObject("repo", repo)
		  .addObject("writer", writer)
		  .setViewName("repository/repoDetail");
		return mv;
	}
	

	@RequestMapping("issueslist.re")
	public ModelAndView issueslist(String repoName,String writer,HttpSession session, ModelAndView mv) throws IOException
	{

		github = GitHub.connectUsingOAuth((String)session.getAttribute("token"));
		String url = writer + "/" + repoName;
		System.out.println(url);
		GHRepository repo = github.getRepository(url);
        
        // 레포지토리의 OPEN 상태 이슈 목록 가져오기
        List<GHIssue> issues = repo.getIssues(GHIssueState.OPEN);
        mv.addObject("issues", issues)
		  .setViewName("repository/issuesList");
		//포워딩 => WEB-INF/views/board/boardListView
		return mv;
	}
	@RequestMapping("createRepo.re")
	public String createRepo(Repository repo, HttpSession session) throws IOException {
		github = GitHub.connectUsingOAuth((String)session.getAttribute("token"));
		GHCreateRepositoryBuilder builder = github.createRepository(repo.getRepoName());
        builder.description(repo.getRepoDescription());
        
        if(repo.getVisibility().equals("true")) {
        	builder.private_(true);
        }else {
        	builder.private_(false);
        }
        
        if(!repo.getReadMe().isEmpty()) {
        	builder.autoInit(true);
        }else {
        }
        builder.create();
		
		session.setAttribute("alertMsg", "레파지토리 생성 완료");
		return "redirect:myRepo.re";
	}
	@RequestMapping("deleteRepo.re")
	public String deleteRepo(String reUserUrl, HttpSession session) throws IOException {
//		github = GitHub.connectUsingOAuth((String)session.getAttribute("token"));
//		GitHub github = new GitHubBuilder().withOAuthToken("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").build();
		WebClient webClient = WebClient.create();
		
		String deleteRepoUrl = "https://api.github.com/repos/" + reUserUrl;
		
		webClient
		.delete()
		.uri(deleteRepoUrl)
		.header(HttpHeaders.AUTHORIZATION, "Bearer " + (String)session.getAttribute("token"))
		.header(HttpHeaders.ACCEPT, MediaType.APPLICATION_JSON_VALUE)
		.retrieve()
		.toBodilessEntity()  // No body is returned on a successful DELETE
		.doOnError(error -> {
			System.out.println("Error occurred while deleting the repository: " + error.getMessage());
		})
		.block();  // Blocking to wait for the request to complete
		
		session.setAttribute("alertMsg", "레파지토리 삭제 완료");
		return "redirect:myRepo.re";
	}
	
	@RequestMapping("inviteRepo.re")
	public String inviteRepo(String inviteUserName, String reUserUrl, HttpSession session) throws IOException {
		github = GitHub.connectUsingOAuth((String)session.getAttribute("token"));
		GHRepository repo = github.getRepository(reUserUrl);
		
		GHUser userToInvite = github.getUser(inviteUserName);
		
		repo.addCollaborators(userToInvite);
		
		session.setAttribute("alertMsg", "초대 성공");
		return "redirect:myRepo.re";
	}
	
	
}
