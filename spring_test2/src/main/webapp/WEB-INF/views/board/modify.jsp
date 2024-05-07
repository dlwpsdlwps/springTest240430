<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <jsp:include page="../layout/header.jsp" />
	<div class="container-md">
	<h1>modify</h1>
	<c:set value="${bdto.bvo }" var="bvo"></c:set>
	<form action="/board/modify" method="post" enctype="multipart/form-data">
		<div class="mb-3">
		  <label for="n" class="form-label">bno</label>
		  <input type="text" class="form-control" name="bno" id="n" value="${bvo.bno }" placeholder="bno..." readonly="readonly">
		</div>
		<div class="mb-3">
		  <label for="t" class="form-label">title</label>
		  <input type="text" class="form-control" name="title" id="t" value="${bvo.title }" placeholder="title...">
		</div>
		<div class="mb-3">
		  <label for="w" class="form-label">writer</label>
		  <input type="text" class="form-control" name="writer" id="w" value="${bvo.writer }" placeholder="writer..." readonly="readonly">
		</div>
		<div class="mb-3">
		  <label for="c" class="form-label">content</label>
		  <textarea class="form-control" name="content" id="c" aria-label="With textarea">${bvo.content }</textarea>
		</div>
		<div class="mb-3">
		  <label for="r" class="form-label">regDate</label>
		  <input type="text" class="form-control" name="reg_date" id="r" value="${bvo.regDate }" readonly="readonly">
		</div>
		<div class="mb-3">
		  <label for="rc" class="form-label">readCount</label>
		  <input type="text" class="form-control" name="read_count" id="rc" value="${bvo.readCount }" readonly="readonly">
		</div>
		<!-- file upload 표시라인 -->
		<c:set value="${bdto.flist }" var="flist"></c:set>
		<div class="mb-3">
			<ul class="list-group List-group flush">
				<!-- 파일 개수만큼 li를 반복하여 파일 표시 타입이 1인경우만 표시 -->
				<!-- li => div => img -->
				<!--    => div => 파일이름, 작성일, span size -->
				<c:forEach items="${flist }" var="fvo">
					<li class="list-group-item">
						<c:choose>
							<c:when test="${fvo.fileType > 0 }">
								<div>
									<img alt="" src="/up/${fvo.saveDir }/${fvo.uuid}_th_${fvo.fileName}">
								</div>
							</c:when>
							<c:otherwise>
								<div>
									<!-- 파일 타입이 0인경우 아이콘 모양 하나 가져와서 넣기 / 이미지 말고 다른 파일인 경우-->
									<a href="/up/${fvo.saveDir }/${fvo.uuid}_th_${fvo.fileName}" download="${fvo.fileName }">
									<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-file-earmark-arrow-down" viewBox="0 0 16 16">
									  <path d="M8.5 6.5a.5.5 0 0 0-1 0v3.793L6.354 9.146a.5.5 0 1 0-.708.708l2 2a.5.5 0 0 0 .708 0l2-2a.5.5 0 0 0-.708-.708L8.5 10.293z"/>
									  <path d="M14 14V4.5L9.5 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2M9.5 3A1.5 1.5 0 0 0 11 4.5h2V14a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h5.5z"/>
									</svg>
									</a>
								</div>
							</c:otherwise>
						</c:choose>
						<div>
							<!-- 파일이름 작성이 사이즈 -->
							<div>${fvo.fileName }</div>
							${fvo.regDate }
							<span class="badge text-bg-warning">${fvo.fileSize }Byte</span>
							<button type="button" class="btn btn-outline-danger btn-sm file-x" data-uuid="${fvo.uuid }">X</button>
						</div>
					</li>			
				</c:forEach>
			</ul>
		</div>
		
		<!-- 파일 입력 라인 추가 -->
		<div class="mb-3">
		  <label for="file" class="form-label">files...</label>
		  <input type="file" class="form-control" name="files" id="file" multiple="multiple" style="display: none"> <br>
		  <button type="button" class="btn btn-info" id="trigger">FileUpload...</button>
		</div>
		
		<!-- 파일 목록 표시 라인 -->
		<div class="mb-3" id="fileZone">
		</div>
		
		<!-- 하단부 버튼 -->
		<button type="submit" class="btn btn-warning" id="regBtn">수정</button>
		<a href="/board/list"><button type="button" class="btn btn-primary">목록</button></a>
		</form>
	</div>
	<script type="text/javascript" src="/re/js/boardModify.js"></script>
	<script type="text/javascript" src="/re/js/boardRegister.js"></script>
	<jsp:include page="../layout/footer.jsp" />
</html>