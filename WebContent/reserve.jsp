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
    
    
    request.setCharacterEncoding("UTF-8");
    String pid = request.getParameter("pid");

    String url = "jdbc:oracle:thin:@localhost:1521:oraknu";
    String user = "jmil";
    String pw = "jmil";
    Connection conn=null; //DB����
    PreparedStatement pstmt=null; //SQL��
    ResultSet re = null; //����
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
   	 
   	 
       pstmt=conn.prepareStatement("Insert into reserve values(reserve_seq.nextval,?,?)");//Ŀ�ؼ�Ǯ ����̴�.
       pstmt.setInt(1,s);
       pstmt.setInt(2,p);
       System.out.println("---------------------result------------------");
       int result = pstmt.executeUpdate();
       
       if(result==0){
          out.println("<script>alert(\"�������!\")");
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