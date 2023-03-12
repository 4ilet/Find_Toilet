package com.Fourilet.project.fourilet.data.repository;



import com.Fourilet.project.fourilet.data.entity.Member;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface MemberRepository extends JpaRepository<Member, Long> {
    Member findByMemberId(Long memberId);
    Member findById(long memberId);
    Member findByEmail(String email);

}


