<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../includes/header.jsp"%>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">고정 지출 등록</h1>
	</div>
</div>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Expense Register</div>
			<div class="panel-body">
				
				<form role="form" action="/expense/register" method="post">
					
					<div class="form-group">
						<label>항목명</label> 
						<input class="form-control" name="name" required>
					</div>
					
					<div class="form-group">
						<label>금액</label> 
						<input class="form-control" name="amount" type="number" required>
					</div>
					
					<div class="form-group">
						<label>결제일</label> 
						<input class="form-control" name="payment_day" type="number" min="1" max="31" required>
					</div>
					
					<div class="form-group">
						<label>카테고리</label>
						<select name="category_id" class="form-control" required>
							<option value="">-- 선택하세요 --</option>
							<c:forEach items="${categoryList}" var="category">
								<option value="${category.category_id}">
									<c:out value="${category.name}"/>
								</option>
							</c:forEach>
						</select>
					</div>

					<div class="form-group">
						<label>결제 수단</label>
						<select name="method_id" class="form-control" required>
							<option value="">-- 선택하세요 --</option>
							<c:forEach items="${methodList}" var="method">
								<option value="${method.method_id}">
									<c:out value="${method.name}"/>
								</option>
							</c:forEach>
						</select>
					</div>

					<div class="form-group">
						<label>결제 주기</label>
						<select name="cycle_id" class="form-control" required>
							<option value="">-- 선택하세요 --</option>
							<c:forEach items="${cycleList}" var="cycle">
								<option value="${cycle.cycle_id}">
									<c:out value="${cycle.name}"/>
								</option>
							</c:forEach>
						</select>
					</div>
					
					<button type="submit" class="btn btn-primary">등록하기</button>
					<button type="reset" class="btn btn-default">다시작성</button>
					<button type="button" class="btn btn-info" 
					        onclick="location.href='/expense/list'">목록으로</button>
				</form>
				
			</div>
		</div>
	</div>
</div>

<%@include file="../includes/footer.jsp"%>