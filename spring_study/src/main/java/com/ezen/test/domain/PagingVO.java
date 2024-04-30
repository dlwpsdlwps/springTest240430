package com.ezen.test.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@ToString
@Setter
@Getter
public class PagingVO {
	//select * from board limit 0, 10;
	//페이징 => pageNo / qtt
	//검색 => type / keyword
	private int pageNo;
	private int qtt;	//한 화면에 보여줄 게시글 => 10개
	
	private String type;
	private String keyword;
	
	public PagingVO() {
		this.pageNo = 1;
		this.qtt = 10;
	}
	//DB상에서 limit의 시작 번지를 구하는 메서드
	public int getPageStart() {
		//1=>0 2=>10 3=>20 ...
		return (this.pageNo-1)*this.qtt;
	}
	
	//여러가지의 타입을 검색하기 위해서 타입을 배열로 구분
	//tcw => t c w
	public String[] getTypeToArray() {
		return this.type == null ? new String[] {} : this.type.split("");
	}
}
