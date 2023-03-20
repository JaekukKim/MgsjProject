<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta charset="UTF-8">
<title>제품 등록</title>

<link rel="stylesheet" href="/resources/product/productWritePage.css">
</head>
<body>

	<!-- header -->
	<jsp:include page="../pageIngredient/header.jsp" flush="false"></jsp:include>

	<!-- 상품 등록 시작 -->
	<div class="board_wrap">
		<div class="board_title">상품 등록하기</div>
		<form class="productReg" action="/product/productWrite" method="post" enctype="multipart/form-data">
			<!-- 분류 -->
			<div class="category">
				<label for="" class="label_1">대분류</label>
				<select class="category1">
					<option value="" class="category_1">전체</option>
				</select>
				<label class="label_2">상세분류</label>
				<select class="category2" name="cno">
					<option value="">전체</option>
				</select>
			</div>
			<!-- table -->
			<div class="table">
				<table>
					<tbody>
						<tr>
							<th>
								<label class=" control-label">제품이름</label>
							</th>
							<td>
								<div>
									<input type="text" class="form-control" name="productName" maxlength="40" placeholder="제품 이름 입력" />
								</div>
							</td>
							<td rowspan="3" style="align-items: center;" class="img-td-tag">
								<div>
									<div class="show-image">
										<img src="" />
									</div>
									<label for="productFile" class="upload">이곳을 클릭하여 이미지 업로드</label>
									<br>
									<input type="file" id="productFile" name="file">
								</div>
							</td>
						</tr>

						<tr>
							<th>
								<label class=" control-label">제품 가격</label>
							</th>
							<td>
								<div>
									<input type="number" class="form-control" name="productPrice" maxlength="20" placeholder="제품 가격 입력" />
								</div>
							</td>
						</tr>

						<tr>
							<th>
								<label class=" control-label">제품 재고</label>
							</th>
							<td>
								<div>
									<input type="number" class="form-control" name="productStock" maxlength="10" placeholder="제품 재고 입력" />
								</div>
							</td>
							<!-- 경로 : D:\jsp\workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp8\wtpwebapps\Mgsjproject\ -->
						</tr>

						<tr>
							<th>
								<label class=" control-label">제품 설명</label>
							</th>
							<td colspan="2">
								<div>
									<textarea class="form-control" id="content" name="productDescription" rows="10" placeholder="제품 설명 입력"></textarea>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- 버튼 -->
			<div class="form_button">
				<button type="reset">다시 입력</button>
				<button type="button" onClick="location.href = '/product/productList'">상품 목록 이동</button>
				<button type="submit">게시글 등록</button>
			</div>
		</form>
	</div>




	<!-- 상품 등록 끝 -->
	<!-- 푸터 -->
	<jsp:include page="../pageIngredient/footer.jsp" flush="false"></jsp:include>
</body>
<script>
	//컨트롤러에서 데이터 받기
	var jsonData = JSON.parse ( '${categoryList}' );
	console.log ( jsonData );

	var cate1Arr = new Array ();
	var cate1Obj = new Object ();

	//1차 분류 셀렉트 박스에 삽입할 데이터
	for ( var i = 0; i < jsonData.length; i++ ) {

		if ( jsonData[i].level == 1 ) {
			cate1Obj = new Object (); //초기화
			cate1Obj.cno = jsonData[i].cno;
			cate1Obj.categoryName = jsonData[i].categoryName;
			cate1Arr.push ( cate1Obj );
		}
	}

	//1차 분류 셀렉트 박스에 데이터
	var cate1Select = $ ( 'select.category1' )

	for ( var i = 0; i < cate1Arr.length; i++ ) {
		cate1Select.append ( "<option value='" + cate1Arr[i].cno + "'>" + cate1Arr[i].categoryName + "</option>" );
	}

	$ ( document ).on ( "change" , "select.category1" , function () {

		var cate2Arr = new Array ();
		var cate2Obj = new Object ();

		//2차 분류 셀렉트 박스
		for ( var i = 0; i < jsonData.length; i++ ) {

			if ( jsonData[i].level == 2 ) {
				cate2Obj = new Object ();
				cate2Obj.cno = jsonData[i].cno;
				cate2Obj.categoryName = jsonData[i].categoryName;
				cate2Obj.categoryLevel = jsonData[i].categoryLevel;

				cate2Arr.push ( cate2Obj );
			}
		}

		var cate2Select = $ ( "select.category2" );

		cate2Select.children ().remove ();

		$ ( "option:selected" , this ).each ( function () {

			var selectVal = $ ( this ).val ();
			cate2Select.append ( "<option value=''>전체</option>" );

			for ( var i = 0; i < cate2Arr.length; i++ ) {
				if ( selectVal == cate2Arr[i].categoryLevel ) {
					cate2Select.append ( "<option value='" + cate2Arr[i].cno + "'>" + cate2Arr[i].categoryName + "</option>" );
				}
			}
		} );

	} );

	$ ( "#productFile" ).change ( function () {
		// id = "productFile"이 바뀌었을 때

		if ( this.files && this.files[0] ) {
			// this에 (id = "productFile") 파일이 있다면.

			var reader = new FileReader;
			reader.onload = function ( data ) {
				$ ( ".show-image img" ).attr ( "src" , data.target.result ).width ( 300 ).height ( 300 );
			}
			reader.readAsDataURL ( this.files[0] );
		}
	} );
</script>

</html>