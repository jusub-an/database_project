<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%> <div class="row">
    <div class="col-lg-6 col-lg-offset-3">
        <h1 class="page-header">회원가입</h1>
        <div class="panel panel-default">
            <div class="panel-heading">Register Page</div>
            <div class="panel-body">
                <form role="form" action="/user/register" method="post">
                    <div class="form-group">
                        <label>Email (로그인 ID)</label> 
                        <input class="form-control" name="email" type="email" required>
                    </div>
                    <div class="form-group">
                        <label>Password</label> 
                        <input class="form-control" name="password" type="password" required>
                    </div>
                    <div class="form-group">
                        <label>Nickname</label> 
                        <input class="form-control" name="nickname" required>
                    </div>
                    <button type="submit" class="btn btn-primary">회원가입</button>
                    <button type="button" class="btn btn-info" onclick="location.href='/user/login'">로그인</button>
                </form>
            </div>
        </div>
    </div>
</div>

<%@include file="../includes/footer.jsp"%>