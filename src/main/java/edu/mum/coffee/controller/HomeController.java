package edu.mum.coffee.controller;

import edu.mum.coffee.domain.Person;
import edu.mum.coffee.service.EhTokenService;
import edu.mum.coffee.util.Utility;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.validation.Valid;

@Controller
public class HomeController {

	@Autowired
	private EhTokenService tokenService;

	@GetMapping({"/", "/index", "/home"})
	public String homePage(@RequestParam(required = false) String response, Model model) {
		model.addAttribute("response", response);
		model.addAttribute("person", new Person());
		return "home";
	}

	@GetMapping({"/secure"})
	public String securePage() {
		return "secure";
	}

	@PostMapping(path = "/deleteToken")
	public String logoutUser(@RequestParam String token){
		tokenService.clearObject(token, Utility.TOKEN_CACHE);
		return "redirect:/";
	}


}
