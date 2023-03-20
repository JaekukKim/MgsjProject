<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.project.product.domain.ProductDTO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- 반응형 기능 -->
<title>${productDTO.productName}</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css" />
<link rel="stylesheet" href="/resources/product/productView.css">
<!-- navbar 클릭시 이동 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="${contextPath}/resources/product/js/animatescroll.js"></script>
<script src="/resources/product/js/productView.js"></script>
</head>
<body>

	<!-- 헤더 -->
	<jsp:include page="../pageIngredient/header.jsp" flush="false"></jsp:include>

	<!--상세페이지 시작-->

	<div class="small-container single-product">
		<div class="row">

			<div class="col-2">
				<!-- 
           private String originFileName;
           private String storedFileName;
           private String storedThumbNail;
           -->
				<img id="resultimg" src="${productDTO.storedFileName}" alt="상품 이미지 로딩 실패">
			</div>


			<div class="col-2">
				<form id="form-cart" action="/cart/cartWrite" method="post">
					<!-- cart에 필요한 데이터 -->
					<input type="hidden" name="userId" value="${memberInfo.userId}" />
					<input type="hidden" name="pno" value="${productDTO.pno}" />
					<h1>${productDTO.productName}</h1>
					<h4>
						<fmt:formatNumber value="${productDTO.productPrice}" pattern="###,###,###" />
						원
					</h4>
					<input type="number" class="numbox" min="1" max="${productDTO.productStock}" value="1" name="productCnt" />
					<button type="submit" class="btn">
						<a style="color: #fff; font-size: 16px;" onclick="alert('장바구니에 담겼습니다');">
							장바구니
							<a>
					</button>
					<a href="/order/orderList" class="btn">주문하기</a>
					<h3>배송비 : 3000원</h3>
				</form>
			</div>

		</div>
	</div>


	<div class="small-container">
		<!--navbar-->
		<div class="small-container">
			<div id="navbar">
				<a type="button" onclick="$('.box1').animatescroll();">상품상세정보</a>
				<a type="button" onclick="$('.box2').animatescroll();">리뷰</a>
				<a type="button" onclick="$('.box3').animatescroll();">제품문의</a>
			</div>
		</div>

		<!-- 상품 상세 정보 영역 -->
		<div class="small-container">
			<div class="box1">
				<div class="titlearea">상품상세정보</div>
				<div>${productDTO.productDescription}</div>
			</div>
			<!--box1끝-->

			<!--리뷰목록-->
			<div class="box2" id="reviewBoard">
				<div class="titlearea">리뷰</div>
				<table class="list" align="center">
					<tr>
						<th width="80px">제목</th>
						<th width="80px">상품명</th>
						<th width="240px">리뷰내용</th>
						<th width="40px">작성자</th>
						<th width="80px">등록일</th>
					</tr>
					<c:forEach var="reviewList" items="${reviewList}">
						<tr>
							<td>${reviewList.rvTitle}</td>
							<td>${reviewList.productName}</td>
							<td>${reviewList.rvContent}</td>
							<td>${reviewList.rvWriter}</td>
							<td>
								<fmt:formatDate value="${reviewList.rvRegDate}" pattern="yyyy-MM-dd" />
							</td>
						</tr>
					</c:forEach>
				</table>

				<br>
				
				<!-- 리뷰 등록 -->
				<table class="comment">
					<td width="70%" class="writeCommentForm">
						<div>
							<c:choose>
								<c:when test="${memberInfo != null }">
									<input id="rvWriter" class="inquireContent" name="rvWriter" value="${memberInfo.userId}" readonly></input>
								</c:when>
								<c:otherwise>
									<input id="rvWriter" class="inquireContent" name="rvWriter" value="" placeholder="작성자를 입력해주세요"></input>
								</c:otherwise>
							</c:choose>
						</div>
						<div>
							<input id="rvTitle" class="inquireContent" name="rvTitle" placeholder="제목을 입력하세요"></input>
						</div>
						<div>
							<textarea id="rvContent" name="rvContent" rows="6" cols="100%" placeholder="문의 내용"></textarea>
						</div>
					</td>
					<td width="10%" style="background-color: #FFF; font-size: 20px; font-weight: bold; border-left: 1px solid #b9b9b9;">
						<div style="text-align: center;">
							<a href="javascript:writeReview('${productDTO.pno}')">등록</a>
						</div>
					</td>
				</table>
			</div>
			<!--box2끝-->

			<!--제품문의-->
			<div class="box3">
				<div class="titlearea">제품문의</div>
				<table class="list">
					<tr>
						<th width="40px">번호</th>
						<th width="80px">제품이름</th>
						<th width="80px">답변상태</th>
						<th width="240px">제목</th>
						<th width="80px">등록일</th>
					</tr>
					<c:forEach var="inquireList" items="${inquireList}">
						<tr>
							<td>${inquireList.askNum}</td>
							<td>${inquireList.productName}</td>
							<td>답변완료</td>
							<td>${inquireList.askTitle}</td>
							<td>
								<fmt:formatDate value="${inquireList.askRegDate}" pattern="yyyy-MM-dd" />
							</td>
						</tr>
					</c:forEach>
				</table>

				<br>

				<table class="comment" id="inquire">
					<td width="70%" class="writeCommentForm">
						<div>
							<c:choose>
								<c:when test="${memberInfo != null }">
									<input id="inquierUserId" class="inquireContent" name="userId" value="${memberInfo.userId}" readonly></input>
								</c:when>
								<c:otherwise>
									<input id="inquierUserId" class="inquireContent" name="userId" value="" placeholder="작성자를 입력해주세요"></input>
								</c:otherwise>
							</c:choose>
						</div>
						<div>
							<input id="inquierTitle" class="inquireContent" name="askTitle" placeholder="제목을 입력하세요"></input>
						</div>
						<div>
							<textarea id="inquierContent" name="askContent" rows="6" cols="100%" placeholder="문의 내용"></textarea>
						</div>
					</td>
					<td width="10%" style="background-color: #FFF; font-size: 20px; font-weight: bold; border-left: 1px solid #b9b9b9;">
						<div style="text-align: center;">
							<a href="javascript:writeInq('${productDTO.pno}')">등록</a>
						</div>
					</td>
				</table>
			</div>
			<!--box3끝-->
		</div>
		<!--small-container끝-->
	</div>
	<script type="text/javascript">
		window.onscroll = function () {
			myFunction ()
		};

		var navbar = document.getElementById ( "navbar" );
		var sticky = navbar.offsetTop;

		function myFunction () {
			if ( window.pageYOffset >= sticky ) {
				navbar.classList.add ( "sticky" )
			} else {
				navbar.classList.remove ( "sticky" );
			}
		}
	</script>
	<!-- 푸터 -->
	<jsp:include page="../pageIngredient/footer.jsp" flush="false"></jsp:include>
</body>
</html>