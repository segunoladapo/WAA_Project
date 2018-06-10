package edu.mum.coffee.controller;

import edu.mum.coffee.domain.*;
import edu.mum.coffee.service.EhTokenService;
import edu.mum.coffee.service.ProductService;
import edu.mum.coffee.util.Utility;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

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
        Person person = (Person) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String orderKey = person.getEmail() + "-" + "cart";
        Orderline orderline = new Orderline();
        orderline.setProduct(product);
        orderline.setQuantity(quantity);
        Order order = (Order) tokenService.retrieve(orderKey, Utility.UNEXPIREDCACHE);
        order.setPerson(person);
        order.addOrderLine(orderline);
        orderline.setOrder(order);
        return "redirect:/welcome?X-Auth-Token=" + token;
    }

    @GetMapping(path = "/product")
    @PreAuthorize("hasAnyRole('ROLE_ADMIN')")
    public String newProduct(Model model, HttpServletRequest request) {
        String token = request.getParameter("X-Auth-Token");
        HashMap<String, String> productTypeList = new HashMap<>();
        for (ProductType productType : ProductType.values()) {
            productTypeList.put(productType.name(), productType.name());
        }
        model.addAttribute("productTypeList", productTypeList);
        model.addAttribute("product", new Product());
        model.addAttribute("token", token);
        return "createProduct";
    }

    @PostMapping(path = "/saveProduct")
    public String saveProduct(@Valid Product product, BindingResult bindingResult, Model model, HttpServletRequest request, Principal principal) {
        String token = request.getParameter("X-Auth-Token");
        if (bindingResult.hasErrors()) {
            return "createProduct";
        }
        productService.save(product);
        return "redirect:/welcome?X-Auth-Token=" + token;
    }

    @GetMapping(path = "/productEdit/{id}")
    @PreAuthorize("hasAnyRole('ROLE_ADMIN')")
    public String displayProductToEdit(@PathVariable int id, Model model, HttpServletRequest request) {
        String token = request.getParameter("X-Auth-Token");
        Product product = productService.getProduct(id);
        model.addAttribute("product", product);
        List<String> productTypeList = new ArrayList<>();
        for (ProductType productType : ProductType.values()) {
            productTypeList.add(productType.name());
        }
        model.addAttribute("productTypeList", productTypeList);
        model.addAttribute("productTypeSelected", product.getProductType().toString());
        model.addAttribute("token", token);
        return "productEditPage";
    }


    @PutMapping(path = "/product")
    public String editProduct(Product product, RedirectAttributes redirAttr, HttpServletRequest request, Principal principal) {
        String token = request.getParameter("X-Auth-Token");
        productService.save(product);
        redirAttr.addFlashAttribute("response", "Changes made successfully");
        return "redirect:/welcome?X-Auth-Token=" + token;
    }
}