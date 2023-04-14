<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.project.board.domain.BoardReplyDTO" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<title>공지사항 조회</title>
<link rel="stylesheet" type="text/css" href="/resources/board/boardView/boardView.css">
</head>
<!-- header -->
<jsp:include page="../pageIngredient/header.jsp" flush="false"></jsp:include>
<!-- header -->
<div id="boardTB">
	<div class="col-1">
		<h2>${boardDTO.bno }. 공지사항</h2>
		<form method="post">
			<table>
				<thead>
					<tr align="center">
						<th style="width: 250px;">조회수</th>
						<th style="width: 600px;">게시글 제목</th>
						<th style="width: 250px;">작성자</th>
					</tr>
				</thead>
				<tbody>
					<tr align="center">
						<td>${boardDTO.readCount }</td>
						<td>${boardDTO.title }</td>
						<td>${boardDTO.writer }</td>
					</tr>
				</tbody>	
			</table>
			<br>
			
			<div>
				<label>내용</label>
			</div>
			
			<br>
			<textarea rows="5" cols="50" class="boardTextarea" name="content" maxlength="2000" readonly="readonly">${boardDTO.content}</textarea>
			<br>
		</form>
		
		<div align="right" class="modifyAndDelete">
			<a href="/admin/boardModifyPage?bno=${boardDTO.bno }">
				<button type="button" class="boardUpdate">수정</button>
			</a>
			<a onclick="javascript:removeContent('${boardDTO.bno}');">
				<button type="button" class="boardDelete">삭제</button>
			</a>
		</div>
	</div>
	
	<div class="col-2">
		<hr>
		<!-- 댓글 구현하기 -->
		<h2>댓글</h2>
		<div align="center">
			<table>
				<thead>
					<tr align="center">
						<th style="display: none;">댓글 번호</th>
						<th style="width: 250px;">작성자</th>
						<th style="width: 600px;">내용</th>
						<th style="width: 100px;">수정/삭제</th>
					</tr>
				</thead>
				<tbody>
					<%
					List<BoardReplyDTO> replyList = (List<BoardReplyDTO>) request.getAttribute("replyDTO");

					for (int replyNum = 0; replyNum < replyList.size(); replyNum++) {
					%>
					<tr class="replyVO">
						<td class="replyRno" style="display: none;"><%=replyList.get(replyNum).getRno()%></td>
						<td id="replyBno" class="replyBno" style="display: none;"><%=replyList.get(replyNum).getBno()%></td>
						<td>
							<div class="replyWriter" style="margin-left: 20px;"><%=replyList.get(replyNum).getWriter()%></div>
							<div>
								<div class="replyRegDate" align="right" style="margin-right: 20px;">
									<font size="2" color="gray"> <fmt:formatDate value="<%=replyList.get(replyNum).getRegDate()%>" pattern="yyyy-MM-dd" />
									</font>
								</div>
							</div>
						</td>

						<td id="replyContent" class="replyContent"><%=replyList.get(replyNum).getContent()%></td>

						<td style="padding-right: 5px;" align="center">
							<font size="2"><button class="replyModifyBtn" type="button">[수정]</button></font>
							<br>
							<font size="2">
								<button class="replyDeleteBtn" type="button" onclick="removeReply('<%=replyList.get(replyNum).getRno()%>','<%=replyList.get(replyNum).getBno()%>');">[삭제]</button>
							</font>
						</td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>
	</div>

		<!-- 댓글 수정 모달창 : #modal -->
		<div id="modal" class="modal_overlay">
			<!-- 댓글의 내용을 입력하는 클래스 : .modal_content -->
			<div class="modal_content">
				<button type="button" class="close-button" onclick="modalClose();">X</button>
				<!-- modal_window -->
				<div class="replyTitle">
					<h2>댓글 수정</h2>
				</div>
				<br>
				<div class="replyContent">
					<div style="margin-right: 20px;" align="left">
						<!-- 댓글번호 -->
						<input id="modalRno" type="hidden">
						<!-- 작성자 -->
						<label title="작성자는 수정이 불가능합니다" >작성자 : </label>
						<input id="modalWriter" type="text" readonly="readonly" style="pointer-events: none;">
						<br>
						<!-- 비밀번호 -->
						<label>비밀번호 : </label>
						<input id="modalPwd" type="password" placeholder="비밀번호를 입력해주세요">
					</div>
					<hr>
					<!-- 글 내용 -->
					<textarea id="modalContent" rows="5" cols="80" style="width: 98%; resize: none;" required="required"></textarea>
				</div>
				<div align="right">
					<button class="replyModalModify" onclick="modifyReply(${boardDTO.bno});">댓글수정</button>
					<button class="replyModalCancel" type="button" id="modalClose" onclick="modalClose();">취소</button>
				</div>
			</div>
			<div class="modal_layer"></div>
			
		</div>
		<!-- 댓글 수정 modal창 끝 -->

		<br>
		<hr>
	<div class="col-3">
		<h2>댓글 작성</h2>

		<div align="center">
			<table>
				<thead>
                    <tr>
                        <th style="border-bottom: none;">
                            <div class="reply-in" align="left">
                                <input id="writer" type="text" placeholder="닉네임을 입력하세요.">
                            </div>
                            <div class="reply-in" align="left">
                                <input id="replyPwd" type="password" placeholder="비밀번호를 입력하세요.">
                            </div>
                        </th>
                    </tr>
                </thead>
				<tbody>
					<tr>
						<td style="border-bottom: none;">
							<textarea id="content" rows="5" cols="100" placeholder="내용을 입력하세요"></textarea>
							<div align="right">
								<button class="replySubmitButton" onclick="writeReply('${boardDTO.bno}');">등록</button>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- 댓글 구현 끝 -->
	</div>
</div>

<!-- footer -->
<jsp:include page="../pageIngredient/footer.jsp" flush="false"></jsp:include>
<!-- footer -->
</body>
<script type="text/javascript" src="/resources/board/boardView/boardView.js"></script>
</html>