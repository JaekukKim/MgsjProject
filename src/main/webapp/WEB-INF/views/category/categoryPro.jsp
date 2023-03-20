<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 정상적으로 로그인이 되었는지 확인할수있는 파라미터값 = result -->
<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>상품목록</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="${contextPath}/resources/category/category2.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
</head>
<body>
	<!-- header -->
	<jsp:include page="../pageIngredient/header.jsp" flush="false"></jsp:include>
	<!-- header -->

	<div class="category">

		<div class="category-left">
			<div class="category-title">
				<h2>Category</h2>
				<br>
				<hr>
				<ul>
					<c:forEach var="categoryList1" items="${categoryList1}">
						<!-- 대분류 -->
						<li>
							<a href="#" class="dropdown-btn">
								<c:out value="${categoryList1.categoryName}" />
								<!-- 대분류 이름 -->
							</a>
							<ul class="dropdown_menu dropdown_menu_end" style="display: none;">
								<c:forEach var="categoryList2" items="${categoryList2}">
									<!-- 소분류 -->
									<c:if test="${categoryList2.categoryLevel == categoryList1.cno}">
										<li>
											<a href="/category/categoryPro?cno=${categoryList2.cno}" class="dropdown-btn-detail">
												<c:out value="${categoryList2.categoryName}" />
												<!-- 소분류 이름 -->
											</a>
										</li>
									</c:if>
								</c:forEach>
							</ul>
					</c:forEach>
					<li>
				</ul>
			</div>
		</div>

		<div class="small-container">

			<div class="row-1">
				<h2>Products</h2>
			</div>
			<div class="upper-row">
				<c:forEach var="categoryDTO" items="${categoryDTO}">
					<div class="cate-row">
						<div class="col-4">
							<a href="/product/productView?pno=${categoryDTO.pno }">
								<img src="${categoryDTO.storedFileName}" alt="상품 이미지 로딩 실패">
							</a>
							<h4>${categoryDTO.productName}</h4>
							<p>${categoryDTO.productPrice}원</p>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>

	<!-- footer -->
	<jsp:include page="../pageIngredient/footer.jsp" flush="false"></jsp:include>
	<!-- footer -->

	<script>
		var dropdown = document.getElementsByClassName ( "dropdown-btn" );
		var i;

		for ( i = 0; i < dropdown.length; i++ ) {
			dropdown[i].addEventListener ( "click" , function () {
				this.classList.toggle ( "active" );
				var dropdownContent = this.nextElementSibling;
				if ( dropdownContent.style.display === "block" ) {
					dropdownContent.style.display = "none";
				} else {
					dropdownContent.style.display = "block";
				}
			} );
		}
	</script>
</body>
</html>