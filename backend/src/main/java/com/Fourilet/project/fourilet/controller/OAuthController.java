package com.Fourilet.project.fourilet.controller;

import com.Fourilet.project.fourilet.config.jwt.JwtProperties;
import com.Fourilet.project.fourilet.data.entity.Member;
import com.Fourilet.project.fourilet.data.repository.MemberRepository;
import com.Fourilet.project.fourilet.dto.KakaoDto.OauthToken;
import com.Fourilet.project.fourilet.service.MemberService;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

@RestController
@AllArgsConstructor
@RequestMapping("/oauth2/code")
public class OAuthController {

    @Autowired
    private MemberService memberService;

    @GetMapping("/kakao")
    public ResponseEntity getServerLogin(@RequestParam("code") String code){
        System.out.println("code "+code);
        OauthToken oAuthToken = memberService.getAccessToken(code);

        System.out.println("access!!" + oAuthToken);

        Map<String, Object> result = memberService.saveMemberAndGetToken(oAuthToken.getAccess_token());

        Object jwtToken = result.get("jwtToken");

        Object member = result.get("member");

        System.out.println("JWT TOKEN!! " + jwtToken);
        HttpHeaders headers = new HttpHeaders();
        headers.add(JwtProperties.HEADER_STRING, JwtProperties.TOKEN_PREFIX + jwtToken);

        return ResponseEntity.ok().headers(headers).body(member);
    }

    @GetMapping("/login")
    public ResponseEntity getLogin(@RequestParam("token") String token){

//        OauthToken oAuthToken = memberService.getAccessToken(code);
//
//        System.out.println("access!!" + oAuthToken);

        Map<String, Object> result = memberService.saveMemberAndGetToken(token);

        Object jwtToken = result.get("jwtToken");

        Object member = result.get("member");

        System.out.println("JWT TOKEN!! " + jwtToken);
        HttpHeaders headers = new HttpHeaders();
        headers.add(JwtProperties.HEADER_STRING, JwtProperties.TOKEN_PREFIX + jwtToken);

        return ResponseEntity.ok().headers(headers).body(member);
    }
//
//    @GetMapping("update/nickname")
//    public ResponseEntity updateNickname(@RequestBody )
}
