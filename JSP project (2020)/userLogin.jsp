<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%
    String userID=null;
    if(session.getAttribute("userID")!=null){
        userID=(String)session.getAttribute("userID");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text-html; charset=ETC-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>기말 프로젝트</title>
    <%--부트스트랩 CSS추가--%>
    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <%--부트스트랩 CSS추가--%>
    <link rel="stylesheet" href="./css/custom.min.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-dark">
    <a class="navbar-brand" href="index.jsp"> <span style="color:#FFFFFF;">강의평가</span></a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar"></button>
    <div id="navbar" class="collapse navbar-collapse">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="index.jsp"> <span style="color:#FFFFFF;">메인화면가기</span></a><%--Anchor(닻)문서내 이동 혹은 링크를 통해 다른 홈페이지로 이동--%>
            </li>
            <li class="nav-item dropdown"><%--dropdown 버튼인데 아래쪽에 목록이 보이는 버튼--%>
                <a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown"><%--토글(누르면 사리지고 생기는 것)--%>
                    <span style="color:#FFFFFF;">회원관리</span>
                </a>
                <div class="dropdown-menu" aria-labelledby="dropdown">
                    <%
                        if (userID == null) {
                    %>
                    <a class="dropdown-item" href="userLogin.jsp">로그인</a>
                    <a class="dropdown-item" href="userJoin.jsp">회원가입</a>
                    <%
                    } else {
                    %>
                    <a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
                    <%
                        }
                    %>
                </div>
            </li>
        </ul>
    </div>
</nav>
<section class="container mt-3" style="max-width: 560px;">
    <form method="post" action="./loginAction.jsp">
        <div class="form-group">
            <label>아이디</label>
            <input type="text" name="userID" class="form-control">
        </div>
        <div class="form-group">
            <label>비밀번호</label>
            <input type="password" name="userPassword" class="form-control">
        </div>
        <button type="submit" class="btn btn-primary" >로그인</button>
    </form>
</section>
<footer class="bg mt-4 p-5 text-center"><span style="color:#808080;">
    Copyright &copy; 2020 Jeong Hun All Rights Reserved.
</span>
</footer>
<%--jQuery 자바스크립트 추가--%>
<script src="./js/jquery-3.4.1.min.js"></script>
<%--파퍼 자바스크립트 추가--%>
<script src="./js/popper.js"></script>
<%--부트스트랩 자바스크립트 추가--%>
<script src="./js/bootstrap.min.js"></script>
</body>
</html>
