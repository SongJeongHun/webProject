<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %><%!
    public int login(String userID,String userPassword){
        String SQL="SELECT userPassword FROM evaluation_user WHERE userID=?";//사용자로부터 입력받은 아이디의 패스워드를 불러와서 ㄷ다룸
        Connection conn=null;
        PreparedStatement pstmt=null;
        ResultSet rs=null;//SQL에서 나온 값을 처리하기위한 클래스
        try{
            conn= getConnection(); //객체자체를 반환
            pstmt=conn.prepareStatement(SQL);   //컨객체의 SQL문장 준비
            pstmt.setString(1,userID);  //입력받은 ID값을 ?안에 넣어줌 1번째 물음표
            rs=pstmt.executeQuery();    //데이터를 조회할때 사용 에시쿼트 쿼리
            if(rs.next()){  //rs값이 존재하면
                if(rs.getString(1).equals(userPassword))  //비밀번호가 일치하면
                    return 1;//로그인 성공
                else
                    return  0; //비밀번호 틀림
            }
            return -1; //아이디 없음
        }catch (Exception e) {
            e.printStackTrace();
        }finally {
            try{if(conn!=null) conn.close();} catch (Exception e ){e.printStackTrace();}    //conn과 밑에 3개는 한번사용후에 닫아주는 것이 필요
            try{if(pstmt!=null) pstmt.close();} catch (Exception e ){e.printStackTrace();}
            try{if(rs!=null) rs.close();} catch (Exception e ){e.printStackTrace();}

        }
        return -2; //데이터베이스 오류
    }
    public int join(String userID,String userPassword,String userEmail){
        String SQL="INSERT INTO evaluation_user VALUES (?,?,?,0)";
        Connection conn=null;
        PreparedStatement pstmt=null;
        ResultSet rs=null;//SQL에서 나온 값을 처리하기위한 클래스
        try{
            conn= getConnection(); //객체자체를 반환
            pstmt=conn.prepareStatement(SQL);   //컨객체의 SQL문장 준비
            pstmt.setString(1,userID);  //입력받은 ID값을 ?안에 넣어줌 1번째 물음표
            pstmt.setString(2,userPassword);
            pstmt.setString(3,userEmail);
            return pstmt.executeUpdate();   //데이터 계수를 반환.성공시 1반환

        }catch (Exception e) {
            e.printStackTrace();
        }finally {
            try{if(conn!=null) conn.close();} catch (Exception e ){e.printStackTrace();}    //conn과 밑에 3개는 한번사용후에 닫아주는 것이 필요
            try{if(pstmt!=null) pstmt.close();} catch (Exception e ){e.printStackTrace();}
            try{if(rs!=null) rs.close();} catch (Exception e ){e.printStackTrace();}
        }
        return -1; //회원 가입 실패
    }
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

%>