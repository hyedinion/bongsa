<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="assets/css/main.css" />
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	
</head>
<body>
<%
    String id = null;
    if (session.getAttribute("id") != null) {
        id = (String) session.getAttribute("id");//로그인을 성공적으로 수행하면 메인창 입장.
    } else {
        out.println("<script>");
        out.println("location.href='choose.html'"); //로그인 실패시 다시 loginForm.jsp로 돌아간다.
        out.println("</script>");
    }
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

		


<div  class ="container">


<!-- Form -->
<h3 style="margin-top:20px;">Program Register</h3>

<form method="post" action="programregister.jsp">
	<div class="row uniform">
		<div class="12u$">
			<input type="text" name="pname" placeholder="프로그램 명" />
		</div>
		<div class="12u$">
			<input type="text" name="ddate" placeholder="마감일(yy/mm/dd)" />
		</div>
		
		<div class="6u 12u$(xsmall)">
			<input type="text" name="maxnum" placeholder="모집인원" />
		</div>
		
		<!-- Break -->
		<div class="12u$">
			<ul class="actions">
				<li><input class="button special" type="submit" value="Register" /></li>
				<li><input type="reset" value="Reset" class="alt" /></li>
			</ul>
		</div>
	</div>
</form>

<!-- Scripts -->
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/jquery.scrolly.min.js"></script>
			<script src="assets/js/skel.min.js"></script>
			<script src="assets/js/util.js"></script>
			<script src="assets/js/main.js"></script>

</body>
</html>