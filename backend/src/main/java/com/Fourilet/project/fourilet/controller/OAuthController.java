package com.Fourilet.project.fourilet.controller;

import com.Fourilet.project.fourilet.dto.KakaoDto.OauthToken;
import com.Fourilet.project.fourilet.service.MemberService;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@AllArgsConstructor
@RequestMapping("/oauth2/code")
public class OAuthController {

    @Autowired
    private MemberService memberService;

    @GetMapping("/kakao")
    public ResponseEntity getServerLogin(@RequestParam("code") String code){
        OauthToken oAuthToken = memberService.getAccessToken(code);

        HttpHeaders headers = new HttpHeaders();

        return ResponseEntity.ok().headers(headers).body(oAuthToken.getAccess_token());
    }
}
