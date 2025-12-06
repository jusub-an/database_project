<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../includes/header.jsp"%>


<style>
    /* 탭 네비게이션 디자인 */
    .nav-pills > li > a {
        border-radius: 8px;
        font-weight: 600;
        color: #858796;
        background-color: #fff;
        margin-right: 10px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.05);
    }
    .nav-pills > li.active > a, 
    .nav-pills > li.active > a:focus, 
    .nav-pills > li.active > a:hover {
        background-color: #4e73df; /* 브랜드 컬러 */
        color: #fff;
        box-shadow: 0 4px 10px rgba(78, 115, 223, 0.3);
    }
    .tab-content {
        margin-top: 25px;
        background-color: #fff;
        padding: 30px;
        border-radius: 15px;
        box-shadow: 0 0 20px rgba(0,0,0,0.03);
    }
    h3 {
        margin-top: 0;
        margin-bottom: 20px;
        border-bottom: 2px solid #f0f2f5;
        padding-bottom: 15px;
        font-size: 1.4em;
        color: #333;
    }
</style>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">통합 설정</h1>
	</div>
</div>

<div class="row">
    <div class="col-lg-12">
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissable">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <strong>오류!</strong> ${error}
            </div>
        </c:if>
        
        <c:if test="${not empty result}">
            <div class="alert alert-success alert-dismissable">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <strong>성공!</strong> ${result}
            </div>
        </c:if>
    </div>
</div>

<div class="row">
    <div class="col-lg-12">
        <ul class="nav nav-tabs">
            <li class="active"><a href="#alert" data-toggle="tab">알림 설정</a></li>
            <li><a href="#category" data-toggle="tab">카테고리 관리</a></li>
            <li><a href="#method" data-toggle="tab">결제 수단 관리</a></li>
        </ul>

        <div class="tab-content">
            
            <div class="tab-pane fade in active" id="alert">
                <h3><i class="fa fa-bell"></i> 알림 설정</h3>
                <form class="form-horizontal" action="/setting/alert/save" method="post">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">알림 받기</label>
                        <div class="col-sm-9">
                            <label class="checkbox-inline">
                                <input type="checkbox" name="is_active" value="1" 
                                    ${alertSetting.is_active == 1 ? 'checked' : ''}>
                                결제일 임박 시 알림 (구현 예정)
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">알림 기준일</label>
                        <div class="col-sm-3">
                            <div class="input-group">
                                <span class="input-group-addon">결제일</span>
                                <input type="number" class="form-control" name="days_before" 
                                       value="${alertSetting.days_before}" min="1" max="30">
                                <span class="input-group-addon">일 전</span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-3 col-sm-9">
                            <button type="submit" class="btn btn-primary">알림 설정 저장</button>
                        </div>
                    </div>
                </form>
            </div>
            
            <div class="tab-pane fade" id="category">
                <h3><i class="fa fa-tags"></i> 카테고리 관리</h3>
                <div class="row">
                    <div class="col-lg-4">
                        <div class="panel panel-default">
                           <div class="panel-heading">새 카테고리 등록</div>
                           <div class="panel-body">
                               <form action="/setting/category/register" method="post">
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
											<th>이름</th> <th>유형</th> <th>관리</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${categoryList}" var="category">
											<tr>
												<td><c:out value="${category.name}" /></td>
												<td>
													<c:if test="${empty category.user_id}"><span class="label label-info">기본</span></c:if>
													<c:if test="${not empty category.user_id}"><span class="label label-success">사용자 정의</span></c:if>
												</td>
												<td>
													<c:if test="${not empty category.user_id}">
														<form action="/setting/category/remove" method="post" style="display:inline;">
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
            </div>
            
            <div class="tab-pane fade" id="method">
                <h3><i class="fa fa-credit-card"></i> 결제 수단 관리</h3>
                <div class="row">
                    <div class="col-lg-4">
                        <div class="panel panel-default">
                           <div class="panel-heading">새 결제 수단 등록</div>
                           <div class="panel-body">
                               <form action="/setting/method/register" method="post">
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
											<th>이름</th> <th>유형</th> <th>관리</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${methodList}" var="method">
											<tr>
												<td><c:out value="${method.name}" /></td> 
												<td><c:out value="${method.type}" /></td>
												<td>
													<form action="/setting/method/remove" method="post" style="display:inline;"> 
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
            </div>

        </div> </div>
</div>

<%@include file="../includes/footer.jsp"%>