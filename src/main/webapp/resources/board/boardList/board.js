function searchingActivate() {
	let searchType = document.getElementsByName("searchType")[0].value;
	let keyword = document.getElementsByName("keyword")[0].value;
	
	/* select 태그의 value인 searchType에 관한 option태그의 값과
	input태그에 들어간 keyword 값을 쿼리스트링으로 보내 첫페이지를 출력한다. */
	location.href = "/announcement/announcement?pageNum=1" + "&searchType="
		+ searchType + "&keyword=" + keyword;
	
}

/* input 태그 안에서 enter키 (keyNumber == 13) 누르면 검색 시작. */
function enterSearching() {
	if (window.event.keyCode == 13) {
		searchingActivate();
	}
}