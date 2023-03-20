package com.project.product.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.product.domain.ProductDTO;

@Repository
public class ProductDAOImpl implements ProductDAO {

	private static final Logger logger = LoggerFactory.getLogger(ProductDAOImpl.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	private static final String NAME_SPACE = "mappers.productMapper";
	
	private static final String NAME_SPACE_ADMIN = "mappers.adminMapper";
	
	// 상품 게시글 등록하기
	@Override
	public void productWrite(ProductDTO productDTO) throws Exception {
		
		logger.info("상품 게시글 등록하기 productWrite - productDAO");
		
		sqlSession.insert(NAME_SPACE + ".productWrite", productDTO);
	}
	
	// 상품 게시글 삭제하기
	@Override
	public void productDelete(int pno) throws Exception {
		
		logger.info("상품 게시글 삭제하기 productDelete - productDAO");
		
		// 리뷰테이블 먼저 삭제
		// 장바구니 삭제 (쿠키면 생략해도됨 - 테이블일 경우에만)
		// 주문 세부정보 삭제
		// 제품 문의 글 삭제
		
		sqlSession.delete(NAME_SPACE + ".productDelete", pno);
	}
	
	// 상품 게시글 수정하기
	@Override
	public void productUpdate(ProductDTO productDTO) throws Exception {
		
		logger.info("상품 게시글 수정하기 productUpdate - productDAO");
		
		sqlSession.update(NAME_SPACE + ".productUpdate", productDTO);
	}
	
	// 상품 게시글 상세조회
	@Override
	public ProductDTO productView(int pno) throws Exception {
		
		logger.info("상품 게시글 상세조회 productDetail - productDAO");
		
		return sqlSession.selectOne(NAME_SPACE + ".productView", pno);
	}
	
	// 상품 게시글 목록
	@Override
	public List<ProductDTO> productList() throws Exception {
		
		logger.info("상품 게시글 목록 productList - productDAO");
		
		return sqlSession.selectList(NAME_SPACE + ".productList");
	}
	
	// -------------------------------------관리자-------------------------------------
	// 상품 목록 : 검색 + 페이징 + 리스트
	@Override
	public List<ProductDTO> getProductList(int displayTotalContent, int pageContent, String searchType, String keyword) {
		
		logger.info("관리자 상품 목록 getProductList - productDAO");
		
		HashMap<String, Object> productPageData = new HashMap<>();
		productPageData.put("displayTotalContent", displayTotalContent);
		productPageData.put("pageContent", pageContent);
		productPageData.put("searchType", searchType);
		productPageData.put("keyword", keyword);
		
		return sqlSession.selectList(NAME_SPACE_ADMIN + ".adminProductList", productPageData);
	}
	
	// 검색 결과에 따른 상품 목록 출력
	@Override
	public int totalSearchProduct(String searchType, String keyword) throws Exception {
		
		HashMap<String, String> productPageData = new HashMap<>();

		productPageData.put("searchType", searchType);
		productPageData.put("keyword", keyword);
		
		return sqlSession.selectOne(NAME_SPACE_ADMIN + ".totalSearchProduct", productPageData);
	}
	
	// 관리자 상품 삭제
	@Override
	public void adminProductDelete(int pno) throws Exception {
		
		logger.info("관리자 상품 삭제, 삭제된 상품 번호 : {}", pno);
		
		sqlSession.delete(NAME_SPACE_ADMIN + ".adminProductDelete", pno);
	}
}
