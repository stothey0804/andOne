<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"   isELIgnored="false"
 %>
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
      	<a class="logotype">&분의일</a>
        <small class="d-block text-muted">능력있는사람들</small>
        <small class="d-block text-muted">서울특별시 중구 69 YMCA 7층</small>
      </div>
      <div class="col-sm-6 col-md">
        <h5>업체관리</h5>
        <ul class="list-unstyled text-small">
          <li><a class="text-muted" href="${contextPath}/biz/join.do">업체회원가입</a></li>
          <li><a class="text-muted" href="${contextPath}/biz/loginPage.do">업체어드민</a></li>
        </ul>
      </div>
      <div class="col-sm-6 col-md">
        <h5>이용약관</h5>
        <ul class="list-unstyled text-small">
          <li><a class="text-muted" href="#">이용약관</a></li>
          <li><a class="text-muted" href="#">개인정보처리방침</a></li>
          <li><a class="text-muted" href="#">위치기반서비스 이용약관</a></li>
        </ul>
      </div>
      <div class="col-sm-6 col-md">
        <h5>공지/문의</h5>
        <ul class="list-unstyled text-small">
          <li><a class="text-muted" href="${contextPath}/notice.do">공지사항</a></li>
          <li><a class="text-muted" href="${contextPath}/member/qna.do">문의하기</a></li>
          <li><a class="text-muted" href="#">신고하기</a></li>
        </ul>
      </div>
    </div>
  </footer>
</body>
</html>