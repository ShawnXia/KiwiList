<%@ page language="java" contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"%>
<%@ page import="ReadExcel.ReadExcel"%>
<%@ page import="java.util.*"%>
<%@ page import="Public.Logging"%>

<%
	Logging log = new Logging(request, "产品列表页-图文版");
	new Thread(log).start();
	//HttpSession session = request.getSession();
	ServletContext sc = session.getServletContext();
	String excelPath = sc.getRealPath("main.xls");
	ReadExcel re = new ReadExcel(excelPath);
	//System.out.println(excelPath);
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
					+ "src='./img/product/" + productMap.get("商品图片") + ".png'><div class='mui-media-body'>"
					+ "<p class=\'mui-text-title\'>" + productMap.get("品牌") + productMap.get("名称")
					+ productMap.get("子分类") + "</p>" + "<p class=\'mui-text-detail\'>" + productMap.get("简述")
					+ "</p></div>" + "<p class=\'mui-text-remark\'>规格:" + productMap.get("规格") + "</p>";

			if (tagImg != null) {
				htmlContent += "<img class='mui-media-tag mui-pull-right'src='./img/" + tagImg + "'>";
			}

			htmlContent += "<p class=\'mui-text-red\'>" + "包邮价：<s><font color='#222222'>¥"
					+ productMap.get("超市原价") + "</font></s>&nbsp;&nbsp;" + "<font color='#222222'>¥"
					+ productMap.get("超值包邮价") + "</font></p></a></li>";
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
<meta charset="utf-8">
<title>新西兰奇异淘 产品列表</title>
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

	<div id="slider" class="mui-slider" style="margin-top: 3px">
		<div class="mui-slider-group mui-slider-loop">
			<!-- 额外增加的一个节点(循环轮播：第一个节点是最后一张轮播) -->
			<div class="mui-slider-item mui-slider-item-duplicate">
				<a href="#"> <img src="./img/slide/slide1.jpg">
				</a>
			</div>
			<!-- 第一张 -->
			<div class="mui-slider-item">
				<a href="#"> <img src="./img/slide/slide1.jpg">
				</a>
			</div>
			<!-- 第二张 -->
			<div class="mui-slider-item">
				<a href="#"> <img src="./img/slide/slide2.jpg">
				</a>
			</div>
			<!-- 第三张 -->
			<div class="mui-slider-item">
				<a href="#"> <img src="./img/slide/slide3.jpg">
				</a>
			</div>
			<!-- 第四张 -->
			<div class="mui-slider-item">
				<a href="#"> <img src="./img/slide/slide4.jpg">
				</a>
			</div>
			<!-- 额外增加的一个节点(循环轮播：最后一个节点是第一张轮播) -->
			<div class="mui-slider-item mui-slider-item-duplicate">
				<a href="#"> <img src="./img/slide/slide1.jpg">
				</a>
			</div>
		</div>
		<div class="mui-slider-indicator">
			<div class="mui-indicator mui-active"></div>
			<div class="mui-indicator"></div>
			<div class="mui-indicator"></div>
			<div class="mui-indicator"></div>
		</div>
	</div>
	<div class="mui-content">

		<p style="padding: 10px 8px; margin-top: -30px;">
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
	<div id="menu-wrapper" class="menu-wrapper hidden" style="margin-top: -45px;">
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

			window.location.href = "index.htm?category=" + tag;

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
	</script>
	<script type="text/javascript">
		var slider = mui("#slider");
		slider.slider({interval: 3000});
	</script>
	<script type="text/javascript" charset="utf-8">
			document.getElementById("switch").addEventListener('toggle', function(e) {
				
				if (e.detail.isActive) {
					
				} else {
					var url = document.location.toString();
					var arrUrl = url.split("?");
					var para = arrUrl[1];
					window.location.href = "indexnoimg.htm?" + para;
				}
			});
		</script>
</body>

</html>