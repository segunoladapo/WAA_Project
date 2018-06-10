package edu.mum.coffee.api;


import edu.mum.coffee.domain.Product;
import edu.mum.coffee.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.core.parameters.P;
import org.springframework.web.bind.annotation.*;

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

    @ResponseBody
    @GetMapping(value = "/product/{id}", produces =  "application/json")
    public  Product getProductById(@PathVariable int id){
        Product product = productService.getProduct(id);
        double price = product.getPrice();
       return product;
    }

}
