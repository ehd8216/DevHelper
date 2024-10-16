package com.kh.dh.repository.model.service;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Map;

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
			
			String url = repo.getUrl().toString().substring(29);
			
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
	
//	public ArrayList<Repository> selectMemRepoList(int memNo) {
//		
//		
//	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
