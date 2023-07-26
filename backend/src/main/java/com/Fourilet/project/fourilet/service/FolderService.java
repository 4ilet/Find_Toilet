package com.Fourilet.project.fourilet.service;

import com.Fourilet.project.fourilet.data.entity.*;
import com.Fourilet.project.fourilet.data.repository.*;
import com.Fourilet.project.fourilet.dto.FolderDto;
import com.Fourilet.project.fourilet.dto.ToiletDto2;
import com.Fourilet.project.fourilet.exception.AtLeastException;
import com.Fourilet.project.fourilet.exception.DuplicationNameException;
import com.Fourilet.project.fourilet.exception.LimitException;
import lombok.RequiredArgsConstructor;
import org.aspectj.weaver.ast.Not;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.PageRequest;
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

    public void deleteFolder(long folderId, long memberId) throws Exception {
        Member member = memberRepository.findById(memberId);
        Folder folder = folderRepository.findById(folderId).orElse(null);
        List<Folder> folderList = folderRepository.findAllByMember(member);


        if (folder == null) {
            throw new NullPointerException("해당 폴더가 존재하지 않습니다.");
        }

        if (folderList.size() > 1){
            List<BookMark> bookmarkList = bookMarkRepository.findAllByFolder(folder);
            if (bookmarkList.size() > 0) {
                for (BookMark bookmark : bookmarkList) {
                    bookMarkRepository.delete(bookmark);
                }
            }
            folderRepository.delete(folder);
        } else {
            throw new AtLeastException();
        }
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
    public void AddDeleteToilet(FolderDto.AddOrDelToiletDto addOrDelToiletDto){
        LOGGER.info("CALL ADD TOILET");
        Toilet toilet  = toiletRepository.findById(addOrDelToiletDto.getToiletId()).orElse(null);
        List<Long> AddfolderIdList = addOrDelToiletDto.getAddFolderIdList();

        if (!AddfolderIdList.isEmpty()){
            for (long folderId : AddfolderIdList){
                Folder folder = folderRepository.findById(folderId).orElse(null);
                List<BookMark> bookMarkList= bookMarkRepository.findAllByFolder(folder);

                if (toilet == null | folder == null){
                    throw new NullPointerException("폴더 혹은 화장실이 존재하지 않습니다.");
                }
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
        }

        List<Long> DelfolderIdList = addOrDelToiletDto.getDelFolderIdList();
        if(!DelfolderIdList.isEmpty()){
            for (long folderId : DelfolderIdList ){
                Folder folder = folderRepository.findById(folderId).orElse(null);
                List<BookMark> bookMarkList= bookMarkRepository.findAllByFolder(folder);

                if (toilet == null | folder == null){
                    throw new NullPointerException("폴더 혹은 화장실이 존재하지 않습니다.");
                }

                boolean flag = false;
                for (BookMark bookmark : bookMarkList) {
                    if (bookmark.getToilet() == toilet) {
                        bookMarkRepository.delete(bookmark);
                        flag = true;
                    }
                }
                if (!flag) {
                    throw new NullPointerException("존재하지 않는 화장실입니다");
                }
            }
        }
    }

    public ToiletDto2.ToiletDto2WithSize getToiletList(long folderId, Long memberId, int page){
        LOGGER.info("CALL GET TOILET LIST");
        Member member = memberRepository.findById(memberId).orElse(null);
        Folder folder = folderRepository.findById(folderId).orElse(null);
        PageRequest pageRequest = PageRequest.of(page, 10);
        List<BookMark> bookMarkList = bookMarkRepository.findAllByFolder(folder, pageRequest); 
        int size = ((bookMarkRepository.findAllByFolder(folder).size() - 1) / 10) + 1 ;
        if (folder == null) {
            throw new NullPointerException("폴더가 존재하지 않습니다.");
        }

        List<ToiletDto2> toiletDtoList = new ArrayList<>();
        List<Toilet> toiletList = new ArrayList<>();

        for (BookMark bookmark : bookMarkList){
            Toilet toilet = bookmark.getToilet();
            toiletList.add(toilet);
        }

        for (Toilet toilet : toiletList){
            long alreadyReviewed = 0; 
            ToiletDto2 toiletDto2 = new ToiletDto2();
            List<Review> reviewList = reviewRepository.findAllByToilet(toilet);
            float total = 0;

            for (Review review : reviewList) {
                float score = review.getScore();
                total += score;
                if(review.getMember() == member){
                    alreadyReviewed = review.getReviewId();
                }
            }

            float average = 0;
            if (reviewList.size() == 0){
                toiletDto2.setScore(average);
                toiletDto2.setComment(reviewList.size());

            } else {
                average = Float.parseFloat(String.format("%2f", total / reviewList.size()));
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
                toiletDto2.setFolderId(new ArrayList<>()); 
                toiletDto2.setReviewId(0L); 
            }else{
                toiletDto2.setReviewId(alreadyReviewed); 
                List<Folder> folderList = folderRepository.findAllByMember(member);
                List<Long> isBookmark = bookMarkRepository.isBookmark(folderList, toilet.getToiletId()).orElseGet(() -> new ArrayList<>());
                toiletDto2.setFolderId(isBookmark);
            }

            toiletDtoList.add(toiletDto2);

        }
        ToiletDto2.ToiletDto2WithSize result = new ToiletDto2.ToiletDto2WithSize();
        result.setTotalPage(size);
        result.setResponse(toiletDtoList);
        return result;
    }


}

