console.log("boardModify.js in");

document.addEventListener('click',(e)=>{
    console.log(e.target);
    if(e.target.classList.contains('file-x')){
        let uuid = e.target.dataset.uuid;
        console.log(uuid);
        deleteFileFromServer(uuid).then(result =>{
            if(result == 1){
                alert('파일 삭제 성공');
                e.target.closest('li').remove();
            }
        })
    }
})
//비동기 메서드 맵핑 방법 : post, get, put, delete
async function deleteFileFromServer(uuid){
    try {
        const url = "/board/"+uuid;
        const config={
            method:"delete"
        }
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    } catch (error) {
        console.log(error);
    }
}