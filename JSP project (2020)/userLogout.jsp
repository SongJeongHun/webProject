<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    session.invalidate();   //모든 세션 정보를 파기
%>
<script>
    location.href='index.jsp';
</script>
