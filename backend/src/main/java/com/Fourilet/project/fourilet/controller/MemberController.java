package com.Fourilet.project.fourilet.controller;
import com.Fourilet.project.fourilet.config.jwt.JwtProperties;
import com.Fourilet.project.fourilet.data.entity.Member;
import com.Fourilet.project.fourilet.service.MemberService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.AllArgsConstructor;
import org.apache.coyote.Response;
import org.hibernate.sql.Update;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Api(tags = "User API")
@RestController
@AllArgsConstructor
@RequestMapping("/user")
public class MemberController {
    @Autowired
    private MemberService memberService;

    @PostMapping("/login")
    @ApiOperation(value = "로그인 API", notes = "회원가입/로그인 합니다. 카카오에서 받은 AccessToken을 Body에 담아주세요!")
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
    @ApiOperation(value="정보 조회 API", notes = "유저의 정보를 조회합니다. 유저의 memberId 값을 parameter에 담아주세요!")
    public ResponseEntity<Member> getUser(@RequestParam("user_id") Long memberId){
        Member member = memberService.getMember(memberId);
        return ResponseEntity.ok().body(member);
    }

    @PutMapping("/update/nickname/{user_id}")
    @ApiOperation(value="닉네임 변경 API", notes = "유저의 닉네임을 변경합니다. 유저의 memberId 값을 path에 담아주시고, 변경할 닉네임을 Body에 담아주세요!")
    public ResponseEntity<Map<String, String>> updateNickname(@PathVariable Long user_id, @RequestBody Map<String, String> UpdateInfo){
        Member member = memberService.updateNickname(user_id, UpdateInfo.get("nickname"));
        Map<String, String> result = new HashMap<String, String>();
        result.put("success", member.getNickname());
        return ResponseEntity.ok().body(result);
    }


}