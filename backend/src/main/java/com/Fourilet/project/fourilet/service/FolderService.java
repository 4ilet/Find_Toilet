package com.Fourilet.project.fourilet.service;

import com.Fourilet.project.fourilet.data.entity.BookMark;
import com.Fourilet.project.fourilet.data.entity.Folder;
import com.Fourilet.project.fourilet.data.entity.Member;
import com.Fourilet.project.fourilet.data.entity.Toilet;
import com.Fourilet.project.fourilet.data.repository.BookMarkRepository;
import com.Fourilet.project.fourilet.data.repository.FolderRepository;
import com.Fourilet.project.fourilet.data.repository.MemberRepository;
import com.Fourilet.project.fourilet.data.repository.ToiletRepository;
import com.Fourilet.project.fourilet.dto.FolderDto;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.awt.print.Book;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class FolderService {
    private final Logger LOGGER = LoggerFactory.getLogger(FolderService.class);
    private final FolderRepository folderRepository;
    private final MemberRepository memberRepository;
    private final BookMarkRepository bookMarkRepository;
    private final ToiletRepository toiletRepository;
    public List<FolderDto.FolderListDto> getFolderList(long memberId) {
        LOGGER.info("call folderServiceIm.getFolderList");
        Member member = memberRepository.findById(memberId);
        List<Folder> memberFolderList = folderRepository.findAllByMember(member);
        List<FolderDto.FolderListDto> folderListDto = new ArrayList<>();

        for (Folder folder : memberFolderList) {
            FolderDto.FolderListDto folderListDto1 = new FolderDto.FolderListDto();
            folderListDto1.setFolderId(folder.getFolderId());
            folderListDto1.setFolderName(folder.getFolderName());
            folderListDto1.setFolderLen(bookMarkRepository.countByFolder(folder));

            folderListDto.add(folderListDto1);
        }
        return folderListDto;
    }

    // null일때 예외처리해야함.
    public void deleteFolder(long folderId) {
        Folder folder = folderRepository.findById(folderId).orElse(null);
//        System.out.println(folder.getFolderName());
        List<BookMark> bookmarkList = bookMarkRepository.findAllByFolder(folder);
//        System.out.println(bookmarkList.size());
        if (bookmarkList.size() > 0) {
            for (BookMark bookmark : bookmarkList) {
                bookMarkRepository.delete(bookmark);
            }
        }
        folderRepository.delete(folder);
    }

    public ResponseEntity<?> updateFolderName(long folderId, FolderDto folderDto){
        LOGGER.info("CALL UPDATE FOLDER NAME");
        Folder folder = folderRepository.findById(folderId).orElse(null);
        folder.setFolderName(folderDto.getFolderName());
        folderRepository.save(folder);

        return new ResponseEntity<>(HttpStatus.OK);
    }

    public ResponseEntity<?> createFolder(long memberId, FolderDto newFolderDto) {
        LOGGER.info("CALL CREATE FOLDER");
        Member member =  memberRepository.findById(memberId);
        Folder folder = new Folder();
        folder.setFolderName(newFolderDto.getFolderName());
        folder.setMember(member);
        folderRepository.save(folder);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    public ResponseEntity<?> addToilet(long folderId, long toiletId){
        LOGGER.info("CALL ADD TOILET");
        Folder folder = folderRepository.findById(folderId).orElse(null);
        Toilet toilet = toiletRepository.findById(toiletId).orElse(null);
        System.out.println("토일렛도?" + toilet.getToiletId());
        BookMark bookMark = new BookMark();

        bookMark.setFolder(folder);
        bookMark.setToilet(toilet);

        bookMarkRepository.save(bookMark);
        return new ResponseEntity<>(HttpStatus.OK);
    }
    public ResponseEntity<?> deleteToilet(long folderId, long toiletId){
        LOGGER.info("CAA DELETE TOILET");
        Folder folder = folderRepository.findById(folderId).orElse(null);
        Toilet toilet = toiletRepository.findById(toiletId).orElse(null);

        List<BookMark> bookmarkList = bookMarkRepository.findAllByFolder(folder);
        for (BookMark bookmark : bookmarkList) {
            if (bookmark.getToilet() == toilet){
                bookMarkRepository.delete(bookmark);

            }
        }
        return new ResponseEntity<>(HttpStatus.OK);
    }
}
