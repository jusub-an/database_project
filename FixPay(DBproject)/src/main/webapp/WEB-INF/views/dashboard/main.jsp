<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<%@include file="../includes/header.jsp"%> 
<head>
    <script src="/resources/vendor/jquery/jquery.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    </head>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">메인 대시보드</h1>
	</div>
</div>



<div class="row">
	<div class="col-lg-6">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-pie-chart"></i> 카테고리별 지출 현황
			</div>
			<div class="panel-body">
				<canvas id="myPieChart" width="400" height="400"></canvas>
			</div>
		</div>
	</div>
	
	<div class="col-lg-6">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-list"></i> 지출 항목 목록 </div>
			<div class="panel-body">
				<table class="table table-striped table-hover"> <thead>
						<tr>
							<th>항목명</th>
							<th>카테고리</th>
							<th>예상 금액</th>
						</tr>
					</thead>
					<tbody>
                        <c:forEach items="${expenseList}" var="ex">
							<tr style="cursor:pointer;" 
                                onclick="location.href='/history/detail?expense_id=${ex.expense_id}'">
								<td>
                                    <c:out value="${ex.name}" />
                                </td>
								<td><c:out value="${ex.category_name}" /></td>
								<td><fmt:formatNumber value="${ex.amount}" pattern="#,##0" /> 원</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
<c:if test="${not empty alertList}">
    <div class="modal fade" id="alertModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header" style="background-color: #f6c23e; border-bottom: none;">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" style="color: #fff;">
                        <i class="fa fa-bell fa-fw"></i> 결제 임박 알림 (${daysBefore}일 전)
                    </h4>
                </div>
                <div class="modal-body">
                    <p class="text-center" style="font-size: 1.2em; margin: 15px 0;">
                        💳 <strong>곧 결제일이 다가옵니다!</strong><br>
                        <small class="text-muted">계좌 잔액을 미리 확인해주세요.</small>
                    </p>
                    <ul class="list-group">
					    <c:forEach items="${alertList}" var="item">
					        <li class="list-group-item" style="border-left: 5px solid ${item.d_day == 0 ? '#e74a3b' : '#f6c23e'};">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <span class="badge" style="width: 100%; padding: 8px 0; background-color: ${item.d_day == 0 ? '#e74a3b' : '#f6c23e'};">
                                            ${item.d_day == 0 ? '오늘!' : 'D-' += item.d_day}
                                        </span>
                                    </div>
                                    <div class="col-xs-5" style="font-size: 1.1em; padding-top: 3px;">
                                        <strong><c:out value="${item.name}"/></strong>
                                    </div>
                                    <div class="col-xs-4 text-right" style="padding-top: 3px;">
                                        <fmt:formatNumber value="${item.amount}" pattern="#,##0"/> 원
                                    </div>
                                </div>
					        </li>
					    </c:forEach>
					</ul>
                </div>
                <div class="modal-footer" style="background-color: #f8f9fc; justify-content: space-between; display: flex;">
                    <div class="checkbox" style="margin: 0;">
                        <label>
                            <input type="checkbox" id="dontShowToday"> 오늘 하루 그만 보기
                        </label>
                    </div>
                    <div>
                        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                        <button type="button" class="btn btn-primary" onclick="location.href='/history/manage'">결제 확정하러 가기</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</c:if>

<div class="col-lg-12">
    <div class="panel panel-default">
        <div class="panel-heading">
            <i class="fa fa-bar-chart-o"></i> 월별 지출 추이 (Archive)
        </div>
        <div class="panel-body">
            <canvas id="monthlyBarChart" height="100"></canvas>
        </div>
    </div>
</div>

<script>
// 4. JSTL(Java) 데이터를 JavaScript 변수로 변환
var parsedStats = ${statsJson};

// 5. JS 객체에서 라벨과 데이터 추출
var labels = parsedStats.map(function(stat) { return stat.category_name; });
var data = parsedStats.map(function(stat) { return stat.total_amount; });
// 5. Chart.js를 사용해 파이 차트 생성
$(document).ready(function(){
    // ✨ [추가] 쿠키 설정 및 확인 함수
    function setCookie(name, value, days) {
        var date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000)); // 일 단위
        var expires = "; expires=" + date.toUTCString();
        document.cookie = name + "=" + (value || "") + expires + "; path=/";
    }

    function getCookie(name) {
        var nameEQ = name + "=";
        var ca = document.cookie.split(';');
        for(var i=0;i < ca.length;i++) {
            var c = ca[i];
            while (c.charAt(0)==' ') c = c.substring(1,c.length);
            if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
        }
        return null;
    }

    // ✨ [수정] 쿠키가 없을 때만 모달 띄우기
    <c:if test="${not empty alertList}">
        if (getCookie("hideAlertModal") !== "true") {
            $("#alertModal").modal("show");
        }
    </c:if>
    
    // ✨ [추가] 모달이 닫힐 때 체크박스 확인
    $('#alertModal').on('hidden.bs.modal', function () {
        if ($("#dontShowToday").is(":checked")) {
            setCookie("hideAlertModal", "true", 1); // 1일 동안 저장
        }
    });
    
	var ctx = document.getElementById('myPieChart').getContext('2d');
	var myPieChart = new Chart(ctx, {
		type: 'pie', // 차트 유형: 파이
		data: {
			labels: labels, // 위에서 만든 라벨 배열
			datasets: [{
				label: '지출액',
				data: data, // 위에서 만든 데이터 배열
				backgroundColor: [ // 색상은 원하는 만큼 추가
					'rgba(255, 99, 132, 0.7)',
					'rgba(54, 162, 235, 0.7)',
					'rgba(255, 206, 86, 0.7)',
					'rgba(75, 192, 192, 0.7)',
					'rgba(153, 102, 255, 0.7)',
					'rgba(255, 159, 64, 0.7)'
				],
				borderColor: 'rgba(255, 255, 255, 1)',
				borderWidth: 1
			}]
		},
		options: {
			responsive: true,
			maintainAspectRatio: false
		}
	});
});

//✨ [추가] 월별 막대 그래프 생성
var monthlyData = ${monthlyJson}; // Controller에서 넘겨준 JSON
var monthLabels = monthlyData.map(function(m) { return m.MONTH; }); // YYYY-MM
var monthAmounts = monthlyData.map(function(m) { return m.TOTAL; }); // 금액

var ctx2 = document.getElementById("monthlyBarChart").getContext("2d");
var myBarChart = new Chart(ctx2, {
    type: 'bar',
    data: {
        labels: monthLabels,
        datasets: [{
            label: '월별 총 지출액',
            data: monthAmounts,
            backgroundColor: 'rgba(78, 115, 223, 0.6)', // 파란색
            borderColor: 'rgba(78, 115, 223, 1)',
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            y: { beginAtZero: true }
        }
    }
});
</script>


<%@include file="../includes/footer.jsp"%>