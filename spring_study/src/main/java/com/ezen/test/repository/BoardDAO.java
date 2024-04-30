package com.ezen.test.repository;

import java.util.List;

import com.ezen.test.domain.BoardVO;
import com.ezen.test.domain.BoradDTO;
import com.ezen.test.domain.CommentVO;
import com.ezen.test.domain.PagingVO;

public interface BoardDAO {

	int insert(BoardVO bvo);

	List<BoardVO> getList(PagingVO pgvo);

	BoardVO getDetail(int bno);

	int update(BoardVO bvo);

	void delete(int bno);

	void updateReadCount(int bno);

	int getTotal(PagingVO pgvo);

	int selectBno();

	int getCmtQtt(PagingVO pvo);

	void cmtQttUpdate();

	void hasFileUpdate();


}