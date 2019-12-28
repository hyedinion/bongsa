<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="assets/css/main.css" />
<title>bogsaweb</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

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
    request.setCharacterEncoding("EUC-KR");
    String pname = request.getParameter("query");
%>

<!-- Header -->
			<header id="header">
				<nav class="left">
					<a href="#menu"><span>Menu</span></a>
				</nav>
				<a href="company_main.jsp" class="logo">volunteer</a>
				<nav class="right">
				
					<a href="company_loginprocess.jsp" class="button special small">Log out</a>
				</nav>
			</header>

		<!-- Menu -->
			<nav id="menu">
				<ul class="links">
					<li><a href="company_main.jsp">Home</a></li>
					<li><a href="company_volunteer.jsp">volunteer</a></li>
					<li><a href="company_mypage.jsp">Mypage</a></li>
				</ul>
				<ul class="actions vertical">
					<li><a href="loginprocess.jsp" class="button fit">Login</a></li>
				</ul>
			</nav>


<div class="container" style="margin-top:10px" >

<form method="post" action="mypage.jsp">
	<div class="row uniform">
		<div class="9u 12u$(small)">
			<input type="text" name="query" placeholder="프로그램명 입력" />
		</div>
		<div class="3u$ 12u$(small)">
			<input type="submit" value="Search" class="button special" />
		</div>
	</div>
</form>




<!-- Table -->

<div class="table-wrapper">
	<table>
		<thead>
			<tr>
				<th>프로그램명</th>
				<th>신청마감</th>
				<th>신청가능명수</th>
				<th>신청현황</th>
				<th>기업명</th>
				<th>예약</th>
			</tr>
		</thead>
		<tbody>
		
		
		
<%
   String url = "jdbc:oracle:thin:@localhost:1521:oraknu";
    String user = "jmil";
    String pass = "jmil";
    int s_sid = 2;
    Connection conn = null;
    String sql = null;
    String query = null;
    int result;
    try {
       Class.forName("oracle.jdbc.driver.OracleDriver");
       System.out.println("드라이버 검색 성공!");
    } catch (ClassNotFoundException e) {
       System.err.println("error = " + e.getMessage());
       System.exit(1);
    }
    try {
       conn = DriverManager.getConnection(url, user, pass);
    } catch (SQLException e) {
       System.err.println("sql error conn = " + e.getMessage());
       System.exit(1);
    }
    
    try {
       conn.setAutoCommit(false);     
       Statement stmt = conn.createStatement(); 
       query = "select p.name , p.ddate,p.maxnum , count(r.rid), c.name from company c left outer join program p on(p.cid = c.cid) left outer join reserve r on(r.pid=p.pid) where c.id = '"+id+"' group by p.name,p.maxnum, p.ddate , c.name";
       ResultSet rs = stmt.executeQuery(query); 
    while (rs.next()) {   
    	String  name = rs.getString(1); 
    	if(name==null)break;
    	System.out.println(name);
    	System.out.println(pname);
    	if(pname!=null &&(!pname.equals(name)))continue;
		 Date ddate = rs.getDate(2);   
		 int maxnum = rs.getInt(3);
		 int count = rs.getInt(4);
		 String cname = rs.getString(5);
		 
		 System.out.println(" 프로그램명= "+ name + ",  신청마감= "+ ddate+ ",  신청가능명수= "+ maxnum+",  신청현황= "+ count+", 기업명 : "+cname);    
		 
		 Statement stmt2 = conn.createStatement(); 
		 String query2 = "select count(r.rid) from program p left outer join reserve r on(p.pid=r.pid) where p.name = '"+name+"'";   
		 ResultSet rs2 = stmt2.executeQuery(query2);
		 while(rs2.next()){
			 count = rs2.getInt(1);
		 }
		 
		 out.println("<tr>");
		 out.println("<td>"+name+"</td>");
		 out.println("<td>"+ddate+"</td>");
		 out.println("<td>"+maxnum+"</td>");
		 out.println("<td>"+count+"</td>");
		 out.println("<td>"+cname+"</td>");
		 out.println("<td>");
		 out.println("<form action = \"company_student.jsp\" method=\"post\"> ");
		 out.println("<input type=\"hidden\" name=\"pname\" value= \""+name+"\"/>");
		 out.println("<input class=\"button alt small\" type=\"submit\" value=\"학생보기\" />");
		 out.println("</form>");
		 out.println("</td>");
		 out.println("</tr>");
    }   
    rs.close();       
             
    
    conn.commit(); 
    conn.setAutoCommit(true);    
    stmt.close();      
    conn.close();      
    } catch(Exception e) {       
       System.err.println("sql error = " + e.getMessage());  
   }
%>
		
		
		
		
		
		</tbody>
		
	</table>
</div>

<!-- Scripts -->
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/jquery.scrolly.min.js"></script>
			<script src="assets/js/skel.min.js"></script>
			<script src="assets/js/util.js"></script>
			<script src="assets/js/main.js"></script>
</body>
</html>