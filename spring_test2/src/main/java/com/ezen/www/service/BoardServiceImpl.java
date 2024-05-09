package com.ezen.www.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ezen.www.domain.BoardDTO;
import com.ezen.www.domain.BoardVO;
import com.ezen.www.domain.FileVO;
import com.ezen.www.domain.PagingVO;
import com.ezen.www.repository.BoardDAO;
import com.ezen.www.repository.FileDAO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Slf4j
@Service
public class BoardServiceImpl implements BoardService {
	private final BoardDAO bdao;
	private final FileDAO fdao;

	@Transactional
	@Override
	public int insert(BoardDTO bdto) {
		// bvo 저장 후 bno set 한 후 fileVO 저장
		int isOk = bdao.insert(bdto.getBvo());
		
		if(bdto.getFlist() == null) {
			return isOk;
		}
		if(isOk>0 && bdto.getFlist().size()>0) {
			//bno setting
			int bno = bdao.selectOneBno();	//가장 마지막에 등록된 bno
			for(FileVO fvo : bdto.getFlist()) {
				fvo.setBno(bno);
				isOk *= fdao.insertFile(fvo);
			}
		}
		return isOk;
	}

	@Override
	public List<BoardVO> getList(PagingVO pgvo) {
		// TODO Auto-generated method stub
		return bdao.getList(pgvo);
	}

	@Override
	public BoardDTO getDetail(int bno) {
		// bvo, flist, 묶어서 DTO return
		bdao.updateReadCount(bno);
		BoardVO bvo = bdao.getDetail(bno);
		List<FileVO> flist = fdao.getList(bno);
		BoardDTO bdto = new BoardDTO(bvo, flist);
		return bdto;
	}
	
	@Transactional
	@Override
	public void update(BoardDTO bdto) {
		// TODO Auto-generated method stub
		int isOk = bdao.update(bdto.getBvo());
		if(bdto.getFlist()==null) {
			return;
		}
		
		if(isOk>0 && bdto.getFlist().size()>0) {
			for(FileVO fvo : bdto.getFlist()) {
				fvo.setBno(bdto.getBvo().getBno());
				isOk *= fdao.insertFile(fvo);
			}
		}
	}

	@Override
	public void delete(int bno) {
		// TODO Auto-generated method stub
		bdao.delete(bno);
	}

	@Override
	public int getTotal(PagingVO pgvo) {
		// TODO Auto-generated method stub
		return bdao.getTotal(pgvo);
	}

	@Override
	public int deleteFile(String uuid) {
		// TODO Auto-generated method stub
		return fdao.deleteFile(uuid);
	}
}
