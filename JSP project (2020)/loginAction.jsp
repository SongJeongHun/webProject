<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="userDAO.jsp" %>
<%@ page import="java.io.PrintWriter" %>
<%
    request.setCharacterEncoding("UTF-8");

    String userID=null;
    String userPassword=null;

    if(request.getParameter("userID")==null)
        userID="";
    else
        userID=request.getParameter("userID");
    if(request.getParameter("userPassword")==null)
        userPassword="";
    else
        userPassword=request.getParameter("userPassword");


    if(userID.equals("")||userPassword.equals("")){
        PrintWriter script=response.getWriter();
        script.println("<script>");
        script.println("alert('입력이 안된 사항이 있습니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
    }
    int result=login(userID,userPassword);
    if(result==1){
        session.setAttribute("userID",userID);
        PrintWriter script=response.getWriter();
        script.println("<script>");
        script.println("alert('로그인 성공!');");
        script.println("location.href='index.jsp'");
        script.println("</script>");
        script.close();
    }
    else if(result==0){
        PrintWriter script=response.getWriter();
        script.println("<script>");
        script.println("alert('비밀번호가 틀립니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
    }
    else if(result==-1){

        PrintWriter script=response.getWriter();
        script.println("<script>");
        script.println("alert('존재 하지 않는 아이디 입니다..');");
        script.println("history.back();");
        script.println("</script>");
        script.close();

    }
    else if(result==-2) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('데이터 베이스 오류 입니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
    }
%>
