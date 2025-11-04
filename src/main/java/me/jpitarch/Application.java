package me.jpitarch;

import io.micronaut.http.annotation.Controller;
import io.micronaut.http.annotation.Get;
import io.micronaut.runtime.Micronaut;

import java.util.logging.Logger;

public class Application {

    public static void main(String[] args) {
        Micronaut.run(Application.class, args);
    }
}

@Controller
class HelloController {

  private static final Logger LOGGER = Logger.getLogger(HelloController.class.getName());

    @Get("/hello-world")
    public String index() {
        LOGGER.info("Hello World endpoint was called");
        return "Hello World";
    }
}
