
/*슬라이드 배너*/
const swiper = new Swiper('.swiper', {
	autoplay: {
		delay: 2500,
		disableOnInteraction: false,
	},
	loop: true,

	pagination: {
		el: '.swiper-pagination',
		clickable: true,
	},

	navigation: {
		nextEl: '.swiper-button-next',
		prevEl: '.swiper-button-prev',
	},

});

function memberLogout() {
	let logoutYN = confirm("로그아웃 하시겠습니까?");

	if (logoutYN == true) {
		alert("로그아웃 되었습니다");
		location.href = "/member/memberLogout"; /* 세션 invalidate */

	} else {
		alert("로그아웃을 취소하셨습니다.");
	}
}