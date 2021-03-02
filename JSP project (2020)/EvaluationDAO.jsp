<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    public int write(int evaluationID, String userID, String lectureName, String professorName, int lectureYear, String semesterDivide, String lectureDivide, String evaluationTitle, String evaluationContent, String totalScore, String creditScore, String comfortabelScore, String lectureScore, int likeCount) {
        String SQL = "INSERT INTO evaluation_evaluation VALUES (NULL,?,?,?,? ,?,?,?,?,?,? ,?,?,0,0)";//사용자로부터 입력받은 아이디의 패스워드를 불러와서 ㄷ다룸
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = getConnection1(); //객체자체를 반환
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
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }    //conn과 밑에 3개는 한번사용후에 닫아주는 것이 필요
            try {
                if (pstmt != null) pstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return -1; //데이터베이스 오류
    }

    public ResultSet getList(String lectureDivide, String searchType, String search)throws SQLException {
        if (lectureDivide.equals("전체")) {
            lectureDivide = "";
        }
        String SQL = "";
        PreparedStatement pstmt = null;
        Connection conn = null;
        ResultSet rs = null;//SQL에서 나온 값을 처리하기위한 클래스
        try {
            if (searchType.equals("최신순")) {
                SQL = "SELECT * FROM evaluation_evaluation WHERE lectureDivide LIKE ? AND CONCAT(lectureName,professorName,evaluationTitle,evaluationContent,userID) LIKE ? ORDER BY evaluationID";
            } else if (searchType.equals("추천순")) {
                SQL = "SELECT * FROM evaluation_evaluation WHERE lectureDivide LIKE ? AND CONCAT(lectureName,professorName,evaluationTitle,evaluationContent,userID) LIKE ? ORDER BY likeCount";
            }
            conn = getConnection1(); //객체자체를 반환
            pstmt = conn.prepareStatement(SQL);   //컨객체의 SQL문장 준비
            pstmt.setString(1, "%" +lectureDivide + "%");
            pstmt.setString(2, "%" + search + "%");
            rs = pstmt.executeQuery();
            return rs;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }    //conn과 밑에 3개는 한번사용후에 닫아주는 것이 필요
            try {
                if (pstmt != null) pstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            try {
                if (rs != null) rs.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return null;
    }
    public ResultSet list(String lectureDivide, String searchType, String search) {
        if (lectureDivide.equals("전체")) {
            lectureDivide = "";
        }
        String SQL = "";
        PreparedStatement pstmt = null;
        Connection conn = null;
        ResultSet rs = null;//SQL에서 나온 값을 처리하기위한 클래스
        try {
            if (searchType.equals("최신순")) {
                SQL = "SELECT * FROM evaluation_evaluation WHERE lectureDivide LIKE ? AND CONCAT(lectureName,professorName,evaluationTitle,evaluationContent,userID) LIKE ? ORDER BY evaluationID";
            } else if (searchType.equals("추천순")) {
                SQL = "SELECT * FROM evaluation_evaluation WHERE lectureDivide LIKE ? AND CONCAT(lectureName, professorName, evaluationTitle,evaluationContent,userID) LIKE ? ORDER BY likeCount";
            }
            conn = getConnection1(); //객체자체를 반환
            pstmt = conn.prepareStatement(SQL);   //컨객체의 SQL문장 준비
            pstmt.setString(1, "%" + lectureDivide + "%");
            pstmt.setString(2, "%" + search + "%");
            rs = pstmt.executeQuery();
            return rs;

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }    //conn과 밑에 3개는 한번사용후에 닫아주는 것이 필요
            try {
                if (pstmt != null) pstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            try {
                if (rs != null) rs.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    public ResultSet getComment(int evaluationID) {
        String SQL = "SELECT * FROM evaluation_evaluation WHERE evaluationID="+evaluationID;
        PreparedStatement pstmt = null;
        Connection conn = null;
        ResultSet rs = null;//SQL에서 나온 값을 처리하기위한 클래스
        try {
            conn = getConnection1(); //객체자체를 반환
            pstmt = conn.prepareStatement(SQL);   //컨객체의 SQL문장 준비
            rs = pstmt.executeQuery();
            return rs;

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }    //conn과 밑에 3개는 한번사용후에 닫아주는 것이 필요
            try {
                if (pstmt != null) pstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            try {
                if (rs != null) rs.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    public int overwrite(int evaluationID, String userID, String lectureName, String professorName, int lectureYear, String semesterDivide, String lectureDivide, String evaluationTitle, String evaluationContent, String totalScore, String creditScore, String comfortabelScore, String lectureScore, int likeCount) {
        String SQL1 = "UPDATE evaluation_evaluation SET lectureName=?, professorName=?, lectureYear=?, semesterDivide=?, lectureDivide=?, evaluationTitle=?, evaluationContent=?, totalScore=?, creditScore=?, comfortableScore=?, lectureScore=? WHERE evaluationID=?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        int result = 0;
        try {
            conn = getConnection1();
            pstmt = conn.prepareStatement(SQL1);
            pstmt.setString(1, lectureName);  //입력받은 ID값을 ?안에 넣어줌 1번째 물음표
            pstmt.setString(2, professorName);  //입력받은 ID값을 ?안에 넣어줌 1번째 물음표
            pstmt.setInt(3, lectureYear);  //입력받은 ID값을 ?안에 넣어줌 1번째 물음표
            pstmt.setString(4, semesterDivide);  //입력받은 ID값을 ?안에 넣어줌 1번째 물음표
            pstmt.setString(5, lectureDivide);  //입력받은 ID값을 ?안에 넣어줌 1번째 물음표
            pstmt.setString(6, evaluationTitle);  //입력받은 ID값을 ?안에 넣어줌 1번째 물음표
            pstmt.setString(7, evaluationContent);  //입력받은 ID값을 ?안에 넣어줌 1번째 물음표
            pstmt.setString(8, totalScore);  //입력받은 ID값을 ?안에 넣어줌 1번째 물음표
            pstmt.setString(9, creditScore);  //입력받은 ID값을 ?안에 넣어줌 1번째 물음표
            pstmt.setString(10, comfortabelScore);  //입력받은 ID값을 ?안에 넣어줌 1번째 물음표
            pstmt.setString(11, lectureScore);  //입력받은 ID값을 ?안에 넣어줌 1번째 물음표
            pstmt.setInt(12, evaluationID);
            result = pstmt.executeUpdate();
            return result;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }    //conn과 밑에 3개는 한번사용후에 닫아주는 것이 필요
            try {
                if (pstmt != null) pstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return -1;
    }


%>
