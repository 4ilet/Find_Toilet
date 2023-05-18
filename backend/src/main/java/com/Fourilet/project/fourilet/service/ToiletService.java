package com.Fourilet.project.fourilet.service;

import com.Fourilet.project.fourilet.data.entity.*;
import com.Fourilet.project.fourilet.data.repository.*;
import com.Fourilet.project.fourilet.dto.ToiletDto;
import com.Fourilet.project.fourilet.dto.ToiletGetCondition;
import com.Fourilet.project.fourilet.dto.ToiletSearchCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

@Service
public class ToiletService {
    @Autowired
    ToiletRepository toiletRepository;
    @Autowired
    ReviewRepository reviewRepository;
    @Autowired
    MemberRepository memberRepository;
    @Autowired
    BookMarkRepository bookMarkRepository;
    @Autowired
    FolderRepository folderRepository;

    public Page<ToiletDto> getNearToilet(Long memberId, BigDecimal nowLon, BigDecimal nowLat, Long radius, Boolean allDay, Boolean disabled, Boolean kids, Boolean diaper, Pageable pageable) {

        ToiletGetCondition condition = new ToiletGetCondition(memberId, nowLat, nowLon, radius, allDay, disabled, kids, diaper);
        Page<ToiletDto> result = toiletRepository.nearByToilet(condition, pageable);

        Member member = null;

        if(memberId != null){
            member = memberRepository.findById(memberId).orElse(null);
        }

        for(ToiletDto toiletDto : result) {
            Long distance = toiletRepository.calDistance(condition.getNowLon(), condition.getNowLat(), toiletDto.getToiletId());
            toiletDto.setDistance(distance);
            long alreadyReviewed = 0; // 리뷰를 작성한 적이 있다면 해당 reviewId를, 리뷰 작성한 적이 없다면 0
            if(member != null) {
                // 해당 화장실의 리뷰 목록
                Toilet toilet = toiletRepository.findById(toiletDto.getToiletId()).orElse(null);
                List<Review> reviewList = reviewRepository.findAllByToilet(toilet);
                for (Review review : reviewList) {
                    if (review.getMember().getMemberId() == memberId) { // 리뷰의 작성자와 현재 접속한 유저의 아이디가 같다면? : 리뷰를 작성한 유저이다.
                        alreadyReviewed = review.getReviewId();
                    }
                }
                // 로그인한 상태라면 유저가 해당 화장실을 북마크했는지 확인
                List<Folder> folderList = folderRepository.findAllByMember(member);
                List<Long> isBookmark = bookMarkRepository.isBookmark(folderList, toiletDto.getToiletId()).orElseGet(() -> new ArrayList<>());
                toiletDto.setFolderId(isBookmark);
            }
            else{
                toiletDto.setFolderId(new ArrayList<>());
            }
            toiletDto.setReviewId(alreadyReviewed);
        }
        return result;
    }

    public Page<ToiletDto> getSearchToilet(Long memberId, BigDecimal nowLon, BigDecimal nowLat, Boolean allDay, Boolean disabled, Boolean kids, Boolean diaper, String keyword, String order, Pageable pageable) {
        ToiletSearchCondition condition = new ToiletSearchCondition(memberId, nowLat, nowLon, allDay, disabled, kids, diaper, keyword, order);
        Member member = null;

        if(memberId != null){
            member = memberRepository.findById(memberId).orElse(null);
        }

        Page<ToiletDto> result = null;

        if(order.equals("distance") || order == null){
            result = toiletRepository.searchToiletDistance(condition, pageable);
        }else if(order.equals("score")){
            result = toiletRepository.searchToiletScore(condition, pageable);
        }else if(order.equals("comment")){
            result = toiletRepository.searchToiletComment(condition, pageable);
        }else{
            throw new IllegalArgumentException();
        }

        for(ToiletDto toiletDto : result) {
            Long distance = toiletRepository.calDistance(condition.getNowLon(), condition.getNowLat(), toiletDto.getToiletId());
            toiletDto.setDistance(distance);
            long alreadyReviewed = 0; // 리뷰를 작성한 적이 있다면 해당 reviewId를, 리뷰 작성한 적이 없다면 0
            // memberId != null -> 로그인한 상태
            if(member != null){
                // 해당 화장실의 리뷰 목록
                Toilet toilet = toiletRepository.findById(toiletDto.getToiletId()).orElse(null);
                List<Review> reviewList = reviewRepository.findAllByToilet(toilet);
                for (Review review : reviewList) {
                    if (review.getMember().getMemberId() == memberId) { // 리뷰의 작성자와 현재 접속한 유저의 아이디가 같다면? : 리뷰를 작성한 유저이다.
                        alreadyReviewed = review.getReviewId();
                    }
                }
                // 로그인한 상태라면 유저가 해당 화장실을 북마크했는지 확인
                List<Folder> folderList = folderRepository.findAllByMember(member);
                // 폴더 ID가 없으면 빈 배열 넣어주기
                List<Long> isBookmark = bookMarkRepository.isBookmark(folderList, toiletDto.getToiletId()).orElseGet(() -> new ArrayList<>());
                toiletDto.setFolderId(isBookmark);
            }
            else{
                // member가 null이면 빈 배열 넣어주기
                toiletDto.setFolderId(new ArrayList<>());
            }
            toiletDto.setReviewId(alreadyReviewed);
        }
        return result;
    }
}
