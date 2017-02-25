package service;

import org.apache.commons.io.IOUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;

@RestController
public class RController {

    @RequestMapping("/countries")
    public String greeting() throws IOException {
        return IOUtils.toString(new InputStreamReader(new URL("http://api.population.io/1.0/countries/?format=json")
                .openConnection().getInputStream(), "UTF-8"));
    }

    @RequestMapping("/population")
    public String greeting(@RequestParam(value = "country", required = false, defaultValue = "Russian%20Federation") String country,
                           @RequestParam(value = "date", required = false, defaultValue = "2017-01-01") String date) throws IOException {
        URL url = new URL("http://api.population.io/1.0/population/" + country + "/" + date + "/?format=json");
        return IOUtils.toString(new InputStreamReader(url.openConnection().getInputStream(), "UTF-8"));
    }
}