package com.ezen.test.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ezen.test.domain.MemberVO;
import com.ezen.test.service.MemberService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@RequestMapping("/member/*")
@Controller
public class MemberController {
	
	private final MemberService msv;
	
	@GetMapping("/register")
	public void register() {
		
	}
	@PostMapping("/register")
	public String register(MemberVO mvo) {
		log.info("register mvo >> {}", mvo);
		int isOk = msv.insert(mvo);
		return "index";
	}
	@GetMapping("/login")
	public void login() {
		
	}
	@PostMapping("/login")
	public String login(MemberVO mvo, HttpServletRequest request, Model m) {
		log.info("login mvo >> {}", mvo);
		
		//mvo 객체가 DB의 값과 일치하는 객체 가져오기
		MemberVO loginMvo = msv.isUser(mvo);
		log.info("login loginMvo >> {}", loginMvo);
		
		if(loginMvo != null) {
			//로그인 성공시
			HttpSession ses = request.getSession();
			ses.setAttribute("ses", loginMvo);
			ses.setMaxInactiveInterval(10*60);
		}else {
			//로그인 실패시
			m.addAttribute("msg_login", "1");
		}
		return "index";
	}
	@GetMapping("/logout")
	public String logout(HttpServletRequest request, Model m) {
		//last_login 업데이트 => 세션 객체 삭제 => 세션 끊기
		MemberVO mvo = (MemberVO)request.getSession().getAttribute("ses");
		msv.lastLoginUpdate(mvo.getId());
		
		request.getSession().removeAttribute("ses");
		
		request.getSession().invalidate();
		
		m.addAttribute("msg_logout", "1");
		return "index";
	}
	
	@GetMapping("/modify")
	public void modify() {}
	
	@PostMapping("/modify")
	public String modify(MemberVO mvo) {
		msv.modify(mvo);
		return "redirect:/member/logout";
	}
	@GetMapping("/delete")
	public String delete(HttpServletRequest request, RedirectAttributes re) {
		MemberVO mvo = (MemberVO)request.getSession().getAttribute("ses");
		msv.delete(mvo.getId());
		
		re.addFlashAttribute("msg_delete", "1");
		return "redirect:/member/logout";
	}
}
