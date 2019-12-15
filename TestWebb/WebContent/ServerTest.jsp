
<%@page import="org.codehaus.jettison.json.JSONObject"%>
<%@page import="javax.json.JsonObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*,java.util.HashMap,java.util.Map" %>
<%@ page language="java" import = "javax.json.Json,javax.json.JsonArrayBuilder, javax.json.JsonBuilderFactory,javax.json.JsonObjectBuilder,javax.servlet.ServletException, javax.servlet.http.HttpServletRequest,javax.servlet.http.HttpServletResponse" %>
<%@ page language="java" import = "javax.json.JsonArray"%>

<%
	//값을 받는 부분.
	//post 방식으로 받는다.
	//request.setCharacterEncoding("UTF-8");
	//String aa = (String) request.getParameter("aa");
	//String bb = (String) request.getParameter("bb");
	//out.println("파라미터 확인"+aa+bb+'\n');
%>
	
<%
	
	
  /*	JSONObject jsonObject = new JSONObject();
	
	JSONObject personInfo = new JSONObject();
	JSONObject personInfo1 = new JSONObject();
	// json 만들기
    personInfo.put("name", "송강호");
    personInfo.put("age", "25");
    personInfo.put("gender", "남자");
    personInfo.put("nickname", "남궁민수");
   
    //배열에 추가
    personArray.put(personInfo);
   
    personInfo1.put("name", "강준혁");
    personInfo1.put("age", "27");
    personInfo1.put("gender", "여자");
    personInfo1.put("nickname", "궁민수");
    
    //배열에 추가
    personArray.put(personInfo1);
   
    //send
   
    System.out.print(personArray.toString());
    out.print(personArray.toString());
    */
    JSONArray array = new JSONArray();
   
    String url = "jdbc:oracle:thin:@localhost:1521:oraknu";
    String user = "kdhong";
    String pass = "kdhong";
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
       
        
    query = "select * from program";   
    ResultSet rs = stmt.executeQuery(query); 
    while (rs.next()) {   
       
       JSONObject object = new JSONObject();
       
       int pid = rs.getInt(1);
       String name = rs.getString(2);
       Date date = rs.getDate(3);
       int maxnum = rs.getInt(4);
       int cid = rs.getInt(5);
       
       object.put("pid", pid);
       object.put("name", name);
       object.put("date", date);
       object.put("maxnum", maxnum);
       object.put("cid", cid);
       
       array.add(object);
       
      
        System.out.println(pid+name+date+maxnum+cid);
        //out.println(pid+name+date+maxnum+cid);
       
    }     
    System.out.println(array.toString());
    out.println(array.toString());
    
   // out.println("</table>");
    rs.close();       
             
    
    conn.commit(); 
    conn.setAutoCommit(true);    
    stmt.close();      
    conn.close();    
    
    
    
    
    
    } catch(Exception e) {       
       System.err.println("sql error = " + e.getMessage());  
   }
%>
