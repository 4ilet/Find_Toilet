package com.Fourilet.project.fourilet.config;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
public class CustomAuthenticationEntryPoint implements AuthenticationEntryPoint {
    @Override
    public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException authException) throws IOException, ServletException {

        //(1)
        String exception = (String) request.getAttribute("Authorization");
        String errorCode;

        if(exception.equals("토큰 만료")) {
            errorCode = "토큰 만료";
            setResponse (response, errorCode);
        }

        if(exception.equals("유효하지 않은 토큰")) {
            errorCode = "유효하지 않은 토큰";
            setResponse(response, errorCode);
        }
    }

    //(2)
    private void setResponse(HttpServletResponse response, String errorCode) throws IOException {
        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().println(errorCode);
    }
}
