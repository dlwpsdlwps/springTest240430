package com.ezen.www.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ezen.www.domain.UserVO;
import com.ezen.www.repository.UserDAO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class UserServiceImpl implements UserService{
	private final UserDAO udao;

	@Transactional
	@Override
	public int register(UserVO uvo) {
		// 권한 추가
		int isOk = udao.insert(uvo);
		return udao.insertAuthInit(uvo.getEmail()); 
	}

	@Override
	public List<UserVO> getList() {
		List<UserVO> list = udao.getList();
		for(UserVO uvo : list) {
			uvo.setAuthList(udao.selectAuths(uvo.getEmail()));
		}
		return list;
	}

	@Override
	public void modify(UserVO uvo) {
		udao.modify(uvo);
	}

	@Override
	public void modifyWithoutPwd(UserVO uvo) {
		udao.modifyWithoutPwd(uvo);
	}

	@Override
	public void delete(String email) {
		udao.deleteAuth(email);
		udao.delete(email);
	}
}
