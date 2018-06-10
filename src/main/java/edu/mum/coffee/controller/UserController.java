package edu.mum.coffee.controller;

import edu.mum.coffee.domain.*;
import edu.mum.coffee.security.AuthenticationWithToken;
import edu.mum.coffee.service.EhTokenService;
import edu.mum.coffee.service.OrderService;
import edu.mum.coffee.service.PersonService;
import edu.mum.coffee.service.ProductService;
import edu.mum.coffee.util.Utility;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.security.Principal;
import java.util.List;

@Controller
public class UserController {

    @Autowired
    PersonService personService;

    @Autowired
    private EhTokenService tokenService;

    @Autowired
    private ProductService productService;

    @Autowired
    private OrderService orderService;

    @PostMapping(path = "/user")
    public String createUser(@Valid Person person, Model model, BindingResult bindingResult) {
        Person personRepo = personService.savePerson(person);
        model.addAttribute("response", "User Added successfully");
        model.addAttribute("person", new Person());
        return "home";
    }

    @GetMapping(path = "/user")
    public String getUser(Model model) {
        Person person = new Person();
        Address address = new Address();
        person.setAddress(address);
        model.addAttribute("person", person);
        return "registration";
    }

    @PostMapping(path = "/authenticate")
    public String loginUser(@Valid Person person, Model model, BindingResult bindingResult,
                            RedirectAttributes redirAttr) {
        List<Person> personList = personService.findByEmail(person.getEmail());
        if (personList == null || personList.size() == 0) {
            redirAttr.addFlashAttribute("response", "Invalid Email or password");
            return "redirect:/home";
        }
        String token = null;
        if (personList.get(0).isAdmin()) {
            token = tokenService.setToken(new AuthenticationWithToken(personList.get(0),
                    null, AuthorityUtils.commaSeparatedStringToAuthorityList("ROLE_" + personList.get(0).getRole())));
        } else {
            token = tokenService.setToken(new AuthenticationWithToken(personList.get(0),
                    null, AuthorityUtils.commaSeparatedStringToAuthorityList("ROLE_USER")));
        }
        return "redirect:/welcome?X-Auth-Token=" + token;
    }

    @GetMapping(path = "/welcome")
    public String welcomePage(Model model, HttpServletRequest request) {
        String token = request.getParameter("X-Auth-Token");
        model.addAttribute("token", token);
        List<Product> products = productService.getAllProduct();
        model.addAttribute("products", products);
        Order order = null;
        Person principal = (Person) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String orderKey = ((Person) principal).getEmail() + "-" + "cart";
        if (tokenService.contains(orderKey, Utility.UNEXPIREDCACHE)) {
            order = (Order) tokenService.retrieve(orderKey, Utility.UNEXPIREDCACHE);
        } else {
            order = new Order();
            tokenService.saveObject(orderKey, order, Utility.UNEXPIREDCACHE);
        }
        if (principal.isAdmin()) {
            List<Order> orders = orderService.findAll();
            model.addAttribute("orders", orders);
            model.addAttribute("users", personService.getAll());

        }
        model.addAttribute("order", order);
        return "welcome";
    }

    @GetMapping(path = "/userProfile")
    public String viewUserProfile(Model model, HttpServletRequest request) {
        String token = request.getParameter("X-Auth-Token");
        Person principal = (Person) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        List<Person> person = personService.findByEmail(principal.getEmail());
        model.addAttribute("person", person.get(0));
        model.addAttribute("token", token);
        return "userEditProfilePage";
    }

    @PutMapping(path = "/user")
    public String editUserProfile(Person person, Model model, BindingResult bindingResult,
                                  RedirectAttributes redirAttr, HttpServletRequest request) {
        String token = request.getParameter("X-Auth-Token");
        model.addAttribute("token", token);
        Person principal = (Person) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        List<Person> personList = personService.findByEmail(principal.getEmail());
        person.setEmail(principal.getEmail());
        person.setId(personList.get(0).getId());
        person.setRole(personList.get(0).getRole());
        person.setAdmin(personList.get(0).isAdmin());
        personService.savePerson(person);
        redirAttr.addFlashAttribute("response", "Profile Edited successfully");
        return "redirect:/welcome?X-Auth-Token=" + token;
    }

}
