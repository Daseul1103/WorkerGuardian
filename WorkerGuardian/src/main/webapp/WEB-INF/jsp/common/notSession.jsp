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
	alert("세션이 만료되었습니다. 다시 로그인 해 주세요.");
	window.location.href = '/login/login.do';
});

</script>
<body>

</body>
</html>