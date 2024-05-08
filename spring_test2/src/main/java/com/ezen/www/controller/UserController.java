package com.ezen.www.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ezen.www.domain.AuthVO;
import com.ezen.www.domain.UserVO;
import com.ezen.www.service.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@RequestMapping("/user/*")
@Controller
public class UserController {
	private final UserService usv;
	private final BCryptPasswordEncoder bcEncoder;
	
	//controller mapping과 jsp 경로가 같으면 void가능
	
	@GetMapping("/register")
	public void register() {}
	
	@PostMapping("/register")
	public String register(UserVO uvo) {
		log.info("uvo>>{}", uvo);
		uvo.setPwd(bcEncoder.encode(uvo.getPwd()));
		int isOk = usv.register(uvo);
		return "index";
	}
	
	@GetMapping("/login")
	public void login() {}
	
	@PostMapping("/login")
	public String loginPost(HttpServletRequest request, RedirectAttributes re) {
		//로그인 실패시 다시 로그인 페이지로 돌아와 오류 메세지 전송
		//다시 로그인 유도
		log.info("errMsg >> {}",request.getAttribute("errMsg").toString()); // 한 번 띄워봄
		re.addAttribute("email", request.getAttribute("email"));
		re.addAttribute("errMsg", request.getAttribute("errMsg"));
		
		return "redirect:/user/login";
	}
	
	@GetMapping("/list")
	public String list(Model m) {
		List<UserVO> list = usv.getList();
		m.addAttribute("list", list);
		return "/user/list";
	}
	
	@GetMapping("/modify")
	public void modify() {}
	
	@PostMapping("/modify")
	public String modify(UserVO uvo) {
		usv.modify(uvo);
		return "redirect:/user/logout";
	}
	
}
