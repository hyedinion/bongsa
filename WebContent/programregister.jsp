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
        id = (String) session.getAttribute("id");//�α����� ���������� �����ϸ� ����â ����.
    } else {
        out.println("<script>");
        out.println("location.href='login.html'"); //�α��� ���н� �ٽ� loginForm.jsp�� ���ư���.
        out.println("</script>");
    }
    request.setCharacterEncoding("EUC-KR");
    String pname = request.getParameter("pname");
    String ddate = request.getParameter("ddate");
    String maxnum = request.getParameter("maxnum");
    System.out.println(pname+ddate+maxnum);
    
    String url = "jdbc:oracle:thin:@localhost:1521:oraknu";
    String user = "jmil";
    String pw = "jmil";
    Connection conn=null; //DB����
    PreparedStatement pstmt=null; //SQL��
    ResultSet re = null; //����
    
    try{
   	 Class.forName("oracle.jdbc.driver.OracleDriver");
   	 conn = DriverManager.getConnection(url, user, pw);
   	        
    Statement stmt = conn.createStatement(); 
 	String query = "insert into program values(program_seq.NEXTVAL,'"+pname+"', '"+ddate+"' ,"+maxnum+" , (select cid from company where id='"+id+"'))";   
 	int cnt = stmt.executeUpdate(query); 
 	
       
       
       
       
       
 	System.out.println(cnt);
       System.out.println("---------------------result------------------");
       
       
       if(cnt!=0){
          out.println("<script>alert('����')");
          out.println("location.href='company_volunteer.jsp'");
          out.println("</script>");
       }else {
          out.println("<script>");
          out.println("location.href='company_volunteer.jsp'");
          out.println("</script>");
       }
    }catch(Exception e){
       e.printStackTrace();    
       }
    response.sendRedirect("company_mypage.jsp");
    
    
    
    
    
%>
</body>
</html>