<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.*" %>
<%!
    public Connection getConnection1(){
        try{
            String dbURL="jdbc:mysql://localhost/songjeh1039";
            String dbID="songjeh1039";
            String dbPassword="KSsongjeh1039M";
            Class.forName("com.mysql.jdbc.Driver");
            //그냥jdbc에 드라이버는 이제 안씀
            return DriverManager.getConnection(dbURL,dbID,dbPassword);//3306 포트에 튜토리얼 에서 위에 적힌 아이디와
            // 페스워드로 로그인한 상태를 반환
        }catch(Exception e){
            e.printStackTrace();
        }
        return null;
    }
    public int insertComment(int evaluationID, String commentContent, String userID)throws SQLException {
        String SQL = "INSERT INTO evaluation_comment VALUES (?,?,?)";
        PreparedStatement pstmt = null;
        Connection conn = null;
        conn = getConnection1();
        pstmt = conn.prepareStatement(SQL);
        pstmt.setInt(1, evaluationID);
        pstmt.setString(2, userID);
        pstmt.setString(3, commentContent);
        return pstmt.executeUpdate();
    }
%>
<%
    String userID;
    int evaluationID;
    String commentContent;

    if (request.getParameter("userID") != null)
       userID =request.getParameter("userID");
    else
        userID = "";

    if (request.getParameter("evaluationID") != null)
        evaluationID = Integer.parseInt(request.getParameter("evaluationID"));
    else
        evaluationID = 0;

    if (request.getParameter("comment") != null)
        commentContent = request.getParameter("comment");
    else
        commentContent = "";

    int result=insertComment(evaluationID,commentContent,userID);
    if(result==1){
        PrintWriter script=response.getWriter();
        script.println("<script>");
        script.println("alert('입력완료 되었습니다..');");
        script.println("location.href='coment.jsp?evaluationID="+evaluationID+"'");
        script.println("</script>");
        script.close();
    } else{
        PrintWriter script=response.getWriter();
        script.println("<script>");
        script.println("alert('입력실패');");
        script.println("location.href='index.jsp'");
        script.println("</script>");
        script.close();
    }

%>