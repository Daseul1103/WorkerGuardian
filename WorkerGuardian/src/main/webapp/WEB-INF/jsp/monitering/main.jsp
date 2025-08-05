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
	
    <script>
	    $(document).ready(function () {
	
	    	var siteList;
	    	
	        // 첫 진입 시 현장 선택 메뉴 정보 불러오기
	        $.ajax({
	            url: "/main/siteInfo.ajax",
	            success: function(data) {
	                siteList = data.siteList;
	                var html = '';
	
	                siteList.forEach(function(site) {
	                    html += '<div id="' + site.site_ID + '" class="site-item">' + site.site_NAME + '</div>\n';
	                });
	
	                // 클래스명이 sitemenu인 요소 안에 삽입
	                $('.sitemenu').html(html);
	            },
	            error: function(xhr, status, error) {
	                console.log('ajax 요청에 문제가 있습니다.', error);
	            }
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
		            	
		            	
		            	if(workername.length <= 0 || workername == null) {
		            		return false;
		            	} else {
		            		// 이후 작업 진행 - 비콘 정보 배열 사용해서 랜덤으로 안내 메세지 뜨게하는 함수 실행하기
				            interval = setInterval(function() { randomAlram( beaconId,beaconName,siteId ) }, 15000);
		            	}
    		            	
				    },
				    error: function(xhr, status, error) {
				        console.log('ajax 요청에 문제가 있습니다.', error);
				    }
				});
	        });
	        
	        
	        
	     	// 도움말 파일 다운로드하기
            $('.help').on('click', function() {
            	helpDownLoad();
    		});
	     	
	     	// 로그아웃 버튼
            $('.logout').on('click', function() {
            	logoutChk();
	        });
	     	
         	// 마이페이지 버튼
	     	$('.mypage').on('click', function() {
	     		mypageGo();
	     	});
	        
	
	    });
	    
	    
	 // 알람 띄우기 전 사전 작업 함수
        function randomAlram(beaconId, beaconName ,siteId) {
        	
        	// 받아온 데이터가 있는지 확(비어 있는지)
        	if (!beaconId.length || !beaconName.length) {
		        /* console.log("비콘 정보가 없습니다."); */
		        return false;
		    } else {
		    	if (beaconId.length !== beaconName.length) { // 길이가 다르면 안됨
		            /* console.log("비콘 ID와 이름 배열 길이가 다릅니다."); */
		            return false;
		        } else {
		        	/* console.log("길이 같음"); */
		        	var arrayLength = beaconId.length;
		        	var randomIndex = Math.floor(Math.random() * arrayLength);  // 비콘 고르기 전용 랜덤 변수
					
		        	var now = new Date();  // 날짜 변수

	            	 var yy = String(now.getFullYear()).slice(2); // 날짜 변수
	            	 var mm = String(now.getMonth() + 1).padStart(2, '0'); // 날짜 변수
	            	 var dd = String(now.getDate()).padStart(2, '0'); // 날짜 변수

	            	 var hh = String(now.getHours()).padStart(2, '0'); // 날짜 변수
	            	 var min = String(now.getMinutes()).padStart(2, '0'); // 날짜 변수
	            	 var ss = String(now.getSeconds()).padStart(2, '0'); // 날짜 변수

	            	 var currentDateTime = yy + '/' + mm + '/' + dd + ' ' + hh + ':' + min + ':' + ss; // 날짜 변수
	            	 
	            	 var workerLength = workername.length;
	            	 var workerIndex = Math.floor(Math.random() * workerLength); // 0~5 까지 출력 - 작업자 뽑기 전용 랜덤 변수
	            	 var accidentIndex = Math.floor(Math.random() * 3); // 0~2 까지 출력 - 사고 뽑기 전용 랜덤 변수
		        	
	            	 // 알림 만들어서 띄워주는 함수
	            	 makeAlram(randomIndex,workerIndex,accidentIndex,currentDateTime,siteId);
		        	
		        }
		    }
        	
        	
        	function makeAlram(randomIndex,workerIndex,accidentIndex,currentDateTime,siteId) {
        		
        		var dOrgId = orgId;
    	 		  var dSiteId = siteId;
    	 		  var dBeaconId = beaconId[randomIndex];
    	 		  var dWorkerId = workerid[workerIndex];
    	 		  var dEventType = '';
    	 		  
    	 		  
    	 		  if(accidentIndex == 0) {
    	 			dEventType = "F";
    	 		  } else if(accidentIndex == 1) {
    	 			dEventType = "G";
    	 		  } else {
    	 			dEventType = "D";
    	 		  }
    	 		 
    	 		  
    	 		$.ajax({
				    url: "/main/insertTestData.ajax",
				    data: {
				        "ORG_ID" : dOrgId,
				        "SITE_ID" : dSiteId,
				        "UUID" : dBeaconId,
				        "WORKER_ID" : dWorkerId,
				        "EVENT_TYPE" : dEventType,
				        "EVENT_TIME" : currentDateTime
				    },
				    success: function(data) {
				    	console.log("ajax 성공");
				    },    				    
				    error: function(xhr, status, error) {
				        console.log('ajax 요청에 문제가 있습니다.', error);
				    }
				    
    	 		});
    	 		
    	 		
    	 		
        		// 알림 생성하기 (고쳐야됨)
        		
        		var inputText = 
      	 		  '<div id="beaconAlram' + ringVal + '">' +
      	 		    '<div class="alramTitle">' +
      	 		      '<div class="titleDiv">' +
      	 		        '<div class="alramTitleBig">' +
      	 		          '<h2 style="margin: 0;">알림</h2>' +
      	 		        '</div>' +
      	 		        '<div class="alramDate">' +
      	 		          currentDateTime +
      	 		        '</div>' +
      	 		      '</div>' +
      	 		      '<div class="areaLineDiv">' +
      	 		      '</div>' +
      	 		    '</div>' +

      	 		    '<div class="alramContent">' +
      	 		      '<p style="margin-left: 40px;">' + workername[workerIndex] + ' 작업자</p>' +
      	 		      '<p style="margin: 0; margin-left: 40px;"> ' + beaconName[randomIndex]  + '에서 ' + accident[accidentIndex] + ' 사고 발생</p>' +
      	 		    '</div>' +

      	 		    '<div class="alramBtn">' +
      	 		      '<button id="alramBtn' + ringVal + '" style="margin-bottom: 20px;">확인</button>' +
      	 		    '</div>' +
      	 		  '</div>';
      	 		  
      	 		  
      	 		  // 알림함에 알림 넣기 (만들어야 됨)
      	 		  var highlightedId = $(".site-item.highlight").attr("id");
      	 		  var highlightedSiteName = null;
      	 		  
      	 		  siteList.forEach(function(site) {
					    if (site.site_ID === highlightedId) {
					       highlightedSiteName = site.site_NAME;
					    }
					});
      	 		  
      	 		  var alramText = '<div class="alram-item">' +
	          	    '<div class="alram-item-date">' + highlightedSiteName +  " - "+ currentDateTime + '</div>' +
	          	    '<p>' + workername[workerIndex] + ' 작업자 ' + beaconName[randomIndex] + '에서 ' + accident[accidentIndex] + ' 사고 발생</p>' +
	          	  	'</div>';
      	  	
      	 		  // text input 하기
      	 		  $("#" + beaconId[randomIndex]).append(inputText); // 비콘에 알람 띄우기
      	 		  $('.alramMenu').prepend(alramText); // 알림함에 띄우기
      	 		  
      	 		  // 알림 인덱스 증가 시키기
      	 		  ringVal = ringVal + 1; 
      	 		  
        	}
        }
    </script>
</head>
<body>
    <div class="main_div">  <!-- 메인 div -->
        <div class="menu_div"> <!-- 메뉴 div -->
            <div class="logo_div"></div> <!-- 로고 사진 첨부-->
            <div class="menuZip">
                <div class="topMenuDiv">
                    <div class="login"><p>${loginInfo.USER_NAME}님</p></div>
                    <div class="logout"><p>로그아웃</p></div>
                    <div class="mypage"><p>마이페이지</p></div>
                    <div class="help" style="width:110px;"><p>사용자 매뉴얼</p></div>
                    <input type="hidden" id="userInfo" value="${loginInfo.USER_ID}"></input>
                </div>
                <div class="bottomMenuDiv">
                    <div class="menu"><h2 style="margin: 0;"><a style="text-decoration: none; color: #2e5fd7;v" href='/first.do'>현장 모니터링</a></h2></div>
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
        <div class="title_div">
            <div class="title">
                <h1 id="siteTitle">현장 미선택</h1>
            </div>
        </div> 
        <div class="content_div">
            <div class="monitering_div">

            </div>

		<div class="sideMenu">
            <div class="sitemenu_div">
            	<div class="sitetile">
                    <h1 style="margin: 0;">현장 선택</h1>
                </div>
                <div class="sitemenu">
                    <!-- <div id="Kc2Ah" class="site-item">현장 1</div>
                    <div id="Kl0Zr" class="site-item">현장 2</div>
                    <div id="q3333" class="site-item">현장 3</div>
                    <div id="w4444" class="site-item">현장 4</div>
                    <div id="e5555" class="site-item">현장 5</div> -->
                </div>
            </div>
            <div class="message_div">
                    <div class="sitetile">
                        <h1 style="margin: 0;">알림함</h1>
                    </div>
                    <div class="alramMenu">

                    </div>
                </div>
            </div>
        </div>
       
        </div>
    </div>
</body>


</html>