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
    public ResultSet getComment(int evaluationID) throws SQLException {
        String SQL = "SELECT * FROM evaluation_evaluation WHERE evaluationID=" + evaluationID;
        PreparedStatement pstmt = null;
        Connection conn = null;
        ResultSet rs = null;//SQL에서 나온 값을 처리하기위한 클래스
        conn = getConnection1(); //객체자체를 반환
        pstmt = conn.prepareStatement(SQL);   //컨객체의 SQL문장 준비
        rs = pstmt.executeQuery();
        return rs;
    }
    public ResultSet getCommentlist(int evalutionID)throws SQLException {
        String SQL = "SELECT * FROM evaluation_comment WHERE evaluationID= " + evalutionID;
        PreparedStatement pstmt = null;
        Connection conn = null;
        ResultSet rs = null;
        conn = getConnection1();
        pstmt = conn.prepareStatement(SQL);
        rs = pstmt.executeQuery();
        return rs;
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
    public int addviewCount(int evaluationID) throws  SQLException{
        String SQL="UPDATE evaluation_evaluation SET viewCount=viewCount+1 where evaluationID="+evaluationID;
        PreparedStatement pstmt = null;
        Connection conn = null;
        ResultSet rs = null;
        conn = getConnection1();
        pstmt = conn.prepareStatement(SQL);
        return pstmt.executeUpdate();

    }

%>
<%

    request.setCharacterEncoding("UTF-8");
    String userID = null;
    int evaluationID = Integer.parseInt(request.getParameter("evaluationID"));
    addviewCount(evaluationID);
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
    if (userID == null) { //로그인을 하지 않은 상태라면
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 해주세요1.');");
        script.println("location.href='index.jsp'");
        script.println("</script>");
        script.close();
    }
%>
<!DOCTYPE html>

<html>
<head>
    <meta http-equiv="Content-Type" content="text-html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>기말 프로젝트</title>
    <%--부트스트랩 CSS추가--%>
    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <%--부트스트랩 CSS추가--%>
    <link rel="stylesheet" href="./css/custom.min.css">
</head>
<body>

<section class="container">
    <%
        ResultSet evaluation = null;
        evaluation = getComment(evaluationID);
        if (evaluation.next()) {
    %>
    <div class="card bg-light mt-3">
        <div class="card-header">
            <div class="row">
                <h5 class="col-8 text-Left"><%=evaluation.getString("lectureName")%></h5>
                <div class="col-2 text-Right">조회수<span style="color:red;"><%=evaluation.getInt("viewCount")%></span></div>
                <div class="col-2 text-Right">작성자:<%=evaluation.getString("userID")%>
                </div>
            </div>
        </div>
        <div class="card-body">
            <p class="card-text"><%=evaluation.getString("evaluationContent")%>
            </p>
            <div class="row">
                <div class="col-9 text-Left">
                    <span style="color:green;">추천(<%=evaluation.getString("likeCount")%>)</span>
                </div>
                <div class="col-3 text-Right">
                       <a onclick="return confirm('추천하시겠습니까?')" href="./LikeAction.jsp?evaluationID=<%=evaluationID%>">추천&nbsp;</a>
                    <%
                        if (userID.equals(evaluation.getString("userID"))) {
                    %>
                    <a onclick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?evaluationID=<%=evaluationID%>">삭제&nbsp;</a>
                    <a data-toggle="modal" href="#registerModal">수정하기</a>
                    <%
                            }
                        }
                    %>
                </div>
            </div>
        </div>
    </div>

     <div class="card bg-light mt-3">
         <div class="card-header">
             <h5>댓글<small></small></h5>
         </div>
         <div class="card-body">
             <%
                 ResultSet comment=null;
                 comment=getCommentlist(evaluationID);
                 while(comment.next()){
             %>
             <a class="form-control"><%=comment.getString("commentContent")%><small style="color:blue"
                                                                                class="text-right">(<%=comment.getString("userID")%>
                 )</small></a>
             <%
                 }
             %>
         </div>
     </div>


    <%-- 댓글 입력 시작--%>
    <div class="card bg-light mt-3">
        <form method="get" action="./commentAction.jsp">
            <div class="card-body">
                <label>댓글달기</label>
                <textarea name="comment" class="form-control col-12" maxlength="50"
                          style="height: 70px;"></textarea>
                <input type="hidden" name="evaluationID" value="<%=evaluationID%>">
                <input type="hidden" name="userID" value="<%=userID%>">
                <button class="btn btn-primary form-control col-12" type="submit">입력</button>
            </div>
        </form>
    </div>
    <%--댓글출력--%>
</section>
<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modal">게시글 작성</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="evaluationRegisterAction.jsp" method="post">
                    <div class="form-group">
                        <label>제목</label>
                        <input type="text" name="lectureName" class="form-control" maxlength="40">
                    </div>
                    <%--3열--%>
                    <div class="form-group">
                        <label>내용</label>
                        <textarea name="evaluationContent" class="form-control" maxlength="2048"
                                  style="height: 180px;"></textarea>
                    </div>
                    <%--5열--%>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                        <button type="submit" class="btn btn-primary">등록하기</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%--jQuery 자바스크립트 추가--%>
<script src="./js/jquery-3.4.1.min.js"></script>
<%--파퍼 자바스크립트 추가--%>
<script src="./js/popper.js"></script>
<%--부트스트랩 자바스크립트 추가--%>
<script src="./js/bootstrap.min.js"></script>
</body>
</html>
</body>
</html>
