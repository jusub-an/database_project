<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp"%>

<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">
            '<c:out value="${expense.name}"/>' 결제 내역 상세
        </h1>
    </div>
</div>

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                총 <c:out value="${historyList.size()}"/> 건의 결제 내역
            </div>
            <div class="panel-body">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>결제일</th>
                            <th>결제 금액</th>
                            <th>메모</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${historyList}" var="history">
                            <tr>
                                <td>
                                    <fmt:formatDate value="${history.payment_date}" 
                                                    pattern="yyyy년 MM월 dd일" />
                                </td>
                                <td>
                                    <fmt:formatNumber value="${history.paid_amount}" 
                                                      pattern="#,##0" /> 원
                                </td>
                                <td><c:out value="${history.memo}"/></td>
                            </tr>
                        </c:forEach>
                        <c:if test="${historyList.size() == 0}">
                            <tr>
                                <td colspan="3" class="text-center">
                                    아직 확정된 결제 내역이 없습니다.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>

                <button type="button" class="btn btn-info" 
                        onclick="location.href='/dashboard/main'">
                    대시보드로
                </button>

            </div>
        </div>
    </div>
</div>

<%@include file="../includes/footer.jsp"%>