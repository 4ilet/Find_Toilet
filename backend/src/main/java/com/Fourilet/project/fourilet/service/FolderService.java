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
import com.Fourilet.project.fourilet.dto.ToiletDto;
import com.Fourilet.project.fourilet.dto.ToiletDto2;
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
        LOGGER.info("call folderService.getFolderList");
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

    public void deleteFolder(long folderId) {
        Folder folder = folderRepository.findById(folderId).orElse(null);
        List<BookMark> bookmarkList = bookMarkRepository.findAllByFolder(folder);
        if (bookmarkList.size() > 0) {
            for (BookMark bookmark : bookmarkList) {
                bookMarkRepository.delete(bookmark);
            }
        }
        folderRepository.delete(folder);
    }

    public void updateFolderName(long folderId, FolderDto folderDto){
        LOGGER.info("CALL UPDATE FOLDER NAME");
        Folder folder = folderRepository.findById(folderId).orElse(null);
        folder.setFolderName(folderDto.getFolderName());
        folderRepository.save(folder);
    }

    public void createFolder(long memberId, FolderDto.NewFolderDto newFolderDto) {
        LOGGER.info("CALL CREATE FOLDER");
        Member member =  memberRepository.findById(memberId);
        if (member == null) {
            throw new NullPointerException("존재하지 않는 회원입니다.");
        }
        Folder folder = new Folder();
        folder.setFolderName(newFolderDto.getFolderName());
        folder.setMember(member);
        folderRepository.save(folder);
    }

    public ResponseEntity<?> addToilet(long folderId, long toiletId){
        LOGGER.info("CALL ADD TOILET");
        Folder folder = folderRepository.findById(folderId).orElse(null);
        Toilet toilet = toiletRepository.findById(toiletId).orElse(null);
        BookMark bookMark = new BookMark();

        bookMark.setFolder(folder);
        bookMark.setToilet(toilet);

        bookMarkRepository.save(bookMark);
        return new ResponseEntity<>(HttpStatus.OK);
    }
    public ResponseEntity<?> deleteToilet(long folderId, long toiletId){
        LOGGER.info("CALL DELETE TOILET");
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
    public List<ToiletDto2> getToiletList(long folderId){
        LOGGER.info("CALL GET TOILET LIST");
        Folder folder = folderRepository.findById(folderId).orElse(null);
        List<BookMark> bookMarkList = bookMarkRepository.findAllByFolder(folder); // 폴더아이디와 일치하는 모든 북마크를 가져온다.

        List<ToiletDto2> toiletDtoList = new ArrayList<>();
        List<Toilet> toiletList = new ArrayList<>();

        for (BookMark bookmark : bookMarkList){
            Toilet toilet = bookmark.getToilet();
            System.out.println(toilet.getToiletName());
            toiletList.add(toilet);
        }

        for (Toilet toilet : toiletList){
            ToiletDto2 toiletDto2 = new ToiletDto2();
            toiletDto2.setToiletId(toilet.getToiletId());
            toiletDto2.setToiletName(toilet.getToiletName());
            toiletDto2.setAddress(toilet.getAddress());
            toiletDto2.setOperationTime(toilet.getOperationTime());
            toiletDto2.setLat(toilet.getLat());
            toiletDto2.setLon(toilet.getLon());
            toiletDto2.setPhoneNumber(toilet.getPhoneNumber());
            toiletDto2.setDMalePee(toilet.isDMalePee());
            toiletDto2.setDMalePoo(toilet.isDMalePoo());
            toiletDto2.setDFemalePoo(toilet.isDFemalePoo());
            toiletDto2.setCFemalePoo(toilet.isCFemalePoo());
            toiletDto2.setCMalePee(toilet.isCMalePee());
            toiletDto2.setCMalePoo(toilet.isCMalePoo());
            toiletDto2.setAllDay(toilet.isAllDay());
            toiletDto2.setDiaper(toilet.isDiaper());
            toiletDtoList.add(toiletDto2);
        }
        return toiletDtoList;
    }
}
