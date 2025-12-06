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
	
	<style>
        /* 1. 전체 폰트 및 배경 변경 */
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f4f6f9; /* 아주 연한 회색 배경 */
            color: #333;
        }
        
        /* 2. 패널(박스) 디자인: 그림자 추가, 테두리 제거, 둥근 모서리 */
        .panel {
            border: none !important;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05) !important;
            border-radius: 12px !important;
            margin-bottom: 25px;
        }
        .panel-heading {
            background-color: #fff !important;
            border-bottom: 1px solid #f0f0f0 !important;
            border-radius: 12px 12px 0 0 !important;
            font-weight: 700;
            padding: 15px 20px;
            font-size: 1.1em;
            color: #444 !important;
        }
        .panel-body {
            padding: 20px;
        }
        
        /* 3. 버튼 디자인: 둥글고 플랫하게 */
        .btn {
            border-radius: 8px !important;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            font-weight: 500;
            padding: 8px 16px;
            border: none;
            transition: all 0.2s;
        }
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
        }
        .btn-primary { background-color: #4e73df; } /* 모던한 블루 */
        .btn-success { background-color: #1cc88a; } /* 모던한 그린 */
        .btn-danger  { background-color: #e74a3b; } /* 모던한 레드 */
        
        /* 4. 테이블 디자인 */
        .table > thead > tr > th {
            border-bottom: 2px solid #e3e6f0;
            color: #666;
            font-weight: 600;
        }
        .table-hover > tbody > tr:hover {
            background-color: #f8f9fc;
        }
        
        /* 5. 입력 폼 디자인 */
        .form-control {
            border-radius: 8px;
            height: 45px; /* 입력창 높여서 터치감 개선 */
            border: 1px solid #d1d3e2;
        }
        .form-control:focus {
            border-color: #4e73df;
            box-shadow: 0 0 0 0.2rem rgba(78, 115, 223, 0.25);
        }
        
        /* 6. 모달창 디자인 */
        .modal-content {
            border-radius: 15px;
            border: none;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        .modal-header {
            border-radius: 15px 15px 0 0;
            background-color: #4e73df; /* 헤더 색상 통일 */
            color: white;
        }
        .modal-title { font-weight: bold; }
        .close { color: white; opacity: 0.8; text-shadow: none; }
        .close:hover { opacity: 1; color: white; }
        
        /* 7. 알림 뱃지 디자인 */
        .badge {
            padding: 5px 10px;
            border-radius: 6px;
            font-weight: 500;
        }
    </style>
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