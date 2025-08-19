<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비콘 위치 선택</title>
	<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/js/jquery.js"></script>
	<script src="/js/jquery-3.7.1.min.js"></script>
	<script src="/js/common.js"></script>
</head>
<script>
	$(document).ready(function() {

		// 부모창에서 받아온 값 변수 처리
		var siteVal = '${siteIdVal}'; // 현장 아이디
		var fileVal = '${fileNameVal}'; // 파일명
		
		var fileUrl = '../siteFile/' + siteVal + '/' + fileVal;

		$('.monitering_div').css('background-image', 'url("' + fileUrl + '")');
		$('.monitering_div').css('background-size','cover');
    	$('.monitering_div').css('background-repeat','no-repeat');
    	
    	
    	// 화면에서 커서 클릭 시
    	var w = $('.monitering_div').width();   // 내용 영역(content) 기준 가로 길이
		var h = $('.monitering_div').height();  // 내용 영역(content) 기준 세로 길이

		$('.monitering_div').on('click', function(e) {
		    // div의 크기
		    var divWidth = $(this).width();
		    var divHeight = $(this).height();
		    
		    // 클릭한 좌표 (div 내부 기준)
		    var clickX = e.offsetX;
		    var clickY = e.offsetY;
		    
		    // 퍼센트로 변환
		    var percentX = (clickX / divWidth) * 100;
		    var percentY = (clickY / divHeight) * 100;
		    
		    console.log("X:", percentX.toFixed(2) + "%, Y:", percentY.toFixed(2) + "%");
		    
		    if (window.opener && !window.opener.closed) {
		        window.opener.receiveCoords(percentX.toFixed(2), percentY.toFixed(2));
		    }
		    
		    // 자식창 닫기
		    alert("위치가 선택 되었습니다. 현재 창을 닫고 비콘 등록 화면으로 이동합니다.");
		    window.close();
		});

	});
</script> 
<body>
	<div class="main_content_div" style="padding-left:65px;">
		<div class="main_title_div">
			<h1>비콘 위치 선택</h1>
		</div>
		<div class="mini_title_div">
			<p>설치 된 비콘의 위치를 아래에서 선택해주세요.</p>
		</div>
		<div class="content_div">
			<div class="monitering_div" style="width:625px; height:328.39px; border: 1px solid;"> <!-- 여기에 선택된 현장의 사진 넣기 -->
			</div>
		</div>

	</div>
</body>
</html>