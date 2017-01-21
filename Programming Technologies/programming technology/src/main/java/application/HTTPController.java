package application;

import org.apache.lucene.document.Document;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import search.LuceneSearch;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;

@Controller
public class HTTPController {
    private LuceneSearch searcher = LuceneSearch.getInstance();

    @RequestMapping(value = "/home")
    public ModelAndView root() {
        ModelAndView mv = new ModelAndView("/home");
        ArrayList<Document> topfilms = searcher.searchByRating("9.5");
        String top = "";
        for (int i = 0; i < topfilms.size(); i++) {
            top += topfilms.get(i).get("name") + "\n";
        }
        mv.addObject("topfilms", top);
        return mv;
    }

    @RequestMapping(value = "/search", method = RequestMethod.POST)
    public ModelAndView searchByRating(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("/home");
        String findRating = request.getParameter("rating");
        ArrayList<Document> topfilms = searcher.searchByRating(findRating);
        mv.addObject("topfilms", topfilms);
        return mv;
    }
}
