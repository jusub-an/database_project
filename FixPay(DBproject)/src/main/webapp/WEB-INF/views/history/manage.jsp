<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>

<%-- 오늘 날짜를 yyyy-MM-dd 형식으로 미리 생성 (결제일 기본값) --%>
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyy-MM-dd" var="todayString" />

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">지출 내역 확정</h1>
	</div>
</div>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				이번 달 결제 예정 항목 (고정 지출 목록)
			</div>
			<div class="panel-body">
				<p>항목을 클릭하여 실제 결제 금액을 입력하고 '확정'하세요.</p>
				
				<c:forEach items="${expenseList}" var="expense">
					<div class="panel panel-info">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" href="#collapse${expense.expense_id}">
									<strong><c:out value="${expense.name}" /></strong>
									(<c:out value="${expense.category_name}" />)
									- 예상: <fmt:formatNumber value="${expense.amount}" pattern="#,##0" /> 원
									(매월 <c:out value="${expense.payment_day}" />일)
								</a>
							</h4>
						</div>
						<div id="collapse${expense.expense_id}" class="panel-collapse collapse">
							<div class="panel-body">
								<form action="/history/confirm" method="post" class="form-inline">
									<input type="hidden" name="expense_id" value="${expense.expense_id}">
									
									<div class="form-group">
										<label>실제 결제 금액:</label>
										<input type="number" name="paid_amount" class="form-control" 
										       value="${expense.amount}" required>
									</div>
									<div class="form-group">
										<label>실제 결제일:</label>
										<input type="date" name="payment_date" class="form-control" 
										       value="${todayString}" required>
									</div>
									<button type="submit" class="btn btn-primary btn-sm">
										[ <c:out value="${expense.name}" /> ] 결제 확정
									</button>
								</form>
							</div>
						</div>
					</div>
				</c:forEach>
				
			</div>
		</div>
	</div>
</div>

<%@include file="../includes/footer.jsp"%>