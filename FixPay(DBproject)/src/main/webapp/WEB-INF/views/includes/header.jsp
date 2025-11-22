<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- JSTL 태그 라이브러리 (필수) --%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>고정비서 - 고정 지출 관리</title>

    <link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <link href="/resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    <link href="/resources/vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">

    <link href="/resources/vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">

    <link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">

    <link href="/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    </head>

<body>

    <div id="wrapper">

        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                
                <a class="navbar-brand" href="${not empty loginUser ? '/dashboard/main' : '/user/login'}">고정비서</a>
            </div>
            <ul class="nav navbar-top-links navbar-right">
                
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-user fa-fw"></i> <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user">
                        
                        <c:if test="${not empty loginUser}">
                            <li><a href="#"><i class="fa fa-user fa-fw"></i> ${loginUser.nickname}님</a>
                            </li>
                            <li><a href="/setting/main"><i class="fa fa-gear fa-fw"></i> Settings</a>
                            </li>
                            <li class="divider"></li>
                            <li><a href="/user/logout"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
                            </li>
                        </c:if>
                        
                        <c:if test="${empty loginUser}">
                            <li><a href="/user/login"><i class="fa fa-sign-in fa-fw"></i> Login</a>
                            </li>
                            <li><a href="/user/register"><i class="fa fa-edit fa-fw"></i> Register</a>
                            </li>
                        </c:if>
                    </ul>
                    </li>
                </ul>
            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu">
                        <li class="sidebar-search">
                            <div class="input-group custom-search-form">
                                <input type="text" class="form-control" placeholder="Search...">
                                <span class="input-group-btn">
                                <button class="btn btn-default" type="button">
                                    <i class="fa fa-search"></i>
                                </button>
                            </span>
                            </div>
                            </li>

                        <c:if test="${not empty loginUser}">
                            <li><a href="/dashboard/main"><i class="fa fa-dashboard fa-fw"></i> 대시보드</a></li>
                            <li><a href="/expense/list"><i class="fa fa-table fa-fw"></i> 예정 목록 (CRUD)</a></li>
                            <li><a href="/history/manage"><i class="fa fa-check-square-o fa-fw"></i> 지출 확정하기</a></li>
                            <li><a href="/setting/main"><i class="fa fa-gear fa-fw"></i> 통합 설정</a></li> 
                        </c:if>
                
                        <c:if test="${empty loginUser}">
                             <li><a href="/user/login"><i class="fa fa-sign-in fa-fw"></i> 로그인</a></li>
                             <li><a href="/user/register"><i class="fa fa-edit fa-fw"></i> 회원가입</a></li>
                        </c:if>
                        
                    </ul>
                </div>
                </div>
            </nav>

        <div id="page-wrapper">
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>