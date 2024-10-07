package com.kh.dh.repository.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

<<<<<<< HEAD
import org.kohsuke.github.GHIssue;
import org.kohsuke.github.GHIssueState;
=======
import org.kohsuke.github.GHCreateRepositoryBuilder;
>>>>>>> df77d4e6468e3edef80c0555eb6c517dbc531ed9
import org.kohsuke.github.GHRepository;
import org.kohsuke.github.GitHub;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

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
		
	}
	
	@RequestMapping("repoDetail.re")
	public String repoDetail(String repoName, HttpSession session) throws IOException {
		github = GitHub.connectUsingOAuth((String)session.getAttribute("token"));
		Member m = (Member)session.getAttribute("loginMember");
		String str = m.getGitNick() + "/" + repoName;
		GHRepository repo = github.getRepository(str);
		
		session.setAttribute("repo", repo);
		return "repository/repoDetail";
	}
	

	@RequestMapping("issueslist.re")
	public String issueslist(String repoName, HttpSession session) throws IOException
	{
		github = GitHub.connectUsingOAuth((String)session.getAttribute("token"));
		Member m = (Member)session.getAttribute("loginMember");
		   // 특정 레포지토리 가져오기
		String str = m.getGitNick() + "/" + repoName;
		System.out.println(str);
        GHRepository repo = github.getRepository(str);

        // 레포지토리의 OPEN 상태 이슈 목록 가져오기
        List<GHIssue> issues = repo.getIssues(GHIssueState.OPEN);

        // 이슈 목록 출력
        for (GHIssue issue : issues) {
            System.out.println("Issue #" + issue.getNumber() + ": " + issue.getTitle());
        }
    	return "repository/issuesList";
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
        
        if(repo.getReadMe().equals("true")) {
        	builder.autoInit(true);
        }
        
        builder.create();
		
		session.setAttribute("alertMsg", "레파지토리 생성 완료");
		return "redirect:myRepo.re";
	}
	
}
