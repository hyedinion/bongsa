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
 
<!-- loginProcess�� �Էµ� ������ DB�� �������ִ� â�Դϴ�. -->
		
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
       System.out.println("����̹� �˻� ����!");
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
       pstmt=conn.prepareStatement("select * from company where id=?"); //prepareStatement�� Statement�� �ٸ��� ?�� ������ ���� �ʿ� �� �� ���� �̿��Ҽ��ִ�.
       pstmt.setString(1,id);
       rs=pstmt.executeQuery();
       
       if(rs.next()){  
        if(pass.equals(rs.getString("password"))){ 
         session.setAttribute("id",id);
         out.println("<script>");
         out.println("location.href='company_main.jsp'"); //����� ������ ���̵�� ��й�ȣ�� ��ġ�ϸ� main.jsp�� ������. main.jsp�� ������ ��µǴ� â�̴�.
         out.println("</script>");
        }
       }
       out.println("<script>alert(\"�ٽ� �α��� ���ּ���\")");
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