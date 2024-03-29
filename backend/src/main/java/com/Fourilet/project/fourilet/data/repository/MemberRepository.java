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
    Optional<Member> findByRefreshToken(String refreshToken);

    Optional<Member> findByNickname(String nickname);

}

