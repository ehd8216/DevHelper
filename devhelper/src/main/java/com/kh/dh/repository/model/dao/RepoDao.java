package com.kh.dh.repository.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import com.kh.dh.repository.model.vo.Repositorys;

@Repository
public class RepoDao {
	
	public void insertRepo(SqlSessionTemplate sqlSession, ArrayList<Repositorys> repoList) {
		for(Repositorys r : repoList) {
			sqlSession.insert("repositoryMapper.insertRepo", r);
		}
	}
	
	public ArrayList<Repositorys> selectRepoList(SqlSessionTemplate sqlSession, int memNo) {
		return (ArrayList)sqlSession.selectList("repositoryMapper.selectRepoList", memNo);
	}

}
