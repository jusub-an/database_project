<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../includes/header.jsp"%>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">카테고리 관리</h1>
	</div>
</div>

<div class="row">
	<div class="col-lg-4">
		<div class="panel panel-default">
			<div class="panel-heading">새 카테고리 등록</div>
			<div class="panel-body">
				<form action="/category/register" method="post">
					<div class="form-group">
						<label>카테고리 이름</label> 
						<input class="form-control" name="name" required>
					</div>
					<button type="submit" class="btn btn-primary">등록하기</button>
				</form>
			</div>
		</div>
	</div>

	<div class="col-lg-8">
		<div class="panel panel-default">
			<div class="panel-heading">내 카테고리 목록</div>
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
						<c:forEach items="${list}" var="category">
							<tr>
								<td><c:out value="${category.name}" /></td>
								<td>
									<c:if test="${empty category.user_id}">
										<span class="label label-info">기본</span>
									</c:if>
									<c:if test="${not empty category.user_id}">
										<span class="label label-success">사용자 정의</span>
									</c:if>
								</td>
								<td>
									<c:if test="${not empty category.user_id}">
										<form action="/category/remove" method="post" style="display:inline;">
											<input type="hidden" name="category_id" value="${category.category_id}">
											<button type="submit" class="btn btn-danger btn-xs">삭제</button>
										</form>
									</c:if>
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