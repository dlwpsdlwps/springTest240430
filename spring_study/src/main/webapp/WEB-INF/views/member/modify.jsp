<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <jsp:include page="../layout/header.jsp" />
<div class="container-md">
	<h1>modify</h1>
	<form action="/member/modify" method="post">
		<div class="mb-3">
			<label for="i" class="form-label">id</label>
			<input type="text" class="form-control" name="id" id="i" value="${ses.id }" placeholder="id..." readonly="readonly">
		</div>
		<div class="mb-3">
			<label for="i" class="form-label">reg_date</label>
			<input type="text" class="form-control" name="reg_date" id="i" value="${ses.reg_date }" placeholder="id..." readonly="readonly">
		</div>
		<div class="mb-3">
			<label for="i" class="form-label">last_login</label>
			<input type="text" class="form-control" name="last_login" id="i" value="${ses.last_login }" placeholder="id..." readonly="readonly">
		</div>
		<div class="mb-3">
			<label for="p" class="form-label">password</label>
			<input type="text" class="form-control" name="pw" id="p" placeholder="password...">
		</div>
		<div class="mb-3">
			<label for="n" class="form-label">name</label>
			<input type="text" class="form-control" name="name" id="n" value="${ses.name }" placeholder="name...">
		</div>
		<div class="mb-3">
			<label for="e" class="form-label">email</label>
			<input type="text" class="form-control" name="email" id="e" value="${ses.email }" placeholder="email...">
		</div>
		<div class="mb-3">
			<label for="h" class="form-label">home</label>
			<input type="text" class="form-control" name="home" id="h" value="${ses.home }" placeholder="home...">
		</div>
		<div class="mb-3">
			<label for="a" class="form-label">age</label>
			<input type="text" class="form-control" name="age" id="a" value="${ses.age }" placeholder="age...">
		</div>
		<button type="submit" class="btn btn-primary">적용</button>
		<a href="/member/delete"><button type="button" class="btn btn-danger">삭제</button></a>
		<a href="/member/list"><button type="button" class="btn btn-primary">목록</button></a>
	</form>
</div>
<jsp:include page="../layout/footer.jsp" />