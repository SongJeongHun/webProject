<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.*" %>
<%!
    public Connection getConnection1() {
        try {
            String dbURL = "jdbc:mysql://localhost/songjeh1039";
            String dbID = "songjeh1039";
            String dbPassword = "KSsongjeh1039M";
            Class.forName("com.mysql.jdbc.Driver");
            //그냥jdbc에 드라이버는 이제 안씀
            return DriverManager.getConnection(dbURL, dbID, dbPassword);//3306 포트에 튜토리얼 에서 위에 적힌 아이디와
            // 페스워드로 로그인한 상태를 반환
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    public int addlikeCount(int evaluationID) throws  SQLException{
        String SQL="UPDATE evaluation_evaluation SET likeCount=likeCount+1 where evaluationID="+evaluationID;
        PreparedStatement pstmt = null;
        Connection conn = null;
        ResultSet rs = null;
        conn = getConnection1();
        pstmt = conn.prepareStatement(SQL);
        return pstmt.executeUpdate();
    }
%>
<%
    int evaluationID;
    if(request.getParameter("evaluationID")==null)
        evaluationID=-1;
    else
        evaluationID=Integer.parseInt(request.getParameter("evaluationID"));
    int result=addlikeCount(evaluationID);
    if(result==1){
        PrintWriter script=response.getWriter();
        script.println("<script>");
        script.println("alert('추천 되었습니다..');");
        script.println("location.href='coment.jsp?evaluationID="+evaluationID+"'");
        script.println("</script>");
        script.close();
    } else{
        PrintWriter script=response.getWriter();
        script.println("<script>");
        script.println("alert('입력실패');");
        script.println("location.href='coment.jsp?evaluationID="+evaluationID+"'");
        script.println("</script>");
        script.close();
    }
%>