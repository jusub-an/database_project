<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../includes/header.jsp"%>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">결제 수단 관리</h1>
	</div>
</div>

<div class="row">
	<div class="col-lg-4">
		<div class="panel panel-default">
			<div class="panel-heading">새 결제 수단 등록</div>
			<div class="panel-body">
				<form action="/method/register" method="post">
					<div class="form-group">
						<label>이름</label> 
						<input class="form-control" name="name" placeholder="예: 신한카드(1234)" required>
					</div>
					<div class="form-group">
						<label>유형</label> 
						<input class="form-control" name="type" placeholder="예: 신용카드, 계좌이체">
					</div>
					<button type="submit" class="btn btn-primary">등록하기</button>
				</form>
			</div>
		</div>
	</div>

	<div class="col-lg-8">
		<div class="panel panel-default">
			<div class="panel-heading">내 결제 수단 목록</div>
			<div class="panel-body">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>이름</th>
							<th>유형</th>
							<th>관리</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list}" var="method">
							<tr>
								<td><c:out value="${method.name}" /></td>
								<td><c:out value="${method.type}" /></td>
								<td>
									<form action="/method/remove" method="post" style="display:inline;">
										<input type="hidden" name="method_id" value="${method.method_id}">
										<button type="submit" class="btn btn-danger btn-xs">삭제</button>
									</form>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>

<%@include file="../includes/footer.jsp"%>