package com.myproject.controller;

import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.myproject.domain.Criteria;
import com.myproject.domain.ExpenseVO;
import com.myproject.domain.PageDTO;
import com.myproject.service.ExpenseService;
import com.myproject.domain.UserVO;
import com.myproject.service.CategoryService;
import com.myproject.service.MethodService;
import com.myproject.service.CycleService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/expense/*") // URL을 /expense/로 변경
public class ExpenseController {

	private ExpenseService service;
	private CategoryService categoryService;
	private MethodService methodService;
	private CycleService cycleService;
	
	public ExpenseController(ExpenseService service, CategoryService categoryService,
			MethodService methodService, CycleService cycleService) {
		this.service = service;
		this.categoryService = categoryService;
		this.methodService = methodService;
		this.cycleService = cycleService;
	}

	@GetMapping("/register")
	public void register(HttpSession session, Model model) {
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		
		// 5. 드롭다운 목록을 DB에서 조회
		model.addAttribute("categoryList", categoryService.getList(loginUser.getUser_id()));
		model.addAttribute("methodList", methodService.getList(loginUser.getUser_id()));
		model.addAttribute("cycleList", cycleService.getList(loginUser.getUser_id()));
		
		// /WEB-INF/views/expense/register.jsp 로 이동
	}

	@GetMapping("/list")
	 public void list(Criteria cri, Model model, HttpSession session) { // 4. HttpSession 파라미터 추가
	 
		 log.info("list: " + cri);
		 
		 // 5. 세션에서 로그인한 사용자 정보를 가져옵니다.
		 UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		 
		 // 6. Criteria 객체에 현재 로그인한 사용자의 ID를 저장합니다.
		 cri.setUser_id(loginUser.getUser_id());
		 
		 // 7. 이제 service.getList(cri)는 "누가" 요청했는지 알 수 있습니다.
		 model.addAttribute("list", service.getList(cri));
		 int total = service.getTotal(cri); // getTotal도 cri를 사용하므로 자동 적용
		 
		 log.info("total: "+total);
		 model.addAttribute("pageMaker", new PageDTO(cri, total));
	 }

	 @PostMapping("/register")
		public String register(ExpenseVO expense, HttpSession session, RedirectAttributes rttr) {
			log.info("register: " + expense);

			UserVO loginUser = (UserVO) session.getAttribute("loginUser");
			
			if (loginUser == null) {
			    rttr.addFlashAttribute("result", "login_required");
			    return "redirect:/user/login";
			}
			
			// 7. 세션에서 가져온 user_id 설정
			expense.setUser_id(loginUser.getUser_id()); 

			service.register(expense);
			rttr.addFlashAttribute("result", expense.getExpense_id());
			return "redirect:/expense/list";
		}

	 @GetMapping( {"/get", "/modify"} )
	 public void get(@RequestParam("expense_id") Long expense_id, @ModelAttribute("cri") Criteria cri, 
	                 Model model, HttpSession session) { // 4. HttpSession 파라미터 추가
	    
		 log.info("/get or modify - " + expense_id);
		 UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		 
		 // 5. [추가] register(GET)와 동일하게 드롭다운 목록을 조회
		 model.addAttribute("categoryList", categoryService.getList(loginUser.getUser_id()));
		 model.addAttribute("methodList", methodService.getList(loginUser.getUser_id()));
		 model.addAttribute("cycleList", cycleService.getList(loginUser.getUser_id()));
		 
		 // 6. [기존] 수정할 항목의 상세 정보 조회
		 model.addAttribute("expense", service.get(expense_id));
		 
		 // /WEB-INF/views/expense/get.jsp 또는 modify.jsp 로 이동
	 }

	@PostMapping("/modify")
	public String modify(ExpenseVO expense, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("modify:" + expense);

		if (service.modify(expense)) {
			rttr.addFlashAttribute("result", "success");
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		return "redirect:/expense/list";
	}

	 @PostMapping("/remove")
	 public String remove(@RequestParam("expense_id") Long expense_id, Criteria cri, RedirectAttributes rttr) {
		 log.info("remove..." + expense_id);
		 if (service.remove(expense_id)) {
			 rttr.addFlashAttribute("result", "success");
		 }
		 rttr.addAttribute("pageNum", cri.getPageNum());
		 rttr.addAttribute("amount", cri.getAmount());
		 return "redirect:/expense/list";
	 }
}