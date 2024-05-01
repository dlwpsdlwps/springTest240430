package com.ezen.www.service;

import java.util.List;

import com.ezen.www.domain.BoardVO;

public interface BoardService {

	void insert(BoardVO bvo);

	List<BoardVO> getList();

	BoardVO getDetail(int bno);
	
	void update(BoardVO bvo);

	void delete(int bno);


}
