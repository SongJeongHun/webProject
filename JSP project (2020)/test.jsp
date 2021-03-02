<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="EvaluationDAO.jsp"%>

<%
    ResultSet test=getList("","최신순","");
    while(test.next()){


%>
<div><%=test.getString("userID")%></div>
<%
    }
%>

<%--
<%!
    public Connection getConnection(){
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
    public ResultSet test() throws SQLException {
        String SQL = "SELECT * FROM evaluation_evaluation WHERE lectureDivide LIKE ? AND CONCAT(lectureName,professorName,evaluationTitle,evaluationContent,userID) LIKE ? ORDER BY evaluationID";
        PreparedStatement pstmt = null;
        Connection conn = null;
        conn = getConnection();
        pstmt = conn.prepareStatement(SQL);
        pstmt.setString(1, "%" + "" + "%");
        pstmt.setString(2, "%" + "" + "%");
        ResultSet rs = pstmt.executeQuery();
        return rs;
    }

%>--%>
