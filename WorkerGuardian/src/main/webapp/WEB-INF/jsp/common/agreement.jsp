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
	alert("성공적으로 인증되었습니다.");
	window.location.href = '/mypage/mypageGo.do';
});

</script>
<body>

</body>
</html>