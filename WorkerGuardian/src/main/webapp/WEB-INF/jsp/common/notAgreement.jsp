<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>세션 만료</title>
	<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/js/jquery.js"></script>
	<script src="/js/jquery-3.7.1.min.js"></script>
	<script src="/js/common.js"></script>
</head>
<script>
$(document).ready(function() {
	alert("비밀번호가 일치하지 않습니다. 다시 확인해주세요.");
	window.location.href = '/mypage/mypageGo.do';
});

</script>
<body>

</body>
</html>