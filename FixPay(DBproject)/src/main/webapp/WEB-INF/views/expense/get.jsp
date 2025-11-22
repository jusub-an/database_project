<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp"%>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">고정 지출 상세조회</h1>
	</div>
</div>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Expense Detail</div>
			<div class="panel-body">
				<div class="form-group">
					<label>항목 ID</label> 
					<input class="form-control" name="expense_id" 
					       value='<c:out value="${expense.expense_id}"/>' readonly>
				</div>
				<div class="form-group">
					<label>항목명</label> 
					<input class="form-control" name="name" 
					       value='<c:out value="${expense.name}"/>' readonly>
				</div>
				<div class="form-group">
					<label>금액</label> 
					<input class="form-control" name="amount" 
					       value='<fmt:formatNumber value="${expense.amount}" groupingUsed="false" />' readonly>
				</div>
				<div class="form-group">
					<label>결제일</label> 
					<input class="form-control" name="payment_day" 
					       value='<c:out value="${expense.payment_day}"/>' readonly>
				</div>

				<form id="actionForm" method="get">
					<input type="hidden" name="pageNum" value="${cri.pageNum}">
					<input type="hidden" name="amount" value="${cri.amount}">
				</form>

				<button type="button" id="modifyBtn" class="btn btn-primary">수정하기</button>
				<button type="button" id="listBtn" class="btn btn-info">목록으로</button>
				
			</div>
		</div>
	</div>
</div>

<script>
$(document).ready(function(){
    var actionForm = $("#actionForm");

    // 수정하기 버튼 클릭
    $("#modifyBtn").on("click", function(){
        actionForm.attr("action", "/expense/modify");
        // get.jsp는 expense_id가 필요 없지만, modify.jsp로 넘길 땐 필요
        actionForm.append('<input type="hidden" name="expense_id" value="${expense.expense_id}">');
        actionForm.submit();
    });

    // 목록으로 버튼 클릭
    $("#listBtn").on("click", function(){
        actionForm.attr("action", "/expense/list");
        actionForm.submit();
    });
});
</script>

<%@include file="../includes/footer.jsp"%>