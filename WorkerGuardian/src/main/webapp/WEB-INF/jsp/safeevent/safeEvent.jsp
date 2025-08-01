<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>WorkerGuardian</title>
	<link rel="stylesheet" href="/css/safeevent/safeevent.css"/>
	<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/js/jquery.js"></script>
	<script src="/js/jquery-3.7.1.min.js"></script>
	<script src="/js/common.js"></script>
	
	<script>
	  $(document).ready(function() {
		  
		 // 엑셀 파일 다운로드 버튼 클릭 함수
	    $('.fileDownBtn').on('click', function() {
	    	searchFrm.action = '/safetyEvent/ExcellDownLoad.do';
	    	searchFrm.submit();
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
     	
     	
     	
     	// 검색 버튼 클릭 시 
     	$('.searchBtn').on('click', function(e) {
     		e.preventDefault();
     		console.log("검색 버튼 클릭");
     		
     		var startDate = $('#start_date').val();
     		var endDate = $('#end_date').val();
     		var start = new Date(startDate);
     	    var end = new Date(endDate);
     		
     		if(startDate != "" && endDate == "") {
     			alert("종료일을 입력해 주세요.");
     			return false;
     		} else if (startDate == "" && endDate != "") {
     			alert("시작일을 입력해 주세요.");
     			return false;
     		} else if(start > end) {
     			alert("종료일이 시작일보다 먼저일 수 없습니다.");
     			return false;
     		} else {
     			searchFrm.submit();
     		}
     		
     	});

		 
		 
		 
	  });
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
                    <div class="menu"><h2 style="margin: 0;"><a style="text-decoration: none; color: black;" href='/first.do'>현장 모니터링</a></h2></div>
                    <div class="menu"><h2 style="margin: 0;"><a style="text-decoration: none; color: black;" href='/view/viewInventory.do'>현장 관리</a></h2></div>
                    <div class="menu"><h2 style="margin: 0;"><a style="text-decoration: none; color: #2e5fd7;" href='/safeevent/safeEvent.do'>안전 이벤트</a></h2></div>
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
                <div class="menu1" style="color: white; font-size: 16px;">안전 이벤트</div>
                <div class="next"></div>
                <div class="menu2" style="color: white; font-size: 16px;">안전 이벤트 목록</div>
            </div>
        </div>
        <div class="content_div">
            <div class="site_menu">
                <div class="site_menu_title">
                    <p style="font-size: 32px; margin:0; margin-bottom: 30px; font-weight: bold;"></p>
                </div>

                <div class="site_insert_btn_div">
                    <!--<div class="site_insert_btn">
                        <p>현장 추가</p>
                    </div>-->
                </div>
            </div>
            <div class="site_info">
                <div class="main_title_div">
                    <div class="site_title">
                        <p id="site_title" style="font-size: 35px; font-weight: bold; margin: 0;">안전 이벤트</p>
                    </div>
                    <div class="breadcrumb">

                    </div>
                </div>
                <div class="main_content_div">
                <form id="searchFrm" name="searchFrm" action="/safeevent/safeEvent.do">
                    <div class="searchBox">
                        <div class="search_div">
                            <table class="searchTable">
                                <tr style="border: none;">
                                    <th style="border:none; background:none; text-align:left;"> <h4 style="margin: 0;">이벤트 종류</h4> </th>
                                    <td>
                                        <div class="eventType_div">
										    <input type="checkbox" id="check1" style="margin-left: 40px; margin-right: 10px;" name="type_L" value="L"
										        <c:if test="${searchType.type_L == 'L'}">checked</c:if>> 
										    <label for="check1">접근 제한</label>
										
										    <input type="checkbox" id="check2" style="margin-left: 30px; margin-right: 10px;" name="type_G" value="G"
										        <c:if test="${searchType.type_G == 'G'}">checked</c:if>> 
										    <label for="check2">유해 가스</label>
										
										    <input type="checkbox" id="check3" style="margin-left: 30px; margin-right: 10px;" name="type_F" value="F"
										        <c:if test="${searchType.type_F == 'F'}">checked</c:if>> 
										    <label for="check3">낙상 사고</label>
										</div>
                                    </td>
                                </tr>
                                <tr>
                                    <th style="border:none; background:none; text-align:left;"> <h4 style="margin: 0;">조회 기간</h4></th>
                                    <td>
                                        <div class="date_div">
										    <input type="date" name="start_date" id="start_date"  style="margin-left: 40px; margin-right: 20px;"
										        <c:if test="${not empty searchType.start_date}">value="${searchType.start_date}"</c:if>>
										    ~
										    <input type="date" name="end_date" id="end_date" style="margin-left: 20px; margin-right: 5px;"
										        <c:if test="${not empty searchType.end_date}">value="${searchType.end_date}"</c:if>>
										    <button class="searchBtn"> </button>
										</div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                   </form>
                    <div class="fileDown">
                        <button class="fileDownBtn">파일 저장</button>
                    </div>
                    <div class="table_div">
                        <table class="table">
                            <colgroup>
                                <col style="width: 18%;">
                                <col style="width: 18%;">
                                <col style="width: auto;">
                            </colgroup>
                            <thead style="border-top: 2px solid #305363;">
                                <th scope="col" style="text-align: center;">이벤트 종류</th>
                                <th scope="col" style="text-align: center;">발생 일시</th>
                                <th scope="col" style="text-align: center;">내용</th>
                            </thead>
                            <tbody>
                            <c:if test="${empty safetyList}">
							    <tr>
							        <td colspan="3" style="text-align: center;">결과가 없습니다.</td>
							    </tr>
							</c:if>
                                <c:forEach var="safety" items="${safetyList}">
								    <tr>
								        <td>
								            <c:choose>
								                <c:when test="${safety.EVENT_TYPE == 'L'}">접근 제한</c:when>
								                <c:when test="${safety.EVENT_TYPE == 'G'}">유해 가스</c:when>
								                <c:when test="${safety.EVENT_TYPE == 'F'}">낙상 사고</c:when>
								                <c:otherwise>기타</c:otherwise> 
								            </c:choose>
								        </td>
								        <td>${fn:replace(safety.REG_DATE, '.0', '')}</td>
								        <td>${safety.EVENT_CONTENT}</td>
								    </tr>
								</c:forEach>
                            </tbody>
                        </table>
                        
                    </div>
                </div>
            </div>

        </div>
    </div>
</body>
</html>