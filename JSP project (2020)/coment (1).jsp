<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
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
    public ResultSet getComment(int evaluationID)throws SQLException {
        String SQL = "SELECT * FROM evaluation_evaluation WHERE evaluationID="+evaluationID;
        PreparedStatement pstmt = null;
        Connection conn = null;
        ResultSet rs = null;//SQL에서 나온 값을 처리하기위한 클래스
        conn = getConnection1(); //객체자체를 반환
        pstmt = conn.prepareStatement(SQL);   //컨객체의 SQL문장 준비
        rs = pstmt.executeQuery();
        return rs;
    }

%>
<%
    request.setCharacterEncoding("UTF-8");
    String userID = null;
    int evaluationID = Integer.parseInt(request.getParameter("evaluationID"));
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
    if (userID == null) { //로그인을 하지 않은 상태라면
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 해주세요1.');");
        script.println("location.href='userLogin.jsp'");
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
<nav class="navbar navbar-expand-lg navbar-light bg-dark">
    <a class="navbar-brand" href="index.jsp"> <span style="color:#FFFFFF;">강의평가</span></a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar"></button>
    <div id="navbar" class="collapse navbar-collapse">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="index.jsp"> <span style="color:#FFFFFF;">메인화면가기</span></a><%--Anchor(닻)문서내 이동 혹은 링크를 통해 다른 홈페이지로 이동--%>
            </li>
            <li class="nav-item dropdown"><%--dropdown 버튼인데 아래쪽에 목록이 보이는 버튼--%>
                <a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown"><%--토글(누르면 사리지고 생기는 것)--%>
                    <span style="color:#FFFFFF;">회원관리</span>
                </a>
                <div class="dropdown-menu" aria-labelledby="dropdown">
                    <%
                        if (userID == null) {
                    %>
                    <a class="dropdown-item" href="userLogin.jsp">로그인</a>
                    <a class="dropdown-item" href="userJoin.jsp">회원가입</a>
                    <%
                    } else {
                    %>
                    <a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
                    <%
                        }
                    %>
                </div>
            </li>
        </ul>
    </div>
</nav>
<section class="container">
    <%
        ResultSet evaluation=null;
        evaluation=getComment(evaluationID);
    %>

    게시판내용시작
    <div class="card bg-light mt-3">
        <div class="card-header">
            <div class="row">
                <div class="col-8 text-Left"><%=evaluation.getString("lectureName")%><small><%=evaluation.getString("professorName")%>
                </small></div>
                <div class="col-2 text-Right">조회수<span style="color:red;"></span></div>
                <div class="col-2 text-Right">작성자:<%=evaluation.getString("userID")%>
                </div>
            </div>
        </div>
        <div class="card-body">
            <h5 class="card-title"><%=evaluation.getString("evaluationTitle")%><small><%=evaluation.getString("semesterDivdie")%>
            </small>
            </h5>
            <p class="card-text"><%=evaluation.getString("evaluationContent")%>
            </p>
            <div class="row">
                <div class="col-9 text-Left">
                    종합<span style="color:red;"><%=evaluation.getString("totalScore")%></span>
                    성적<span style="color:red;"><%=evaluation.getString("lectureScore")%></span>
                    출석<span style="color:red;"><%=evaluation.getString("comfortableScore")%></span>
                    <span style="color:green;">추천(<%=evaluation.getString("likeCount")%>)</span>
                </div>
                <div class="col-3 text-Right">
                 <%--   <a onclick="return confirm('추천하시겠습니까?')" href="./LikeAction.jsp?evaluationID=">추천&nbsp;</a>--%>
                     <%
                         if(userID.equals(evaluation.getString("userID"))){
                     %>
                     <a onclick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?evaluationID=<%=evaluationID%>">삭제&nbsp;</a>
                     <a data-toggle="modal" href="#registerModal">수정하기</a>
                    <%
                         }
                    %>
                </div>
            </div>
        </div>
    </div>
    게시판내용끝





   <%-- 댓글 출력 시작
    <div class="card bg-light mt-3">
        <div class="card-header">
            <h5>댓글<small>(<%=num%>개)</small></h5>
        </div>
        <div class="card-body">
            <%
                for (int i = 0; i < commentlist.size(); i++) {
                    commentDTO = commentlist.get(i);
            %>
            <a class="form-control"><%=commentDTO.getCommentContent(i)%><small style="color:blue"
                                                                               class="text-right">(<%=commentDTO.getUserID()%>
                )</small></a>
            <%
                }
            %>
        </div>
    </div>--%>


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
                <h5 class="modal-title" id="modal">평가 등록</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="evaluationOverwriteAction.jsp?evaluationID=<%=evaluationID%>" method="post">
                    <div class="form-row">
                        <div class="form-group col-sm-6">
                            <label>강의명</label>
                            <input type="text" name="lectureName" class="form-control" maxlength="20">
                        </div>
                        <div class="form-group col-sm-6">
                            <label>교수명</label>
                            <input type="text" name="professorName" class="form-control" maxlength="20">.
                        </div>
                    </div>
                    <%--1열--%>
                    <div class="form-row">
                        <div class="form-group col-sm-4">
                            <label>수강년도</label>
                            <select name="lectureYear" class="form-control"> <%--row행 col열--%>
                                <option value="2011">2011</option>
                                <option value="2012">2012</option>
                                <option value="2013">2013</option>
                                <option value="2014">2014</option>
                                <option value="2015">2015</option>
                                <option value="2016">2016</option>
                                <option value="2017">2017</option>
                                <option value="2018">2018</option>
                                <option value="2019">2019</option>
                                <option value="2020" selected>2020</option>
                                <option value="2021">2021</option>
                                <option value="2022">2022</option>
                            </select>
                        </div>
                        <div class="form-group col-sm-4">
                            <label>수강학기</label>
                            <select name="semesterDivide" class="form-control">
                                <option value="1학기" selected>1학기</option>
                                <option value="2학기">2학기</option>
                            </select>
                        </div>
                        <div class="form-group col-sm-4"> <%--네모칸의 가로 크기 조절--%>
                            <label>강의구분</label>
                            <select name="lectureDivide" class="form-control">
                                <option value="전공" selected>전공</option>
                                <option value="교양">교양</option>
                                <option value="기타">기타</option>
                            </select>
                        </div>
                    </div>
                    <%--2열--%>
                    <div class="form-group">
                        <label>제목</label>
                        <input type="text" name="evaluationTitle" class="form-control" maxlength="30">
                    </div>
                    <%--3열--%>
                    <div class="form-group">
                        <label>내용</label>
                        <textarea name="evaluationContent" class="form-control" maxlength="2048"
                                  style="height: 180px;"></textarea>
                    </div>
                    <%--4열--%>
                    <div class="form-row">
                        <div class="form-group col-sm-3">
                            <label>종합</label>
                            <select name="totalScore" class="form-control">
                                <option value="A">A</option>
                                <option value="B">B</option>
                                <option value="C">C</option>
                                <option value="D">D</option>
                                <option value="E">E</option>
                                <option value="F">F</option>
                            </select>
                        </div>
                        <div class="form-group col-sm-3">
                            <label>성적</label>
                            <select name="creditScore" class="form-control">
                                <option value="A">A</option>
                                <option value="B">B</option>
                                <option value="C">C</option>
                                <option value="D">D</option>
                                <option value="E">E</option>
                                <option value="F">F</option>
                            </select>
                        </div>
                        <div class="form-group col-sm-3">
                            <label>출결</label>
                            <select name="comfortableScore" class="form-control">
                                <option value="A">A</option>
                                <option value="B">B</option>
                                <option value="C">C</option>
                                <option value="D">D</option>
                                <option value="E">E</option>
                                <option value="F">F</option>
                            </select>
                        </div>
                        <div class="form-group col-sm-3">
                            <label>강의</label>
                            <select name="lectureScore" class="form-control">
                                <option value="A">A</option>
                                <option value="B">B</option>
                                <option value="C">C</option>
                                <option value="D">D</option>
                                <option value="E">E</option>
                                <option value="F">F</option>
                            </select>
                        </div>
                    </div>
                    <%--5열--%>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                        <button type="submit" class="btn btn-primary">수정하기</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<footer class="bg mt-4 p-5 text-center"><span style="color:#808080;">
    Copyright &copy; 2020 Jeong Hun All Rights Reserved.
</span>
</footer>


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
