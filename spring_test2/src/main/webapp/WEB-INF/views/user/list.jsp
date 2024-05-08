<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<jsp:include page="../layout/header.jsp" />
<div class="container-md">
	<h1>회원정보리스트</h1>
	<div class="card-group">
		<c:forEach items="${list }" var="list">
			<div class="card" style="width: 18rem;">
			<img alt="..." src="/re/image/user.jpg">
				<div class="card-header">email: ${list.email }</div>
				<ul class="list-group list-group-flush">
					<li class="list-group-item">Nickname: ${list.nickName }</li>
					<li class="list-group-item">Regdate: ${list.regDate }</li>
					<li class="list-group-item">Lastlogin: ${list.lastLogin }</li>
					<c:forEach items="${list.authList }" var="a">
						<li class="list-group-item">Auth: ${a.auth }</li>					
					</c:forEach>
				</ul>
			</div>
		</c:forEach>
	</div>
</div>