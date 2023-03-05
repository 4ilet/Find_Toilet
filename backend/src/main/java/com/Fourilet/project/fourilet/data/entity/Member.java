package com.Fourilet.project.fourilet.data.entity;

import lombok.*;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name="member")
public class Member {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "memberId")
    private long memberId;

    @Column(nullable = false)
    private String email;

    @Column(nullable = false)
    private String nickname;

    @OneToMany(mappedBy = "member")
    private List<Folder> folderList = new ArrayList<>();

    @Column(name = "user_role")
    private String userRole;

    private Long kakaoId;

//    public void updateMember(MemberUpdateDto memberUpdateDto){
//        this.nickname = memberUpdateDto.getNickName();
//    }

//    public Member update(String nickname){
//        this.nickname = nickname;
//        return this;
//    }

     @Builder
    public Member(Long kakaoId, String email, String nickname, String refreshToken, String userRole){
         this.email = email;
         this.nickname = nickname;
         this.userRole = userRole;
         this.kakaoId = kakaoId;
     }
}
