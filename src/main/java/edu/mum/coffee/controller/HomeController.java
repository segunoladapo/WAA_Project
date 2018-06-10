package edu.mum.coffee.controller;

import edu.mum.coffee.domain.Person;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class HomeController {
	
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


}
