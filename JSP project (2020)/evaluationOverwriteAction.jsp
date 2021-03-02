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
    public int overwrite(String lectureName, String professorName, int lectureYear, String semesterDivide, String lectureDivide, String evaluationTitle, String evaluationContent, String totalScore, String creditScore, String comfortableScore, String lectureScore, int evaluationID)throws SQLException{
        String SQL1="UPDATE evaluation_evaluation SET lectureName=?, professorName=?, lectureYear=?, semesterDivdie=?, lectureDivide=?, evaluationTitle=?, evaluationContent=?, totalScore=?, creditScore=?, comfortableScore=?, lectureScore=? WHERE evaluationID=?";
        Connection conn=null;
        PreparedStatement pstmt=null;
        int result=0;
            conn= getConnection1();
            pstmt=conn.prepareStatement(SQL1);
            pstmt.setString(1, lectureName);  //입력받은 ID값을 ?안에 넣어줌 1번째 물음표
            pstmt.setString(2, professorName);  //입력받은 ID값을 ?안에 넣어줌 1번째 물음표
            pstmt.setInt(3, lectureYear);  //입력받은 ID값을 ?안에 넣어줌 1번째 물음표
            pstmt.setString(4, semesterDivide);  //입력받은 ID값을 ?안에 넣어줌 1번째 물음표
            pstmt.setString(5, lectureDivide);  //입력받은 ID값을 ?안에 넣어줌 1번째 물음표
            pstmt.setString(6, evaluationTitle);  //입력받은 ID값을 ?안에 넣어줌 1번째 물음표
            pstmt.setString(7, evaluationContent);  //입력받은 ID값을 ?안에 넣어줌 1번째 물음표
            pstmt.setString(8, totalScore);  //입력받은 ID값을 ?안에 넣어줌 1번째 물음표
            pstmt.setString(9, creditScore);  //입력받은 ID값을 ?안에 넣어줌 1번째 물음표
            pstmt.setString(10, comfortableScore);  //입력받은 ID값을 ?안에 넣어줌 1번째 물음표
            pstmt.setString(11, lectureScore);  //입력받은 ID값을 ?안에 넣어줌 1번째 물음표
            pstmt.setInt(12,evaluationID);
            result=pstmt.executeUpdate();
            return result;

    }

%>
<%
    request.setCharacterEncoding("UTF-8");
    String userID=null;
    if(session.getAttribute("userID")!=null){ //유저가 로그인을 할 상태여서 userID값이 존재하낟면,
        userID=(String)session.getAttribute("userID");  //해당 새션 값을 넣어줌
    }
    if(userID==null){ //로그인을 하지 않은 상태라면
        PrintWriter script=response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 해주세요1.');");
        script.println("location.href='userLogin.jsp'");
        script.println("</script>");
        script.close();
    }
    String lectureName=null;
    String professorName=null;
    int lectureYear=-1;
    String semesterDivide=null;
    String lectureDivide=null;
    String evaluationTitle=null;
    String evaluationContent=null;
    String totalScore=null;
    String creditScore=null;
    String comfortableScore=null;
    String lectureScore=null;
    int evaluationID=0;

    int result=0;
    if(request.getParameter("evaluationID")==null)
        evaluationID=-1;
    else
        evaluationID=Integer.parseInt(request.getParameter("evaluationID"));


    if(request.getParameter("lectureName")==null)
        lectureName="";
    else
        lectureName=request.getParameter("lectureName");

    if(request.getParameter("professorName")==null)
        professorName="";
    else
        professorName=request.getParameter("professorName");

    if(request.getParameter("lectureYear")==null)
        lectureYear=-1;

    else
        lectureYear=Integer.parseInt(request.getParameter("lectureYear"));

    if(request.getParameter("semesterDivide")==null)
        semesterDivide="";
    else
        semesterDivide=request.getParameter("semesterDivide");

    if(request.getParameter("lectureDivide")==null)
        lectureDivide="";
    else
        lectureDivide=request.getParameter("lectureDivide");

    if(request.getParameter("evaluationTitle")==null)
        evaluationTitle="";
    else
        evaluationTitle=request.getParameter("evaluationTitle");

    if(request.getParameter("evaluationContent")==null)
        evaluationContent="";
    else
        evaluationContent=request.getParameter("evaluationContent");

    if(request.getParameter("totalScore")==null)
        totalScore="";
    else
        totalScore=request.getParameter("totalScore");

    if(request.getParameter("creditScore")==null)
        creditScore="";
    else
        creditScore=request.getParameter("creditScore");

    if(request.getParameter("comfortableScore")==null)
        comfortableScore="";
    else
        comfortableScore=request.getParameter("comfortableScore");

    if(request.getParameter("lectureScore")==null)
        lectureScore="";
    else
        lectureScore=request.getParameter("lectureScore");

    if(lectureName.equals("")||professorName.equals("")||lectureYear==-1||semesterDivide.equals("")||lectureDivide.equals("")||
            evaluationTitle.equals("")||evaluationContent.equals("")||totalScore.equals("")||creditScore.equals("")||comfortableScore.equals("")||
            lectureScore.equals("")){
        PrintWriter script=response.getWriter();
        script.println("<script>");
        script.println("alert('입력이 안된사항이 있습니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
    }else {
        result = overwrite(lectureName, professorName, lectureYear, semesterDivide, lectureDivide, evaluationTitle, evaluationContent, totalScore, creditScore, comfortableScore, lectureScore,evaluationID);
    }
    if(result==1){
        PrintWriter script=response.getWriter();
        script.println("<script>");
        script.println("alert('등록 성공!')");
        script.println("location.href='index.jsp'");
        script.println("</script>");
        script.close();
    }else{
        PrintWriter script=response.getWriter();
        script.println("<script>");
        script.println("alert('등록 오류')");
        script.println("history.back();");
        script.println("</script>");
        script.close();
    }
%>
