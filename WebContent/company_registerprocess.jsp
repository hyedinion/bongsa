<%@ page language="java" import="java.text.*, java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
    
<%
 request.setCharacterEncoding("UTF-8");
 String id = request.getParameter("id");
 String password = request.getParameter("password");
 String name = request.getParameter("name");

 String url = "jdbc:oracle:thin:@localhost:1521:oraknu";
 String user = "jmil";
 String pw = "jmil";
 Connection conn=null; //DB연결
 PreparedStatement pstmt=null; //SQL문
 ResultSet re = null; //해제
 
 try{
	 Class.forName("oracle.jdbc.driver.OracleDriver");
	 conn = DriverManager.getConnection(url, user, pw);
	    
    
    pstmt=conn.prepareStatement("Insert into company values(company_seq.nextval,?,?,?)");//커넥션풀 방식이다.
    pstmt.setString(1,id);
    pstmt.setString(2,password);
    pstmt.setString(3,name);
    System.out.println("---------------------result------------------");
    int result = pstmt.executeUpdate();
    
    if(result!=0){
       out.println("<script>");
       out.println("location.href='loginForm.jsp'");
       out.println("</script>");
    }else {
       out.println("<script>");
       out.println("location.href='joinForm.jsp'");
       out.println("</script>");
    }
 }catch(Exception e){
    e.printStackTrace();    
    }
 session.setAttribute("id", id); //세션으로 받아와야 한다.
 response.sendRedirect("company_main.jsp");
%>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

</body>
</html>