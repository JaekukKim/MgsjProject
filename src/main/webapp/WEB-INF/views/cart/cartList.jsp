<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>cart</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="${contextPath}/resources/cart/cartList.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
</head>
<body>
	<!-- 헤더 -->
	<jsp:include page="../pageIngredient/header.jsp" flush="false"></jsp:include>
	<!-- 장바구니 -->
	<div class="small-container cart-page">
		<div class="itemcheck">
			<label>
				<input type="checkbox" name="allcheck" id="allchk" value="checkAll">
				<span>전체 선택</span>
			</label>
			<button type="button" class="btn-delete delete-btn">선택삭제</button>
		</div>
		<br>
		<table>
			<tr>
				<th></th>
				<th>Product</th>
				<th>Quantity</th>
				<th>Subtotal</th>
			</tr>
			<c:set var = "total" value = "0"/>
			<c:forEach var="cartList" items="${cartList}">
				<tr class="cart-info-pachment">
					<td class="itemview_chk">
						<input type="checkbox" id="chkbox" class="pnoCheckBox" value="${cartList.pno}" onClick="itemSum()">
					</td>

					<td>
						<div class="cart-info">
							<img id="resultimg" src="${cartList.storedFileName}" alt="상품 이미지 로딩 실패">
							<div>
								<p>
									<a href="${contextPath}/product/productView?pno=${cartList.pno}">${cartList.productName}</a>
								</p>
								<!--상품명-->
								<small>가격 : </small>
								<input id="itemview_price" style="border: 0 solid black" value="${cartList.productPrice}" readonly>
								<small>원</small>
								<!--가격-->
								<br>
								<a class="btn btn-sm btn-warning" href="javascript:deleteCartList('${cartList.cartNum}','${cartList.productName}')">삭제</a>
								<!--개별 삭제 버튼-->
							</div>
						</div>
					</td>

					<!--수량-->
					<td>
						<input type="number" style="border: 0 solid black" value="${cartList.totalCnt}" readonly>
					</td>

					<!--합계-->
					<td class="product-price-td">
						<input id="product_price" class="product_price" style="border: 0 solid black" value="${cartList.productPrice * cartList.totalCnt}" size=10 readonly>
						원
					</td>

				</tr>
				<c:set var= "total" value = "${total + cartList.productPrice * cartList.totalCnt}"/>
			</c:forEach>
		
		</table>

		<div class="total-price">
			<table>
				<tr>
					<td>총 금액</td>
					<td class="total_price">
						<input type="number" name="total-price" id="total-price" value="${total}">
						원
					</td>
				</tr>
				<tr>
					<td colspan=2>
						<button type="button" class="btn_pay" onclick="location.href = '/order/orderPage'">
							<span>주문하기</span>
						</button>
					</td>
				<tr>
			</table>
		</div>
	</div>
	<!-- 푸터 -->
	<jsp:include page="../pageIngredient/footer.jsp" flush="false"></jsp:include>
</body>
<!-- 장바구니 -->

<script>
	// 상품 전체선택 및 총 상품 가격 출력
	const allchk = document.querySelector ( "#allchk" );

	allchk.addEventListener ( "click" , function () {
		const chk = allchk.checked;

		const productInfoTag = document.querySelectorAll ( ".cart-info-pachment" );

		const pnoCheckBoxes = document.querySelectorAll ( ".pnoCheckBox" );

		let totalPrice = document.getElementById ( "total-price" );

		// 상품 가격 총 합계 저장 변수
		let sum = 0;

		pnoCheckBoxes.forEach ( function ( pnoCheckBoxes ) {
			pnoCheckBoxes.checked = chk;
		} );

		if ( chk ) {

			// for문으로 쿼리셀렉터로 가져온 값들을 저장하여 특정값을 빼냄 (각각 상품마다 갯수*가격의 값)
			for ( let i = 0; i < productInfoTag.length; i++ ) {
				let productDetailInfoTag = productInfoTag[i].querySelectorAll ( "td" );

				/* 
					tbody - tr - td태그의 3번째에 product_price는 고정된 위치이다. 그래서 우리는 그전에 상품 갯수에 따라
					product_price 위치가 바뀌는 대참사를 겪었다.
					productInfoTag.length로 적어놓으면 상품 갯수에 따라 product_price의 위치가 변하는, 정확히 말해선 product_price는 3번째 고정인데
					product_price 얘를 1번째 위치 에서 찾을라하고.. 2번째 위치 에서 찾을라하고... 해서 대참사가 발생한 것이다.
				 */
				let productTotalPrice = productDetailInfoTag[3].querySelector ( '.product_price' ).value;

				sum += Number ( productTotalPrice );
			}

		} else {

			sum = 0;

		}

		totalPrice.value = sum;
	} );

	/* 개별체크 상품 가격 추가 */
	function itemSum() {
		let sum = 0;
		
		// 상품에 있는 체크박스를 전부 선택
		const pnoCheckBoxes = document.querySelectorAll('.pnoCheckBox');
		
		// 선택된 체크박스마다 forEach문 실행 => forEach로 페이지를 전체 반복한다고 생각하면 된다.
		// pnoCheckBoxes가 클릭되면 forEach문이 실행된다는 얘기다. 이 부분은 매우매우매우매우 중요하다. 처음 안 개념일 뿐더러 자바에는 없는 개념.
		pnoCheckBoxes.forEach(eachCheckBox => {
			
			// pnoCheckBoxes가 클릭되면서 forEach문이 실행될때마다 상품마다 클릭한 체크박스를(eachCheckBox) 매개변수로 받아 중괄호 내부 실행.
		   	if (eachCheckBox.checked) {
		   	  
		   		// "클릭이 된!!" 박스에서 가장 가까운 클래스(tr태그)를 찾아 내부의 .product_price인 태그를 찾는다.
			    const productPrice = eachCheckBox.closest('.cart-info-pachment').querySelector('.product_price');
		   		// 그 값을 숫자로 변형하고
			    const price = parseInt(productPrice.value);
		   		// sum에 대입.
			    sum += price;
		      
		    }
		   	
		});
	
		// 클라이언트의 눈에 보이게 하는 과정
		const totalPrice = document.getElementById('total-price');
		totalPrice.value = sum;
	}

	/* --------------------------------------------------------------------------------------------------------- */
	// 선택된 상품 삭제 - ajax로 db까지 연동
	const productDeleteButton = document.querySelector ( ".delete-btn" );

	const mainProductCheckBoxes = document.querySelectorAll ( ".pnoCheckBox:checked" );

	const productNum = document.getElementById ( "chkbox" ).value;

	// 선택 삭제 버튼을 눌렀을 때
	productDeleteButton.addEventListener ( "click" , function () {

		let deleteCartProduct = confirm ( "선택하신 상품을 삭제하시겠습니까?" );

		if ( deleteCartProduct == true ) {

			const checkProductArr = new Array ();
			const checkboxes = document.querySelectorAll ( 'input[class="pnoCheckBox"]:checked' );

			checkboxes.forEach ( function ( checkbox ) {
				checkProductArr.push ( checkbox.getAttribute ( "value" ) );
			} );

			$.ajax (
				{
					url : "/cart/cartDelete" ,
					type : "post" ,
					data :
						{
							cartProductNum : checkProductArr
						} ,

					success : function ( deleteResult ) {

						if ( deleteResult == 1 ) {

							mainProductCheckBoxes.forEach ( function ( eachProductCheckBox ) {
								// 체크박스된 태그의 부모노드 (td태그) 선택
								const parentTag = eachProductCheckBox.parentNode;
								// 그 input태그의 부모노드 (tr태그 전체) 선택
								const overParentTag = parentTag.parentNode;
								// tr태그 delete
								overParentTag.parentNode.removeChild ( overParentTag );
							} );

							alert ( "장바구니 목록 삭제가 완료되었습니다." );

							location.reload ( true );

						} else {

							alert ( "장바구니 목록 삭제에 실패하였습니다. 로그인 해주십시오." );
						}

					} ,
					error : function ( error ) {
						alert ( "오류가 발생하였습니다." );
						console.log ( error );
					}

				} )
		} else {
			alert ( "장바구니 목록 삭제를 취소하셨습니다." );
		}

	} );
</script>

</body>
</html>