package com.Fourilet.project.fourilet.controller;

import com.Fourilet.project.fourilet.config.jwt.JwtProperties;
import com.Fourilet.project.fourilet.data.entity.Member;
import com.Fourilet.project.fourilet.dto.KakaoDto.OauthToken;
import com.Fourilet.project.fourilet.service.MemberService;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RestController
@AllArgsConstructor
@RequestMapping("/oauth2/code")
public class OAuthController {

    @Autowired
    private MemberService memberService;

    @GetMapping("/kakao")
    public ResponseEntity getLogin(@RequestParam("code") String code){
        System.out.println("code "+code);
        OauthToken oAuthToken = memberService.getAccessToken(code);

        String jwtToken = memberService.saveMemberAndGetToken(oAuthToken.getAccess_token());

        System.out.println("JWT TOKEN!! " + jwtToken);
        HttpHeaders headers = new HttpHeaders();
        headers.add(JwtProperties.HEADER_STRING, JwtProperties.TOKEN_PREFIX + jwtToken);

        return ResponseEntity.ok().headers(headers).body("success");
    }

    @GetMapping("/me")
    public ResponseEntity<Object> getCurrentUser(HttpServletRequest request){

        Member member = memberService.getMember(request);
        return ResponseEntity.ok().body(member);
    }
}
