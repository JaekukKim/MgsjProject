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
	<a href="/member/memberSignUp">회원가입페이지</a>
	<br>
	<a href="/member/memberLoginPage">로그인페이지</a>
	<div>
		<h1>비회원</h1>
		<a href="/board/boardWritePage">비회원 게시글 작성하기</a>
	</div>
</body>
</html>


