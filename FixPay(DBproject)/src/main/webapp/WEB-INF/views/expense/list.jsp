<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp"%>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">고정 지출 목록</h1>
	</div>
</div>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				Expense List Page
				<button id='regBtn' type="button" class="btn btn-xs pull-right">
					새 항목 등록
				</button>
			</div>

			<div class="panel-body">
				<table class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<th>#항목ID</th>
							<th>항목명</th>
							<th>금액</th>
							<th>카테고리</th> 
							<th>결제 수단</th>
							<th>예정일</th>
						</tr>
					</thead>
					<c:forEach items="${list}" var="expense">
						<tr>
							<td><c:out value="${expense.expense_id}" /></td>
							<td><a href='/expense/get?expense_id=<c:out value="${expense.expense_id}"/>'>
								<c:out value="${expense.name}"/></a>
							</td>
							<td><fmt:formatNumber value="${expense.amount}" pattern="#,##0" /> 원</td>
							<td><c:out value="${expense.category_name}" /></td> 
            				<td><c:out value="${expense.method_name}" /></td>
							<td><c:out value="${expense.cycle_name}" /> <c:out value="${expense.payment_day}" />일</td>
						</tr>
					</c:forEach>
				</table>

				<div class='pull-right'>
					<ul class="pagination">
            
            <c:if test="${pageMaker.prev}">
				<li class="paginate_button previous"><a
					href="${pageMaker.startPage -1}">Previous</a></li>
			</c:if>

			<c:forEach var="num" begin="${pageMaker.startPage}"
				end="${pageMaker.endPage}">
				<li class="paginate_button  ${pageMaker.cri.pageNum == num ? "active":""} ">
					<a href="${num}">${num}</a>
				</li>
			</c:forEach>

			<c:if test="${pageMaker.next}">
				<li class="paginate_button next"><a
					href="${pageMaker.endPage +1 }">Next</a></li>
			</c:if>

					</ul>
				</div>
				</div>

			<form id='actionForm' action="/expense/list" method='get'>
				<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
				<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
			</form>

			<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">&times;</button>
							<h4 class="modal-title" id="myModalLabel">처리 결과</h4>
						</div>
						<div class="modal-body">처리가 완료되었습니다.</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
			</div>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		
		var result = '<c:out value="${result}"/>';
		checkModal(result);
		history.replaceState({}, null, null);

		function checkModal(result) {
			if (result === '' || history.state) { return; }
			
			// result가 숫자인 경우 (등록)
			if (parseInt(result) > 0) {
				$(".modal-body").html(
						"항목 " + parseInt(result) + " 번이 등록되었습니다.");
			} 
			// result가 "success"인 경우 (수정/삭제)
			else if (result === 'success') {
				$(".modal-body").html("처리가 완료되었습니다.");
			}
			$("#myModal").modal("show");
		}

		// 새 항목 등록 버튼
		$("#regBtn").on("click", function() {
			self.location = "/expense/register";
		});

		// 페이지 번호 클릭
		var actionForm = $("#actionForm");
		$(".paginate_button a").on("click", function(e) {
			e.preventDefault();
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});
	});
</script>

<%@include file="../includes/footer.jsp"%>