function findAddr() {
	new daum.Postcode({
		oncomplete: function(data) {
			console.log(data);

			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			let roadAddr = data.roadAddress; // 도로명 주소 변수
			let jibunAddr = data.jibunAddress; // 지번 주소 변수
			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			document.getElementById('postAddress').value = data.zonecode;
			if (roadAddr !== '') {
				document.getElementById("address").value = roadAddr;
			}
			else if (jibunAddr !== '') {
				document.getElementById("address").value = jibunAddr;
			}
		}
	}).open();
}


function editInfo() {

	// let id = document.getElementById("userId").value
	let id = document.getElementById("userId").value
	let pwd = document.getElementById("userPwd").value
	let name = document.getElementById("userName").value
	let email = document.getElementById("userEmail").value
	let phone = document.getElementById("PhoneNumber").value
	let address = document.getElementById("address").value
	let detailAddress = document.getElementById("detailAddress").value
	let check = true

	if (id !== "${userId}") {
		document.getElementById("idError").innerHTML = "아이디는 수정할 수 없습니다."
		check = false;
	} else {
		document.getElementById("idError").innerHTML = ""
	}

	if (pwd === "" || pwd.length < 8 ) {
		document.getElementById("pwdError").innerHTML = "비밀번호는 반드시 8자리 이상으로 입력해주세요."
		check = false;
	} else {
		document.getElementById("pwdError").innerHTML = ""
	}

	if (name === "") {
		document.getElementById("nameError").innerHTML = "이름은 수정할 수 없습니다."
		check = false
	} else {
		document.getElementById("nameError").innerHTML = ""
	}

	if (email === "") {
		document.getElementById("emailError").innerHTML = "이메일은 비워둘 수 없습니다."
		check = false
	} else {
		document.getElementById("emailError").innerHTML = ""
	}

	if (address === "") {
		document.getElementById("addressError").innerHTML = "주소를 검색해주세요."
		check = false
	} else {
		document.getElementById("addressError").innerHTML = ""
	}

	if (detailAddress === "") {
		document.getElementById("detailAddError").innerHTML = "상세주소를 입력해주세요."
		check = false
	} else {
		document.getElementById("detailAddError").innerHTML = ""
	}

	if (check) {
		document.getElementById("pwdError").innerHTML = ""
		document.getElementById("nameError").innerHTML = ""
		document.getElementById("emailError").innerHTML = ""
		document.getElementById("phoneError").innerHTML = ""
		document.getElementById("addressError").innerHTML = ""
		document.getElementById("detailAddError").innerHTML = ""

		// setTimeout
		setTimeout(function() {
			alert("수정이 완료되었습니다.")
		}, 0);
	}
}

function removeMember() {
	
	let removeYN = confirm("정말 탈퇴하시겠습니까? 탈퇴된 정보는 복구되지 않습니다.");
	
	if(removeYN){
		
		let userId = document.getElementById("userId");
		let userPwd = document.getElementById("userPwd");
		
		if(userPwd.value == "" || userPwd.value.length < 4){
			alert("비밀번호는 반드시 4자 이상 입력해주세요");
			return false;
		}
		$.ajax({
			url : "/member/removeMember",
			type : "post",
			data : {
				"userId" : userId.value,
				"userPwd" : userPwd.value
			},
			dataType : "json",
			success : function(result){
				if(result == true){
	
					alert("회원 탈퇴가 완료되었습니다.");	
					location.href = "/member/memberLogout";
					
				} else {
					
					alert("비밀번호 불일치로 회원 탈퇴에 실패하였습니다.");	
					return false;
				}
				
			},
			error : function(error){
				
				alert("알 수 없는 오류로 회원탈퇴에 실패하였습니다.");
				

			}
		})
		
		
	} else {
		alert("탈퇴가 취소되었습니다.");
		
		return false;
	}
}

