package com.Fourilet.project.fourilet.data.repository;



import com.Fourilet.project.fourilet.data.entity.Member;
import com.Fourilet.project.fourilet.data.entity.SocialType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface MemberRepository extends JpaRepository<Member, Long> {
    Member findById(long memberId);
    Member findByEmail(String email);
    Member findByRefreshToken(String refreshToken);

    Member findBySocialTypeAndSocialId(SocialType socialType, String socialId);

}


