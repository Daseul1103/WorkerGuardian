//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/* 회원가입 시 유효성 검사 함수 */

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function joinOkChkFunc($form,dupleChk,orgChk) {
	// 사용 예시
	
	var userId = $form.find('#USER_ID').val();
    var userPw = $form.find('#USER_PW').val();
	var userName = $form.find('#USER_NAME').val();
	var userPhone = $form.find('#USER_PHONE').val();
	var userOrg = $form.find('#ORG_ID').val();
	
	
	if (userId === "") {
	    alert("아이디를 입력해 주세요.");
	    $form.find('#USER_ID').focus();
	    return false;
	} else if (userPw === "") {
	    alert("비밀번호를 입력해 주세요.");
	    $form.find('#USER_PW').focus();
	    return false;
	} else if (userName === "") {
	    alert("이름을 입력해 주세요.");
	    $form.find('#USER_NAME').focus();
	    return false;
	} else if (userPhone === "") {
	    alert("휴대폰 번호를 입력해 주세요.");
	    $form.find('#USER_PHONE').focus();
	    return false;
	} else if (userOrg === "") {
	    alert("소속 회사 코드를 입력해 주세요.");
	    $form.find('#ORG_ID').focus();
	    return false;
	} else if (dupleChk == false) {
	    alert("아이디 중복 확인 버튼을 클릭하여 중복 확인해 주세요.");
	    console.log(dupleChk);
	    $form.find('#USER_ID').focus();
	    return false;
	} else if (orgChk == false) {
		alert("회사 확인 버튼을 클릭하여 소속 회사 증명을 확인해 주세요.");
		return false;
	} else {
			
		$form.submit();
		
	}
	
	return false;
}