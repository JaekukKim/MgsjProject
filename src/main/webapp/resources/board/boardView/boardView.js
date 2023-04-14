/**
 *  게시글 삭제, 댓글 관련, modal 로직
 */
function removeContent(bno) {
	let YN = confirm('정말 [' + bno + ']번 게시글을 삭제하시겠습니까?\n삭제된 정보는 복구되지 않습니다.');

	if (YN == true) {
		
		$.ajax({
			url : '/admin/boardDelete',
			type : 'post',
			data : {
				bno : bno
			},
			
			success : function(){
				
				alert('게시글이 삭제되었습니다.');
				
				location.href = "/announcement/announcement?pageNum=1";
				
			},
			error : function(errorMsg){
				
				alert("댓글이 달린 게시글은 삭제할 수 없습니다");
				
				return false;
			}
			
		})
		
	} else {
		alert('게시글 삭제를 취소하셨습니다.');
		
		return false;
	}
}

/* 댓글 등록 js 로직 (ajax) */
function writeReply(bno) {

	let writer = document.getElementById("writer").value;
	let content = document.getElementById("content").value;
	let replyPwd = document.getElementById("replyPwd").value;

	if (writer.length < 2 || writer.length > 12) {
		alert("닉네임은 2글자 이상 12글자 이하여야 합니다.");
		document.getElementById("writer").focus();
		return false;
	}

	if (content.length == 0) {
		alert("댓글 내용은 반드시 입력되어야 합니다.");
		document.getElementById("content").focus();
		return false;
	}
	
	if(replyPwd.length != 6){
		alert("비밀번호는 6자리의 숫자로 입력해주세요");
		document.getElementById("replyPwd").focus();
		return false;
	}

	$.ajax({
		url: "/reply/replyWrite",
		type: "POST",
		data: {
			'bno': bno,
			'writer': writer,
			'content': content,
			'replyPwd' : replyPwd
		},

		success: function(data) {
			
			alert("댓글작성이 완료되었습니다.");
			location.reload(true);
			
		},
		error: function(error) {
			alert("알 수 없는 에러가 발생하였습니다.");
			console.log(error);
		}
	});
}

/* --------------------------- 댓글수정 관련 JS 로직 --------------------------- */
$(".replyVO").on("click", ".replyModifyBtn", function() {

	// 모달창에 보내주기 전, 데이터를 따내야한다.
	let replyVO = $(this).closest(".replyVO");

	let rno = replyVO.find(".replyRno").text();

	let writer = replyVO.find(".replyWriter").text();

	let content = replyVO.find(".replyContent").text();

	// 모달창에 댓글번호, 내용, 작성자를 보내주어야 한다.
	$("#modalRno").val(rno);
	$("#modalWriter").val(writer);
	$("#modalContent").val(content);

	modalOpen();
	
})

/* 댓글 수정 서버단 js(ajax) 로직 */
function modifyReply(bno) {

	let rno = document.getElementById("modalRno").value;
	let content = document.getElementById("modalContent").value;
	let pwd = document.getElementById("modalPwd").value;
	
	if(pwd == "" || pwd.length < 0 ){
		alert("비밀번호를 반드시 입력 해 주세요");
		
		return false;
	}
	
	$.ajax({
		url: "/reply/replyModify",
		type: "POST",
		data: {
			'bno': bno,
			'rno': rno,
			'content': content,
			'replyPwd' : pwd
		},
		dataType : 'json',

		success: function(data) {
			
			if(data == true) {
				
				alert("댓글수정이 완료되었습니다.");
				location.reload(true);
				modalClose();
				
			} else {
				
				alert("비밀번호가 일치하지 않습니다.");
			}
		},
		error: function(error) {
			alert("알 수 없는 에러가 발생하였습니다.");
			alert(error);
		}
	});

}

/* --------------------------- 댓글수정 관련 JS 로직 끝 --------------------------- */


/* 댓글 삭제 js(ajax) 로직 */
function removeReply(bno,rno) {

	let removeYN = confirm("댓글을 삭제하시겠습니까? 삭제된 정보는 복구되지 않습니다.");
	
	if (removeYN == true) {
	
		$.ajax({
			url: "/reply/replyDelete",
			type: "POST",
			data: {
				'rno': rno,
				'bno': bno,
				'replyPwd' : pwd
			},

			success: function(data) {
				
				if(data == true){
					
					alert("삭제가 완료되었습니다.");
					location.reload(true);
					
				} else {
					
					alert("입력하신 비밀번호가 틀립니다.");
				}
			},
			error: function(error) {
				alert("삭제도중 알 수 없는 오류가 발생하였습니다.");
			}
		});
		
	} else {
		alert("삭제가 취소되었습니다.");
	}

}

/* --- 댓글 수정 모달창 js 로직 --- */
const replyModal = document.getElementById("modal");
function modalOpen() {
	replyModal.style.display = 'block';
}

function modalClose() {
	$("#modalContent").val("");
	replyModal.style.display = 'none';
}

/* 모달창 외의 영역을 클릭하면 모달창이 꺼지게 만들기 */
replyModal.addEventListener("click", e => {
	const evTarget = e.target;
	if (evTarget.classList.contains("modal_layer")) {
		
		replyModal.style.display = "none";
		
	}
})

/* 모달창에서 esc를 누르면 모달창이 꺼지게 만들기 */
window.addEventListener("keyup", e => {
	if (replyModal.style.display === "block" && e.key === "Escape") {
		replyModal.style.display = "none";
	}
})