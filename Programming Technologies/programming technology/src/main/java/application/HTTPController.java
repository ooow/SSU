package application;

import org.apache.lucene.document.Document;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import search.LuceneSearch;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;

@Controller
public class HTTPController {
    private LuceneSearch searcher = LuceneSearch.getInstance();

    @RequestMapping(value = "/home")
    public ModelAndView root() {
        return new ModelAndView("/home");
    }

    @RequestMapping(value = "/search", method = RequestMethod.POST)
    public ModelAndView searchByRating(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("/home");
        String findRating = request.getParameter("rating");
        double rating = -1;
        try {
            rating = Double.valueOf(findRating) - 0.01;
            if (rating < 0.99 || rating > 10) {
                throw new NumberFormatException();
            }
        } catch (NumberFormatException e) {
            String erroreMessage = "Введите пожалуйста рейтинг от 1 до 10";
            mv.addObject("errorMessage", erroreMessage);
            return mv;
        }

        String isUp = request.getParameter("isUp");
        if ("".equals(isUp) || isUp == null) {
            isUp = "1";
            mv.addObject("isUp", isUp);
        } else
            mv.addObject("isUp", isUp);
        mv.addObject("oldrating", findRating);
        ArrayList<Document> topfilms = searcher.searchByRating(rating, isUp);
        mv.addObject("topfilms", topfilms);
        return mv;
    }

    @RequestMapping(value = "/search", method = RequestMethod.GET)
    public ModelAndView searchByName(@RequestParam(name = "title", required = false, defaultValue = "1") String name) {
        ModelAndView mv = new ModelAndView("/home");
        ArrayList<Document> topfilms = searcher.searchByName(name);
        mv.addObject("topfilms", topfilms);
        if (topfilms.size() < 1) {
            String erroreMessage = "По вашему запросу: " + name + " ничего не найдено.";
            mv.addObject("errorMessage", erroreMessage);
        }
        return mv;
    }
}
