<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<title>Intensify by TEMPLATED</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<link rel="stylesheet" href="assets/css/main.css" />
	
</head>
<body>

<%
    String id = null;
    if (session.getAttribute("id") != null) {
        id = (String) session.getAttribute("id");//로그인을 성공적으로 수행하면 메인창 입장.
    } else {
        out.println("<script>");
        out.println("location.href='company_login.html'"); //로그인 실패시 다시 loginForm.jsp로 돌아간다.
        out.println("</script>");
    }
%>

<!-- Header -->
			<header id="header">
				<nav class="left">
					<a href="#menu"><span>Menu</span></a>
				</nav>
				<a href="#" class="logo">volunteer</a>
				<p><%out.print(id); %></p>
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

		
			
			
			<!-- Banner -->
			<section id="banner">
				<div class="inner">
					<header>
						<h1>Company Volunteer Management</h1><br>
					</header>

					<div style="display:flex;justify-content:center;">

						<div style="margin:50px">
						<a href="company_volunteer.jsp" class="button alt small" onmouseout="this.className='button alt small'" onmouseover="this.className='button special small'">
							<span class="icon fa-car" style="font-size=50px;"></span>
							<h3>volunteer</h3>
							</a>
						</div>

						
						<div style="margin:50px">
						<a href="company_mypage.jsp" class="button alt small"  onmouseout="this.className='button alt small'" onmouseover="this.className='button special small'">
							<span class="icon fa-bug"></span>
							<h3>Mypage</h3>
						</a>
						</div>

					</div>

				</div>
			</section>


		<!-- Scripts -->
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/jquery.scrolly.min.js"></script>
			<script src="assets/js/skel.min.js"></script>
			<script src="assets/js/util.js"></script>
			<script src="assets/js/main.js"></script>

</body>
</html>