package com.ezen.test.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.ezen.test.domain.BoardVO;
import com.ezen.test.domain.BoradDTO;
import com.ezen.test.domain.CommentVO;
import com.ezen.test.domain.FileVO;
import com.ezen.test.domain.PagingVO;
import com.ezen.test.repository.BoardDAO;
import com.ezen.test.repository.FileDAO;
import com.mysql.cj.x.protobuf.MysqlxCrud.Update;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class BoardServiceImpl implements BoardService {
	
//	@Inject
	private final BoardDAO bdao;
	private final FileDAO fdao;

	@Override
	public int insert(BoradDTO bdto) {
		log.info("board 레지스터 서비스 접근");
		int isOk = bdao.insert(bdto.getBvo());
		
		//file 처리 => bno는 아직 없음
		if(bdto.getFlist() == null) {
			return isOk;
		}else {
			//파일 저장
			if(isOk > 0 && bdto.getFlist().size()>0) {
				//bno는 아직 없음, insert를 통해 자동생성 => db에 가서 검색해오기
				//insert를 통해 자동생성 => DB에 가서 검색해오기
				int bno = bdao.selectBno();
				for(FileVO fvo : bdto.getFlist()) {
					fvo.setBno(bno);
					//파일저장
					isOk *= fdao.insertFile(fvo);
				}
			}
		}
			
		return isOk;
	}

	@Override
	public List<BoardVO> getList(PagingVO pgvo) {
		log.info("board 리스트 서비스 접근");
		return bdao.getList(pgvo);
	}

	@Override
	public BoradDTO getDetail(int bno) {
		log.info("board 디테일 서비스 접근");
		bdao.updateReadCount(bno);
		BoradDTO bdto = new BoradDTO();
		BoardVO bvo = bdao.getDetail(bno);	//기존에 처리된 bvo 객체
		bdto.setBvo(bvo);
		bdto.setFlist(fdao.getFileList(bno));	//bno에 해당하는 모든 파일 리스트 검색
		
		return bdto;
	}

	@Override
	public void update(BoradDTO bdto) {
		log.info("board 업데이트 서비스 접근");
		//파일 추가 작업
		//bvo => boardMapper / flist => fileMapper
		int isOk = bdao.update(bdto.getBvo());
		//파일 값이 없다면...
		if(bdto.getFlist() == null) {
			return;
		}
		
		//bvo 업데이트 완료 후 파일도 있다면... 파일 추가
		if(isOk > 0 && bdto.getFlist().size() > 0) {
			//bno setting
			for(FileVO fvo : bdto.getFlist()) {
				fvo.setBno(bdto.getBvo().getBno());
				isOk *= fdao.insertFile(fvo);
			}
		}
		
	}

	@Override
	public void delete(int bno) {
		log.info("board delete 서비스 접근");
		bdao.delete(bno);
	}

	@Override
	public int getTotal(PagingVO pgvo) {
		log.info("board getTotal 서비스 접근");
		return bdao.getTotal(pgvo);
	}

	@Override
	public int remove(String uuid) {
		log.info("board file remove 서비스 접근");
		return fdao.delete(uuid);
	}

	@Override
	public void cmtFileUpdate() {
		// TODO Auto-generated method stub
		bdao.cmtQttUpdate();
		bdao.hasFileUpdate();
	}
}