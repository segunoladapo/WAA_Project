package edu.mum.coffee.controller;

import edu.mum.coffee.domain.Person;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
	
	@GetMapping({"/", "/index", "/home"})
	public String homePage(Model model) {

		model.addAttribute("person", new Person());
		return "home";
	}

	@GetMapping({"/secure"})
	public String securePage() {
		return "secure";
	}


}
