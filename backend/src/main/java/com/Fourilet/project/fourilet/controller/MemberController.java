package com.Fourilet.project.fourilet.controller;
import com.Fourilet.project.fourilet.config.jwt.JwtProperties;
import com.Fourilet.project.fourilet.config.jwt.service.JwtService;
import com.Fourilet.project.fourilet.data.entity.Member;
import com.Fourilet.project.fourilet.dto.LoginDto;
import com.Fourilet.project.fourilet.dto.Message;
import com.Fourilet.project.fourilet.dto.StatusEnum;
import com.Fourilet.project.fourilet.dto.UpdateNicknameDto;
import com.Fourilet.project.fourilet.service.MemberService;
import io.swagger.annotations.*;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import org.apache.coyote.Response;
import org.hibernate.sql.Update;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@Api(tags = "User API")
@RestController
@AllArgsConstructor
@RequestMapping("/user")
public class MemberController {
    @Autowired
    private MemberService memberService;
    private final JwtService jwtService;

    @PostMapping("/login")
    @ApiOperation(value = "로그인 API", notes = "회원가입/로그인 합니다. 카카오에서 받은 AccessToken을 Body에 담아주세요!")

    public ResponseEntity getLogin(@RequestBody LoginDto loginDto){

        Map<String, Object> result = memberService.saveMemberAndGetToken(loginDto.getToken());

        Object accessToken = result.get("accessToken");

        Object refreshToken = result.get("refreshToken");

        Object member = result.get("member");

        HttpHeaders headers = new HttpHeaders();

        headers.add("Authorization", "Bearer " + accessToken);
        headers.add("Authorization-refresh", "Bearer " + refreshToken);

        return ResponseEntity.ok().headers(headers).body(member);
    }

    @GetMapping("/userinfo")
    @ApiOperation(value="정보 조회 API", notes = "유저의 정보를 조회합니다. 토큰로 유저 id를 가져옵니다.")
    public ResponseEntity<Member> getUser(HttpServletRequest request){
        // 유효성 체크
        // 헤더에서 accessToken 가져오기 => Bearer 떼고 토큰만 추출
        String accessToken = request.getHeader("Authorization").replace("Bearer ", "");
        // accessToken으로 id 추출
        Long reqMemberId = jwtService.extractId(accessToken).get();

        Member member = memberService.getMember(reqMemberId);

        return ResponseEntity.ok().body(member);
    }

    @PutMapping("/update/nickname/{user_id}")
    @ApiOperation(value="닉네임 변경 API", notes = "유저의 닉네임을 변경합니다. 유저의 memberId 값을 path에 담아주시고, 변경할 닉네임을 Body에 담아주세요!")
    public ResponseEntity<?> updateNickname(HttpServletRequest request, @ApiParam(value = "유저의 memberId") @PathVariable Long user_id, @RequestBody UpdateNicknameDto updateNicknameDto){
        // 유효성 체크
        // 헤더에서 accessToken 가져오기 => Bearer 떼고 토큰만 추출
        String accessToken = request.getHeader("Authorization").replace("Bearer ", "");
        // accessToken으로 id 추출
        Long reqMemberId = jwtService.extractId(accessToken).get();

        Message message = new Message();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(new MediaType("application", "json", Charset.forName("UTF-8")));

        // 요청 보낸 사람 id와 조회하려는 정보의 id가 다르면 403 에러 리턴
        if(!reqMemberId.equals(user_id)){

            message.setStatus(StatusEnum.FORBIDDEN);
            message.setMessage("유저가 일치하지 않습니다.");

            return new ResponseEntity<>(message, headers, HttpStatus.FORBIDDEN);
        }

        // 일치하면 작업 수행
        Member member = memberService.updateNickname(user_id, updateNicknameDto.getNickname());
        Map<String, String> result = new HashMap<String, String>();
        result.put("success", member.getNickname());
        return ResponseEntity.ok().headers(headers).body(result);
    }


}