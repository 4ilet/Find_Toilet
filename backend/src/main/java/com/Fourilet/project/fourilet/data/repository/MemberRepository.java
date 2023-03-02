package com.Fourilet.project.fourilet.data.repository;

import com.Fourilet.project.fourilet.data.entity.MemberEntity;
import org.springframework.data.jpa.repository.JpaRepository;
public interface MemberRepository extends JpaRepository<MemberEntity, Long> {
    // JpaRepository<Entity Class, PK 타입>을 상속하면 기본적인 crud 메서드가 자동으로 생성됨.
}
