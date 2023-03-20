<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.project.member.domain.MemberDTO"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
String cp = request.getContextPath();
request.setCharacterEncoding("UTF-8");

//쿠키 가져오기
Cookie[] ck = request.getCookies();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>header</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="/resources/pageIngredient/header/logout.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="${contextPath}/resources/pageIngredient/header/header2.css">
</head>
<body>
	<div class="header">
		<div class="container">
			<div class="navbar">
				<div class="logo">
					<a href="/mainPage/mainPage">
						<img src="${contextPath}/resources/pageIngredient/header/header-img/logo2.png" width="125px">
					</a>
				</div>

				<nav>
					<c:choose>
						<c:when test="${(memberInfo.userVerify) == 128 && (memberInfo != null) }">
							<%-- 관리자 --%>
							<ul id="MenuItems">
								<li>
									<a href="/admin/memberManagement?pageNum=1" title="관리자 회원 관리 페이지">
										<i class="bi bi-bookmark-star-fill" style="font-size: 30px;"></i>
									</a>
								</li>
								<li>
									<a href="/admin/productManagement?pageNum=1" title="관리자 상품 관리 페이지">
										<i class="bi bi-box-seam-fill" style="font-size: 30px;"></i>
									</a>
								</li>
								<li>
									<a href="javascript:memberLogout()" title="로그아웃">
										<i class="bi bi-door-open" style="font-size: 30px;"></i>
									</a>
								</li>
							</ul>
						</c:when>
						<c:when test="${(memberInfo.userVerify) == 0 && (memberInfo != null) }">
							<%-- 회원 --%>
							<ul id="MenuItems">
								<li>
									<a href="/member/memberModifyPage" title="회원정보수정">
										<i class="bi bi-person-fill" style="font-size: 30px;"></i>
									</a>
								</li>
								<li>
									<a href="/cart/cartList" title="주문내역">
										<i class="bi bi-cart" style="font-size: 30px;"></i>
									</a>
								</li>
								<li>
									<a href="javascript:memberLogout()" title="로그아웃">
										<i class="bi bi-door-open" style="font-size: 30px;"></i>
									</a>

								</li>
							</ul>
						</c:when>
						<c:when test="${(memberInfo.userVerify) == 5 && (memberInfo != null) }">
							<%-- 판매자 --%>
							<ul id="MenuItems">
								<li>
									<a href="/member/memberModifyPage" title="판매자 정보 수정">
										<i class="bi bi-person-fill" style="font-size: 30px;"></i>
									</a>
								</li>
								<li>
									<a href="/cart/cartList" title="판매상품내역">
										<i class="bi bi-cart" style="font-size: 30px;"></i>
									</a>
								</li>
								<li>
									<a href="/product/productWritePage" title="판매상품내역">
										<i class="bi bi-currency-dollar" style="font-size: 30px;"></i>
									</a>
								</li>
								<li>
									<a href="javascript:memberLogout()" title="로그아웃">
										<i class="bi bi-door-open" style="font-size: 30px;"></i>
									</a>
								</li>
							</ul>
						</c:when>
						<c:otherwise>
							<ul id="MenuItems">
								<%-- 비회원 --%>
								<li>
									<a href="/member/memberLoginPage" title="로그인">
										<i class="bi bi-person-fill" style="font-size: 30px;"></i>
									</a>
								</li>
							</ul>
						</c:otherwise>
					</c:choose>
				</nav>

				<img src="/resources/pageIngredient/header/header-img/menu.png" class="menu-icon" onclick="menutoggle()">
			</div>
		</div>
	</div>
	<!--dropdown menu 시작-->
	<div class="menu">
		<a href="/order/orderList">My Page</a>
		<a href="/announcement/announcement?pageNum=1">NOTICE</a>
		<div class="dropdown">
			<button class="dropbtn">
				Product <i class="fa fa-caret-down"></i>
			</button>
			<div class="dropdown-content">
				<div class="row">
					<c:forEach var="categoryList1" items="${categoryList1}">
						<!-- 대분류 -->
						<div class="column">
							<div>
								<c:out value="${categoryList1.categoryName}" />
								<!-- 대분류 이름 -->
							</div>
							<hr>
							<c:forEach var="categoryList2" items="${categoryList2}">
								<!-- 소분류 -->
								<c:if test="${categoryList2.categoryLevel == categoryList1.cno}">
									<a href="/category/categoryPro?cno=${categoryList2.cno}" class="dorpdown-btn">
										<c:out value="${categoryList2.categoryName}" />
										<!-- 소분류 이름 -->
									</a>
								</c:if>
							</c:forEach>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
	<!--dropdown menu 끝-->
</body>


<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pageIngredient/header/history.js"></script>
<script type="text/javascript">
	//반응형 웹 햄버거 토글
	let MenuItems = document.getElementById ( "MenuItems" );

	MenuItems.style.maxHeight = "0px";

	function menutoggle () {
		
		if ( MenuItems.style.maxHeight == "0px" ) {
			
			MenuItems.style.maxHeight = "200px"
			
			let liMediaQuery = document.querySelectorAll("ul>li");
			
			for ( let i = 0; i < liMediaQuery.length; i++ ) {
				liMediaQuery[i].style.float = "left";
			}
			
		} else {
			MenuItems.style.maxHeight = "0px";
		}
	}
</script>
</html>