<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>WorkerGuardian Main</title>
	<link rel="stylesheet" href="/css/monitering/main.css"/>
	<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/js/jquery.js"></script>
	<script src="/js/jquery-3.7.1.min.js"></script>
	<script src="/js/common.js"></script>
	
    <style>
    	.content_div_container {
    		width: 100%;
    		height: 85%;
    		display: flex;
    	}
    	
    	.main_content_div {
    		width : 75%;
    		height : 100%;
    		margin-right : 4%;
    	}
    	
    	.side_content_div {
    		width : 25%;
    		height : 100%;
    		display : flex;
    	}
    	
    	.monitering_div {
    		width : 100%;
    		height : 90%;
    		margin-left : 5%;
    		margin-top : 3%;
    		border : 1px solid gray;
    		position : relative;
    	}
    	
    	.site_container_div {
    		width : 100%;
    		height : 100%;
    		display: flex;
    		flex-direction: column;
    		align-items: center;
    	}
    	
    	.site_title_div {
    		margin-top : 3%;
    		width : 100%;
    		height : auto;   		
    	}
    	
    	.siteTitle {
    		margin: 0;
		    margin-top: 5%;
		    margin-bottom: 5%;
		    margin-left: 6%;
    	}
    	
    </style>
    <script>
	    $(document).ready(function () {
			
			
			
	        // 첫 진입 시 현장 선택 메뉴 정보 불러오기
	        $.ajax({
	            url: "/main/siteInfo.ajax",
	            success: function(data) {
	                siteList = data.siteList;
	                var html = '';
	                
	                siteList.forEach(function(site, index) {
	                    var highlightClass = index === 0 ? ' highlight' : '';
	                    html += '<div id="' + site.site_ID + '" class="site-item' + highlightClass + '">' + site.site_NAME + '</div>\n';
	                });
	
	                // 클래스명이 sitemenu인 요소 안에 삽입
	                $('.sitemenu').html(html);
	                
	                $('.site-item').first().trigger('click');
	            },
	            error: function(xhr, status, error) {
	                console.log('ajax 요청에 문제가 있습니다.', error);
	            }
	        });
	    });
	    
	    
	    var ringVal = 1;
        
        var orgId;
        let workername = [];
        let workerid = [];
        var accident = ["낙상", "가스", "위험구역 진입"];
        
        let beaconId = [];
        let beaconName = [];
        
        var nowSiteName = '';

        // 알림 확인 버튼 눌렀을 때
        $(document).on('click', '[id^="alramBtn"]', function() {
            var nowId = $(this).attr('id').replace('alramBtn', '');
            $('#beaconAlram' + nowId).remove();
        });
        

        // 현장 클릭 시 함수 
        $(document).on('click', '.site-item', function() {

            // 기존의 클릭 스타일 지우고, 클릭 된 현장에 클릭 스타일 적용
            $('.site-item').removeClass('highlight');
            $(this).addClass('highlight');
            
            // 정보 가져오기에 필요한 현장 id 추출 및 변수 초기화
            var siteId = $(this).attr('id');
            var siteName = $(this).text();
            
            // 비콘 정보 배열, 현재 현장 초기화 하기
            beaconId = [];
			beaconName = [];
			workername = [];
			workerid = [];
			nowSiteName = '';
			
            // 클릭 시 가져온 id 사용하여 해당 현장의 비콘 정보 가져오기(ajax)
            $.ajax({
			    url: "/main/selectBeaconInfo.ajax",
			    data: { "siteId": siteId },
			    success: function(data) {

			        var backgroundVal = data.background;
			        var beaconInfoList = data.BeaconInfoList;
			        var workerInfoList = data.workerInfoList;
			        var html = '';
			
			        orgId = data.OrgId;
			        
			        beaconInfoList.forEach(function(beaconInfo) {
			            var style = 'margin-left: ' + beaconInfo.beacon_X + '%; margin-top: ' + beaconInfo.beacon_Y + '%;';
			            html += '<div id="' + beaconInfo.uuid + '" class="beacon-box" style="' + style + '">';
			            html +=     '<div class="beaconImg"></div>';
			            html +=     '<div>';
			            html +=         '<p style="margin-right: 26px; color: white;">' + beaconInfo.beacon_NAME + '</p>';
			            html +=     '</div>';
			            html += '</div>\n';
			            
				        // 비콘 정보 배열에 넣기
				        beaconId.push(beaconInfo.uuid);           // id 배열에 넣기
    					beaconName.push(beaconInfo.beacon_NAME);  // 비콘 이름 배열에 넣기
    					
			         
			        });
			        
			        workerInfoList.forEach(function(workerInfo) {
			        	workerid.push(workerInfo.worker_ID);
			        	workername.push(workerInfo.worker_NAME);
			        });
			        
			
			        // 요소 집어넣기
			        $('.monitering_div').html(html);
			        				        
			        // 배경화면 넣기 & 화면 설정하기
			        $('.monitering_div').css('background-image', "url('../siteFile/" + backgroundVal.site_ID + "/" + backgroundVal.file_NAME + "')");
	            	$('.monitering_div').css('background-size','cover');
	            	$('.monitering_div').css('background-repeat','no-repeat');
	            	
	            	// 현장 선택 정보 타이틀 띄우기
	            	$('#siteTitle').text(siteName);
	            	
	            	
/* 	            	if(workername.length <= 0 || workername == null) {
	            		return false;
	            	} else {
	            		// 이후 작업 진행 - 비콘 정보 배열 사용해서 랜덤으로 안내 메세지 뜨게하는 함수 실행하기
			            interval = setInterval(function() { randomAlram( beaconId,beaconName,siteId ) }, 15000);
	            	} */
		            	
			    },
			    error: function(xhr, status, error) {
			        console.log('ajax 요청에 문제가 있습니다.', error);
			    }
			});
        });
    </script>
</head>
<body>
    <div class="main_div">  
        <div class="menu_div"> 
            <div class="logo_div"></div> 
            <div class="menuZip">
                <div class="topMenuDiv">
                    <div class="login"><p>${loginInfo.USER_NAME}님</p></div>
                    <div class="logout"><p>로그아웃</p></div>
                    <div class="mypage"><p>마이페이지</p></div>
                    <div class="help" style="width:110px;"><p>사용자 매뉴얼</p></div>
                    <input type="hidden" id="userInfo" value="${loginInfo.USER_ID}"></input>
                </div>
                <div class="bottomMenuDiv">
                    <div class="menu"><h2 style="margin: 0;"><a style="text-decoration: none; color: #2e5fd7;" href='/first.do'>현장 모니터링</a></h2></div>
                    <div class="menu"><h2 style="margin: 0;"><a style="text-decoration: none; color: black;" href='/view/viewInventory.do'>현장 관리</a></h2></div>
                    <div class="menu"><h2 style="margin: 0;"><a style="text-decoration: none; color: black;" href='/safeevent/safeEvent.do'>안전 이벤트</a></h2></div>
                    <div class="menu"><h2 style="margin: 0;"><a style="text-decoration: none; color: black;" href='/beacon/beaconInventory.do'>비콘 관리</a></h2></div>
                    <div class="menu"><h2 style="margin: 0;"><a style="text-decoration: none; color: black;" href='/gas/gasInventory.do'>가스 센서 관리</a></h2></div>
                    <div class="menu"><h2 style="margin: 0;"><a style="text-decoration: none; color: black;" href='/worker/workerInventory.do'>작업자 관리</a></h2></div>
                </div>
            </div>
        </div>
        <div class="bread_div">
            <div class="breadcrumb">
                 <div class="home"></div>
                <div class="next"></div>
                <div class="menu1" style="color: white; font-size: 16px;">현장 모니터링</div>
            </div>
        </div>
        <div class="content_div_container">
        	<div class="main_content_div">
        		<div class="monitering_div">
        			
        		</div>
        	</div>
        	<div class="side_content_div">
        		<div class="site_container_div">
        			<div class="site_title_div">
        				<h1 class="siteTitle">현장 선택</h1>
        			</div>
        			<div class="sitemenu">

                	</div>
                	<div class="site_title_div">
        				<h1 class="siteTitle">비콘 등록/수정</h1>
        			</div>
        			<div class="beacon_content_div">
        				
        			</div>
        		</div>
        	</div>
        </div>
    </div>
</body>


</html>