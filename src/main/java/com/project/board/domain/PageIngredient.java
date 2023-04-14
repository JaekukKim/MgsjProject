package com.project.board.domain;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class PageIngredient {

	private static final Logger logger = LoggerFactory.getLogger(PageIngredient.class);

	private int pageNum; // 현재 페이지 번호
	private int totalContent; // 전체 게시글의 갯수
	private int contentNum; // 출력할 게시글의 갯수
	private int totalPageNum; // 전체 페이지의 수
	private int startContentNum; // 페이지당 출력할 게시글의 수
	private int maxPageNum; // 한 화면에 출력되는 페이지의 갯수
	private int startPage; // 한 화면에 출력되는 페이지 중 시작 페이지의 숫자
	private int endPage; // 한 화면에 출력되는 페이지 중 끝 페이지의 숫자
	private boolean prevPage; // 이전페이지 버튼
	private boolean nextPage; // 다음페이지 버튼

	// 검색기능을 위한 검색어 관리. (검색타입 : select 태그, 검색어 : input-text 태그)
	private String searchType;
	private String keyword;
	private String searchTypeAndKeyword;

	// 생성자 오버로딩시 기본생성자 필수.
	public PageIngredient() {

	}

	// 생성자로 원하는 수만큼 데이터를 출력할 수 있게 만들어줌.
	public PageIngredient(int contentNum, int maxPageNum) {
		this.contentNum = contentNum;
		this.maxPageNum = maxPageNum;
	}

	// 페이징 getter, setter
	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getTotalContent() {
		return totalContent;
	}

	public void setTotalContent(int totalContent) {
		this.totalContent = totalContent;
		logger.info("페이지 관련 객체 호출 및 페이징 시작");

		calculatePage();
	}

	public int getContentNum() {
		return contentNum;
	}

	public void setContentNum(int contentNum) {
		this.contentNum = contentNum;
	}

	public int getTotalPageNum() {
		return totalPageNum;
	}

	public void setTotalPageNum(int totalPageNum) {
		this.totalPageNum = totalPageNum;
	}

	public int getStartContentNum() {
		return startContentNum;
	}

	public void setStartContentNum(int startContentNum) {
		this.startContentNum = startContentNum;
	}

	public int getMaxPageNum() {
		return maxPageNum;
	}

	public void setMaxPageNum(int maxPageNum) {
		this.maxPageNum = maxPageNum;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isPrevPage() {
		return prevPage;
	}

	public void setPrevPage(boolean prevPage) {
		this.prevPage = prevPage;
	}

	public boolean isNextPage() {
		return nextPage;
	}

	public void setNextPage(boolean nextPage) {
		this.nextPage = nextPage;
	}

	// 검색타입, 검색어, 쿼리파라미터에 보낼 변수 getter, setter
	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	// 페이징을 본격적으로 구현하는 로직
	private void calculatePage() {

		// 전체 페이지의 갯수
		totalPageNum = (int) Math.ceil((double) totalContent / contentNum);

		// 출력할 게시물 갯수
		startContentNum = (pageNum - 1) * contentNum;

		// 마지막 페이지
		endPage = (int) (Math.ceil((double) pageNum / maxPageNum) * maxPageNum);

		// 실질적인 값을 담고있는 마지막 페이지
		int correctLastPage = (int) (Math.ceil((double) totalContent / maxPageNum));

		// 시작페이지
		startPage = endPage - maxPageNum + 1;

		if (endPage > correctLastPage) {
			endPage = correctLastPage;
		}

		// 이전버튼 : 시작페이지가 10 이상일때.
		if (startPage > maxPageNum) {
			prevPage = true;
		} else {
			prevPage = false;
		}

		// 다음버튼 : 해당 화면의 끝 페이지가 "전체 페이지 수"보다 작으면 활성화
		if (endPage < totalPageNum) {
			nextPage = true;
		} else {
			nextPage = false;
		}

	}

	public String getSearchTypeAndKeyword() {
		return searchTypeAndKeyword;
	}

	// 검색기능에 대한 결과 출력 (쿼리스트링의 파라미터로 보낼 값을 메소드로)
	public void setSearchTypeAndKeyword(String searchType, String keyword) {
		/*
		 * 검색타입이나 검색어가 없다면 공란을 리턴 
		 * 있다면 그 값을 쿼리스트링으로 보냄
		 */
		if (searchType.equals("") || keyword.equals("")) {
			searchTypeAndKeyword = "";
			logger.info("검색타입과 검색어를 쿼리파라미터로 전달(-아무것도 입력하지 않음-)");
		} else {
			// &searchType=writer&keyword=33
			searchTypeAndKeyword = "&searchType=" + searchType + "&keyword=" + keyword;
			logger.info("검색타입과 검색어를 쿼리파라미터로 전달(-검색타입과 검색어가 들어옴-)");
		}

	}

	@Override
	public String toString() {
		return "PageIngredient [totalContent=" + totalContent + ", contentNum=" + contentNum + ", totalPageNum=" + totalPageNum + ", startContentNum="
				+ startContentNum + ", maxPageNum=" + maxPageNum + ", startPage=" + startPage + ", endPage=" + endPage + ", prevPage=" + prevPage
				+ ", nextPage=" + nextPage + "]";
	}

}
