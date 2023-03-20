/*ajax -> 리뷰등록*/

function writeReview(pno) {

	let writeReviewYN = confirm("제품 리뷰 등록을 하시겠습니까?");

	if (writeReviewYN == true) {

		let rvWriter = document.getElementById("rvWriter").value;
		let rvTitle = document.getElementById("rvTitle").value;
		let rvContent = document.getElementById("rvContent").value;

		let reviewBoardDTO = {
			"pno": pno,
			"rvWriter": rvWriter,
			"rvTitle": rvTitle,
			"rvContent": rvContent
		};

		if (rvWriter.length < 4) {
			alert("작성자는 최대 4자 이상으로 입력해주세요");

			return false;
		}

		if (rvTitle.length < 4) {
			alert("제목은 최대 15자 이상으로 입력해주세요");

			return false;
		}

		if (rvContent.length < 15) {
			alert("내용은 최대 15자 이상으로 입력해주세요");

			return false;
		}

		console.log(reviewBoardDTO);

		$.ajax({
			url: "/review/reviewWrite",
			type: "post",
			data: reviewBoardDTO,

			success: function(result) {

				alert("리뷰등록이 완료되었습니다.");

			},
			error: function(error) {
				console.log(error);
			}
		})
	}

}

/*문의 등록 ajax*/
function writeInq(inqPno){

	let writeInqYN = confirm("제품 리뷰 등록을 하시겠습니까?");

	if (writeInqYN == true) {

		let inquierUserId = document.getElementById("inquierUserId").value;
		let inquierTitle = document.getElementById("inquierTitle").value;
		let inquierContent = document.getElementById("inquierContent").value;


		if (inquierUserId.length < 4) {
			alert("작성자는 최대 4자 이상으로 입력해주세요");

			return false;
		}

		if (inquierTitle.length < 4) {
			alert("제목은 최대 15자 이상으로 입력해주세요");

			return false;
		}

		if (inquierContent.length < 15) {
			alert("내용은 최대 15자 이상으로 입력해주세요");

			return false;
		}
		/*
			private int pno;
			private String userId;
			private String askTitle;
			private String askContent;
			private Date askRegDate;
		*/
		$.ajax({
			url: "/inquire/inquireWrite",
			type: "post",
			data: {
				pno : inqPno,
				userId : inquierUserId,
				askTitle : inquierTitle,
				askContent : inquierContent
			},

			success: function(result) {

				alert("리뷰등록이 완료되었습니다.");

			},
			error: function(error) {
				console.log(error);
			}
		})
	}

}