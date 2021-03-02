<%@ page import="java.sql.*" %>
<%@ page import="java.net.InetAddress" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%
    InetAddress Address = InetAddress.getLocalHost();
    String ip=Address.getHostAddress();
    request.setCharacterEncoding("UTF-8");
    String lectureDivide = "";
    String searchType = "";
    String search = "";

    if (request.getParameter("lectureDivide") != null)
        lectureDivide = request.getParameter("lectureDivide");
    else
        lectureDivide = "전체";

    if (request.getParameter("searchType") != null)
        searchType = request.getParameter("searchType");
    else
        searchType = "new";

    if (request.getParameter("search") != null)
        search = request.getParameter("search");
    else
        search = "";

    String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text-html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>기말 프로젝트</title>
    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/custom.min.css">
</head>
<body>
<div class="row bg">
    <%--컨테이너 1--%>
    <section class="container col-2 p-5">
        <%
            if (userID != null) {
        %>
        <div class="dropdown">
            <button class="btn" id="dropdownButton" type="button" data-toggle="dropdown"
                    aria-expanded="false"><span style="color:#808080;"> <%=userID%>님! 안녕하세요</span>
            </button>
            <form method="get" action="index.jsp">
                <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownButton">
                    <button class="dropdown-item" name="search" value="<%=userID%>">내가 쓴 글 보기</button>
                    <div class="dropdown-item"><%=ip%></div>
                    <a class="dropdown-item" href="./userLogout.jsp">로그아웃</a>
                </ul>
            </form>
        </div>
        <%
        } else {
        %>
        <form method="post" action="./loginAction.jsp">
            <div class="form-group">
                <label>아이디</label>
                <input type="text" name="userID" class="form-control">
            </div>
            <div class="form-group">
                <label>비밀번호</label>
                <input type="password" name="userPassword" class="form-control">
            </div>
            <button type="submit" class="btn btn-primary">로그인</button>
            <a class="btn btn-primary" href="userJoin.jsp">가입</a>
        </form>
        <%
            }
        %>
    </section>
    <%--컨테이너 2--%>
    <section class="container col-10 pr-5">
        <form method="get" action="index.jsp" class="form-inline mt-3">
            <select name="searchType" class="form-control mx-1 mt-2">
                <option value="like" <%if (searchType.equals("like")) out.println("selected");%>>like</option>
                <option value="new" <%if (searchType.equals("new")) out.println("selected");%>>new</option>
            </select>
            <input type="text" name="search" class="form-control mx-1 mt-2" placeholder="내용을 입력하세요.">
            <button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
            <a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#registerModal">등록하기</a>
        </form>
        <%
            ResultSet evaluationList = null;
            evaluationList = test(searchType);

        %>
        <div class="card bg-light mt-3">
            <div class="card-header">
                <h5>게시글<%=lectureDivide+search+search%></h5>
            </div>
            <div class="card-body">
                <label>제목</label>
                <%
                    if (evaluationList != null) {
                        while (evaluationList.next()) {
                %>
                <a class="form-control mt-2 text-left"
                   href="./coment.jsp?evaluationID=<%=evaluationList.getInt("evaluationID")%>"><%=evaluationList.getString("evaluationTitle")%><small
                        style="color:blue">&nbsp;작성자:(<%=evaluationList.getString("userID")%>)</small>
                </a>
                <%
                        }
                    }
                %>
            </div>
        </div>
    </section>
</div>
<%--모달창 강의평가등록--%>
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
<%--모달끝--%>


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
    public ResultSet test(String searchType) throws SQLException {

        ResultSet rs=null;
        String SQL="SELECT * FROM evaluation_evaluation WHERE lectureDivide LIKE ? AND CONCAT(lectureName,professorName,evaluationTitle,evaluationContent,userID) LIKE ? ORDER BY evaluationID";
        if (searchType.equals("new")) {
           SQL = "SELECT * FROM evaluation_evaluation WHERE lectureDivide LIKE ? AND CONCAT(lectureName,professorName,evaluationTitle,evaluationContent,userID) LIKE ? ORDER BY evaluationID";
        } else if (searchType.equals("like")) {
            SQL = "SELECT * FROM evaluation_evaluation WHERE lectureDivide LIKE ? AND CONCAT(lectureName,professorName,evaluationTitle,evaluationContent,userID) LIKE ? ORDER BY likeCount";
        }
        PreparedStatement pstmt = null;
        Connection conn = null;
        conn = getConnection1();
        pstmt = conn.prepareStatement(SQL);
        pstmt.setString(1, "%" + "" + "%");
        pstmt.setString(2, "%" + "" + "%");
        rs = pstmt.executeQuery();

        return rs;
    }

%>
