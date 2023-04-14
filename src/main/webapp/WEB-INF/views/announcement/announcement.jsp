<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.project.board.domain.PageIngredient"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
</head>

<link rel="stylesheet" type="text/css" href="/resources/board/boardList/boardList.css">

<body>
<!-- header -->
<jsp:include page="../pageIngredient/header.jsp" flush="false"></jsp:include>
<!-- header -->
   <div id="boardGroup">
      <h1>NOTICE</h1>
      <!-- 게시글 검색기능 -->
      <%
      PageIngredient pageIngredient = (PageIngredient) request.getAttribute("page");
      %>
      <div class="search-bar">
         <select class="searchType" name="searchType">
            <option value="title" <%=pageIngredient.getSearchType().equals("title") ? "selected" : ""%>>
            	제목
            </option>
            <option value="content" <%=pageIngredient.getSearchType().equals("content") ? "selected" : ""%>>
            	내용
            </option>
            <option value="title_and_content" <%=pageIngredient.getSearchType().equals("title_and_content") ? "selected" : ""%>>
            	제목+내용
            </option>
            <option value="writer" <%=pageIngredient.getSearchType().equals("writer") ? "selected" : ""%>>
            	작성자
            </option>
         </select>
         <input type="text" 
         		id="keyword" 
         		class="keyword" 
         		name="keyword" 
         		value="<%=pageIngredient.getKeyword()%>" 
         		onkeyup="enterSearching();">
         <button id="searchingActivate" type="button" onclick="searchingActivate();">검색</button>
      </div>
      <!-- 게시글 검색기능 끝 -->
      <table>
         <thead>
            <tr>
               <th style="width: 80px;">번호</th>
               <th style="width: 300px;">제목</th>
               <th style="width: 150px;">작성자</th>
               <th style="width: 150px;">작성일</th>
               <th style="width: 80px;">조회수</th>
            </tr>
         </thead>
         <tbody>
            <c:forEach items="${adminBoardList }" var="adminBoardList">
               <tr>
                  <td>${adminBoardList.bno }</td>
                  <td>
                     <a href="/admin/boardView?bno=${adminBoardList.bno }">${adminBoardList.title }</a>
                  </td>
                  <td>${adminBoardList.writer }</td>
                  <td>
                     <fmt:formatDate value="${adminBoardList.regDate}" pattern="yyyy-MM-dd" />
                  </td>
                  <td>${adminBoardList.readCount }</td>
               </tr>
            </c:forEach>
         </tbody>
      </table>
      <c:if test="${memberInfo.userVerify == 128 }">
         <div class="board_write">
            <button class="boardWriteButtonDiv" onclick="location.href='/admin/boardWritePage'">게시글 작성</button>
         </div>
      </c:if>


      <!-- 페이징 시작 -->
      <%
      int selectedPageNum = (int) request.getAttribute("selectedPageNum");

      /* 이전페이지 버튼만들기 */
      if (pageIngredient.isPrevPage() == true) {
      %>
      <span>
         <a href="/announcement/announcement?pageNum=<%=pageIngredient.getStartPage() - 1%>
         	<%=pageIngredient.getSearchTypeAndKeyword()%>">◀이전
         </a>
      </span>
      <%
      }
      /* 페이지 출력하기 */
      for (int i = pageIngredient.getStartPage(); i <= pageIngredient.getEndPage(); i++) {

      if (selectedPageNum != i) {
      %>
      <span>
         <a id="notSelectedPage" 
         	href="/announcement/announcement?pageNum=<%=i%><%=pageIngredient.getSearchTypeAndKeyword()%>">
         	<%=i%>
         </a>
      </span>
      <%
      } else if (selectedPageNum == i) {
      %>
      <span>
         <b style="font-size: 22px"><%=i%></b>
      </span>
      <%
      }
      }
      /* 다음버튼 만들기 */
      if (pageIngredient.isNextPage() == true) {
      %>
      <span>
         <a href="/announcement/announcement?pageNum=<%=pageIngredient.getEndPage() + 1%>
         	<%=pageIngredient.getSearchTypeAndKeyword()%>">다음▶
         </a>
      </span>
      <%
      }
      %>
      <!-- 페이징 끝 -->
   </div>
<!-- footer -->
<jsp:include page="../pageIngredient/footer.jsp" flush="false"></jsp:include>
<!-- footer -->
</body>
<script type="text/javascript" src="/resources/board/boardList/board.js"></script>
</html>