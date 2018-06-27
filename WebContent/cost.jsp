<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="ReadExcel.ReadExcel"%>
<%@ page import="java.util.*"%>
<%@ page import="Public.Logging"%>

<%
	Logging log = new Logging(request, "代理查价页-图文版");
	String rootPath = "https://github.com/ShawnXia/KiwiListImg/raw/master/";
	new Thread(log).start();
	
	Cookie cookie = null; 
	String username = null;
    for (Cookie c : request.getCookies()) {
       if (c.getName().equals("name")){
                cookie = c;
                username = c.getValue();
                response.addCookie(cookie);
           }
       }
    
             
	//未登录则跳转回登录页面
	if (username == null||username.equals("")) {
		StringBuffer url = request.getRequestURL();
		if (request.getQueryString() != null) {
			url.append('?');
			url.append(request.getQueryString());
		}
		response.addCookie(new Cookie("url", url.toString()));
		response.sendRedirect("login.htm");
	} else {
		System.out.println("代理登录 ： "+username);
	}

	String excelPath = new java.io.File(application.getRealPath("index.htm")).getParent() + "/main.xls";
	ReadExcel re = new ReadExcel(excelPath);
	HashMap<String, Integer> titleMap = re.getTitleMap(0);
	HashMap<String, ArrayList<HashMap<String, String>>> listMap = re.getDetailMap("Cost", 2, titleMap);
	Set<String> categorySet = new HashSet<String>(listMap.keySet());

	HashMap<String, String> htmlWithCategory = new HashMap<String, String>();

	//主表头，包括搜索栏
	String htmlHead = "<div class='ui container'><div class='column'><div class='ui input focus'><input type='text' placeholder='请输入您想查找的产品名称或介绍...'></div></div>";

	//遍历所有类别
	Iterator<String> categoryIt = categorySet.iterator();
	while (categoryIt.hasNext()) {
		String category = categoryIt.next();

		String categoryHead = "<div class='mui-list-title'>" + category + "</div>";
		String htmlContent = "<ul class='mui-table-view'>";

		Iterator<HashMap<String, String>> productIt = listMap.get(category).iterator();
		while (productIt.hasNext()) {
			HashMap<String, String> productMap = productIt.next();

			String backgroundColor = null;
			String tagImg = null;

			if (productMap.get("备注").contains("热门")) {
				backgroundColor = "mui-onSale-media";
				tagImg = "onSale.png";
			} else if (productMap.get("备注").contains("缺货")) {
				backgroundColor = "mui-outOfStock-media";
				tagImg = "outOfStock.png";
			} else if (productMap.get("备注").contains("超值")) {
				backgroundColor = "mui-discount-media";
				tagImg = "hotPrice.png";
			} else {
				backgroundColor = "mui-normal-media";
				tagImg = "noTag.png";
			}

			htmlContent += "<li class='mui-table-view-cell " + backgroundColor + "'>";
			htmlContent += "<a href='javascript:;'><img class='mui-media-object mui-pull-left'"
					+ "src='"+rootPath +"img/product/" + productMap.get("商品图片") + ".png'><div class='mui-media-body'>"
					+ "<p class=\'mui-text-title\'>" + productMap.get("品牌") + productMap.get("名称")
					+ productMap.get("子分类") + "</p></div>";

			

			htmlContent += "<p class=\'mui-text-remark\'>规格:" + productMap.get("规格") + "</p>";
			
			if (tagImg != null) {
				htmlContent += "<img class='mui-media-tag mui-pull-right'src='" + rootPath + "img/" + tagImg + "'>";
			} 
			htmlContent += "<p class=\'mui-text-red\'>" + "<font color='#23b579'>产品成本价：$"
					+ productMap.get("产品成本价") + "&nbsp;&nbsp;&nbsp;含邮成本价：¥" + productMap.get("实际成本（包邮）")
					+ "</font></p>";
			htmlContent += "<p class=\'mui-text-red\'>" + "<font color='#b59f23'>代理价：¥"
					+ productMap.get("奇异淘代理价（包邮）") + "</font>";
			htmlContent += "<font color='#b53123'>&nbsp;&nbsp;&nbsp;包邮价：¥" + productMap.get("超值包邮价")
					+ "</p></font></li>";
		}
		htmlContent += "</ul>";

		htmlWithCategory.put(category, htmlHead + categoryHead + htmlContent + "</div>");
	}
	categorySet.remove("全部产品");
	categorySet.remove("只看热销");
	categorySet.remove("只看特价");
	categorySet.remove("只看缺货");
%>
<!DOCTYPE html>
<html>

<head>
<script>
window['_fs_debug'] = false;
window['_fs_host'] = 'fullstory.com';
window['_fs_org'] = 'C1G6T';
window['_fs_namespace'] = 'FS';
(function(m,n,e,t,l,o,g,y){
    if (e in m) {if(m.console && m.console.log) { m.console.log('FullStory namespace conflict. Please set window["_fs_namespace"].');} return;}
    g=m[e]=function(a,b){g.q?g.q.push([a,b]):g._api(a,b);};g.q=[];
    o=n.createElement(t);o.async=1;o.src='https://'+_fs_host+'/s/fs.js';
    y=n.getElementsByTagName(t)[0];y.parentNode.insertBefore(o,y);
    g.identify=function(i,v){g(l,{uid:i});if(v)g(l,v)};g.setUserVars=function(v){g(l,v)};
    g.shutdown=function(){g("rec",!1)};g.restart=function(){g("rec",!0)};
    g.consent=function(a){g("consent",!arguments.length||a)};
    g.identifyAccount=function(i,v){o='account';v=v||{};v.acctId=i;g(o,v)};
    g.clearUserCookie=function(){};
})(window,document,window['_fs_namespace'],'script','user');
</script>
<meta charset="utf-8">
<title>新西兰奇异淘 代理查价</title>
<meta name="viewport"
	content="width=480,maximum-scale=1.2,user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">

<link rel="stylesheet" href="./css/mui.min.css">
<link rel="stylesheet" type="text/css"
	href="./src/material-scrolltop.css">
<link rel="stylesheet" type="text/css" href="./css/normalize.css" />
<link rel="stylesheet" type="text/css" href="./css/semantic.min.css" />

<style>
html, body {
	min-height: 100%;
	background-color: #f9f9f9;
}

.animated {
	-webkit-animation-duration: 0.5s;
	animation-duration: 0.5s;
	-webkit-animation-fill-mode: both;
	animation-fill-mode: both;
}

@
-webkit-keyframes bounceInDown { 0%, 60%, 75%, 90%, 100% {
	-webkit-transition-timing-function: cubic-bezier(0.215, 0.610, 0.355, 1.000);
	transition-timing-function: cubic-bezier(0.215, 0.610, 0.355, 1.000);
}

0%
{
opacity








































:




















 




















0;
-webkit-transform








































:




















 




















translate3d








































(0
,
-100%,
0);
transform








































:




















 




















translate3d








































(0
,
-100%,
0);
}
60%
{
opacity








































:




















 




















1;
-webkit-transform








































:




















 




















translate3d








































(0
,
25
px
,
0);
transform








































:




















 




















translate3d








































(0
,
25
px
,
0);
}
75%
{
-webkit-transform








































:




















 




















translate3d








































(0
,
-10
px
,
0);
transform








































:




















 




















translate3d








































(0
,
-10
px
,
0);
}
90%
{
-webkit-transform








































:




















 




















translate3d








































(0
,
5
px
,
0);
transform








































:




















 




















translate3d








































(0
,
5
px
,
0);
}
100%
{
-webkit-transform








































:




















 




















none








































;
transform








































:




















 




















none








































;
}
}
@
keyframes bounceInDown { 0%, 60%, 75%, 90%, 100% {
	-webkit-transition-timing-function: cubic-bezier(0.215, 0.610, 0.355, 1.000);
	transition-timing-function: cubic-bezier(0.215, 0.610, 0.355, 1.000);
}

0%
{
opacity








































:




















 




















0;
-webkit-transform








































:




















 




















translate3d








































(0
,
-100%,
0);
transform








































:




















 




















translate3d








































(0
,
-100%,
0);
}
60%
{
opacity








































:




















 




















1;
-webkit-transform








































:




















 




















translate3d








































(0
,
25
px
,
0);
transform








































:




















 




















translate3d








































(0
,
25
px
,
0);
}
75%
{
-webkit-transform








































:




















 




















translate3d








































(0
,
-10
px
,
0);
transform








































:




















 




















translate3d








































(0
,
-10
px
,
0);
}
90%
{
-webkit-transform








































:




















 




















translate3d








































(0
,
5
px
,
0);
transform








































:




















 




















translate3d








































(0
,
5
px
,
0);
}
100%
{
-webkit-transform








































:




















 




















none








































;
transform








































:




















 




















none








































;
}
}
.bounce-in-down {
	-webkit-animation-name: bounceInDown;
	animation-name: bounceInDown;
}

@
-webkit-keyframes fadeInDown { 0%, 60%, 75%, 90%, 100% {
	-webkit-transition-timing-function: cubic-bezier(0.215, 0.610, 0.355, 1.000);
	transition-timing-function: cubic-bezier(0.215, 0.610, 0.355, 1.000);
}

0%
{
opacity








































:




















 




















0;
-webkit-transform








































:




















 




















translate3d








































(0
,
-100%,
0);
transform








































:




















 




















translate3d








































(0
,
-100%,
0);
}
60%
{
opacity








































:




















 




















1;
-webkit-transform








































:




















 




















translate3d








































(0
,
0
px
,
0);
transform








































:




















 




















translate3d








































(0
,
0
px
,
0);
}
75%
{
-webkit-transform








































:




















 




















translate3d








































(0
,
0
px
,
0);
transform








































:




















 




















translate3d








































(0
,
0
px
,
0);
}
90%
{
-webkit-transform








































:




















 




















translate3d








































(0
,
0
px
,
0);
transform








































:




















 




















translate3d








































(0
,
0
px
,
0);
}
100%
{
-webkit-transform








































:




















 




















none








































;
transform








































:




















 




















none








































;
}
}
@
keyframes fadeInDown { 0%, 60%, 75%, 90%, 100% {
	-webkit-transition-timing-function: cubic-bezier(0.215, 0.610, 0.355, 1.000);
	transition-timing-function: cubic-bezier(0.215, 0.610, 0.355, 1.000);
}

0%
{
opacity








































:




















 




















0;
-webkit-transform








































:




















 




















translate3d








































(0
,
-100%,
0);
transform








































:




















 




















translate3d








































(0
,
-100%,
0);
}
60%
{
opacity








































:




















 




















1;
-webkit-transform








































:




















 




















translate3d








































(0
,
0
px
,
0);
transform








































:




















 




















translate3d








































(0
,
0
px
,
0);
}
75%
{
-webkit-transform








































:




















 




















translate3d








































(0
,
0
px
,
0);
transform








































:




















 




















translate3d








































(0
,
0
px
,
0);
}
90%
{
-webkit-transform








































:




















 




















translate3d








































(0
,
0
px
,
0);
transform








































:




















 




















translate3d








































(0
,
0
px
,
0);
}
100%
{
-webkit-transform








































:




















 




















none








































;
transform








































:




















 




















none








































;
}
}
.fade-in-down {
	-webkit-animation-name: fadeInDown;
	animation-name: fadeInDown;
}

@
-webkit-keyframes bounceOutUp { 20% {
	-webkit-transform: translate3d(0, -10px, 0);
	transform: translate3d(0, -10px, 0);
}

40%,
45%
{
opacity








































:




















 




















1;
-webkit-transform








































:




















 




















translate3d








































(0
,
20
px
,
0);
transform








































:




















 




















translate3d








































(0
,
20
px
,
0);
}
100%
{
opacity








































:




















 




















0;
-webkit-transform








































:




















 




















translate3d








































(0
,
-100%,
0);
transform








































:




















 




















translate3d








































(0
,
-100%,
0);
}
}
@
keyframes bounceOutUp { 20% {
	-webkit-transform: translate3d(0, -10px, 0);
	transform: translate3d(0, -10px, 0);
}

40%,
45%
{
opacity








































:




















 




















1;
-webkit-transform








































:




















 




















translate3d








































(0
,
20
px
,
0);
transform








































:




















 




















translate3d








































(0
,
20
px
,
0);
}
100%
{
opacity








































:




















 




















0;
-webkit-transform








































:




















 




















translate3d








































(0
,
-100%,
0);
transform








































:




















 




















translate3d








































(0
,
-100%,
0);
}
}
.bounce-out-up {
	-webkit-animation-name: bounceOutUp;
	animation-name: bounceOutUp;
}

@
-webkit-keyframes fadeOutUp { 20% {
	-webkit-transform: translate3d(0, 0px, 0);
	transform: translate3d(0, 0px, 0);
}

40%,
45%
{
opacity








































:




















 




















1;
-webkit-transform








































:




















 




















translate3d








































(0
,
0
px
,
0);
transform








































:




















 




















translate3d








































(0
,
0
px
,
0);
}
100%
{
opacity








































:




















 




















0;
-webkit-transform








































:




















 




















translate3d








































(0
,
-100%,
0);
transform








































:




















 




















translate3d








































(0
,
-100%,
0);
}
}
@
keyframes fadeOutUp { 20% {
	-webkit-transform: translate3d(0, 0px, 0);
	transform: translate3d(0, 0px, 0);
}

40%,
45%
{
opacity





























:





























1;
-webkit-transform






























:





























translate3d





























(0
,
0
px
,
0);
transform








































:




















 




















translate3d








































(0
,
0
px
,
0);
}
100%
{
opacity








































:




















 




















0;
-webkit-transform








































:




















 




















translate3d








































(0,-100%,0);
transform


























:translate3d




























(0,-100%,0);
}
}
.fade-out-up {
	-webkit-animation-name: fadeOutUp;
	animation-name: fadeOutUp;
}

.menu-open {
	height: 100%;
	width: 100%;
}

.menu-open .mui-scroll-wrapper {
	position: absolute;
	top: 48;
	bottom: 0;
	left: 0;
	z-index: 1;
	width: 100%;
	overflow: hidden;
	-webkit-backface-visibility: hidden;
}

.menu-backdrop {
	display: none;
}

.menu-open .menu-backdrop {
	position: fixed;
	top: 0;
	bottom: 0;
	height: 100%;
	width: 100%;
	display: block;
	z-index: 998;
}

.menu-wrapper {
	position: absolute;
	top: 48px;
	left: 0;
	right: 0;
	z-index: 999;
	text-align: center;
	width: 100%;
}

.menu-wrapper.hidden {
	-webkit-transform: translate3d(0, -100%, 0);
	transform: translate3d(0, -100%, 0);
	z-index: -1;
}

.menu {
	width: 100%;
}

.menu .mui-table-view-inverted {
	color: #6c6c6c;
	font-size: 19px;
}

.menu .mui-table-view-inverted .mui-table-view-cell:after {
	height: 2px;
	left: 0;
	right: 0;
}

.menu-wrapper.mui-active, .menu-wrapper.mui-active .menu {
	-webkit-transform: translate3d(0, 0, 0);
	transform: translate3d(0, 0, 0);
}

#info {
	padding: 20px 10px;
}

.container {
	width: 100%;
	margin: -20px auto;
}

.column {
	margin-bottom: 20px;
}

div.input {
	width: 100%;
}

li:before {
	display: none;
}

ul.ui.list {
	margin-left: 0
}
</style>
</head>

<body>
	<header class="mui-bar mui-bar-nav">
		<h1 class="mui-title">
			欢迎光临 <b><font color="#FFA858">新西兰奇异淘</font></b>
		</h1>
		<button id="logout"
			class="mui-btn mui-btn-blue mui-btn-link mui-pull-right">退出
		</button>
		<div class="mui-btn mui-btn-black mui-pull-right"
			style="padding: 4px 8px; margin-bottom: 0px;"><%=username%></div>
	</header>
	<div class="mui-content" style="padding: 0px 0px; margin-top: 48px;">
			<ul class="mui-table-view mui-table-view-chevron">
				<li id="switch" class="mui-table-view-cell">
					图文模式<i>（建议在Wi-Fi条件下使用）</i>
					<div class="mui-switch mui-active">
						<div class="mui-switch-handle"></div>
					</div>
				</li>
			</ul>
		</div>

	<div class="mui-content">

		<p style="padding: 10px 8px; margin-top: -40px;">
			<button id="menu-btn" type="button"
				class="mui-btn mui-btn-primary mui-btn-block" style="padding: 10px;">选择分类</button>
		</p>


	</div>
	<div style="padding: 40px -35px;" id="info" class="mui-content">
		<%
			String id = "";
			if (request.getParameter("category") != null)
				id = request.getParameter("category");

			if (id.equals("")) {
				out.println(htmlWithCategory.get("只看特价"));
			} else {
				out.println(htmlWithCategory.get(id));
			}
		%>

	</div>
	<div id="menu-wrapper" class="menu-wrapper hidden"
		style="margin-top: -60px;">
		<div id="menu" class="menu">
			<ul class="mui-table-view mui-table-view-inverted">
				<%
					out.println(
							"<b><font color='#b52323'><li value='全部产品' class='mui-table-view-cell'><a href='javascript:;'>全部产品</a></li></font></b>");
					categoryIt = categorySet.iterator();
					while (categoryIt.hasNext()) {
						String category = categoryIt.next();

						out.println("<li value='" + category + "' class='mui-table-view-cell'><a href='javascript:;'>"
								+ category + "</a></li>");

					}
					out.println(
							"<b><font color='#1e97d6'><li value='只看特价' class='mui-table-view-cell'><a href='javascript:;'>只看特价</a></li></font></b>");
					out.println(
							"<b><font color='#896c2f'><li value='只看热销' class='mui-table-view-cell'><a href='javascript:;'>只看热销</a></li></font></b>");
					out.println(
							"<b><font color='#3b968e'><li value='只看缺货' class='mui-table-view-cell'><a href='javascript:;'>只看缺货</a></li></font></b>");
				%>
			</ul>
		</div>
	</div>
	<div id="menu-backdrop" class="menu-backdrop"></div>
	<script src="./js/mui.min.js"></script>
	<script src="./js/jquery.js"></script>
	<script>
		mui.init({
			swipeBack : true
		//启用右滑关闭功能
		});
		var menuWrapper = document.getElementById("menu-wrapper");
		var menu = document.getElementById("menu");
		var menuWrapperClassList = menuWrapper.classList;
		var backdrop = document.getElementById("menu-backdrop");
		var info = document.getElementById("info");

		backdrop.addEventListener('tap', toggleMenu);
		document.getElementById("menu-btn").addEventListener('tap', toggleMenu);

		//下沉菜单中的点击事件
		mui('#menu').on('tap', 'a', function() {
			toggleMenu();
			var tag = this.innerHTML;

			window.location.href = "cost.htm?category=" + tag;

		});
		var busying = false;

		function toggleMenu() {
			if (busying) {
				return;
			}
			busying = true;
			if (menuWrapperClassList.contains('mui-active')) {
				document.body.classList.remove('menu-open');
				menuWrapper.className = 'menu-wrapper fade-out-up animated';
				menu.className = 'menu bounce-out-up animated';
				setTimeout(function() {
					backdrop.style.opacity = 0;
					menuWrapper.classList.add('hidden');
				}, 500);
			} else {
				document.body.classList.add('menu-open');
				menuWrapper.className = 'menu-wrapper fade-in-down animated mui-active';
				menu.className = 'menu bounce-in-down animated';
				backdrop.style.opacity = 1;
			}
			setTimeout(function() {
				busying = false;
			}, 500);
		}
	</script>
	<button class="material-scrolltop" type="button"></button>

	<script src="./js/jquery.js"></script>
	<script src="./src/material-scrolltop.js"></script>
	<script>
		$(document).ready(function() {
			$('body').materialScrollTop({
				revealElement : 'header',
				revealPosition : 'bottom',
				onScrollEnd : function() {
					console.log('Scrolling End');
				}
			});
		});
	</script>
	<script src="./js/jquery.easysearch.js"></script>
	<script>
		$('input').jSearch({
			selector : 'ul',
			child : 'li div.mui-media-body',
			minValLength : 0,
			Found : function(elem, event) {
				$(elem).parent().parent().show();
			},
			NotFound : function(elem, event) {
				$(elem).parent().parent().hide();
			},
			After : function(t) {
				if (!t.val().length)
					$('ul li').show();
				console.log('Searching');
			}
		});
		$(function() {
			$("#logout").click(function() {
				window.location.href = "login.htm";
				return false;
			});
		})
	</script>
	<script type="text/javascript" charset="utf-8">
			document.getElementById("switch").addEventListener('toggle', function(e) {
				if (e.detail.isActive) {
					
				} else {
					var url = document.location.toString();
					var arrUrl = url.split("?");
					var para = arrUrl[1];
					window.location.href = "costnoimg.htm?" + para;
				}
			});
		</script>
</body>

</html>