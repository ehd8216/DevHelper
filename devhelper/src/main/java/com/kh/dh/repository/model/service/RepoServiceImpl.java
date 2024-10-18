package com.kh.dh.repository.model.service;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.kohsuke.github.GHRepository;
import org.kohsuke.github.GitHub;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.dh.repository.model.dao.RepoDao;
import com.kh.dh.repository.model.vo.Repositorys;

@Service
public class RepoServiceImpl implements RepoService {
	

	private GitHub github;
	private SimpleDateFormat sdf;
	
	@Autowired
	private RepoDao rDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public void insertRepo(int memNo, String token) throws IOException {
		github = GitHub.connectUsingOAuth(token);
		
		ArrayList<Repositorys> repoList = new ArrayList();
		sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
		Map<String , GHRepository> list = github.getMyself().getRepositories();
		
		for (Map.Entry<String, GHRepository> entry : list.entrySet()) {
			GHRepository repo = entry.getValue();
			
			Repositorys r = new Repositorys();
			r.setMemNo(memNo);
			r.setRepoName(repo.getName());
			r.setRepoDescription(repo.getDescription());
			r.setVisibility(repo.getVisibility().toString());
			r.setCreateDate(sdf.format(repo.getCreatedAt()));
			r.setRepoUrl(repo.getUrl().toString());
			repoList.add(r);
		}
		rDao.insertRepo(sqlSession, repoList);
	}
	
	public ArrayList<Repositorys> selectRepoList(int memNo) {
		return rDao.selectRepoList(sqlSession, memNo);
	}
	
	public ArrayList<Repositorys> getGHRepo(String token, int memNo) throws IOException {
		github = GitHub.connectUsingOAuth(token);
		Map<String , GHRepository> list = github.getMyself().getRepositories();
		ArrayList<Repositorys> repoList = new ArrayList();
		sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
		for (Map.Entry<String, GHRepository> entry : list.entrySet()) {
			GHRepository repo = entry.getValue();
			
			Repositorys r = new Repositorys();
			r.setMemNo(memNo);
			r.setRepoName(repo.getName());
			r.setRepoDescription(repo.getDescription());
			r.setVisibility(repo.getVisibility().toString());
			r.setCreateDate(sdf.format(repo.getCreatedAt()));
			r.setRepoUrl(repo.getUrl().toString());
			repoList.add(r);
		}
		return repoList;
	}
	
	public void insertRepoPlus(Repositorys repo) {
		rDao.insertRepoPlus(sqlSession, repo);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
