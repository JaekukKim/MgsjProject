<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>로그인</title>
<link rel="stylesheet" href="/resources/login/styles/reset.css">
<link rel="stylesheet" href="/resources/login/styles/login.css">
</head>
<body>
	<div class="login">
		<h1>
			<a href="/mainPage/mainPage" title="메인페이지로 이동">
				<span class="login-logo">MGSJ</span>
			</a>
		</h1>

		<form action="/member/memberLogin" method="post" id="login-form" name="login-form">
			<div class="login-box">
				<ul>
					<li>
						<span class="id-icon">
							<!-- 장식이미지 -->
						</span>
						<span>
							<input type="text" id="userId" name="userId" placeholder="아이디">
						</span>
					</li>
					<li class="error id-error">아이디를 입력해주세요</li>
					<li>

						<span class="pwd-icon">
							<!-- 장식이미지 -->
						</span>
						<span>
							<input type="password" id="userPwd" name="userPwd" placeholder="비밀번호">
						</span>

					</li>
					<li class="error pwd-error">비밀번호를 입력해주세요</li>
					<c:if test="${loginMessage == false }">
						<li style="color: red; border: none;">아이디나 비밀번호를 확인해주세요</li>
					</c:if>
				</ul>
				<button type="submit" id="login-btn" onclick="memberLogin()">로그인</button>
			</div>
		</form>
		<div class="btm">
			<!-- <p>
				<label>
					<input type="checkbox" name="login-y" id="login-y">
					<span>자동로그인</span>
				</label>
			</p> -->
		</div>
		<a href="/member/memberSignUp" class="join_link">회원가입</a>
	</div>

	<footer> &copy; Ezen project.</footer>
</body>
<script src="/resources/login/script/memberlogin.js"></script>
</html>