package com.Fourilet.project.fourilet.data.entity;

import com.fasterxml.jackson.annotation.JsonManagedReference;
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

    @Column(unique = true)
    private String nickname;

    @JsonManagedReference
    @OneToMany(mappedBy = "member", cascade = CascadeType.REMOVE)
    private List<Folder> folderList = new ArrayList<>();

    @JsonManagedReference
    @OneToMany(mappedBy = "member", cascade = CascadeType.REMOVE)
    private List<Review> reviewList = new ArrayList<>();

    @Column(name = "user_role")
    private String userRole;

    private Long kakaoId;

    private String refreshToken;

    public void updateRefreshToken(String updateRefreshToken){
        this.refreshToken = updateRefreshToken;
    }


     @Builder
    public Member(Long kakaoId, String email, String nickname, String refreshToken, String userRole){
         this.email = email;
         this.nickname = nickname;
         this.userRole = userRole;
         this.kakaoId = kakaoId;
         this.refreshToken = refreshToken;
     }
}
