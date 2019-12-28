<%@ page language="java" import="java.text.*, java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
 
<!-- loginProcess는 입력된 정보를 DB와 연결해주는 창입니다. -->
		
<%
String id = request.getParameter("id");
System.out.println(id);

String pass =request.getParameter("pass");
System.out.println(pass);

   String url = "jdbc:oracle:thin:@localhost:1521:oraknu";
    String user = "jmil";
    String pw = "jmil";
    Connection conn = null;
	PreparedStatement pstmt =null;
	ResultSet rs = null;
   
    try {
       Class.forName("oracle.jdbc.driver.OracleDriver");
       System.out.println("드라이버 검색 성공!");
    } catch (ClassNotFoundException e) {
       System.err.println("error = " + e.getMessage());
       System.exit(1);
    }
    try {
       conn = DriverManager.getConnection(url, user, pw);
    } catch (SQLException e) {
       System.err.println("sql error conn = " + e.getMessage());
       System.exit(1);
    }
    
    try {
       pstmt=conn.prepareStatement("select * from company where id=?"); //prepareStatement는 Statement와 다르게 ?로 지정된 값을 필요 할 때 마다 이용할수있다.
       pstmt.setString(1,id);
       rs=pstmt.executeQuery();
       
       if(rs.next()){  
        if(pass.equals(rs.getString("password"))){ 
         session.setAttribute("id",id);
         out.println("<script>");
         out.println("location.href='company_main.jsp'"); //저장된 정보와 아이디와 비밀번호가 일치하면 main.jsp로 보낸다. main.jsp는 정보가 출력되는 창이다.
         out.println("</script>");
        }
       }
       out.println("<script>alert(\"다시 로그인 해주세요\")");
       out.println("location.href='choose.html'"); 
       out.println("</script>");
       
       rs.close();       
       
           
       conn.close(); 
      }catch(Exception e){
       e.printStackTrace();
      }
       
      
         
%>

</body>
</html>