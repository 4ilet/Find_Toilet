package com.Fourilet.project.fourilet.controller;
import org.springframework.web.bind.annotation.*;
@RestController
public class MemberController {

//    @PostMapping("/user/signup")
//    public signUp(){};

    //테스트
    @GetMapping("/login/2")
    public String login() {
        return "로그인 api 테스트";
    }

}
