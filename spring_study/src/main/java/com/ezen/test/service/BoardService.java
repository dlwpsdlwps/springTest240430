package com.ezen.test.service;

import java.util.List;

import com.ezen.test.domain.BoardVO;
import com.ezen.test.domain.BoradDTO;
import com.ezen.test.domain.CommentVO;
import com.ezen.test.domain.PagingVO;

public interface BoardService {

	int insert(BoradDTO bdto);

	List<BoardVO> getList(PagingVO pgvo);

	BoradDTO getDetail(int bno);

	void update(BoradDTO bdto);

	void delete(int bno);

	int getTotal(PagingVO pgvo);

	int remove(String uuid);

	void cmtFileUpdate();
}
