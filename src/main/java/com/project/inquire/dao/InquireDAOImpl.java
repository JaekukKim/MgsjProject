package com.project.inquire.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.inquire.domain.InquireDTO;

@Repository
public class InquireDAOImpl implements InquireDAO {

	private static final Logger logger = LoggerFactory.getLogger(InquireDAOImpl.class);

	@Autowired
	private SqlSession sqlSession;

	private static final String NAME_SPACE = "mappers.inquireMapper";

	// 제품 문의 등록
	@Override
	public void inquireWrite(InquireDTO inquireDTO) throws Exception {

		logger.info("제품 문의 등록 inquireWrite - DAO");

		sqlSession.insert(NAME_SPACE + ".inquireWrite", inquireDTO);
	}

	// 제품 문의 조회
	@Override
	public InquireDTO inquireView(int askNum) throws Exception {

		logger.info("제품 문의 조회 inquireView - DAO");

		return sqlSession.selectOne(NAME_SPACE + ".inquireView", askNum);
	}

	// 제품 문의 수정
	@Override
	public void inquireUpdate(InquireDTO inquireDTO) throws Exception {

		logger.info("제품 문의 수정 inquireUpdate - DAO");

		sqlSession.update(NAME_SPACE + ".inquireUpdate", inquireDTO);
	}

	// 제품 문의 삭제
	@Override
	public void inquireDelete(int askNum) throws Exception {

		logger.info("제품 문의 삭제 inquireDelete - DAO");

		sqlSession.delete(NAME_SPACE + ".inquireDelete", askNum);
	}

	// 제품 문의 목록
	@Override
	public List<InquireDTO> inquireList(int pno) throws Exception {
             
		logger.info("제품 문의 목록 inquireList - DAO");

		return sqlSession.selectList(NAME_SPACE + ".inquireList", pno);
	}
}
