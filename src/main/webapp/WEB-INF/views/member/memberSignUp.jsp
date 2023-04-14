<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 폼</title>
<link rel="stylesheet" href="/resources/SignUp/signup/sign-up.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	<div class="sign-up">
		<form id="sign-up" name="sign-up" action="/member/memberSignUp" method="post">
			<div class="member">
				<!-- 로고 -->
				<span class="main-logo">
					<a href="/mainPage/mainPage">MGSJ</a>
				</span>
				<!-- 필드 -->
				<div class="field">
					<b>아이디</b>
					<input class="userid" id="userId" name="userId" type="text" placeholder="아이디를 입력하세요" maxlength="12">
					<button type="button" onclick="checkDuplicateId()" style="float: right;">아이디중복검사</button>
					<div id="idError" class="error"></div>
				</div>
				<div class="field">
					<b>비밀번호</b>
					<input class="userpwd" id="userPwd" name="userPwd" type="password" placeholder="비밀번호를 입력하세요" maxlength="20" />
					<div id="pwdError" class="error"></div>
				</div>
				<div class="field">
					<b>비밀번호 확인</b>
					<input class="userpwd-re" id="rePwd" name="rePwd" type="password" placeholder="비밀번호 재입력" maxlength="20" />
					<div id="re-pwdError" class="error"></div>
				</div>
				<div class="field">
					<b>이름</b>
					<input id="userName" name="userName" type="text" placeholder="이름을 입력하세요" maxlength="20" />
					<div id="nameError" class="error"></div>
				</div>
				<div class="field">
					<b>생년월일</b>
					<input id="userBirth" name="userBirth" type="text" placeholder="20230101 식으로 입력" maxlength="20" />
					<div id="nameError" class="error"></div>
				</div>
				<div class="field">
					<b>이메일</b>
					<input id="userEmail" name="userEmail" type="email" placeholder="이메일을 입력하세요" maxlength="30" />
					<div id="emailError" class="error"></div>
				</div>
				<div class="field">
					<b>주소</b>
					<!-- 
						private String postAddress;
						private String address;
						private String detailAddress;
					 -->
					<input id="postAddress" name="postAddress" type="text" placeholder="우편번호" readonly />
					<button type="button" onclick="findAddr()">우편번호 검색</button>
					<input id="address" name="address" type="text" placeholder="주소" readonly />
					<br />
					<div id="addressError" class="error"></div>
					<input id="detailAddress" name="detailAddress" type="text" placeholder="상세주소 입력" />
					<div id="detailAddError" class="error"></div>
				</div>
				<div class="field gender">
					<b>성별</b>
					<div>
						<label>
							<input id="gender_man" type="radio" name="userGender" value="M" checked="checked">
							남성
						</label>
						<label>
							<input id="gender_woman" type="radio" name="userGender" value="F">
							여자
						</label>
					</div>
					<div id="genderError" class="error"></div>
				</div>


				<div class="field tel-number">
					<b>휴대전화</b> <select>
						<option>대한민국 +82</option>
					</select>
					<div>
						<input type="tel" id="userPhoneNumber" name="userPhoneNumber" placeholder="전화번호를 입력하세요" />
						<!-- <input type="button" value="인증번호 받기"> -->
					</div>
					<!--  <input type="tel" placeholder="인증번호를 입력하세요" /> -->
				</div>
				<div class="signUp">
					<!-- 실전에서 button type submit으로 변경 -->
					<button type="submit" onclick="signUpCheck()" disabled>회원가입</button>
				</div>
			</div>
		</form>

	</div>
</body>
<script type="text/javascript" src="/resources/SignUp/signup/sign-up.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</html>