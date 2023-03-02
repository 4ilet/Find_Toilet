package com.Fourilet.project.fourilet.data.entity;

import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
@Getter
@NoArgsConstructor
@Entity

public class MemberEntity {
    @Id // PK 필드임을 표현
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    // PK 생성규칙, Spring boot 2.0 GenetrationType.IDENTITY 옵션을 추가해야 AUTO_INCREMENT가 된다.
    private Long user_id;

    @Column // 테이블의 컬럼을 표현
    private String email;

    @Column
    private String refreshToken;

    @Column
    private String accessToken;

}
