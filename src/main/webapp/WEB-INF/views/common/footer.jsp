<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"   isELIgnored="false"
 %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>footer</title>
</head>
<body>

<footer class="pt-4 my-md-5 p-md-5 p-sm-3 border-top">
    <div class="row">
      <div class="col-sm-12 col-md mb-sm-5">
      	<a class="logotype"><spring:message code="title" /></a>
        <small class="d-block text-muted"><spring:message code="footer.company" /></small>
        <small class="d-block text-muted"><spring:message code="footer.addr" /></small>
      </div>
      <div class="col-sm-6 col-md">
        <h5><spring:message code="footer.shopManager" /></h5>
        <ul class="list-unstyled text-small">
          <li><a class="text-muted" href="${contextPath}/biz/join.do"><spring:message code="footer.regiBmember" /></a></li>
          <li><a class="text-muted" href="${contextPath}/biz/loginPage.do"><spring:message code="footer.shopAdmin" /></a></li>
        </ul>
      </div>
      <div class="col-sm-6 col-md">
        <h5><spring:message code="footer.term" /></h5>
        <ul class="list-unstyled text-small">
          <li><a class="text-muted" href="#"><spring:message code="footer.term" /></a></li>
          <li><a class="text-muted" href="#"><spring:message code="footer.privacyPolicy" /></a></li>
          <li><a class="text-muted" href="#"><spring:message code="footer.locateTerm" /></a></li>
        </ul>
      </div>
      <div class="col-sm-6 col-md">
        <h5><spring:message code="footer.noticeMenu" /></h5>
        <ul class="list-unstyled text-small">
          <li><a class="text-muted" href="${contextPath}/notice.do"><spring:message code="footer.notice" /></a></li>
          <li><a class="text-muted" href="${contextPath}/member/qna.do"><spring:message code="footer.inqury" /></a></li>
          <li><a class="text-muted" href="#"><spring:message code="footer.report" /></a></li>
        </ul>
      </div>
    </div>
  </footer>
</body>
</html>