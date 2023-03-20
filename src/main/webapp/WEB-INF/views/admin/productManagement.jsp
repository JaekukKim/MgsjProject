<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.project.board.domain.PageIngredient" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>상품 관리 페이지</title>
</head>
<link rel="stylesheet" type="text/css" href="/resources/admin/adminPage.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<body>
<!-- header -->        
<jsp:include page="../pageIngredient/header.jsp" flush="false"></jsp:include>
<!-- header -->

	<div id="boardGroup">
		<h1>상품 목록 (관리자)</h1>
		<!-- 게시글 검색기능 -->
		<%
		PageIngredient pageIngredient = (PageIngredient) request.getAttribute("page");
		%>
		<div>
			<select class="searchType" name="searchType" onchange="changeInputTag();">
				<option value="productName" <%=pageIngredient.getSearchType().equals("productName") ? "selected" : ""%>>상품이름</option>
				<option value="cno" <%=pageIngredient.getSearchType().equals("cno") ? "selected" : ""%>>상품종류</option>
			</select>
			<input type="text" id="keyword" class="keyword" name="keyword" value="<%=pageIngredient.getKeyword()%>" onkeyup="enterSearching();">
			<button id="searchingActivate" type="button" onclick="searchingActivate();">검색</button>
		</div>
		<!-- 게시글 검색기능 끝 -->
		<table>
			<thead>
				<tr>
					<th style="width: 80px;">상품번호</th>
					<th style="width: 150px;">상품이미지</th>
					<th style="width: 300px;">상품이름</th>
					<th style="width: 150px;">상품가격</th>
					<th style="width: 150px;">상품재고</th>
					<th style="width: 150px;">상품등록일</th>
					<th style="width: 80px;">상품관리</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${productList }" var="productList">
					<tr>
						<td>${productList.pno }</td>
						
						<td>
							<img alt=""${productList.productName } 
							src="${productList.storedFileName }"
							width="130px"
							height="130px">
						</td>
						
						<td>
							<a href="/product/productView?pno=${productList.pno }">${productList.productName }</a>
						</td>
						
						<td>${productList.productPrice }</td>
						
						<td>${productList.productStock }</td>
						
						<td>
							<fmt:formatDate value="${productList.productRegDate }" pattern="yyyy-MM-dd" />
						</td>
						
						<td>
							<a href="">[상품수정]</a>
							<br>
							<a href="javascript:deleteProductList('${productList.pno }')">[상품삭제]</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>


		<!-- 페이징 시작 -->
		<%
		int selectedPageNum = (int) request.getAttribute("selectedPageNum");

		/* 이전페이지 버튼만들기 */
		if (pageIngredient.isPrevPage() == true) {
		%>
		<span>
			<a href="/admin/productManagement?pageNum=<%=pageIngredient.getStartPage() - 1%><%=pageIngredient.getSearchTypeAndKeyword()%>">◀이전</a>
		</span>
		<%
		}

		/* 페이지 쫙(1,2,3,4...) 출력하기 */
		for (int i = pageIngredient.getStartPage(); i <= pageIngredient.getEndPage(); i++) {

		if (selectedPageNum != i) {
		%>
		<span>
			<a id="notSelectedPage" href="/admin/productManagement?pageNum=<%=i%><%=pageIngredient.getSearchTypeAndKeyword()%>"><%=i%></a>
		</span>
		<%
		} else if (selectedPageNum == i) {
		%>
		<span>
			<b style="font-size: 22px"><%=i%></b>
		</span>
		<%
		}
		}

		/* 다음버튼 만들기 */
		if (pageIngredient.isNextPage() == true) {
		%>
		<span>
			<a href="/admin/productManagement?pageNum=<%=pageIngredient.getEndPage() + 1%><%=pageIngredient.getSearchTypeAndKeyword()%>">다음▶</a>
		</span>
		<%
		}
		%>
		<!-- 페이징 끝 -->
	</div>
	
<!-- footer -->        
<jsp:include page="../pageIngredient/footer.jsp" flush="false"></jsp:include>
<!-- footer -->
</body>
<script type="text/javascript" src="/resources/admin/product/adminProduct.js"></script>
</html>