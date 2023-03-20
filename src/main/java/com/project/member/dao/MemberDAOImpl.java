package com.project.member.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.member.domain.MemberAddressDTO;
import com.project.member.domain.MemberDTO;

@Repository
public class MemberDAOImpl implements MemberDAO {

	private static final Logger logger = LoggerFactory.getLogger(MemberDAOImpl.class);

	@Autowired
	private SqlSession sqlSession;

	private static final String NAME_SPACE = "mappers.memberMapper";
	
	private static final String NAME_SPACE_ORDER = "mappers.orderMapper";

	private static final String NAME_SPACE_ADMIN = "mappers.adminMapper";

	// 회원가입 로직 구현
	@Override
	public void signUpMember(MemberDTO memberDTO, MemberAddressDTO memberAddressDTO) throws Exception {
		logger.info("회원가입 실행 signUpMember - (DAO)");

		sqlSession.insert(NAME_SPACE + ".signUpAddress", memberAddressDTO);

		sqlSession.insert(NAME_SPACE + ".signUpMember", memberDTO);
	}

	// 로그인 로직 구현
	@Override
	public MemberDTO memberLogin(MemberDTO memberDTO) throws Exception {

		logger.info("로그인 실행 memberLogin - (DAO)");

		return sqlSession.selectOne(NAME_SPACE + ".memberLogin", memberDTO);
	}

	// 정보수정 로직
	@Override
	public void memberModify(MemberDTO memberDTO) throws Exception {

		logger.info("회원정보 수정 memberModify - DAO");

		sqlSession.update(NAME_SPACE + ".memberModify", memberDTO);
	}

	// 아이디 중복검사 로직
	@Override
	public int checkDuplicateId(String userId) throws Exception {

		logger.info("아이디 중복검사 수행 checkDuplicateId - DAO : {}", userId);

		return sqlSession.selectOne(NAME_SPACE + ".checkDuplicateId", userId);
	}
	
	// 아이디 찾기
	@Override
	public MemberDTO memberFindId(MemberDTO memberDTO) throws Exception {
		
		logger.info("회원 아이디 찾기 실행 - DAO : {}", memberDTO);
		
		return sqlSession.selectOne(NAME_SPACE + ".memberFindId", memberDTO);
	}
	
	// 비밀번호 찾기
	@Override
	public MemberDTO memberFindPwd(MemberDTO memberDTO) throws Exception {
		
		logger.info(NAME_SPACE + ".memberFindPwd", memberDTO);
		
		return sqlSession.selectOne(NAME_SPACE + ".memberFindPwd", memberDTO);
	}
	
	// 회원 탈퇴
	@Override
	public void removeMember(MemberDTO memberDTO) throws Exception {
		
		logger.info("회원탈퇴 시작");
		
		sqlSession.delete(NAME_SPACE_ORDER + ".removerMemberOrder", memberDTO.getUserId()); 
		
		sqlSession.selectOne(NAME_SPACE + ".removeMember", memberDTO);
	}
	
	// 회원 탈퇴를 위한 비밀번호 검증
	@Override
	public String getUserPwd(String userId) throws Exception {
		
		logger.info("회원탈퇴 비밀번호 검증");
		
		return sqlSession.selectOne(NAME_SPACE + ".getUserPwd", userId);
	}
	
	// ---------------관리자---------------
	// 회원 관리를 위한 회원 리스트 가져오기
	@Override
	public List<MemberDTO> getMemberList(int displayTotalContent, int pageContent, String searchType, String keyword) throws Exception {

		logger.info("회원 리스트 가져오기(관리자) getMemberList - DAO");

		HashMap<String, Object> memberPageData = new HashMap<>();
		memberPageData.put("displayTotalContent", displayTotalContent);
		memberPageData.put("pageContent", pageContent);
		memberPageData.put("searchType", searchType);
		memberPageData.put("keyword", keyword);

		return sqlSession.selectList(NAME_SPACE_ADMIN + ".getMemberList", memberPageData);
	}

	// 회원 검색 기능
	@Override
	public int totalSearchMember(String searchType, String keyword) throws Exception {

		logger.info("회원 검색 시작 (관리자) totalSearchMember - DAO");

		HashMap<String, String> memberSearchData = new HashMap<>();

		memberSearchData.put("searchType", searchType);
		memberSearchData.put("keyword", keyword);

		return sqlSession.selectOne(NAME_SPACE_ADMIN + ".totalSearchMember", memberSearchData);
	}

}
