package edu.mum.coffee.controller;

import edu.mum.coffee.domain.Address;
import edu.mum.coffee.domain.Person;
import edu.mum.coffee.domain.User;
import edu.mum.coffee.service.OrderService;
import edu.mum.coffee.service.PersonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import javax.validation.Valid;
import java.util.List;

@Controller
public class UserController {

    @Autowired
    PersonService personService;

    @PostMapping(path = "/user")
    public String createUser(@Valid Person person, Model model, BindingResult bindingResult){
        Person personRepo = personService.savePerson(person);
        model.addAttribute("response", "User Added successfully");
        model.addAttribute("person",new Person());
        return "home";
    }

    @GetMapping(path = "/user")
    public String getUser(Model model){
        Person person = new Person();
        Address address = new Address();
        person.setAddress(address);
        model.addAttribute("person",person);
        return "registration";
    }

    @PostMapping(path = "/autnenticate")
    public String  loginUser(@Valid Person person, Model model, BindingResult bindingResult){
        List<Person> personList = personService.findByEmail(person.getEmail());
        if(personList ==  null || personList.size() == 0){
            model.addAttribute("response", "Invalid Email or password");
            return "home";
        }
        return "registration";
    }

}
