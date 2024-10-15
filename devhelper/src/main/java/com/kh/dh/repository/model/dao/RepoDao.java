package com.kh.dh.repository.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.dh.repository.model.vo.Repository;

public class RepoDao {
	
	public void insertRepo(SqlSessionTemplate sqlSession, ArrayList<Repository> repoList) {
		for(Repository r : repoList) {
			sqlSession.insert("repositoryMapper.insertRepo", r);
		}
	}

}
