<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="User.UserInfo"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<title>新西兰奇异淘 导航栏</title>
		<meta name="viewport" content="width=480,maximum-scale=1.2,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">

		<link rel="stylesheet" href="./css/mui.min.css">
	</head>

	<body>
		<header class="mui-bar mui-bar-nav">
		<h1 class="mui-title">
			欢迎光临 <b><font color="#FFA858">新西兰奇异淘</font></b>
		</h1>
		
	</header>
		<div class="mui-content">
			<ul id="list" class="mui-table-view mui-table-view-chevron">
				<li class="mui-table-view-cell">
					<a class="mui-navigate-right mui-text-center mui-h3" href="costnoimg.htm">
						  <font color=717171>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;代理查价-文字版</font>
					</a>
				</li>
				<li class="mui-table-view-cell">
					<a class="mui-navigate-right mui-text-center mui-h3" href="cost.htm">
						  <font color="717171"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;代理查价-图文版</font>
					</a>
				</li>
				<li class="mui-table-view-cell">
					<a class="mui-navigate-right mui-text-center mui-h3" href="indexnoimg.htm">
						   <b><font color="d6b243">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;产品列表-文字版</font></b>
					</a>
				</li>
				<li class="mui-table-view-cell">
					<a class="mui-navigate-right mui-text-center mui-h3" href="index.htm">
						   <b><font color="a13f34">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;产品列表-图文版</font></b>
					</a>
				</li>
			</ul>
		</div>
	</body>

</html>