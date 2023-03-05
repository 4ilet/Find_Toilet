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

    private String password;

    @Column(name = "refreshToken")
    private String refreshToken;

    @OneToMany(mappedBy = "member")
    private List<Folder> folderList = new ArrayList<>();

    @Enumerated(EnumType.STRING)
    private Role role;

    @Enumerated(EnumType.STRING)
    private SocialType socialType;

    private String socialId;

//    public void updateMember(MemberUpdateDto memberUpdateDto){
//        this.nickname = memberUpdateDto.getNickName();
//    }

//    public Member update(String nickname){
//        this.nickname = nickname;
//        return this;
//    }

     @Builder
    public Member(String email, String nickname, String refreshToken){
         this.email = email;
         this.nickname = nickname;
         this.refreshToken = refreshToken;
         this.role = Role.USER;
     }

     public void updateRefreshToken(String updateRefreshToken){

         this.refreshToken = updateRefreshToken;
     }
}
