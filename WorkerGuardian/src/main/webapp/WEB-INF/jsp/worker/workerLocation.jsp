<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>WorkerGuardian</title>
	<link rel="stylesheet" href="/css/worker/inventory.css"/>
	<link rel="stylesheet" href="//cdn.datatables.net/2.3.2/css/dataTables.dataTables.min.css"/>
	<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/js/jquery.js"></script>
	<script src="/js/jquery-3.7.1.min.js"></script>
	<script src="//cdn.datatables.net/2.3.2/js/dataTables.min.js"></script>
	<script src="/js/common.js"></script>
	<style>
		
		#locationTable th,
		#locationTable td {
		  text-align: center;
		  vertical-align: middle;
		}
	
	</style>
    <script>
        $(document).ready(function() {
        	
        	let locationListSize = '${locationDataSize}';

        	if(locationListSize != 0) {
        		let table = new DataTable('#locationTable', {
                    searching: false,   
                    lengthChange: false,
                    ordering: false,
                    pageLength: 10,     
                    language: {
                        emptyTable: "표에 데이터가 없습니다.",
                        info: "_TOTAL_개 중 _START_부터 _END_까지 표시",
                        infoEmpty: "데이터 없음",
                        infoFiltered: "(전체 _MAX_개 중 필터링됨)",
                    }
                });
        	}      	
            
        });  
            
    </script>
</head>
<body>
    <div class="main_div">         
        <div class="content_div">           
            <div class="site_info">
                <div class="main_title_div" style="margin-bottom: 5px;">
                    <div class="site_title">
                        <p id="site_title" style="font-size: 35px; font-weight: bold; margin: 0;">위치 이력 조회</p>
                    </div>
                    <div class="breadcrumb">

                    </div>
                </div>
                <div class="main_content_div">
                    <div class="table_div">
                        <table class="table" id="locationTable" style="width: 640px;">
					    <thead>
					        <tr>
					            <th>위치 조회 시간</th>
					            <th>작업자 위치(X,Y)</th>
					        </tr>                        
					    </thead>
					    <tbody>
					        <c:choose>
					            <c:when test="${not empty locationData}">
					                <c:forEach var="location" items="${locationData}">
					                    <tr>
					                        <td>${fn:substringBefore(location.LOCATION_TIME, ".0")}</td>
					                        <td>${location.WORKER_LOCATION_X}, ${location.WORKER_LOCATION_Y}</td>
					                    </tr>
					                </c:forEach>
					            </c:when>
					            <c:otherwise>
					                <tr>
					                    <td colspan="2" style="text-align: center;">위치 정보가 없습니다.</td>
					                </tr>
					            </c:otherwise>
					        </c:choose>
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