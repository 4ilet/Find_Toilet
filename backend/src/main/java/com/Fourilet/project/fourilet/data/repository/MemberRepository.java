package com.Fourilet.project.fourilet.data.repository;



import com.Fourilet.project.fourilet.data.entity.Member;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface MemberRepository extends JpaRepository<Member, Long> {
    Member findById(long memberId);
    Optional<Member> findByEmail(String email);
//    List<Member> findAllByMember(Member member);
    Optional<Member> findByRefreshToken(String refreshToken);


    Member findByMemberId(Member member);

    Optional<Member> findByKakaoId(Long kakaoId);

}

