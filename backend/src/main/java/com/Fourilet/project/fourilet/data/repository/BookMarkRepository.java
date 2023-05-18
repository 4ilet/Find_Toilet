package com.Fourilet.project.fourilet.data.repository;

import com.Fourilet.project.fourilet.data.entity.BookMark;
import com.Fourilet.project.fourilet.data.entity.Folder;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;


@Repository
public interface  BookMarkRepository extends JpaRepository<BookMark, Long> {
    Long countByFolder(Folder folder);
    List<BookMark> findAllByFolder(Folder folder);
    @Query(value = "select folder from bookmark where folder in :folderList and toilet = :toiletId"
    , nativeQuery = true)
    Optional<List<Long>> isBookmark(@Param("folderList") List<Folder> folderList, @Param("toiletId") long toiletId);
}
