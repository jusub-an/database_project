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


<script>
// 4. JSTL(Java) 데이터를 JavaScript 변수로 변환
var parsedStats = ${statsJson};

// 5. JS 객체에서 라벨과 데이터 추출
var labels = parsedStats.map(function(stat) { return stat.category_name; });
var data = parsedStats.map(function(stat) { return stat.total_amount; });
// 5. Chart.js를 사용해 파이 차트 생성
$(document).ready(function(){
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
</script>


<%@include file="../includes/footer.jsp"%>