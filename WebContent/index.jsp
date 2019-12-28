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
    Date deadline_date = null;
    if (session.getAttribute("id") != null) {
        id = (String) session.getAttribute("id");//로그인을 성공적으로 수행하면 메인창 입장.
    } else {
        out.println("<script>");
        out.println("location.href='login.html'"); //로그인 실패시 다시 loginForm.jsp로 돌아간다.
        out.println("</script>");
    }
    request.setCharacterEncoding("EUC-KR");
    String pname = request.getParameter("query1");
    String deadline = request.getParameter("query2");
    String company = request.getParameter("query3");
    if(pname!=null&&pname.equals("")) pname=null;
    if(deadline!=null&&deadline.equals("")) deadline=null;
    if(company!=null&&company.equals("")) company=null;
    
    if(deadline!=null) {
       deadline_date = Date.valueOf(deadline);
    }
%>

<!-- Header -->
         <header id="header">
            <nav class="left">
               <a href="#menu"><span>Menu</span></a>
            </nav>
            <a href="Main_login.jsp" class="logo">volunteer</a>
            <nav class="right">
               <a href="loginprocess.jsp" class="button small">Log out</a>
            </nav>
         </header>

      <!-- Menu -->
         <nav id="menu">
            <ul class="links">
               <li><a href="Main_login.jsp">Home</a></li>
               <li><a href="index.jsp">예약</a></li>
               <li><a href="mypage.jsp">Mypage</a></li>
            </ul>
            <ul class="actions vertical">
               <li><a href="loginprocess.jsp" class="button small">Logout</a></li>
            </ul>
         </nav>


<div class="container" style="margin-top:10px" >

   <form method="post" action="index.jsp" class="form-inline">
      <div class="form-group" style="margin:10px" width=20%>
         <label for="exampleInputEmail3">프로그램명</label>
         <input type="text" name="query1" placeholder="프로그램명" />
      </div>
      <div class="form-group" style="margin:10px" width=20%>
         <label for="exampleInputEmail3">신청마감</label>
         <input type="text" name="query2" placeholder="YYYY-MM-DD" />
      </div>
      <div class="form-group" style="margin:10px" width=20%>
         <label for="exampleInputEmail3">기업명</label>
         <input type="text" name="query3" placeholder="기업명" />
      </div>
      
      <div class="form-group" align="right" style="margin:20px; margin-top:40px" width=20%>
         <label for="exampleInputEmail3"></label>
         <input type="submit" value="Search" class="button alt" />
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
    Connection conn = null;
    String sql = null;
    String query = null;
    int check=0;
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
    query = "select p.name , p.ddate,p.maxnum , count(r.rid), c.name, p.pid from program p left outer join company c on(p.cid =c.cid) left outer join reserve r on(p.pid = r.pid) where p.ddate > SYSDATE group by p.name,p.maxnum, p.ddate , c.name,p.pid order by p.pid";   
    ResultSet rs = stmt.executeQuery(query);
    
    while (rs.next()) {   
       check=0;
       String  name = rs.getString(1); 
      Date ddate = rs.getDate(2); 
      int maxnum = rs.getInt(3);
      int count = rs.getInt(4);
      String cname = rs.getString(5);
      int pid = rs.getInt(6);
      if(pname!=null &&(!name.contains(pname)))continue;
      if (deadline != null && deadline_date.compareTo(ddate)>0) continue;
       if(company!=null &&(!company.equals(cname)))continue;
      System.out.println(" 프로그램명= "+ name + ",  신청마감= "+ ddate+ ",  신청가능명수= "+ maxnum+",  신청현황= "+ count+", 기업명 : "+cname);    
       
       out.println("<tr>");
       out.println("<td>"+name+"</td>");
       out.println("<td>"+ddate+"</td>");
       out.println("<td>"+maxnum+"</td>");
       out.println("<td>"+count+"</td>");
       out.println("<td>"+cname+"</td>");
       
       Statement stmt2 = conn.createStatement(); 
       String query2 = "select r.rid from reserve r left outer join student s on(r.sid=s.sid) where r.pid = '"+pid+"'"+" and s.id = '"+id+"'";   
       ResultSet rs2 = stmt2.executeQuery(query2);
       
       while(rs2.next()){
          int rid = rs2.getInt(1);
          System.out.println(rid);
          out.println("<td>");
          out.println("<form action = \"cancle.jsp\" method=\"post\"> ");
          out.println("<input type=\"hidden\" name=\"rid\" value= \""+rid+"\"/>");
          out.println("<input class=\"button small\" type=\"submit\" value=\"예약취소\" />");
          out.println("</form>");
          out.println("</td>");
          out.println("</tr>");
          check=1;
       }
       if(check==0){
          out.println("<td>");
          out.println("<form action = \"reserve.jsp\" method=\"post\"> ");
          out.println("<input type=\"hidden\" name=\"pid\" value= \""+pid+"\"/>");
          if (count < maxnum)
             out.println("<input class=\"button alt small\" type=\"submit\" value=\"예약\" />");
          else
             out.println("<input class=\"button alt small\" type=\"submit\" value=\"예약불가\" disabled=\"disabled\" />");
          out.println("</form>");
          out.println("</td>");
          out.println("</tr>");
       }
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