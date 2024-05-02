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
        postCommentToServer(cmtData).then(result => {
            console.log(cmtData);
            if(result == '1'){
                alert('댓글 등록 성공');
                document.getElementById('cmtText').value = '';
                spreadCommentList(bnoVal);
            }
        })
    }
})

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
                let add = `<li class="list-group-item">`;
                add += `<div class="input-group mb-3"> no. ${cvo.cno} |`;
                add += `<div class="fw-bold">${cvo.writer}</div>`;
                add += ` ${cvo.content}`;
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

async function getCommentListFromServer(bno, page){
    try {
        const resp = await fetch("/comment/"+bno+"/"+page);
        const result = await resp.json();
        return result;
    } catch (error) {
        console.log(error);
    }
}

document.addEventListener('click', (e)=>{
    if(e.target.id == 'moreBtn'){
        let page = parseInt(e.target.dataset.page);
        spreadCommentList(bnoVal, page);
    }
})