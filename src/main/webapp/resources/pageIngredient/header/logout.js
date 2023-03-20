/*로그아웃*/
function memberLogout() {
	let logoutYN = confirm("로그아웃 하시겠습니까?");

	if (logoutYN == true) {
		alert("로그아웃 되었습니다");
		location.href = "/member/memberLogout"; /* 세션 invalidate */

	} else {
		alert("로그아웃을 취소하셨습니다.");
	}
}

