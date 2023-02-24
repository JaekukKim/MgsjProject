<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<meta charset="UTF-8">
<title>주문 목록(간이)</title>
</head>
<body>
 <div align = "center">
		<table border = "1">
			<thead>
				<tr class = "warning">
					<th class = "col-sm-2  text-center">주문번호</th>
					<th class = "col-sm-2  text-center">회원번호</th>
					<th class = "col-sm-2  text-center">회원아이디</th>
					<th class = "col-sm-2  text-center">주문일자</th>
					<th class = "col-sm-2  text-center">우편번호</th>
					<th class = "col-sm-2  text-center">상세주소1</th>
					<th class = "col-sm-2  text-center">상세주소2</th>
					<th class = "col-sm-2  text-center">수령인</th>
					<th class = "col-sm-2  text-center">수령인번호</th>			
				</tr>
			</thead>
			<tbody>
			<!-- 
			orderNum int AI PK 
			userNum int 
			userId varchar(20) 
			orderDate datetime 
			postAddress varchar(20) 
			detailAddress varchar(50) 
			detailAddress2 varchar(50) 
			recipient varchar(10) 
			recipientPhone varchar(15)
 			-->
				<c:forEach var = "orderList" items = "${orderList}">
				<tr>
					<td align = "center">${orderList.orderNum}</td>
					<td align = "center">${orderList.userNum}</td>
					<td align = "center">${orderList.userId}</td>
					<td><fmt:formatDate value = "${orderList.orderDate}" pattern = "yyyy-MM-dd"/></td>
					<td align = "center">${orderList.postAddress}</td>
					<td align = "center">${orderList.detailAddress}</td>
					<td align = "center">${orderList.detailAddress2}</td>
					<td align = "center">${orderList.recipient}</td>
					<td align = "center">${orderList.recipientPhone}</td>
					<!-- 나중 사용을 위해서 이미지 이름과 경로 히든 처리 -->
				</tr>
				</c:forEach>
			</tbody>
		</table>
	
	</div>

</body>
</html>