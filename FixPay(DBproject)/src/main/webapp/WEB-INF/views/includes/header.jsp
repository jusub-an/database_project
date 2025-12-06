<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>FixedPay - 스마트한 고정지출 관리</title>

    <link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="/resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">
    <link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">
    <link href="/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">

    <style>
        /* 1. 폰트 및 기본 설정 */
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f8f9fc; /* 배경색 변경 */
            color: #5a5c69;
        }
        
        /* 2. 카드형 디자인 (Panel 오버라이딩) */
        .panel {
            border: none;
            border-radius: 0.75rem; /* 둥근 모서리 */
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15); /* 그림자 */
        }
        .panel-default > .panel-heading {
            background-color: #fff;
            border-bottom: 1px solid #e3e6f0;
            border-top-left-radius: 0.75rem;
            border-top-right-radius: 0.75rem;
            padding: 1rem 1.25rem;
            font-weight: 700;
            color: #4e73df; /* 헤더 텍스트 색상 */
        }
        
        /* 3. 버튼 디자인 */
        .btn {
            border-radius: 0.35rem;
            padding: 0.375rem 0.75rem;
            font-weight: 600;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            transition: all 0.2s;
        }
        .btn:hover { transform: translateY(-1px); box-shadow: 0 4px 8px rgba(0,0,0,0.15); }
        
        .btn-primary { background-color: #4e73df; border-color: #4e73df; }
        .btn-primary:hover { background-color: #2e59d9; border-color: #2e59d9; }
        
        .btn-success { background-color: #1cc88a; border-color: #1cc88a; }
        .btn-info    { background-color: #36b9cc; border-color: #36b9cc; }
        .btn-warning { background-color: #f6c23e; border-color: #f6c23e; }
        .btn-danger  { background-color: #e74a3b; border-color: #e74a3b; }
        
        /* 4. 테이블 디자인 */
        .table thead th {
            border-top: none;
            border-bottom: 2px solid #e3e6f0;
            color: #858796;
            font-weight: 700;
            text-transform: uppercase;
            font-size: 0.85rem;
        }
        .table-hover tbody tr:hover {
            background-color: #eaecf4;
        }
        
        /* 5. 뱃지(Badge) 디자인 */
        .badge {
            padding: 0.4em 0.6em;
            border-radius: 0.35rem;
            font-weight: 600;
        }
        
        /* 6. 입력 폼 디자인 */
        .form-control {
            border-radius: 0.35rem;
            height: calc(1.5em + 0.75rem + 2px); /* 높이 증가 */
            border: 1px solid #d1d3e2;
        }
        .form-control:focus {
            border-color: #bac8f3;
            box-shadow: 0 0 0 0.2rem rgba(78, 115, 223, 0.25);
        }
        
        /* 7. 네비게이션 바 (사이드바) */
        .navbar-default { background-color: #fff; border-color: #e7e7e7; }
        .sidebar ul li a.active { background-color: #f8f9fc; color: #4e73df; font-weight: 700; }
        .navbar-brand { color: #4e73df !important; font-weight: 800; font-size: 1.5rem; }
        
        /* 8. 페이지 헤더 */
        .page-header {
            border-bottom: none;
            margin: 1.5rem 0 1rem;
            color: #5a5c69;
            font-weight: 400;
        }
    </style>
</head>

<body>
    <div id="wrapper">
        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="${not empty loginUser ? '/dashboard/main' : '/user/login'}">
                    <i class="fa fa-credit-card"></i> FixedPay
                </a>
            </div>

            <ul class="nav navbar-top-links navbar-right">
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-user fa-fw"></i> <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user">
                        <c:if test="${not empty loginUser}">
                            <li><a href="#"><i class="fa fa-user fa-fw"></i> ${loginUser.nickname}님</a></li>
                            <li><a href="/setting/main"><i class="fa fa-gear fa-fw"></i> 설정</a></li>
                            <li class="divider"></li>
                            <li><a href="/user/logout"><i class="fa fa-sign-out fa-fw"></i> 로그아웃</a></li>
                        </c:if>
                        <c:if test="${empty loginUser}">
                            <li><a href="/user/login"><i class="fa fa-sign-in fa-fw"></i> 로그인</a></li>
                            <li><a href="/user/register"><i class="fa fa-edit fa-fw"></i> 회원가입</a></li>
                        </c:if>
                    </ul>
                </li>
            </ul>

            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu">
                        <c:if test="${not empty loginUser}">
                             <li style="padding: 20px 15px; text-align: center; background-color: #f8f9fc; border-bottom: 1px solid #e3e6f0;">
                                <div style="font-weight: 700; color: #4e73df;">${loginUser.nickname}</div>
                                <div style="font-size: 0.85em; color: #858796;">${loginUser.email}</div>
                            </li>
                        </c:if>
                        
                        <c:if test="${not empty loginUser}">
                            <li><a href="/dashboard/main"><i class="fa fa-dashboard fa-fw"></i> 대시보드</a></li>
                            <li><a href="/expense/list"><i class="fa fa-list-alt fa-fw"></i> 지출 항목 관리</a></li>
                            <li><a href="/history/manage"><i class="fa fa-check-square-o fa-fw"></i> 결제 확정</a></li>
                            <li><a href="/setting/main"><i class="fa fa-cogs fa-fw"></i> 통합 설정</a></li> 
                        </c:if>
                
                        <c:if test="${empty loginUser}">
                             <li><a href="/user/login"><i class="fa fa-sign-in fa-fw"></i> 로그인</a></li>
                             <li><a href="/user/register"><i class="fa fa-user-plus fa-fw"></i> 회원가입</a></li>
                        </c:if>
                    </ul>
                </div>
            </div>
        </nav>

        <div id="page-wrapper" style="min-height: 800px;">
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>