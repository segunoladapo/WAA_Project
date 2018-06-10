package edu.mum.coffee.api;


import edu.mum.coffee.domain.Product;
import edu.mum.coffee.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.core.parameters.P;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController("ApiProductController")
@RequestMapping(value = "/api")
public class ProductController {


    @Autowired
    private ProductService productService;

    @ResponseBody
    @GetMapping(value = "/product", produces = "application/json")
    public List<Product> getAllProducts(){
        return productService.getAllProduct();
    }
}
