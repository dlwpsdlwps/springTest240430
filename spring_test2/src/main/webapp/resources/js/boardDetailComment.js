console.log("bdc in");

//cmtAddBtn 누르면 bno, writer, content를 비동기로 DB에 넣기
document.getElementById('cmtAddBtn').addEventListener('click', ()=>{
    let cmtText = document.getElementById('cmtText').value;
    const cmtWriter = document.getElementById('cmtWriter').innerText;

    if(cmtText == null || cmtText == ''){
        alert('댓글을 입력하세요');
        document.getElementById('cmtText').focus();
        return false;
    }else{
        let cmtData={
            bno:bnoVal,
            writer:cmtWriter,
            content:cmtText
        }
        //댓글 등록
        postCommentToServer(cmtData).then(result => {
            console.log(cmtData);
            if(result == '1'){
                alert('댓글 등록 성공');
                document.getElementById('cmtText').value = '';
                //댓글 뿌리기
                spreadCommentList(bnoVal);
            }
        })
    }
})

//댓글 등록
async function postCommentToServer(cmtData){
    try {
        const url = "/comment/post";
        const config={
            method:"post",
            headers:{
                "content-type":"application/json; charset=utf-8"
            },
            body: JSON.stringify(cmtData)
        }
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    } catch (error) {
        console.log(error);
    }
}

//댓글 뿌리기
function spreadCommentList(bno, page=1){
    //댓글 뿌리기 for of로도 작성해보기
    getCommentListFromServer(bno, page).then(result => {
        const ul = document.getElementById('cmtListArea');
        if(result.cmtList.length > 0){
            if(page==1){
                ul.innerHTML = '';
            }
            // for(let i=0; i<result.cmtList.length; i++){
            //     let add = `<li class="list-group-item">`;
            //     add += `<div class="input-group mb-3"> no. ${result[i].cno} |`;
            //     add += `<div class="fw-bold">${result[i].writer}</div>`;
            //     add += ` ${result[i].content}`;
            //     add += `</div>`;
            //     add += `<span class="badge rounded-pill text-bg-warning">${result[i].regDate}</span>`;
            //     //수정 삭제 버튼
            //     add += `<button type="button" class="btn btn-outline-warning btn-sm mod" data-bs-toggle="modal" data-bs-target="#myModal">%</button>`;
            //     add += `<button type="button" class="btn btn-outline-danger btn-sm del" >X</button>`;
            //     add += `</li>`;
            //     ul.innerHTML += add;
            // }
            for(let cvo of result.cmtList){
                let add = `<li class="list-group-item" data-cno="${cvo.cno}">`;
                add += `<div class="input-group mb-3"> no. ${cvo.cno} | `;
                add += `<div class="fw-bold">　${cvo.writer}　</div>`;
                add += `${cvo.content}`;
                add += `</div>`;
                add += `<span class="badge rounded-pill text-bg-warning">${cvo.regDate}</span>`;
                //수정 삭제 버튼
                add += `<button type="button" class="btn btn-outline-warning btn-sm mod" data-bs-toggle="modal" data-bs-target="#myModal">%</button>`;
                add += `<button type="button" class="btn btn-outline-danger btn-sm del" >X</button>`;
                add += `</li>`;
                ul.innerHTML += add;
            }
            //더보기 버튼 코드
            let moreBtn = document.getElementById('moreBtn');
            console.log(moreBtn);
            //moreBtn 표시되는 조건
            //pgvo.pageNo = 1 / realEndPage = 3
            //realEndPage보다 현재 내 페이지가 작으면 표시
            if(result.pgvo.pageNo < result.realEndPage){
                //style="visibility:hidden" => 숨김, "visibility:visible" => 표시
                moreBtn.style.visibility = 'visible';   //버튼 표시
                moreBtn.dataset.page = page + 1;    //1페이지 늘림
            }else{
                moreBtn.style.visibility = 'hidden';    //숨김
            }

        }else{
            ul.innerHTML = `<div class="fw-bold"> Comment List is Empty </div>`;
        }
    })
}

/*
<button type="button" class="btn btn-warning-sm">Warning</button>
		<ul class="list-group list-group-flush" id="cmtListArea">
		  <li class="list-group-item">
		  	<div class="input-group mb-3">
		  		<div class="fw-bold">Writer</div>
		  		content
		  	</div>
		  	<span class="badge rounded-pill text-bg-warning">regDate</span>
		  </li>
		</ul>
*/

//댓글 리스트 가져오기
async function getCommentListFromServer(bno, page){
    try {
        const resp = await fetch("/comment/"+bno+"/"+page);
        const result = await resp.json();
        return result;
    } catch (error) {
        console.log(error);
    }
}

//더보기 수정 삭제
document.addEventListener('click', (e)=>{
    if(e.target.id == 'moreBtn'){
        let page = parseInt(e.target.dataset.page);
        spreadCommentList(bnoVal, page);
    }
    else if(e.target.classList.contains('mod')){
        //내가 수정버튼을 누른 댓글의 li
        let li = e.target.closest('li');
        //nextSibling : 한 부모 안에서 다음 형제를 찾기
        let cmtText = li.querySelector('.fw-bold').nextSibling;
        console.log(cmtText);
        document.getElementById('cmtTextMod').value = cmtText.nodeValue;

        //수정 => cno dataset으로 달기 cno, content
        document.getElementById('cmtModBtn').setAttribute("data-cno", li.dataset.cno);
    }
    else if(e.target.id == 'cmtModBtn'){
        let cmtModData = {
            cno: e.target.dataset.cno,
            content: document.getElementById('cmtTextMod').value
        }
        console.log(cmtModData);
        //비동기로 보내기
        updateCommentToServer(cmtModData).then(result => {
            if(result == '1'){
                alert('댓글 수정 성공');
                //모달창 닫기
                document.querySelector(".btn-close").click();
            }else{
                alert('수정실패');
                document.querySelector(".btn-close").click();
            }
            //댓글 새로 뿌리기
            spreadCommentList(bnoVal);
        })
    }
    else if(e.target.classList.contains('del')){
        //cno
        // let cnoVal = e.target.dataset.cno;
        let li = e.target.closest('li');
        let cnoVal = li.dataset.cno;
        //비동기로 삭제 요청
        removeCommentToServer(cnoVal).then(result=>{
            if(result == '1'){
                alert('댓삭 성공');
                spreadCommentList(bnoVal);
            }
        })
    }
})

//수정
async function updateCommentToServer(cmtModData){
    try {
        const url = "/comment/edit";
        const config = {
            method: "put",
            headers: {
                'content-type':'application/json; charset=utf-8'
            },
            body: JSON.stringify(cmtModData)
        }
        const resp = await fetch(url, config);
        const result = resp.text();
        return result;
    } catch (error) {
        console.log(error);
    }
}

//삭제
async function removeCommentToServer(cnoVal){
    try {
        const url = "/comment/"+cnoVal;
        const config = {
            method: "delete"
        }
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    } catch (error) {
        console.log(error);
    }
}