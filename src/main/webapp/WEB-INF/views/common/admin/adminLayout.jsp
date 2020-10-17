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
    <link rel="stylesheet" href="${contextPath}/resources/css/font.css">
	<link rel="stylesheet" href="${contextPath}/resources/css/common.css">
    <!-- bootstrap -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    <!-- JS, Popper.js, and jQuery -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
    
    <style>
    	body{
	    	overflow-x: hidden;
	    	font-family: 'Noto Sans KR', sans-serif !important; 
	    }
      #container {
        width: 100%;
        margin: 0px auto;
          /*text-align:center;*/
      }
      #header {
/*         position: fixed; */
/*         z-index: 99; */
        width:100%;
      }
      #header .logotype {
        font-size: 2em;
      }
       #sidebar-left { 
         width: 280px; 
         float: left; 
         position: sticky;
/*          height: calc(100vh - 74px); */
         overflow-x: hidden;
       } 
       #content-wrap{
       	padding: 0;
       	width: calc(100vw);
       	height: calc(100vh - 74px);
       }
      #content {
      	margin: 0;
        width: calc(100vw - 280px); 
       	height: calc(100vh - 74px);
       	overflow-y: auto;
        float: left;
      }
     
    
    </style>
    
    <title><tiles:insertAttribute name="title" /></title>
  </head>
    <body class="bg-light">
    <div id="container">
      <div id="header" class="sticky-top">
         <tiles:insertAttribute name="header"/>
      </div>
      <div id="content-wrap" class="bg-light">
	      <div id="sidebar-left" class="p-2 pt-3">
	          <tiles:insertAttribute name="side"/>
	      </div>
	      <div id="content" class="bg-white">
	          <tiles:insertAttribute name="body"/>
	      </div>
      </div>
    </div>
  </body>
</html>