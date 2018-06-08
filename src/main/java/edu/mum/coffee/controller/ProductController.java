package edu.mum.coffee.controller;

import edu.mum.coffee.domain.Order;
import edu.mum.coffee.domain.Orderline;
import edu.mum.coffee.domain.Person;
import edu.mum.coffee.domain.Product;
import edu.mum.coffee.service.EhTokenService;
import edu.mum.coffee.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpServletRequest;
import java.security.Principal;

@Controller
public class ProductController {

    @Autowired
    private ProductService productService;

    @Autowired
    private EhTokenService tokenService;

    @GetMapping(path = "/product/{id}")
    public String displayProduct(@PathVariable int id, Model model, HttpServletRequest request) {
        String token = request.getParameter("X-Auth-Token");
        Product product = productService.getProduct(id);
        model.addAttribute("product", product);
        model.addAttribute("token", token);
        return "productPage";
    }

    @PostMapping(path = "/productAddToCart")
    public String addToCart(Product product, Model model, HttpServletRequest request, Principal principal) {
        String token = request.getParameter("X-Auth-Token");
        int quantity = Integer.valueOf(request.getParameter("quantity"));
        Person person = (Person)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String orderKey = person.getEmail() + "-" + "cart";
        Orderline orderline = new Orderline();
        orderline.setProduct(product);
        orderline.setQuantity(quantity);
        Order order = (Order) tokenService.retrieve(orderKey);
        order.setPerson(person);
        order.addOrderLine(orderline);
        orderline.setOrder(order);
        return "redirect:/welcome?X-Auth-Token=" + token;
    }
}
