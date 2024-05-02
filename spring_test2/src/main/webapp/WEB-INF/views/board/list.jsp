<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../layout/header.jsp" />
<!-- 컨테이너 시작 -->
<div class="container-md">
	<h1>list</h1>
	<!-- 검색라인 -->
	<form action="/board/list" method="get">
	<!-- 셀렉트 -->
		<div class="col-auto">
    		<label class="visually-hidden" for="autoSizingSelect">Preference</label>
		    <select class="form-select" id="autoSizingSelect" name="type">
		      <option ${ph.pgvo.type == null ? 'selected' : '' }>Choose...</option>
		      <option value="t" ${ph.pgvo.type eq 't' ? 'selected' : '' }>title</option>
		      <option value="w" ${ph.pgvo.type eq 'w' ? 'selected' : '' }>writer</option>
		      <option value="c" ${ph.pgvo.type eq 'c' ? 'selected' : '' }>content</option>
		      <option value="tc" ${ph.pgvo.type eq 'tc' ? 'selected' : '' }>title+content</option>
		      <option value="wc" ${ph.pgvo.type eq 'wc' ? 'selected' : '' }>writer+content</option>
		      <option value="tw" ${ph.pgvo.type eq 'tw' ? 'selected' : '' }>title+writer</option>
		      <option value="twc" ${ph.pgvo.type eq 'twc' ? 'selected' : '' }>all</option>
		    </select>
		</div>
    	<div class="input-group mb-3">
    	<!-- 검색어 입력 -->
		  <input type="text" name="keyword" value="${ph.pgvo.keyword }" class="form-control" placeholder="검색어 입력" aria-label="Recipient's username" aria-describedby="button-addon2">
		  <input type="hidden" name="pageNo" value="1">
		  <input type="hidden" name="qty" value="10">
		  <!-- 검색버튼 및 배지 -->		  
		  <button class="btn btn-outline-secondary position-relative" type="submit" id="button-addon2">
		  검색
		  <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
		    ${ph.totalCount }
		    <span class="visually-hidden">unread messages</span>
		  </span>
		  </button>
		</div>
	</form>
	<!-- 검색라인 끝 -->
	<!-- 테이블 라인 -->
	<table class="table table-hover">
		<thead>
			<tr>
				<th>#</th>
				<th>title</th>
				<th>writer</th>
				<th>regDate</th>
				<th>readCount</th>
				<th>cmtQty</th>
				<th>hasFile</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list }" var="bvo">
				<tr>
					<td>${bvo.bno }</td>
					<td><a href="/board/detail?bno=${bvo.bno }">${bvo.title }</a></td>
					<td>${bvo.writer }</td>
					<td>${bvo.regDate }</td>
					<td>${bvo.readCount }</td>				
					<td>${bvo.cmtQty }</td>				
					<td>${bvo.hasFile }</td>				
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<!-- 테이블 라인 끝 -->
	<!-- 페이지네이션 라인 -->
	<nav aria-label="Page navigation example">
		<ul class="pagination">
			<%-- <c:if test="${ph.prev }"> --%>
				<li class="page-item ${ph.prev eq false ? 'disabled' : ''}"><a class="page-link" href="/board/list?pageNo=${ph.startPage-1 }&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}">Previous</a></li>
			<%-- </c:if> --%>
			<c:forEach begin="${ph.startPage }" end="${ph.endPage }" var="i">
				<li class="page-item ${ph.pgvo.pageNo eq i ? 'active' : ''}"><a class="page-link" href="/board/list?pageNo=${i }&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}">${i }</a></li>
			</c:forEach>
			<%-- <c:if test="${ph.next }"> --%>
				<li class="page-item ${ph.next eq false ? 'disabled' : ''}"><a class="page-link" href="/board/list?pageNo=${ph.endPage+1 }&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}">Next</a></li>
			<%-- </c:if> --%>
		</ul>
	</nav>
	<!-- 페이지네이션 라인 끝 -->
</div>
<!-- 컨테이너 끝 -->
<jsp:include page="../layout/footer.jsp" />