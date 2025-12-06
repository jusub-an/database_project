<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp"%>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<div class="row">
	<div class="col-lg-12">
		<h2 class="page-header" style="border:none; margin-top:20px; margin-bottom:20px; font-weight:700; color:#4e73df;">
            Dashboard <small style="color:#858796; font-size:0.6em;">지출 분석 리포트</small>
        </h2>
	</div>
</div>

<div class="row" style="margin-bottom: 20px;">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-body">
                <div style="display:flex; align-items:center; justify-content:space-between; margin-bottom:15px;">
                    <h4 style="margin:0; color:#4e73df; font-weight:bold;">
                        <i class="fa fa-filter"></i> Filter Data
                    </h4>
                    <button class="btn btn-danger btn-xs" id="resetFilterBtn">
                        <i class="fa fa-refresh"></i> 필터 초기화
                    </button>
                </div>
                
                <hr style="margin: 10px 0; border-top: 1px solid #eee;">
                
                <div class="filter-group" style="margin-bottom: 12px;">
                    <span class="label label-success" style="font-size:12px; margin-right:10px; display:inline-block; width:80px; text-align:center;">카테고리</span>
                    <div style="display:inline-block;">
                        <c:forEach items="${categoryList}" var="cat">
					        <button class="btn btn-default btn-sm filter-btn" data-type="category" data-val="${cat.name}" 
					                style="margin-bottom:5px; ${cat.expenseCount == 0 ? 'opacity:0.6;' : ''}">
					            #<c:out value="${cat.name}"/>
					            <span class="badge" style="margin-left:3px; font-size:0.8em; background-color:#ddd; color:#555;">
					                ${cat.expenseCount}
					            </span>
					        </button>
					    </c:forEach>
                    </div>
                </div>
                
                <div class="filter-group" style="margin-bottom: 12px;">
                    <span class="label label-info" style="font-size:12px; margin-right:10px; display:inline-block; width:80px; text-align:center;">결제수단</span>
                    <div style="display:inline-block;">
                        <c:forEach items="${methodList}" var="met">
					        <button class="btn btn-default btn-sm filter-btn" data-type="method" data-val="${met.name}" 
					                style="margin-bottom:5px; ${met.expenseCount == 0 ? 'opacity:0.6;' : ''}">
					            💳 <c:out value="${met.name}"/>
					            <span class="badge" style="margin-left:3px; font-size:0.8em; background-color:#ddd; color:#555;">
					                ${met.expenseCount}
					            </span>
					        </button>
					    </c:forEach>
                    </div>
                </div>
                
                 <div class="filter-group">
                    <span class="label label-warning" style="font-size:12px; margin-right:10px; display:inline-block; width:80px; text-align:center;">결제주기</span>
                    <div style="display:inline-block;">
                        <c:forEach items="${cycleList}" var="cyc">
					        <button class="btn btn-default btn-sm filter-btn" data-type="cycle" data-val="${cyc.name}" 
					                style="margin-bottom:5px; ${cyc.expenseCount == 0 ? 'opacity:0.6;' : ''}">
					            📅 <c:out value="${cyc.name}"/>
					            <span class="badge" style="margin-left:3px; font-size:0.8em; background-color:#ddd; color:#555;">
					                ${cyc.expenseCount}
					            </span>
					        </button>
					    </c:forEach>
                    </div>
                </div>
                
            </div>
        </div>
    </div>
</div>

<div class="row">
	<div class="col-lg-8">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-bar-chart-o fa-fw"></i> 월별 지출 추이 (Stacked)
			</div>
			<div class="panel-body">
				<div style="height: 300px;">
					<canvas id="monthlyBarChart"></canvas>
				</div>
			</div>
		</div>
	</div>
	
	<div class="col-lg-4">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-pie-chart fa-fw"></i> 지출 비중
			</div>
			<div class="panel-body">
				<div style="height: 300px;">
					<canvas id="myPieChart"></canvas>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <i class="fa fa-history fa-fw"></i> 상세 지출 내역
                <span id="filterInfo" class="pull-right text-muted small">전체 보기</span>
            </div>
            <div class="panel-body">
                <div class="table-responsive">
                    <table class="table table-striped table-hover" id="logTable">
                        <thead>
                            <tr>
                                <th>결제일</th>
                                <th>항목명</th>
                                <th class="text-center">카테고리</th>
                                <th class="text-center">결제수단</th>
                                <th class="text-center">주기</th>
                                <th class="text-right">금액</th>
                            </tr>
                        </thead>
                        <tbody>
                            </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<c:if test="${not empty alertList}">
    <div class="modal fade" id="alertModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header" style="background-color: #f6c23e; color:white;">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title"><i class="fa fa-bell"></i> 결제 임박 알림 (${daysBefore}일 전)</h4>
                </div>
                <div class="modal-body">
                    <ul class="list-group">
					    <c:forEach items="${alertList}" var="item">
					        <li class="list-group-item">
                                <span class="badge" style="background-color: ${item.d_day == 0 ? '#e74a3b' : '#f6c23e'}; margin-right:10px;">
                                    ${item.d_day == 0 ? '오늘!' : 'D-' += item.d_day}
                                </span>
                                <strong>${item.name}</strong>
                                <span class="pull-right"><fmt:formatNumber value="${item.amount}" pattern="#,##0"/> 원</span>
					        </li>
					    </c:forEach>
					</ul>
                </div>
                <div class="modal-footer">
                    <label class="checkbox-inline"><input type="checkbox" id="dontShowToday"> 오늘 하루 그만 보기</label>
                    <button type="button" class="btn btn-primary" onclick="location.href='/history/manage'">확정하러 가기</button>
                </div>
            </div>
        </div>
    </div>
</c:if>

<script>
var charts = {}; 

// 현재 선택된 필터 상태
var currentFilters = {
    category: [],
    method: [],
    cycle: []
};

// 쿠키 관련 함수
function setCookie(name, value, days) {
    var date = new Date();
    date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
    document.cookie = name + "=" + (value || "") + "; expires=" + date.toUTCString() + "; path=/";
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

$(document).ready(function(){
    // 1. 알림 모달 체크
    <c:if test="${not empty alertList}">
        if (getCookie("hideAlertModal") !== "true") { $("#alertModal").modal("show"); }
    </c:if>
    $('#alertModal').on('hidden.bs.modal', function () {
        if ($("#dontShowToday").is(":checked")) { setCookie("hideAlertModal", "true", 1); }
    });

    // 2. 초기 데이터 로딩
    var initData = ${initDataJson}; 
    processAndRender(initData);
    
    // 3. [핵심] 태그 버튼 클릭 이벤트
    $(".filter-btn").on("click", function(){
        var type = $(this).data("type"); // category, method, cycle, all
        var val = $(this).data("val");   
        
        // '전체' 버튼 클릭 시
        if(type === 'all') {
            // 1. 모든 데이터 초기화
            currentFilters = { category: [], method: [], cycle: [] };
            // 2. UI 초기화 (모든 버튼 끄기)
            $(".filter-btn").removeClass("btn-primary active").addClass("btn-default");
            // 3. '전체' 버튼만 켜기
            $(this).removeClass("btn-default").addClass("btn-primary active");
        } 
        else {
            // 일반 태그 클릭 시 ('전체' 버튼 끄기)
            $("[data-type='all']").removeClass("btn-primary active").addClass("btn-default");
            
            // UI 토글 & 데이터 배열 관리
            if ($(this).hasClass("active")) {
                // [해제] 이미 선택된 상태라면 -> 배열에서 제거
                $(this).removeClass("btn-primary active").addClass("btn-default");
                
                // 해당 배열에서 값 제거
                var index = currentFilters[type].indexOf(val);
                if (index > -1) {
                    currentFilters[type].splice(index, 1);
                }
            } 
            else {
                // [선택] 선택 안 된 상태라면 -> 배열에 추가
                $(this).removeClass("btn-default").addClass("btn-primary active");
                currentFilters[type].push(val);
            }
        }
        
        // AJAX 요청
        requestDashboardData();
    });
    
    // 초기화 버튼
    $("#resetFilterBtn").on("click", function(){
        $(".filter-btn").removeClass("btn-primary active").addClass("btn-default");
        $("[data-type='all']").removeClass("btn-default").addClass("btn-primary active");
        currentFilters = { category: [], method: [], cycle: [] };
        requestDashboardData();
    });
});

// 데이터 요청 함수
function requestDashboardData() {
    var params = {};
    
    // 배열이 비어있지 않으면 파라미터에 추가
    if(currentFilters.category.length > 0) params.categoryList = currentFilters.category;
    if(currentFilters.method.length > 0) params.methodList = currentFilters.method;
    if(currentFilters.cycle.length > 0) params.cycleList = currentFilters.cycle;
    
    // 필터 정보 텍스트 업데이트
    var allFilters = [].concat(currentFilters.category, currentFilters.method, currentFilters.cycle);
    $("#filterInfo").text(allFilters.length > 0 ? "필터: " + allFilters.join(", ") : "전체 보기");

    $.ajax({
        url: "/dashboard/api/data",
        type: "POST",
        data: params,
        traditional: true, // [중요] 배열을 전송할 때 필수 옵션 (param=a&param=b 형태)
        success: function(data) {
            processAndRender(data);
        }
    });
}

// 데이터 처리 및 렌더링
function processAndRender(rawData) {
    // 테이블 갱신
    renderTable(rawData);
    
    // 차트 초기화
    if(charts['monthlyBarChart']) charts['monthlyBarChart'].destroy();
    if(charts['myPieChart']) charts['myPieChart'].destroy();

    if(!rawData || rawData.length === 0) return;

    // --- A. Stacked Bar Chart (월별 x 항목별) ---
    var months = [...new Set(rawData.map(d => d.PAY_MONTH))].sort();
    var expenseNames = [...new Set(rawData.map(d => d.EXPENSE_NAME))];
    
    var barDatasets = expenseNames.map(function(name, index) {
        var data = months.map(function(month) {
            var item = rawData.find(d => d.PAY_MONTH === month && d.EXPENSE_NAME === name);
            return item ? item.AMOUNT : 0;
        });
        return {
            label: name,
            data: data,
            backgroundColor: getColor(index),
            stack: 'Stack 0' // 이 속성 때문에 쌓임
        };
    });
    
    updateChart('monthlyBarChart', 'bar', months, barDatasets, true);

    // --- B. Doughnut Chart (카테고리별 비중) ---
    var catMap = {};
    rawData.forEach(function(d) {
        var c = d.CATEGORY_NAME || '미분류';
        catMap[c] = (catMap[c] || 0) + d.AMOUNT;
    });
    
    var pieLabels = Object.keys(catMap);
    var pieData = Object.values(catMap);
    var pieColors = pieLabels.map((_, i) => getColor(i));
    
    var pieDatasets = [{
        data: pieData,
        backgroundColor: pieColors
    }];
    
    updateChart('myPieChart', 'doughnut', pieLabels, pieDatasets, false);
}

// 테이블 그리기
function renderTable(data) {
    var tbody = $("#logTable tbody");
    tbody.empty();
    
    if(data && data.length > 0) {
        $.each(data, function(i, item) {
            var row = "<tr>" +
                "<td>" + item.PAY_DATE + "</td>" +
                "<td><strong>" + item.EXPENSE_NAME + "</strong></td>" +
                "<td class='text-center'><span class='badge' style='background-color:#858796;'>" + (item.CATEGORY_NAME || '-') + "</span></td>" +
                "<td class='text-center'>" + (item.METHOD_NAME || '-') + "</td>" +
                "<td class='text-center'>" + (item.CYCLE_NAME || '-') + "</td>" +
                "<td class='text-right' style='color:#4e73df; font-weight:bold;'>" + item.AMOUNT.toLocaleString() + " 원</td>" +
                "</tr>";
            tbody.append(row);
        });
    } else {
        tbody.append("<tr><td colspan='6' class='text-center' style='padding:20px;'>데이터가 없습니다.</td></tr>");
    }
}

// 차트 생성기
function updateChart(canvasId, type, labels, datasets, isStacked) {
    var ctx = document.getElementById(canvasId).getContext('2d');
    charts[canvasId] = new Chart(ctx, {
        type: type,
        data: { labels: labels, datasets: datasets },
        options: {
            maintainAspectRatio: false,
            scales: (type === 'bar') ? { 
                x: { stacked: true }, 
                y: { stacked: true, beginAtZero: true } 
            } : {},
            plugins: {
                legend: { position: 'bottom' }
            }
        }
    });
}

function getColor(index) {
    var palette = ['#4e73df', '#1cc88a', '#36b9cc', '#f6c23e', '#e74a3b', '#858796', '#6f42c1', '#fd7e14'];
    return palette[index % palette.length];
}
</script>

<%@include file="../includes/footer.jsp"%>