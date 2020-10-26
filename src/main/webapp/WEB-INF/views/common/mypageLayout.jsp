<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  isELIgnored="false"
 %>
 <%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
 
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <style>
      #sidebar-left {
        width: 250px;
        float: left;
        
      }
      
      ul {
      	list-style-type: none;
      }
      
      li{
      	padding: 0.25rem 0;
      }
      
      #sidebar-left>ul>li{
      	font-size: 1.25rem;
      }
      
      #container {
        width: 100%;
        margin: 0px auto;
      }
      #header {
/*         z-index: 99; */
        width:100%;
      }

      #content {
	    width: calc(100% - 250px);
        float: left;
      }
      #footer {
        clear: both;
        padding: 1.25em;
      }
      
     #header .logotype {
	   font-size: 2.5em;
	 }
	 #footer .logotype {
	   font-size: 2.5em;
	 }
    </style>
    
    <!-- Custom Source CSS -->
    <link rel="stylesheet" href="${contextPath}/resources/css/font.css">
    <link rel="stylesheet" href="${contextPath}/resources/css/common.css">
    <!-- bootstrap -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
	<!--font awesome-->
	<script src="https://kit.fontawesome.com/cdac256c63.js" crossorigin="anonymous"></script>
    <!-- JS, Popper.js, and jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>	
	<!-- Custom Source JS -->
	<script src="${contextPath}/resources/js/common.js"></script>
    <title><tiles:insertAttribute name="title" /></title>
    
  </head>
    <body>
    <div id="container">
      <div id="header">
         <tiles:insertAttribute name="header"/>
      </div>
      <div id="sidebar-left" class="pt-5 p-2">
          <tiles:insertAttribute name="side"/> 
      </div>
      <div id="content">
          <tiles:insertAttribute name="body"/>
      </div>
      <div id="footer">
          <tiles:insertAttribute name="footer"/>
      </div>
    </div>
  </body>
</html>