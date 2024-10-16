package com.kh.dh.repository.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.kohsuke.github.GHIssue;
import org.kohsuke.github.GHIssueState;
import org.kohsuke.github.GHPermissionType;
import org.kohsuke.github.GHBranch;
import org.kohsuke.github.GHCommit;
import org.kohsuke.github.GHContent;
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
import com.kh.dh.repository.model.vo.Branch;
import com.kh.dh.repository.model.vo.Commit;
import com.kh.dh.repository.model.vo.RepoDirectory;
import com.kh.dh.repository.model.vo.Repositorys;

@Controller
public class RepoController {
	
	private GitHub github; 
	
	private SimpleDateFormat sdf;
	
	// 전체 레파지토리 조회
	@RequestMapping("myRepo.re")
	public String myRepo(HttpSession session) throws IOException {
		
		if(session.getAttribute("loginMember") == null) {
			session.setAttribute("alertMsg", "로그인 후 이용 가능합니다.");
			return "redirect:/";
		}else {
			String token = (String)session.getAttribute("token");
			github = GitHub.connectUsingOAuth(token);
			
			ArrayList<Repositorys> repoList = new ArrayList();
			sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
			Map<String , GHRepository> list = github.getMyself().getRepositories();
			
			for (Map.Entry<String, GHRepository> entry : list.entrySet()) {
				GHRepository repo = entry.getValue();
				
				String url = repo.getUrl().toString().substring(29);
				
				Repositorys r = new Repositorys();
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
	public String repoDetail(String repoUrl, HttpSession session) throws IOException {
		github = GitHub.connectUsingOAuth((String)session.getAttribute("token"));
		String url = repoUrl.substring(29);
		GHRepository repo = github.getRepository(url);
		String[] str = url.split("/");

        // 첫 번째 부분만 출력
        String writer = str[0];
        
        // 레포 폴더 뽑기
        List<GHContent> contents = repo.getDirectoryContent("");
        ArrayList<RepoDirectory> list = new ArrayList<RepoDirectory>();
        for (GHContent content : contents) {
        	RepoDirectory rd = new RepoDirectory();
        	rd.setDirName(content.getName());
        	if(content.isFile()) {
        		rd.setIsFile("true");
        	}else {
        		rd.setIsFile("false");
        	}
        	list.add(rd);
        }
        
        // 브랜치 리스트 뽑기
        Map<String, GHBranch> branches = repo.getBranches();
        ArrayList<Branch> bList = new ArrayList<Branch>();
        
        for (String branchName : branches.keySet()) {
        	Branch b = new Branch();
        	b.setBranchName(branchName);
        	bList.add(b);
        }
		session.setAttribute("repo", repo);
		session.setAttribute("writer", writer);
		session.setAttribute("url", url);
		session.setAttribute("repoDirectory", list);
		session.setAttribute("bList", bList);
		return "repository/repoDetail";
	}
	

	@RequestMapping("issueslist.re")
	public ModelAndView issueslist(String repoName,String writer,HttpSession session, ModelAndView mv) throws IOException
	{

		github = GitHub.connectUsingOAuth((String)session.getAttribute("token"));
		String url = writer + "/" + repoName;
		GHRepository repo = github.getRepository(url);
        
        // 레포지토리의 OPEN 상태 이슈 목록 가져오기
        List<GHIssue> issues = repo.getIssues(GHIssueState.OPEN);
        mv.addObject("issues", issues)
          .addObject("writer", writer)
          .addObject("repoName", repoName)
		  .setViewName("repository/issuesList");
		//포워딩 => WEB-INF/views/board/boardListView
		return mv;
	}
	@RequestMapping(value = "issuesInsert.re")
	public String createIssue(String repoName,String writer, String title, String body, HttpSession session, ModelAndView mv) throws IOException {
	    GitHub github = GitHub.connectUsingOAuth((String)session.getAttribute("token"));
	    String url = writer + "/" + repoName;
	    GHRepository repo = github.getRepository(url);
	    // 이슈 생성
	    GHIssue issue = repo.createIssue(title)
	                        .body(body)
	                        .create();
	    
	    // 생성된 이슈를 다시 가져오거나 이슈 리스트 페이지로 리다이렉트
		/* mv.setViewName("redirect:/issuesList?repoName="); */
	    return "redirect:issueslist.re?repoName=" + repoName + "&writer=" + writer ;
	}
	@RequestMapping(value = "issuesDetail.re")
	public String issuesDetail(int issueNum,String writer,String repoName, HttpSession session,HttpServletRequest request) throws IOException
	{
	    GitHub github = GitHub.connectUsingOAuth((String)session.getAttribute("token"));
	    String url = writer + "/" + repoName;
	    System.out.println(url);
	    GHRepository repo = github.getRepository(url);
	    GHIssue issueDe = repo.getIssue(issueNum);
	    request.setAttribute("issueDe", issueDe);
		return "repository/issuesDetail";
	}
	@RequestMapping("createRepo.re")
	public String createRepo(Repositorys repo, HttpSession session) throws IOException {
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
	public String deleteRepo(String repoUserUrl, HttpSession session) throws IOException {
		// 현재 토큰 받아오는 코드로 가져온 토큰값이 삭제 권한이 없어 삭제기능은 실현 불가능 이슈
		
		session.setAttribute("alertMsg", "레파지토리 삭제 완료");
		return "redirect:myRepo.re";
	}
	
	@RequestMapping("inviteRepo.re")
	public String inviteRepo(String inviteUserName, String repoUserUrl, HttpSession session) throws IOException {
		github = GitHub.connectUsingOAuth((String)session.getAttribute("token"));
		GHRepository repo = github.getRepository(repoUserUrl);
		
		GHUser userToInvite = github.getUser(inviteUserName);
		
		repo.addCollaborators(userToInvite);
		
		session.setAttribute("alertMsg", "초대 성공");
		return "redirect:myRepo.re";
	}
	
	@RequestMapping("commitList.re")
	public String commitList(String repoUserUrl, HttpSession session) throws IOException {
		github = GitHub.connectUsingOAuth((String)session.getAttribute("token"));
		GHRepository repo = github.getRepository(repoUserUrl);
		String[] str = repoUserUrl.split("/");
		
		// commit 리스트 뽑기
        sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
        ArrayList<Commit> list = new ArrayList<>();
        for (GHCommit commit : repo.listCommits()) {
        	Commit c = new Commit();
        	c.setComAuthor(commit.getCommitShortInfo().getAuthor().getName());
        	c.setComMessage(commit.getCommitShortInfo().getMessage());
        	c.setComDate(sdf.format(commit.getCommitDate()));
        	c.setSHA(commit.getSHA1().substring(0, 11));
        	list.add(c);
        }
        session.setAttribute("repoName", str[1]);
		session.setAttribute("commitList", list);
		return "repository/commitList";
	}
	
	@RequestMapping("branchDetail.re")
	public String branchDetail(String branchName, HttpSession session) throws IOException {
		github = GitHub.connectUsingOAuth((String)session.getAttribute("token"));
		GHRepository repo = github.getRepository((String)session.getAttribute("url"));
        
        List<GHContent> contents = repo.getDirectoryContent("/", branchName);
        ArrayList<RepoDirectory> list = new ArrayList<RepoDirectory>();

        for (GHContent content : contents) {
        	RepoDirectory rd = new RepoDirectory();
        	rd.setDirName(content.getName());
        	if(content.isFile()) {
        		rd.setIsFile("true");
        	}else {
        		rd.setIsFile("false");
        	}
        	list.add(rd);
        }
        
        session.setAttribute("bDirectory", list);
		session.setAttribute("branchName", branchName);
		return "repository/repoBranchDetail";
	}
	
	@RequestMapping("bCommitList.re")
	public String bCommitList(String branchName, HttpSession session) throws IOException {
		github = GitHub.connectUsingOAuth((String)session.getAttribute("token"));
		String url = (String)session.getAttribute("url");
		GHRepository repo = github.getRepository(url);
		String[] str = url.split("/");
		List<GHCommit> commits = repo.queryCommits().from(branchName).list().toList();
		
		// commit 리스트 뽑기
        sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
        ArrayList<Commit> list = new ArrayList<>();
        for (GHCommit commit : commits) {
        	Commit c = new Commit();
        	c.setComAuthor(commit.getCommitShortInfo().getAuthor().getName());
        	c.setComMessage(commit.getCommitShortInfo().getMessage());
        	c.setComDate(sdf.format(commit.getCommitDate()));
        	c.setSHA(commit.getSHA1().substring(0, 11));
        	list.add(c);
        }
        session.setAttribute("repoName", str[1]);
		session.setAttribute("commitList", list);
		return "repository/commitList";
	}
	
	@RequestMapping("branch.re")
	public String branch(String repoUserUrl, HttpSession session) throws IOException {
		github = GitHub.connectUsingOAuth((String)session.getAttribute("token"));
		GHRepository repo = github.getRepository(repoUserUrl);
		String[] str = repoUserUrl.split("/");
		
		Map<String, GHBranch> branches = repo.getBranches();
        ArrayList<Branch> bList = new ArrayList<Branch>();
        
        for (String branchName : branches.keySet()) {
        	Branch b = new Branch();
        	b.setBranchName(branchName);
        	
        	List<GHCommit> commits = repo.queryCommits().from(branchName).list().toList();
			sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
	        for (GHCommit commit : commits) {
	        	b.setUpdateDate(sdf.format(commit.getCommitDate()));
	        	break;
	        }
        	
        	bList.add(b);
        }
        
		session.setAttribute("bList", bList);
		session.setAttribute("repoName", str[1]);
		return "repository/branch";
	}
	
	@RequestMapping("deleteBranch.re")
	public String deleteBranch(String branchName, HttpSession session) throws IOException {
		String userUrl = (String)session.getAttribute("url");
		String[] str = userUrl.split("/");
		
		String url = String.format("https://api.github.com/repos/%s/%s/git/refs/heads/%s", str[0], str[1], branchName);
		WebClient client = WebClient.create();

        client.delete()
                .uri(url)
                .header(HttpHeaders.AUTHORIZATION, "Bearer " + (String)session.getAttribute("token"))
                .header(HttpHeaders.ACCEPT, MediaType.APPLICATION_JSON_VALUE)
                .retrieve()
                .bodyToMono(Void.class)
                .block();
        
        return "repository/branch";
	}
	
	
	
}
