<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../layout/header.jsp" />
<div class="container-md">
	<h1>register</h1>
	<form action="/user/login" method="post">
		<div class="mb-3">
			<label for="e" class="form-label">email</label>
			<input type="text" class="form-control" name="email" id="e" placeholder="email...">
		</div>
		<div class="mb-3">
			<label for="p" class="form-label">password</label>
			<input type="text" class="form-control" name="pwd" id="p" placeholder="password...">
		</div>
		<button type="submit" class="btn btn-primary">로그인</button>
	</form>
</div>
<jsp:include page="../layout/footer.jsp" />