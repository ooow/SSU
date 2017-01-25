package application;

import org.apache.lucene.document.Document;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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

    @RequestMapping(value = "/searchbyyear", method = RequestMethod.GET)
    public ModelAndView searchByYear(@RequestParam(name = "year", required = false, defaultValue = "1") String yearr) {
        ModelAndView mv = new ModelAndView("/home");
        int year = 0;
        try {
            year = Integer.valueOf(yearr);
        } catch (NumberFormatException e) {
        }
        ArrayList<Document> topfilms = searcher.searchByYear(year);
        mv.addObject("topfilms", topfilms);
        if (topfilms.size() < 1) {
            String erroreMessage = "Не найдено ни одного фильма " + year + " года";
            mv.addObject("errorMessage", erroreMessage);
        }
        return mv;
    }

    @RequestMapping(value = "/gettop", method = RequestMethod.GET, produces = "application/json; charset=utf-8")
    @ResponseBody
    public String getTop(@RequestParam(value = "rating", required = false, defaultValue = "1") String findRating) {
        double rating = Double.valueOf(findRating) - 0.01;
        ArrayList<Document> topfilms = searcher.searchByRating(rating, "1");
        ArrayList<JSONObject> films = new ArrayList<>();
        for (int i = 0; i < topfilms.size(); i++) {
            JSONObject film = new JSONObject();
            film.put("img", topfilms.get(i).get("img"));
            film.put("href", topfilms.get(i).get("href"));
            film.put("rating", topfilms.get(i).get("rating"));
            film.put("title", topfilms.get(i).get("name"));
            film.put("year", topfilms.get(i).get("year"));
            films.add(film);
        }
        return films.toString();
    }


    @RequestMapping(value = "/getbyear", method = RequestMethod.GET, produces = "application/json; charset=utf-8")
    @ResponseBody
    public String getByYear(@RequestParam(value = "year", required = false, defaultValue = "2016") String yearr) {
        int year = 0;
        try {
            year = Integer.valueOf(yearr);
        } catch (NumberFormatException e) {
        }
        ArrayList<Document> topfilms = searcher.searchByYear(year);
        ArrayList<JSONObject> films = new ArrayList<>();
        for (int i = 0; i < topfilms.size(); i++) {
            JSONObject film = new JSONObject();
            film.put("img", topfilms.get(i).get("img"));
            film.put("href", topfilms.get(i).get("href"));
            film.put("rating", topfilms.get(i).get("rating"));
            film.put("title", topfilms.get(i).get("name"));
            film.put("year", topfilms.get(i).get("year"));
            films.add(film);
        }
        return films.toString();
    }
}