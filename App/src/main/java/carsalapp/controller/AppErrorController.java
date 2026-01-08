package carsalapp.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AppErrorController implements ErrorController {

    @RequestMapping("/error")
    public String handleError(HttpServletRequest request, Model model) {
        Object statusAttr = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
        model.addAttribute("status", statusAttr);

        if (statusAttr instanceof Integer statusCode) {
            if (statusCode == HttpStatus.FORBIDDEN.value()) {
                return "error/403";
            }
        }
        return "error/500";
    }
}
