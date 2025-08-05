<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>WorkerGuardian</title>
	<link rel="stylesheet" href="/css/view/inventory.css"/>
	<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/js/jquery.js"></script>
	<script src="/js/jquery-3.7.1.min.js"></script>
	<script src="/js/common.js"></script>
	<style>
		.btn_div {
	            width: 100%;
	            height: 20%;
	            display: flex;
	            align-items: flex-start;
	    		justify-content: space-between;
	        }
        
        .deleteBtn {
            width: 150px;
            height: 45px;
            border-radius: 5px;
            border: 1px solid #ababab;
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: pointer;
        }

        .updateBtn {
            width: 150px;
            height: 45px;
            border-radius: 5px;
            background-color: #44a7ef;
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: pointer;
            color: white;
            border: 1px solid #ababab;
        }
	</style>
    <script>
        $(document).ready(function() {
  	
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
         	
         	
	     	// 내 정보 변경   
	     	$('#myInfoUpdate').on('click', function() {
	     		myInfoUpdateGo();
	     	});
         	
	     	$('#myInfo').on('click', function() {
	     		mypageGo();
	     	});
	     	
	     	
	     	// 이전 버튼 클릭 시
	     	$('.deleteBtn').on('click', function() {
	     		var historyChk = confirm("본인 인증을 취소하시겠습니까?");
	     		
	     		if(historyChk == true) {
	     			window.location.href = '/first.do';
	     		} else {
	     			return false;
	     		}
	     		
	     	});
	     	
	     	
	     	// 인증 버튼 클릭 시
	     	$('.updateBtn').on('click', function() {
	     		identityFrm.submit();
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
                <div class="menu1" style="color: white; font-size: 16px;">마이페이지</div>
                <div class="next"></div>
                <div class="menu2" style="color: white; font-size: 16px;">본인 확인</div>
            </div>
        </div>
        <div class="content_div" style="justify-content: center; align-items: center;">

            <div class="site_info" style="width:50%;">
                <div class="main_title_div">
                    <div class="site_title">
                        <p id="site_title" style="font-size: 35px; font-weight: bold; margin: 0;">본인 확인</p>
                    </div>
                </div>
                <div class="main_content_div" style="height:50%;">
                    <div class="mini_title">
                        <p style="font-size: 26px; margin: 0;">마이페이지를 이용하시려면 본인 확인이 필요합니다.</p>
                    </div>
                    <div class="table_div">
                    <form id="identityFrm" name="identityFrm" action="/mypage/identity.do">
                        <table class="table">                       
                            <tbody>
                                <tr>
                                    <th scope="row">비밀번호 입력</th>
                                    <td>
                                    	<input type="password" id="USER_PW" name="USER_PW" placeholder="현재 사용중인 비밀번호 입력"></input>
                                    </td>
                                </tr>                                
                            </tbody>
                        </table>  
                    </form>                    
                    </div>
                </div>
                <div class="btn_div">
                    <div class="deleteBtn">
                       	이전
                    </div>
                    <div class="updateBtn">
                        	인증
                    </div>
                </div>
                <form id="frmSite" name="frmSite" method="post">
                	<input type="hidden" id="site_id" name="SITE_ID"></input>
                </form>
            </div>
        </div>
    </div>
</body>
</html>