package application;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class HTTPController {

    @RequestMapping("/greeting") //Аннотация @RequestMapping(method=GET) гарантирует, что HTTP запросы к /greeting приведут к выполнению метода greeting().
    public String greeting(@RequestParam(value = "name", required = false, defaultValue = "World") String name, Model model) {
        model.addAttribute("name", name);
        return "home";
    }
}
