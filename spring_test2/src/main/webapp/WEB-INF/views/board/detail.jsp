<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <jsp:include page="../layout/header.jsp" />
	<div class="container-md">
	<h1>detail</h1>
	<%-- <c:set value="${bdto.bvo }" var="bvo"></c:set> --%>
		<div class="mb-3">
		  <label for="n" class="form-label">bno</label>
		  <input type="text" class="form-control" name="bno" id="n" value="${bvo.bno }" placeholder="bno..." readonly="readonly">
		</div>
		<div class="mb-3">
		  <label for="t" class="form-label">title</label>
		  <input type="text" class="form-control" name="title" id="t" value="${bvo.title }" placeholder="title..." readonly="readonly">
		</div>
		<div class="mb-3">
		  <label for="w" class="form-label">writer</label>
		  <input type="text" class="form-control" name="writer" id="w" value="${bvo.writer }" placeholder="writer..." readonly="readonly">
		</div>
		<div class="mb-3">
		  <label for="c" class="form-label">content</label>
		  <textarea class="form-control" name="content" id="c" aria-label="With textarea" readonly="readonly">${bvo.content }</textarea>
		</div>
		<div class="mb-3">
		  <label for="r" class="form-label">regDate</label>
		  <input type="text" class="form-control" name="reg_date" id="r" value="${bvo.regDate }" readonly="readonly">
		</div>
		<div class="mb-3">
		  <label for="rc" class="form-label">readCount</label>
		  <input type="text" class="form-control" name="read_count" id="rc" value="${bvo.readCount }" readonly="readonly">
		</div>
		
		<%-- <!-- file upload 표시라인 -->
		<c:set value="${bdto.flist }" var="flist"></c:set>
		<div class="mb-3">
			<ul class="list-group List-group flush">
				<!-- 파일 개수만큼 li를 반복하여 파일 표시 타입이 1인경우만 표시 -->
				<!-- li => div => img -->
				<!--    => div => 파일이름, 작성일, span size -->
				<c:forEach items="${flist }" var="fvo">
					<li class="list-group-item">
						<c:choose>
							<c:when test="${fvo.file_type > 0 }">
								<div>
									<img alt="" src="/upload/${fvo.save_dir }/${fvo.uuid}_th_${fvo.file_name}">
								</div>
							</c:when>
							<c:otherwise>
								<div>
									<!-- 파일 타입이 0인경우 아이콘 모양 하나 가져와서 넣기 / 이미지 말고 다른 파일인 경우-->
								</div>
							</c:otherwise>
						</c:choose>
						<div>
							<!-- 파일이름 작성이 사이즈 -->
							<div>${fvo.file_name }</div>
							${fvo.reg_date }
							<span class="badge text-bg-warning">${fvo.file_size }Byte</span>
						</div>
					</li>			
				</c:forEach>
			</ul>
		</div> --%>
		
		<!-- Comment 라인 -->
		<!-- 댓글 등록 라인 -->
		<br>
		<hr>
		<div class="input-group mb-3">
			<span class="input-group-text" id="cmtWriter">${ses.id }</span>
			<input type="text" id="cmtText" class="form-control" placeholder="Add Comment..." aria-label="Username" aria-describedby="basic-addon1">
			<button type="button" id="cmtAddBtn" class="btn btn-secondary">Post</button>
		</div>
		
		<!-- 댓글 출력 라인 -->
		<ul class="list-group list-group-flush" id="cmtListArea">
		  <li class="list-group-item">
		  	<div class="input-group mb-3">
		  		<div class="fw-bold">Writer</div>
		  		content
		  	</div>
		  	<span class="badge rounded-pill text-bg-warning">regDate</span>
		  </li>
		</ul>
		
		<!-- 댓글 더보기 버튼 -->
		<div>
			<button type="button" id="moreBtn" data-page="1" class="btn btn-dark" style="visibility:hidden"> More + </button>
		</div>
		
		<!-- 모달 -->
		<div class="modal" id="myModal" tabindex="-1">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title">Writer</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		        <input type="text" class="form-control" id="cmtTextMod">
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
		        <button type="button" class="btn btn-primary" id="cmtModeBtn">modify</button>
		      </div>
		    </div>
		  </div>
		</div>
		
			<a href="/board/modify?bno=${bvo.bno }"><button type="button" class="btn btn-warning">수정</button></a>
			<a href="/board/delete?bno=${bvo.bno }"><button type="button" class="btn btn-danger">삭제</button></a>
		
		<a href="/board/list"><button type="button" class="btn btn-primary">목록</button></a>
	</div>
	
	
	<script type="text/javascript">
		const bnoVal = `<c:out value="${bvo.bno}" />`;
		/* const id = `<c:out value="${ses.id}" />`; */
		console.log(bnoVal);
	</script>
	
	<script type="text/javascript" src="/re/js/boardDetailComment.js"></script>
	
	<script type="text/javascript">
		spreadCommentList(bnoVal);
	</script>

	<jsp:include page="../layout/footer.jsp" />