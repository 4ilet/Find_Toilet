package com.Fourilet.project.fourilet.service;

//import com.Fourilet.project.fourilet.config.oauth2.CustomOAuth2User;
import com.Fourilet.project.fourilet.data.entity.BookMark;
import com.Fourilet.project.fourilet.data.entity.Folder;
import com.Fourilet.project.fourilet.data.entity.Member;
import com.Fourilet.project.fourilet.data.repository.BookMarkRepository;
import com.Fourilet.project.fourilet.data.repository.FolderRepository;
import com.Fourilet.project.fourilet.data.repository.MemberRepository;
import com.Fourilet.project.fourilet.dto.FolderDto;
import com.Fourilet.project.fourilet.dto.KakaoDto.KakaoProfile;
import com.Fourilet.project.fourilet.dto.KakaoDto.OauthToken;
import com.Fourilet.project.fourilet.config.jwt.service.JwtService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class MemberService {

    private final MemberRepository memberRepository;
    private final FolderRepository folderRepository;
    private final BookMarkRepository bookMarkRepository;
    private final FolderService folderService;
    private final JwtService jwtService;

    @Value("${spring.security.oauth2.client.registration.kakao.client-secret}")
    String client_secret;

    @Value("${spring.security.oauth2.client.registration.kakao.client-id}")
    String client_id;

    @Value("${spring.security.oauth2.client.registration.kakao.redirect-uri}")
    String redirect_uri;


    public OauthToken getAccessToken(String code){
        RestTemplate rt = new RestTemplate();

        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("grant_type", "authorization_code");
        params.add("client_id", client_id);
        params.add("redirect_uri", redirect_uri);
        params.add("code", code);
        params.add("client_secret", client_secret);

        HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = new HttpEntity<>(params, headers);

        ResponseEntity<String> accessTokenResponse = rt.exchange(
                "https://kauth.kakao.com/oauth/token",
                HttpMethod.POST,
                kakaoTokenRequest,
                String.class
        );

        ObjectMapper objectMapper = new ObjectMapper();
        OauthToken oauthToken = null;
        try {
            oauthToken = objectMapper.readValue(accessTokenResponse.getBody(), OauthToken.class);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }

        return oauthToken;
    }

    public Map<String, Object> saveMemberAndGetToken(String token){

        Map<String, Object> result = new HashMap<String, Object>();

        KakaoProfile profile = findProfile(token);

        String email = profile.getKakao_account().getEmail();

        Member member = memberRepository.findByEmail(email).orElse(null);
        Folder folder = new Folder();
        if(member == null){
            member = memberRepository.save(Member.builder()
                .kakaoId(profile.getId())
                .nickname(profile.getKakao_account().getProfile().getNickname())
                .email(profile.getKakao_account().getEmail())
                .userRole("USER")
                .build());
            // 회원가입을 한 멤버를 저장할 때, 기본 즐겨찾기 폴더 설정
            folder.setMember(member);
            folder.setFolderName("기본 즐겨찾기 폴더");
            folderRepository.save(folder);
        }

        String accessToken = jwtService.createAccessToken(email, member.getMemberId());
        String refreshToken = jwtService.createRefreshToken();

        member.setRefreshToken(refreshToken);
        memberRepository.save(member);
////      회원을 저장할 때, 기본 즐겨찾기 폴더 설정 부분
//        folder.setMember(member);
//        folder.setFolderName("기본 즐겨찾기 폴더");
//        folderRepository.save(folder);

        jwtService.updateRefreshToken(email, refreshToken);

        result.put("member", member);
        result.put("accessToken", accessToken);
        result.put("refreshToken", refreshToken);

        return result;
    }

    public KakaoProfile findProfile(String token){
        RestTemplate rt = new RestTemplate();

        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "Bearer " + token);
        headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

        HttpEntity<MultiValueMap<String, String>> kakaoProfileRequest = new HttpEntity<>(headers);

        ResponseEntity<String> kakaoProfileResponse = rt.exchange(
                "https://kapi.kakao.com/v2/user/me",
                HttpMethod.POST,
                kakaoProfileRequest,
                String.class
        );

        ObjectMapper objectMapper = new ObjectMapper();
        KakaoProfile kakaoProfile = null;

        try{
            kakaoProfile = objectMapper.readValue(kakaoProfileResponse.getBody(), KakaoProfile.class);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }

        return kakaoProfile;
    }

    public Member getMember(long memberId){
        System.out.println("엥?? " + memberRepository.findById(memberId));
        return memberRepository.findById(memberId);
    }

    public Member updateNickname(long memberId, String nickname){
        Member member = memberRepository.findById(memberId);
        member.setNickname(nickname);
        return memberRepository.save(member);
    }

    public void deleteMember(long memberId){

        Member member = memberRepository.findById(memberId);
        List<Folder> memberFolderList = folderRepository.findAllByMember(member);

        System.out.println("폴더리스트예용 " + memberFolderList);

        for(Folder folder : memberFolderList) {
            List<BookMark> bookmarkList = bookMarkRepository.findAllByFolder(folder);
            if (bookmarkList.size() > 0) {
                for (BookMark bookmark : bookmarkList) {
                    bookMarkRepository.delete(bookmark);
                }
            }
        }

        memberRepository.deleteById(memberId);
    }
}
