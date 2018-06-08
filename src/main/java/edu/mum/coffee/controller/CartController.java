package edu.mum.coffee.controller;

import com.sun.org.apache.xpath.internal.operations.Mod;
import edu.mum.coffee.domain.Order;
import edu.mum.coffee.domain.Orderline;
import edu.mum.coffee.domain.Person;
import edu.mum.coffee.domain.Product;
import edu.mum.coffee.service.EhTokenService;
import edu.mum.coffee.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import javax.servlet.http.HttpServletRequest;
import java.security.Principal;
import java.util.Date;
import java.util.List;

@Controller
public class CartController {

    @Autowired
    private EhTokenService tokenService;

    @Autowired
    private OrderService orderService;

    @GetMapping(path = "/viewCart")
    public String displayProduct(Model model, HttpServletRequest request) {
        String token = request.getParameter("X-Auth-Token");
        Person person = (Person) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String orderKey = person.getEmail() + "-" + "cart";
        Order order = (Order) tokenService.retrieve(orderKey);
        model.addAttribute("token", token);
        model.addAttribute("order", order);
        model.addAttribute("quantity", order.getQuantity());
        model.addAttribute("totalAmount", order.getTotalAmount());
        return "viewCart";
    }

    @PostMapping(path = "/checkout")
    public String addToCartModel(Model model, RedirectAttributes redirAttr, HttpServletRequest request, Principal principal) {
        String token = request.getParameter("X-Auth-Token");
        Person person = (Person) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String orderKey = person.getEmail() + "-" + "cart";
        Order order = (Order) tokenService.retrieve(orderKey);
        order.setPerson(person);
        order.setOrderDate(new Date());
        orderService.save(order);
        tokenService.clearObject(orderKey);
        new Order();
        tokenService.saveObject(orderKey, new Order());
        redirAttr.addFlashAttribute("response","Checkout successful, order placed.");
        return "redirect:/welcome?X-Auth-Token=" + token;
    }
}