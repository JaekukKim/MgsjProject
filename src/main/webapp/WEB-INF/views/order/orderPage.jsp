<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%-- 액션(코어)태그 --%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- EL태그로 쓸것을 미리 만들어놓는 좋은 습관 기억하자 -->
<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta charset="UTF-8">
<title>주문하기</title>
<link rel="stylesheet" href="${contextPath}/resources/order/orderPage.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
</head>
<body>
	<!-- header -->
	<jsp:include page="../pageIngredient/header.jsp" flush="false"></jsp:include>
	<!-- header -->
	<div class="lay-wrap">

		<form action="/payment/paymentWrite" method="post">
			<div class="lay-con1">
				<div class="title">
					<h2>주문하기</h2>
					<hr>
					<div class="orderarea">
						<div class="order_lft">
							<div class="itemcheck">
								<ul class="checkbtn1">
									<li>
										
									</li>
								</ul>
							</div>
						</div>
					</div>
				</div>


				<div class="cart">
					<table>
						<thead>
							<tr>
								<th></th>
								<th>Product</th>
								<th>Quantity</th>
								<th>Subtotal</th>
							</tr>
						</thead>

						<tbody>
							<c:set var="total" value="0" />
							<c:forEach var="cartList" items="${cartList}">
								<tr>
									<td class="itemview_chk"></td>
									<td class="itemview_thum"><a href="#">
											<img src="${cartList.storedFileName }">
										</a></td>
									<td class="itemview_info">

										<div>
											<!--  <span>제품번호 : </span><span class="product_num">00000</span><br> -->
											<span class="product_name">
												<input type="hidden" name="pno" value="${cartList.pno}">
												<a href="${contextPath}/product/productView?pno=${orderDetailList.pno}">${cartList.productName}</a>
											</span>
										</div>

									</td>
									<td class="itemview_price">

										<div>
											<span>
												금액 :
												<input type="text" name="productPrice" value="${cartList.productPrice}">
											</span>
											<span>원</span>
										</div>
										<div class="input-group">
											<span>주문갯수 :</span>
											<input type="number" class="input-number" min="1" name="productCnt" value="${cartList.totalCnt}" onkeydown="javascript: return event.keyCode == 69 ? false : true" readonly="readonly">
										</div>
									</td>
								</tr>
								<c:set var="total" value="${total + (cartList.productPrice * cartList.totalCnt)}" />
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>

			<div class="lay-con2">
				<!-- 결제 -->


				<!-- 배송지 -->
				<div class="u-post">


					<div class="tbl_frm01 tbl_wrap" align="center">
						<div class="post-title">
							<b>POST</b>
						</div>
						<div class="order_choice_place">
							<input type="radio" name="ad_sel_addr" value="same" id="ad_sel_addr_same">
							<label for="ad_sel_addr_same">주문자와 동일</label>
							<input type='radio' name="ad_sel_addr" id='my_checkbox' onclick='toggleTextbox(this)' />
							<label for="od_sel_addr_new">신규배송지</label>
						</div>
						<table>
							<tbody>

								<tr class="addressIng">
									<th scope="row"><label for="od_b_name">
											아이디<strong class="sound_only"></strong>
										</label></th>
									<td><input type="text" name="userId" maxlength="200" value="${memberInfo.userId}" readOnly></td>
								</tr>
								<tr class="addressIng">
									<th scope="row"><label for="od_b_name">
											이름<strong class="sound_only"></strong>
										</label></th>
									<td><input type="text" class="checkDel" id="recipient" name="recipient" value="${memberInfo.userId}" maxlength="200" /></td>
								</tr>
								<tr class="addressIng">
									<th scope="row"><label for="od_b_tel">
											전화번호<strong class="sound_only"> </strong>
										</label></th>
									<td><input type="Number" class="checkDel" id="recipientPhone" name="recipientPhone" value="${memberAddress.userPhoneNumber}" maxlength="11" /></td>
								</tr>
								<tr class="addressIng">
									<th scope="row">주소</th>
									<td id="sod_frm_addr"><label for="od_b_zip" class="sound_only">
											<strong class="sound_only"></strong>
										</label> <input id="postAddress" type="text" placeholder="우편번호" name = "postAddress" readonly value="${memberAddress.postAddress}" />
										<button class="btn_address" type="button" onclick="findAddr()">검색</button> <br /> <input type="text" class="checkDel" id="detailAddress" name="detailAddress" value="${memberAddress.address}" maxlength="200" /> <input type="text" class="checkDel" id="detailAddress2" name="detailAddress2" value="${memberAddress.detailAddress}" maxlength="200" /></td>
								</tr>

							</tbody>
						</table>
					</div>
				</div>
				<!-- 배송지 -->

				<div class="payment">
					<div class="payment-content">
						<div class="pay-title">
							<b>Payment</b>
						</div>
						<%
						// order_date : value 출력용
						SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
						Calendar payCal = Calendar.getInstance();
						String paymentDate = date.format(payCal.getTime());
						%>

						<!-- 주문시 주문정보  -->
						<div class="pay-product">
							<b class="pro-title">결제일자</b>
							<input type="text" id="order_date" value="<%=paymentDate.toString()%>" readonly />
							<br>
							<div class="pay-method">
								<b class="pro-title">결제수단</b>
								<!-- 자바스크립트로 라디오타입의 value값을 따와서 text할 예정 -->
								<label>
									<input id="pay-card" type="radio" name="paymentKind" value="카드" checked>
									카드
								</label>
								<label>
									<input id="pay-cash" type="radio" name="paymentKind" value="계좌이체">
									계좌이체
								</label>
							</div>
						</div>

						<div class="card-container">
							<div class="card-sel">
								<div class="card-con">
									<b class="pro-title">카드선택</b>
									<select name = "paymentCard">
										<option value="hyundai">현대카드</option>
										<option value="lotte">롯데카드</option>
										<option value="ezen">이젠카드</option>
									</select>
								</div>
							</div>
							<br>
							<div class="card-con2">
								<div class="card-date">
									<b class="pro-title">유효기간</b>
									<input type="date" id="card_date" name="card_date" />
								</div>
								<br>
								<div class="card-info">
									<div class="card-num">
										<b class="pro-title">카드번호</b>
										<input type="text" id="card_num" name="" />
									</div>
									<br>
									<div class="card-pwd">
										<b class="pro-title">비밀번호</b>
										<input type="number" id="card_pwd" name="card_pwd" placeholder="카드 비밀번호" />
									</div>
								</div>
							</div>
						</div>
					</div>



					<div class="payment">
						<div class="pay">
							<!-- 공란용 -->
							<!-- 			<div class="pay-emp"></div> -->
							<!-- 공란용 -->

							<div class="order_rgt">
								<div class="order_price">
									<div class="order_itemprice">
										<span>주문금액</span>
										<span>
											<c:out value="${total}" />
											원
										</span>
									</div>
									<div class="order_deliveryprice">
										<span>+ 배송비</span>
										<span>3,000원</span>
									</div>
								</div>
								<br>
								<div class="pay-rast">
									<span>총</span>
									<span>
										<input type="number" name="paymentMoney" value="${total + 3000}">
										원
									</span>


								</div>
								<div class="cart-btn">
									<a href="/cart/cartList">
										<button type="button" class="btn_cart">
											<span>장바구니로 이동</span>
										</button>
									</a>
								</div>

								<div class="payment-btn">
									<a href="/payment/paymentPage">
										<button type="submit" class="btn_pay">결제하기</button>
									</a>
								</div>

							</div>
						</div>
					</div>
				</div>

			</div>
		</form>
	</div>




	<!-- footer -->
	<jsp:include page="../pageIngredient/footer.jsp" flush="false"></jsp:include>
	<!-- footer -->
	<!-- 스크립트 -->
	<script>
		 $("#allchk").click(function(){
				var chk = $("#allchk").prop("checked");
			
				if(chk) {
					$(".test").prop("checked", true);
				} else {
					$(".test").prop("checked", false);
				}
			
			}); 
		
		
		function toggleTextbox(checkbox) {
			 
			var userInfoText = document.querySelectorAll('.checkDel');
			
			
			for (let i = 0; i < userInfoText.length; i++) {
					/* userInfoText[i].textContent = ""; */
					if(userInfoText[i].id == "postAddress") {
						userInfoText[i].value = checkbox.checked ? "" : '${memberAddress.postAddress}';
					} else if(userInfoText[i].id == "detailAddress") {
						userInfoText[i].value = checkbox.checked ? "" : '${memberAddress.address}';
					} else if(userInfoText[i].id == "detailAddress2") {
						userInfoText[i].value = checkbox.checked ? "" : '${memberAddress.detailAddress}';
					} else if(userInfoText[i].id == "recipient") {
						userInfoText[i].value = checkbox.checked ? "" : '${memberInfo.userId}';
					} else if(userInfoText[i].id == "recipientPhone") {
						userInfoText[i].value = checkbox.checked ? "" : '${memberAddress.userPhoneNumber}';
					}
				}
			}
			
		const groups = document.querySelectorAll('.input-group');

		        groups.forEach(group => {
		          const input = group.querySelector('.input-number');
		          const increaseBtn = group.querySelector('.btn-increase');
		          const decreaseBtn = group.querySelector('.btn-decrease');

		          increaseBtn.addEventListener('click', () => {
		            input.value = parseInt(input.value) + 1;
		          });

		          decreaseBtn.addEventListener('click', () => {
		            input.value = parseInt(input.value) - 1;
		          });
		        });
		        

		        function findAddr() {
		        	new daum.Postcode({
		        		oncomplete: function(data) {
		        			console.log(data);

		        			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		        			let roadAddr = data.roadAddress; // 도로명 주소 변수
		        			let jibunAddr = data.jibunAddress; // 지번 주소 변수
		        			// 우편번호와 주소 정보를 해당 필드에 넣는다.
		        			document.getElementById('postAddress').value = data.zonecode;
		        			if (roadAddr !== '') {
		        				document.getElementById("address").value = roadAddr;
		        			}
		        			else if (jibunAddr !== '') {
		        				document.getElementById("address").value = jibunAddr;
		        			}
		        		}
		        	}).open();
		        }
		        
</script>

	<script src="/resources/order/addressApi.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</body>
</html>