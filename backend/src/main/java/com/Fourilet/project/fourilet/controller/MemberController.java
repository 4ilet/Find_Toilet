package com.Fourilet.project.fourilet.controller;
import com.Fourilet.project.fourilet.config.jwt.JwtProperties;
import com.Fourilet.project.fourilet.data.entity.Member;
import com.Fourilet.project.fourilet.service.MemberService;
import lombok.AllArgsConstructor;
import org.apache.coyote.Response;
import org.hibernate.sql.Update;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@AllArgsConstructor
@RequestMapping("/user")
public class MemberController {
    @Autowired
    private MemberService memberService;

    @PostMapping("/login")
    public ResponseEntity getLogin(@RequestBody Map<String, String> accessToken){

//        OauthToken oAuthToken = memberService.getAccessToken(code);
//
//        System.out.println("access!!" + oAuthToken);

        Map<String, Object> result = memberService.saveMemberAndGetToken(accessToken.get("token"));

        Object jwtToken = result.get("jwtToken");

        Object member = result.get("member");

        System.out.println("JWT TOKEN!! " + jwtToken);
        HttpHeaders headers = new HttpHeaders();
        headers.add(JwtProperties.HEADER_STRING, JwtProperties.TOKEN_PREFIX + jwtToken);

        return ResponseEntity.ok().headers(headers).body(member);
    }

    @GetMapping("/userinfo")
    public ResponseEntity<Member> getUser(@RequestParam("user_id") Long memberId){
        Member member = memberService.getMember(memberId);
        return ResponseEntity.ok().body(member);
    }

    @PutMapping("/update/nickname/{user_id}")
    public ResponseEntity<Map<String, String>> updateNickname(@PathVariable Long user_id, @RequestBody Map<String, String> UpdateInfo){
        Member member = memberService.updateNickname(user_id, UpdateInfo.get("nickname"));
        Map<String, String> result = new HashMap<String, String>();
        result.put("success", member.getNickname());
        return ResponseEntity.ok().body(result);
    }

//    @PostMapping("/user/signup")
//    public signUp(){};

    //테스트
//    @PutMapping("/user/update/nickname/{user_id}")
//    public String updateUserNickname(){
//
//    }
}