<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- 반응형 기능 -->
<link rel="stylesheet" href="/resources/mainpage/main.css">

<title>MGSJ</title>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/resources/mainpage/swiper-bundle.css">
</head>
<body>
	<!-- header -->
	<jsp:include page="../pageIngredient/header.jsp" flush="false"></jsp:include>
	<!-- header -->

	<div class="wrap">
		<!-- banner -->
		<div class="small-container-ba">
			<div class="row">
				<div class="swiper" align="center">
					<div class="swiper-wrapper">
						<div class="swiper-slide">
							<img src="${pageContext.request.contextPath}/resources/mgsjimages/mainimages/banner1.jpg">
						</div>
						<div class="swiper-slide">
							<img src="${pageContext.request.contextPath}/resources/mgsjimages/mainimages/banner2.jpg">
						</div>
						<div class="swiper-slide">
							<img src="${pageContext.request.contextPath}/resources/mgsjimages/mainimages/banner3.jpg">
						</div>
						<div class="swiper-slide">
							<img src="${pageContext.request.contextPath}/resources/mgsjimages/mainimages/banner4.jpg">
						</div>
						<div class="swiper-slide">
							<img src="${pageContext.request.contextPath}/resources/mgsjimages/mainimages/banner5.jpg">
						</div>
					</div>
					<div class="swiper-pagination"></div>
					<div class="swiper-button-prev"></div>
					<div class="swiper-button-next"></div>
					<div class="swiper-scrollbar"></div>
				</div>
			</div>
		</div>
		<!-- banner -->

		<!---------------- item ---------------------------------------->
		<div class="small-container">
			<h2 class="title">먹고사는 즐거움</h2>
			<div class="row">
				<c:forEach var="mainPageProductList" items="${mainPageProductList }" begin="28" end="34" step="3">
					<div class="col-4">
						<a href="/product/productView?pno=${mainPageProductList.pno }">
							<img src="${mainPageProductList.storedFileName}" alt="상품이미지로딩실패">
						</a>
						<br>
						<a href="/product/productView?pno=${mainPageProductList.pno }" class="product_name">${mainPageProductList.productName }</a>
						<br>
						<p class="product_price">${mainPageProductList.productPrice }원</p>
					</div>
				</c:forEach>
			</div>
		</div>
		<div class="small-container">
			<h2 class="title">많이 구매한 제품</h2>
			<div class="row">

				<c:forEach var="mainPageProductList" items="${mainPageProductList }" begin="14" end="16">
					<div class="col-4">
						<a href="/product/productView?pno=${mainPageProductList.pno }">
							<img src="${mainPageProductList.storedFileName }" alt="상품이미지로딩실패">
						</a>
						<br>
						<a href="/product/productView?pno=${mainPageProductList.pno }" class="product_name">${mainPageProductList.productName }</a>
						<br>
						<p class="product_price">${mainPageProductList.productPrice }원</p>

					</div>
				</c:forEach>
			</div>
		</div>

	</div>

	<!-- footer -->
	<jsp:include page="../pageIngredient/footer.jsp" flush="false"></jsp:include>
	<!-- footer -->


	<!-- 배너 js -->
	<script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>

	<script src="/resources/mainpage/main.js"></script>

</body>
</html>