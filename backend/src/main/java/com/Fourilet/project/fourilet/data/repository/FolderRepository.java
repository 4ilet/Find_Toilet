package com.Fourilet.project.fourilet.data.repository;

import com.Fourilet.project.fourilet.data.entity.Folder;
import com.Fourilet.project.fourilet.data.entity.Member;
import com.Fourilet.project.fourilet.dto.FolderDto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface FolderRepository extends JpaRepository<Folder, Long> {
    List<Folder> findAllByMember(Member member);

    @Override
    Optional<Folder> findById(Long folderId);
}