<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../includes/header.jsp"%> <div class="row">
    <div class="col-lg-6 col-lg-offset-3">
        <h1 class="page-header">로그인</h1>
        <div class="panel panel-default">
            <div class="panel-heading">Login Page</div>
            <div class="panel-body">
                <form role="form" action="/user/login" method="post">
                    <div class="form-group">
                        <label>Email</label> 
                        <input class="form-control" name="email" type="email" required>
                    </div>
                    <div class="form-group">
                        <label>Password</label> 
                        <input class="form-control" name="password" type="password" required>
                    </div>
                    
                    <c:if test="${result == 'login_fail'}">
                        <div class="alert alert-danger">
                            이메일 또는 비밀번호가 올바르지 않습니다.
                        </div>
                    </c:if>
                    <c:if test="${result == 'register_success'}">
                        <div class="alert alert-success">
                            회원가입이 완료되었습니다. 로그인해주세요.
                        </div>
                    </c:if>
                    
                    <button type="submit" class="btn btn-primary">로그인</button>
                    <button type="button" class="btn btn-info" onclick="location.href='/user/register'">회원가입</button>
                </form>
            </div>
        </div>
    </div>
</div>

<%@include file="../includes/footer.jsp"%>