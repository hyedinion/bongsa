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
    String pid = request.getParameter("pid");

    String url = "jdbc:oracle:thin:@localhost:1521:oraknu";
    String user = "jmil";
    String pw = "jmil";
    Connection conn=null; //DB연결
    PreparedStatement pstmt=null; //SQL문
    ResultSet re = null; //해제
    int p= Integer.parseInt(pid);
    int s=0;
    try{
   	 Class.forName("oracle.jdbc.driver.OracleDriver");
   	 conn = DriverManager.getConnection(url, user, pw);
   	    
   	 Statement stmt = conn.createStatement(); 
   	String query = "select sid from student where id = '"+id+"'";   
    ResultSet rs = stmt.executeQuery(query);   
    while (rs.next()) {
    	s=rs.getInt(1);
    }
   	 
   	 
       pstmt=conn.prepareStatement("Insert into reserve values(reserve_seq.nextval,?,?)");//커넥션풀 방식이다.
       pstmt.setInt(1,s);
       pstmt.setInt(2,p);
       System.out.println("---------------------result------------------");
       int result = pstmt.executeUpdate();
       
       if(result==0){
          out.println("<script>alert(\"예약실패!\")");
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