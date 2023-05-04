package com.Fourilet.project.fourilet.service;

import com.Fourilet.project.fourilet.data.entity.BookMark;
import com.Fourilet.project.fourilet.data.entity.Folder;
import com.Fourilet.project.fourilet.data.entity.Review;
import com.Fourilet.project.fourilet.data.entity.Toilet;
import com.Fourilet.project.fourilet.data.repository.ReviewRepository;
import com.Fourilet.project.fourilet.data.repository.ToiletRepository;
import com.Fourilet.project.fourilet.dto.ToiletDto;
import com.Fourilet.project.fourilet.dto.ToiletGetCondition;
import com.Fourilet.project.fourilet.dto.ToiletSearchCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.List;

@Service
public class ToiletService {
    @Autowired
    ToiletRepository toiletRepository;
    @Autowired
    ReviewRepository reviewRepository;
    public Page<ToiletDto> getNearToilet(Long memberId, BigDecimal nowLon, BigDecimal nowLat, Long radius, Boolean allDay, Boolean disabled, Boolean kids, Boolean diaper, Pageable pageable) {
        ToiletGetCondition condition = new ToiletGetCondition(memberId, nowLat, nowLon, radius, allDay, disabled, kids, diaper);
        Page<ToiletDto> result = toiletRepository.nearByToilet(condition, pageable);

        for(ToiletDto toiletDto : result) {
            Long distance = toiletRepository.calDistance(condition.getNowLon(), condition.getNowLat(), toiletDto.getToiletId());
            toiletDto.setDistance(distance);
            long alreadyReviewed = 0; // 리뷰를 작성한 적이 있다면 해당 reviewId를, 리뷰 작성한 적이 없다면 0
            long alreadyBookmarked = 0;
            if(memberId != null) {
                // 해당 화장실의 리뷰 목록
                Toilet toilet = toiletRepository.findById(toiletDto.getToiletId()).orElse(null);
                List<Review> reviewList = reviewRepository.findAllByToilet(toilet);
                for (Review review : reviewList) {
                    if (review.getMember().getMemberId() == memberId) { // 리뷰의 작성자와 현재 접속한 유저의 아이디가 같다면? : 리뷰를 작성한 유저이다.
                        alreadyReviewed = review.getReviewId();
                    }
                }
                // 로그인한 상태라면 유저가 해당 화장실을 북마크했는지 확인
                Long isBookmark = toiletRepository.isBookmark(memberId, toiletDto.getToiletId());
                if(isBookmark != 0){
                    // 북마크했다면 폴더 아이디를 넣어줌
                    alreadyBookmarked = isBookmark;
                }
            }
            toiletDto.setReviewId(alreadyReviewed);
            toiletDto.setFolderId(alreadyBookmarked);
        }
        return result;
    }

    public Page<ToiletDto> getSearchToilet(Long memberId, BigDecimal nowLon, BigDecimal nowLat, Boolean allDay, Boolean disabled, Boolean kids, Boolean diaper, String keyword, String order, Pageable pageable) {
        ToiletSearchCondition condition = new ToiletSearchCondition(memberId, nowLat, nowLon, allDay, disabled, kids, diaper, keyword, order);


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
            long alreadyBookmarked = 0;
            // memberId != null -> 로그인한 상태
            if(memberId != null){
                // 해당 화장실의 리뷰 목록
                Toilet toilet = toiletRepository.findById(toiletDto.getToiletId()).orElse(null);
                List<Review> reviewList = reviewRepository.findAllByToilet(toilet);
                for (Review review : reviewList) {
                    if (review.getMember().getMemberId() == memberId) { // 리뷰의 작성자와 현재 접속한 유저의 아이디가 같다면? : 리뷰를 작성한 유저이다.
                        alreadyReviewed = review.getReviewId();
                    }
                }
                // 로그인한 상태라면 유저가 해당 화장실을 북마크했는지 확인
                Long isBookmark = toiletRepository.isBookmark(memberId, toiletDto.getToiletId());
                if(isBookmark != 0){
                    // 북마크했다면 폴더 아이디를 넣어줌
                    alreadyBookmarked = isBookmark;
                }
            }
            toiletDto.setReviewId(alreadyReviewed);
            toiletDto.setFolderId(alreadyBookmarked);
        }
        return result;
    }
}
