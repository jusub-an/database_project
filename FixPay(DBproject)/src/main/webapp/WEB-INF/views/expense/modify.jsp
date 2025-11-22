<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
	
<%@include file="../includes/header.jsp"%>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">고정 지출 수정</h1>
	</div>
</div>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Expense Modify</div>
			<div class="panel-body">
				
				<form role="form" action="/expense/modify" method="post">
				
					<input type='hidden' name='pageNum' value='${cri.pageNum}'>
					
					<div class="form-group">
						<label>항목 ID</label> 
						<input class="form-control" name="expense_id" 
						       value='<c:out value="${expense.expense_id}"/>' readonly>
					</div>
					
					<div class="form-group">
						<label>항목명</label> 
						<input class="form-control" name="name" 
						       value='<c:out value="${expense.name}"/>'>
					</div>
					
					<div class="form-group">
						<label>금액</label> 
						<input class="form-control" name="amount" type="number"
						       value='<fmt:formatNumber value="${expense.amount}" groupingUsed="false" />'>
					</div>
					
					<div class="form-group">
						<label>결제일 (매월)</label> 
						<input class="form-control" name="payment_day" type="number" min="1" max="31"
						       value='<c:out value="${expense.payment_day}"/>'>
					</div>
					
					<div class="form-group">
						<label>카테고리</label>
						<select name="category_id" class="form-control">
							<c:forEach items="${categoryList}" var="category">
								<option value="${category.category_id}"
								    <%-- 현재 항목의 category_id와 일치하면 'selected' --%>
									<c:if test="${expense.category_id == category.category_id}">selected</c:if>
								>
									<c:out value="${category.name}"/>
								</option>
							</c:forEach>
						</select>
					</div>

					<div class="form-group">
						<label>결제 수단</label>
						<select name="method_id" class="form-control">
							<c:forEach items="${methodList}" var="method">
								<option value="${method.method_id}"
								    <%-- 현재 항목의 method_id와 일치하면 'selected' --%>
									<c:if test="${expense.method_id == method.method_id}">selected</c:if>
								>
									<c:out value="${method.name}"/>
								</option>
							</c:forEach>
						</select>
					</div>

					<div class="form-group">
						<label>결제 주기</label>
						<select name="cycle_id" class="form-control">
							<c:forEach items="${cycleList}" var="cycle">
								<option value="${cycle.cycle_id}"
								    <%-- 현재 항목의 cycle_id와 일치하면 'selected' --%>
									<c:if test="${expense.cycle_id == cycle.cycle_id}">selected</c:if>
								>
									<c:out value="${cycle.name}"/>
								</option>
							</c:forEach>
						</select>
					</div>
					
					<button type="submit" id="modifyBtn" class="btn btn-primary">수정 완료</button>
					<button type="button" id="removeBtn" class="btn btn-danger">삭제하기</button>
					<button type="button" id="listBtn" class="btn btn-info">목록으로</button>
				</form>
				
				<form id="removeForm" action="/expense/remove" method="post">
					<input type='hidden' name='pageNum' value='${cri.pageNum}'>
					<input type='hidden' name='amount' value='${cri.amount}'>
					<input type="hidden" name="expense_id" value="${expense.expense_id}">
				</form>
				
			</div>
		</div>
	</div>
</div>

<script>
$(document).ready(function(){
    var removeForm = $("#removeForm"); // 삭제용 폼 (POST)

    // 삭제 버튼 클릭
    $("#removeBtn").on("click", function(){
        if(confirm("정말로 삭제하시겠습니까?")) {
            removeForm.submit();
        }
    });

    // 목록으로 버튼 클릭
    $("#listBtn").on("click", function(){
		var form = $('<form action="/expense/list" method="get"></form>');
		form.append('<input type="hidden" name="pageNum" value="${cri.pageNum}">');
		form.append('<input type="hidden" name="amount" value="${cri.amount}">');
		$('body').append(form);
        form.submit();
    });
});
</script>

<%@include file="../includes/footer.jsp"%>