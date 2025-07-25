<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WorkerGaurdian</title>
	<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/js/jquery.js"></script>
	<script src="/js/jquery-3.7.1.min.js"></script>
	<script src="/js/common.js"></script>
	<script>
		$(document).ready(function() {
			alert("회원가입이 완료 되었습니다. 로그인 화면으로 이동합니다.");
			window.location.href = '/login/login.do';
		});	
	</script>
</head>
<body>
	
</body>
</html>