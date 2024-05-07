<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <jsp:include page="../layout/header.jsp" />
<div class="container-md">
	<h1>register</h1>
	<form action="/user/register" method="post">
		<div class="mb-3">
			<label for="e" class="form-label">email</label>
			<input type="text" class="form-control" name="email" id="e" placeholder="email...">
		</div>
		<div class="mb-3">
			<label for="p" class="form-label">password</label>
			<input type="text" class="form-control" name="pwd" id="p" placeholder="password...">
		</div>
		<div class="mb-3">
			<label for="n" class="form-label">nick_name</label>
			<input type="text" class="form-control" name="nickName" id="n" placeholder="nickname...">
		</div>
		<button type="submit" class="btn btn-primary">가입</button>
	</form>
</div>
<jsp:include page="../layout/footer.jsp" />