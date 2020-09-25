<%@page contentType="text/html;charset=utf-8"%>
<div id="navi">
	<div style="width:50%;float:left">
			<span style="font-size:13pt;Color:#545454;font-weight:700;">IBSheet7 전자정부표준 프레임워크 예제</span>
	</div>
	<div style="width:50%;text-align:right;float:left">
		<a href="#" style="text-decoration:none;color:#343434">
			<span>
			<%
			if(request.getParameter("navi1")!=null) out.print(request.getParameter("navi1"));
			if(request.getParameter("navi2")!=null) out.print( "&gt;"+request.getParameter("navi2") );
			if(request.getParameter("navi3")!=null) out.print( "&gt;"+request.getParameter("navi3") );
			%>
			</span>
		</a>
	</div>
</div>
<div class="clear"></div>