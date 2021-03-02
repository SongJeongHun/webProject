<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.*" %>
<%!
    public int join(String userID,String userPassword,String userEmail) throws SQLException{
        String SQL="INSERT INTO evaluation_user VALUES (?,?,?)";
        Connection conn=null;
        PreparedStatement pstmt=null;
        ResultSet rs=null;//SQL에서 나온 값을 처리하기위한 클래스

            conn= getConnection1(); //객체자체를 반환
            pstmt=conn.prepareStatement(SQL);   //컨객체의 SQL문장 준비
            pstmt.setString(1,userID);  //입력받은 ID값을 ?안에 넣어줌 1번째 물음표
            pstmt.setString(2,userPassword);
            pstmt.setString(3,userEmail);
            return pstmt.executeUpdate();   //데이터 계수를 반환.성공시 1반환

    }
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
%>
<%
request.setCharacterEncoding("UTF-8");

    String userID=null;
    String userPassword=null;
    String userEmail=null;

    if(session.getAttribute("userID")!=null){
        PrintWriter script=response.getWriter();
        script.println("<script>");
        script.println("alert('로그인이 된 상태입니다.');");
        script.println("location.href='index.jsp'");
        script.println("</script>");
        script.close();
    }

    if(request.getParameter("userID")==null)
        userID="";
    else
        userID=request.getParameter("userID");

    if(request.getParameter("userPassword")==null)
        userPassword="";
    else
        userPassword=request.getParameter("userPassword");

    if(request.getParameter("userEmail")==null)
        userEmail="";
    else
        userEmail=request.getParameter("userEmail");

    if(userID.equals("")||userPassword.equals("")||userEmail.equals("")){
        PrintWriter script=response.getWriter();
        script.println("<script>");
        script.println("alert('입력이 안된 사항이 있습니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
    }
    int result=join(userID,userPassword,userEmail);
    if(result==-1){
        PrintWriter script=response.getWriter();
        script.println("<script>");
        script.println("alert('이미 존재하는 아이디 입니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
    }
    else {
        session.setAttribute("userID",userID);
        PrintWriter script=response.getWriter();
        script.println("<script>");
        script.println("alert('회원가입 성공!')");
        script.println("location.href='index.jsp'");
        script.println("</script>");
        script.close();
        session.invalidate();
    }
%>
