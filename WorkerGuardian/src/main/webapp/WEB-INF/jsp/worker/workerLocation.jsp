<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>WorkerGuardian</title>
	<link rel="stylesheet" href="/css/worker/inventory.css"/>
	<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/js/jquery.js"></script>
	<script src="/js/jquery-3.7.1.min.js"></script>
	<script src="/js/common.js"></script>

    <script>
        $(document).ready(function() {
        	
        	
            
        });  
            
    </script>
</head>
<body>
    <div class="main_div">  <!-- 메인 div -->        
        <div class="content_div">           
            <div class="site_info">
                <div class="main_title_div">
                    <div class="site_title">
                        <p id="site_title" style="font-size: 35px; font-weight: bold; margin: 0;">작업자 위치 이력 조회</p>
                    </div>
                    <div class="breadcrumb">

                    </div>
                </div>
                <div class="main_content_div">
                    <div class="table_div">
                        <table class="table">
                            <colgroup>
                                <col style="width: 18%;">
                                <col style="width: auto;">
                                <col style="width: 18%;">
                                <col style="width: 34%;">
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row">작업자 이름</th>
                                    <td id="worker_name"></td>
                                    <th scope="row">연동 현장</th>
                                    <td></td>
                                </tr>
                                <tr>
                                    <th scope="row">소속(회사)</th>
                                    <td><p class="site_file"></p></td>
                                    <th scope="row">성별</th>
                                    <td><p class="site_file"></p></td>
                                </tr>
                                <tr>
                                    <th scope="row">생년월일</th>
                                    <td><p class="site_file"></p></td>
                                    <th scope="row">전화번호</th>
                                    <td><p class="site_file"></p></td>
                                </tr>
                                <tr>
                                    <th scope="row">작업자 정보</th>
                                    <td colspan="3" ></td>
                                </tr>
                            </tbody>
                        </table>                        
                    </div>
                </div>
                <div class="btn_div">
                    <div class="deleteBtn">
                       
                    </div>
                    <div class="updateBtn">
                        
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