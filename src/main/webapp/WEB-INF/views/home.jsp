<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>최초실행페이지(스프링)</title>
</head>
<body>
	<h1>현재시간</h1>
	<P>=> The time on the server is ${serverTime}. <=</P>
	<a href="/mainPage/mainPage">쇼핑몰 메인페이지로 이동</a>
	<br>
	<a href="/member/memberSignUp">회원가입페이지</a>
	<br>
	<a href="/member/memberLoginPage">로그인페이지</a>
	<div>
		<h1>비회원</h1>
		<a href="/board/boardWritePage">비회원 게시글 작성하기</a>
		<br>
		<a href="/board/member/memberBoardList">게시판으로</a>
	</div>
	<div>
		<h1>테스트 업무</h1>
		<a href="/product/productWritePage">상품 등록</a>
		<br>
		<a href="/product/productList">판매 상품 목록</a>
	</div>
	<%= request.getRealPath("/") %>
</body>
</html>


