<%@ page language="java" import="java.text.*, java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
    String id = null;
    if (session.getAttribute("id") != null) {
        id = (String) session.getAttribute("id");//로그인을 성공적으로 수행하면 메인창 입장.
    } else {
        out.println("<script>");
        out.println("location.href='login.html'"); //로그인 실패시 다시 loginForm.jsp로 돌아간다.
        out.println("</script>");
    }
    
    
    request.setCharacterEncoding("UTF-8");
    String rid = request.getParameter("rid");

    String url = "jdbc:oracle:thin:@localhost:1521:oraknu";
    String user = "jmil";
    String pw = "jmil";
    Connection conn=null; //DB연결
    PreparedStatement pstmt=null; //SQL문
    ResultSet re = null; //해제
    int r= Integer.parseInt(rid);
    
    try{
   	 Class.forName("oracle.jdbc.driver.OracleDriver");
   	 conn = DriverManager.getConnection(url, user, pw);
   	 
   	Statement stmt = conn.createStatement(); 
    String query = "delete from reserve where rid = "+r;   
    int rs = stmt.executeUpdate(query); 
    System.out.println("---------------------result------------------");
    
    if(rs==0){
          out.println("<script>alert(\"취소실패!\")");
          out.println("location.href='index.jsp'");
          out.println("</script>");
       }else {
          out.println("<script>");
          out.println("location.href='mypage.jsp'");
          out.println("</script>");
       }
    }catch(Exception e){
       e.printStackTrace();    
       }
    response.sendRedirect("index.jsp");
%>

</body>
</html>