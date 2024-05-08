<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<sec:authentication property="principal.uvo.email" var="email" />
<sec:authentication property="principal.uvo.pwd" var="pwd" />
<sec:authentication property="principal.uvo.nickName" var="nick" />
<sec:authentication property="principal.uvo.regDate" var="reg" />
<sec:authentication property="principal.uvo.lastLogin" var="last" />
<sec:authentication property="principal.uvo.authList" var="auth" />
<jsp:include page="../layout/header.jsp" />
<div class="container-md">
	<h1>modify</h1>
	<form action="/user/modify" method="post">
		<div class="mb-3">
			<label for="e" class="form-label">email</label>
			<input type="text" class="form-control" name="email" id="e" value="${email }" placeholder="email..." readonly="readonly">
		</div>
		<div class="mb-3">
			<label for="p" class="form-label">password</label>
			<input type="text" class="form-control" name="pwd" id="p" value="${pwd }" placeholder="password...">
		</div>
		<div class="mb-3">
			<label for="n" class="form-label">nick_name</label>
			<input type="text" class="form-control" name="nickName" id="n" value="${nick }" placeholder="nickName...">
		</div>
		<div class="mb-3">
			<label for="r" class="form-label">reg_date</label>
			<input type="text" class="form-control" name="regDate" value="${reg }" placeholder="regDate..." readonly="readonly">
		</div>
		<div class="mb-3">
			<label for="l" class="form-label">last_login</label>
			<input type="text" class="form-control" name="lastLogin" value="${last }" placeholder="lastLogin..." readonly="readonly">
		</div>
		<%-- <div class="mb-3">
			<label for="a" class="form-label">auth</label>
			<input type="text" class="form-control" name="auth" value="${auth }" placeholder="lastLogin..." readonly="readonly">
		</div> --%>
		<button type="submit" class="btn btn-primary">적용</button>
		<a href="/user/delete"><button type="button" class="btn btn-danger">삭제</button></a>
		<a href="/user/list"><button type="button" class="btn btn-primary">목록</button></a>
	</form>
</div>
<jsp:include page="../layout/footer.jsp" />