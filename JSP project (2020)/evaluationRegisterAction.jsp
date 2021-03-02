<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.*" %>
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
    public int write(int evaluationID, String userID, String lectureName, String professorName, int lectureYear, String semesterDivide, String lectureDivide, String evaluationTitle, String evaluationContent, String totalScore, String creditScore, String comfortabelScore, String lectureScore, int likeCount)throws SQLException{
        String SQL = "INSERT INTO evaluation_evaluation VALUES (NULL,?,?,?,? ,?,?,?,?,?,? ,?,?,0,0)";//사용자로부터 입력받은 아이디의 패스워드를 불러와서 ㄷ다룸
        Connection conn = null;
        PreparedStatement pstmt = null;
            conn = getConnection(); //객체자체를 반환
            pstmt = conn.prepareStatement(SQL);   //컨객체의 SQL문장 준비
            pstmt.setString(1, userID);  //입력받은 ID값을 ?안에 넣어줌 1번째 물음표
            pstmt.setString(2, lectureName);  //입력받은 ID값을 ?안에 넣어줌 1번째 물음표
            pstmt.setString(3, professorName);  //입력받은 ID값을 ?안에 넣어줌 1번째 물음표
            pstmt.setInt(4, lectureYear);  //입력받은 ID값을 ?안에 넣어줌 1번째 물음표
            pstmt.setString(5, semesterDivide);  //입력받은 ID값을 ?안에 넣어줌 1번째 물음표
            pstmt.setString(6, lectureDivide);  //입력받은 ID값을 ?안에 넣어줌 1번째 물음표
            pstmt.setString(7, evaluationTitle);  //입력받은 ID값을 ?안에 넣어줌 1번째 물음표
            pstmt.setString(8, evaluationContent);  //입력받은 ID값을 ?안에 넣어줌 1번째 물음표
            pstmt.setString(9, totalScore);  //입력받은 ID값을 ?안에 넣어줌 1번째 물음표
            pstmt.setString(10, creditScore);  //입력받은 ID값을 ?안에 넣어줌 1번째 물음표
            pstmt.setString(11, comfortabelScore);  //입력받은 ID값을 ?안에 넣어줌 1번째 물음표
            pstmt.setString(12, lectureScore);  //입력받은 ID값을 ?안에 넣어줌 1번째 물음표
            return pstmt.executeUpdate();    //데이터를 조회할때 사용 에시쿼트 쿼리
        }
%>
<%
    request.setCharacterEncoding("UTF-8");
    String userID=null;
    if(session.getAttribute("userID")!=null){ //유저가 로그인을 할 상태여서 userID값이 존재하낟면,
        userID=(String)session.getAttribute("userID");  //해당 새션 값을 넣어줌
    }
    /*if(userID==null){ //로그인을 하지 않은 상태라면
        PrintWriter script=response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 해주세요1.');");
        script.println("location.href='userLogin.jsp'");
        script.println("</script>");
        script.close();
    }*/
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

    int result=0;
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
        result = write(0, userID, lectureName, professorName, lectureYear, semesterDivide, lectureDivide
                , evaluationTitle, evaluationContent, totalScore, creditScore, comfortableScore, lectureScore,0);
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
