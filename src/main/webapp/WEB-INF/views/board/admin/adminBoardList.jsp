<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>관리자 전용 게시판</title>
</head>
<body>
	<div align="center">
		<table border="1">
			<thead>
				<tr>
					<th class="col-sm-1  text-center">번 호</th>
					<th class="col-sm-4  text-center">제 목</th>
					<th class="col-sm-1  text-center">작성자</th>
					<th class="col-sm-1  text-center">작성자아이디</th>
					<th class="col-sm-3  text-center">작성일자</th>
					<th class="col-sm-1  text-center">조회수</th>
				</tr>
			</thead>
			<tbody>
				<!-- 
				bno int userId varchar(20) 
				writer varchar(20) 
				title varchar(50) 
				content text 
				regDate datetime
				readCount int
				
			-->
				<c:forEach var="adminBoardList" items="${adminBoardList}">
					<tr>
						<td align="center">${adminBoardList.bno}</td>
						<td align="center" title="${adminBoardList.content}">
						<a href="/board/boardView?bno=${adminBoardList.bno}">${adminBoardList.title}</a></td>
						<!-- <td class = "hidden">${notice.content}</td>-->
						<td align="center">${adminBoardList.writer}</td>
						<td align="center">${adminBoardList.userId}</td>
						<td>
							<fmt:formatDate value="${adminBoardList.regDate}" pattern="yyyy-MM-dd" />
						</td>
						<td align="center">${adminBoardList.readCount}</td>
						<!-- 나중 사용을 위해서 이미지 이름과 경로 히든 처리 -->
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>