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
 Connection conn=null; //DB����
 PreparedStatement pstmt=null; //SQL��
 ResultSet re = null; //����
 
 try{
	 Class.forName("oracle.jdbc.driver.OracleDriver");
	 conn = DriverManager.getConnection(url, user, pw);
	    
    
    pstmt=conn.prepareStatement("Insert into company values(company_seq.nextval,?,?,?)");//Ŀ�ؼ�Ǯ ����̴�.
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
 session.setAttribute("id", id); //�������� �޾ƿ;� �Ѵ�.
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