<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%
    String userID=null;
    if(session.getAttribute("userID")!=null){
        PrintWriter script=response.getWriter();
        script.println("<script>");
        script.println("alert('이미 로그인이 되어 있습니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text-html; charset=ETC-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>기말 프로젝트</title>
    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/custom.min.css">
</head>
<body>
<section class="container mt-3" style="max-width: 560px;">
    <form method="post" action="./userRegisterAction.jsp">
        <div class="form-group">
            <label>아이디</label>
            <input type="text" name="userID" class="form-control">
        </div>
        <div class="form-group">
            <label>비밀번호</label>
            <input type="password" name="userPassword" class="form-control">
        </div>
        <div class="form-group">
            <label>이메일</label>
            <input type="text" name="userEmail" class="form-control">
        </div>
        <button type="submit" class="btn btn-primary" >회원가입</button>
    </form>
</section>
<%--jQuery 자바스크립트 추가--%>
<script src="./js/jquery-3.4.1.min.js"></script>
<%--파퍼 자바스크립트 추가--%>
<script src="./js/popper.js"></script>
<%--부트스트랩 자바스크립트 추가--%>
<script src="./js/bootstrap.min.js"></script>
</body>
</html>
