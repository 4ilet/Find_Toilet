package com.Fourilet.project.fourilet.service;

import com.Fourilet.project.fourilet.data.entity.*;
import com.Fourilet.project.fourilet.data.repository.*;
import com.Fourilet.project.fourilet.dto.FolderDto;
import com.Fourilet.project.fourilet.dto.ToiletDto2;
import com.Fourilet.project.fourilet.exception.DuplicationNameException;
import com.Fourilet.project.fourilet.exception.LimitException;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

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
    private final ReviewRepository reviewRepository;
    public List<FolderDto.FolderListDto> getFolderList(long memberId) {
        LOGGER.info("call folderService.getFolderList");
        Member member = memberRepository.findById(memberId);
        List<Folder> memberFolderList = folderRepository.findAllByMember(member);
        if (memberFolderList == null || memberFolderList.isEmpty()) {
            throw new NullPointerException("즐겨찾기가 존재하지 않습니다.");
        }
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
        if (folder == null) {
            throw new NullPointerException("해당 폴더가 존재하지 않습니다.");
        }
        List<BookMark> bookmarkList = bookMarkRepository.findAllByFolder(folder);
        if (bookmarkList.size() > 0) {
            for (BookMark bookmark : bookmarkList) {
                bookMarkRepository.delete(bookmark);
            }
        }
        folderRepository.delete(folder);
    }

    public void updateFolderName(long folderId, FolderDto.UpdateFolderDto update){
        LOGGER.info("CALL UPDATE FOLDER NAME");
        Folder folder = folderRepository.findById(folderId).orElse(null);
        if (update.getFolderName().length() > 10){
            throw new IllegalArgumentException("폴더명은 10자 이내로 정해주세요");
        }

        folder.setFolderName(update.getFolderName());
        folderRepository.save(folder);
    }

    public void createFolder(long memberId, FolderDto.NewFolderDto newFolderDto) {
        LOGGER.info("CALL CREATE FOLDER");
        Member member = memberRepository.findById(memberId);
        List<Folder> folderList = folderRepository.findAllByMember(member);
        String DtoName = newFolderDto.getFolderName().toString();

        for (Folder EachFolder : folderList) {
            String EachFolderName = EachFolder.getFolderName().toString();
            if (EachFolderName.equals(DtoName)) {
                throw new DuplicationNameException("중복된 즐겨찾기 이름입니다.");
            }
        }
        if (newFolderDto.getFolderName().length() > 10){
            throw new IllegalArgumentException("폴더명은 10자 이내로 정해주세요");
        }
        if (folderList.size() > 10) {
            throw new LimitException("즐겨찾기는 10개 이상 생성하지 못합니다.");
        }
        if (member == null) {
            throw new NullPointerException("존재하지 않는 회원입니다.");
        }

        Folder folder = new Folder();
        folder.setFolderName(newFolderDto.getFolderName());
        folder.setMember(member);
        folderRepository.save(folder);
        }
    public void addToilet(long folderId, long toiletId){
        LOGGER.info("CALL ADD TOILET");
        Folder folder = folderRepository.findById(folderId).orElse(null);
        Toilet toilet = toiletRepository.findById(toiletId).orElse(null);
        if (folder == null | toilet == null){
            throw new NullPointerException("폴더 혹은 화장실이 존재하지 않습니다.");
        }
        List<BookMark> bookMarkList= bookMarkRepository.findAllByFolder(folder);
        for (BookMark bookmark : bookMarkList){
            if(bookmark.getToilet() == toilet) {
                throw new IllegalStateException("이미 즐겨찾기에 추가되어 있습니다.");
            }
        }
        BookMark bookMark = new BookMark();
        bookMark.setFolder(folder);
        bookMark.setToilet(toilet);
        bookMarkRepository.save(bookMark);
    }
    public void deleteToilet(long folderId, long toiletId){
        LOGGER.info("CALL DELETE TOILET");
        Folder folder = folderRepository.findById(folderId).orElse(null);
        Toilet toilet = toiletRepository.findById(toiletId).orElse(null);
        List<BookMark> bookMarkList = bookMarkRepository.findAllByFolder(folder);
        if (folder == null){
            throw new NullPointerException("즐겨찾기가 존재하지 않습니다");
        }
        boolean flag = false;
        for (BookMark bookmark : bookMarkList) {
            if (bookmark.getToilet() == toilet) {
                bookMarkRepository.delete(bookmark);
                flag = true;
            }
        }
        if (!flag){
            throw new NullPointerException("존재하지 않는 화장실입니다");
        }
    }
    public List<ToiletDto2> getToiletList(long folderId, Long memberId){
        LOGGER.info("CALL GET TOILET LIST");
        Member member = memberRepository.findById(memberId).orElse(null);
        Folder folder = folderRepository.findById(folderId).orElse(null);
        List<BookMark> bookMarkList = bookMarkRepository.findAllByFolder(folder); // 폴더아이디와 일치하는 모든 북마크를 가져온다.

        if (folder == null) {
            throw new NullPointerException("폴더가 존재하지 않습니다.");
        }

        List<ToiletDto2> toiletDtoList = new ArrayList<>();
        List<Toilet> toiletList = new ArrayList<>();
        long alreadyReviewed = 0; // 리뷰를 작성한 적이 있다면 해당 reviewId를, 리뷰 작성한 적이 없다면 0

        for (BookMark bookmark : bookMarkList){
            Toilet toilet = bookmark.getToilet();
            toiletList.add(toilet);
        }

        for (Toilet toilet : toiletList){
            ToiletDto2 toiletDto2 = new ToiletDto2();
            // 해당 화장실의 모든 리뷰 목록을 reviewList에 저장,
            List<Review> reviewList = reviewRepository.findAllByToilet(toilet);
            float total = 0;

            for (Review review : reviewList) {
                float score = review.getScore();
                total += score;
                if(review.getMember() == member){ // 리뷰의 작성자와 현재 접속한 유저의 아이디가 같다면? : 리뷰를 작성한 유저이다.
                    alreadyReviewed = review.getReviewId();
                }
            }

            float average = 0;
            if (reviewList.size() == 0){
                toiletDto2.setScore(average);
                toiletDto2.setComment(reviewList.size());

            } else {
                average = total / reviewList.size();
                toiletDto2.setScore(average);
                toiletDto2.setComment(reviewList.size());
            }

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

            if(memberId == null){
                toiletDto2.setFolderId(0L); // 0L : 롱타입 0으로~
                toiletDto2.setReviewId(0L); // 0 인거죠 ~ 리뷰 작성하기 버튼이 보일꺼고,
            }else{
                toiletDto2.setReviewId(alreadyReviewed); // 0인 경우 리뷰 쓴 적 없음, 0이 아니면 해당 리뷰 쓴거임~!
                Long isBookmark = toiletRepository.isBookmark(memberId, toilet.getToiletId());
                if(isBookmark != 0){
                    toiletDto2.setFolderId(isBookmark);
                }else{
                    toiletDto2.setFolderId(0L);
                }
            }

            toiletDtoList.add(toiletDto2);

        }
        return toiletDtoList;
    }
}
