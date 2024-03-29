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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    public Map<String, Object> getNearToilet(Long memberId, BigDecimal nowLon, BigDecimal nowLat, Long radius, Boolean allDay, Boolean disabled, Boolean kids, Boolean diaper, Pageable pageable) {

        ToiletGetCondition condition = new ToiletGetCondition(memberId, nowLat, nowLon, radius, allDay, disabled, kids, diaper);
        Page<ToiletDto> item = toiletRepository.nearByToilet(condition, pageable);
        Map<String, Object> result = new HashMap<>();
        Member member = null;

        if(memberId != null){
            member = memberRepository.findById(memberId).orElse(null);
        }

        for(ToiletDto toiletDto : item) {
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
            toiletDto.setScore(Double.valueOf(String.format("%.2f", toiletDto.getScore())));
        }
        result.put("content", item.getContent());
        result.put("totalPages", item.getTotalPages());

        return result;
    }

    public Map<String, Object> getSearchToilet(Long memberId, BigDecimal nowLon, BigDecimal nowLat, Boolean allDay, Boolean disabled, Boolean kids, Boolean diaper, String keyword, String order, Pageable pageable) {
        ToiletSearchCondition condition = new ToiletSearchCondition(memberId, nowLat, nowLon, allDay, disabled, kids, diaper, keyword, order);
        Member member = null;
        Map<String, Object> result = new HashMap<>();
        if(memberId != null){
            member = memberRepository.findById(memberId).orElse(null);
        }
        Page<ToiletDto> item = null;

        if(order.equals("distance") || order == null){
            item = toiletRepository.searchToiletDistance(condition, pageable);
        }else if(order.equals("score")){
            item = toiletRepository.searchToiletScore(condition, pageable);
        }else if(order.equals("comment")){
            item = toiletRepository.searchToiletComment(condition, pageable);
        }else{
            throw new IllegalArgumentException();
        }

        for(ToiletDto toiletDto : item) {
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
            toiletDto.setScore(Double.valueOf(String.format("%.2f", toiletDto.getScore())));
        }
        result.put("content", item.getContent());
        result.put("totalPages", item.getTotalPages());
        return result;
    }
    public Map<String, Object> getToilet(Long memberId, Long toiletId){

        Map<String, Object> result = new HashMap<>();
        Toilet toilet = toiletRepository.findById(toiletId).orElse(null);
        if(toilet == null){
            throw new NullPointerException("존재하지 않는 화장실입니다.");
        }
        Member member = null;

        long review_cnt = 0;
        double review_score = 0;

        if(memberId != null){
            member = memberRepository.findById(memberId).orElse(null);
        }

        ToiletDto toiletDto = new ToiletDto();
        toiletDto.setToiletId(toiletId);
        toiletDto.setToiletName(toilet.getToiletName());
        toiletDto.setAddress(toilet.getAddress());
        toiletDto.setOperationTime(toilet.getOperationTime());
        toiletDto.setLat(toilet.getLat());
        toiletDto.setLon(toilet.getLon());
        toiletDto.setPhoneNumber(toilet.getPhoneNumber());
        toiletDto.setDFemalePoo(toilet.isDFemalePoo());
        toiletDto.setDMalePee(toilet.isDMalePee());
        toiletDto.setDMalePoo(toilet.isDMalePoo());
        toiletDto.setCFemalePoo(toilet.isCFemalePoo());
        toiletDto.setCMalePee(toilet.isCMalePee());
        toiletDto.setCMalePoo(toilet.isCMalePoo());
        toiletDto.setAllDay(toilet.isAllDay());
        toiletDto.setDiaper(toilet.isDiaper());

        Long distance = toiletRepository.calDistance(toilet.getLon(), toilet.getLat(), toiletId);
        toiletDto.setDistance(distance);

        long alreadyReviewed = 0; // 리뷰를 작성한 적이 있다면 해당 reviewId를, 리뷰 작성한 적이 없다면 0

        // 해당 화장실의 리뷰 목록
        List<Review> reviewList = reviewRepository.findAllByToilet(toilet);
        if (reviewList.size() > 0 ) {
            for (Review review : reviewList) {
                review_cnt += 1;
                review_score += review.getScore();
                if(member != null) {
                    if (review.getMember().getMemberId() == memberId) { // 리뷰의 작성자와 현재 접속한 유저의 아이디가 같다면? : 리뷰를 작성한 유저이다.
                        alreadyReviewed = review.getReviewId();
                    }
                }
            }
            toiletDto.setScore(Double.valueOf(String.format("%.2f", review_score / review_cnt)));
        }else{
            toiletDto.setScore((double) 0);
        }

        if(member != null){
            // 로그인한 상태라면 유저가 해당 화장실을 북마크했는지 확인
            List<Folder> folderList = folderRepository.findAllByMember(member);
            // 폴더 ID가 없으면 빈 배열 넣어주기
            List<Long> isBookmark = bookMarkRepository.isBookmark(folderList, toiletDto.getToiletId()).orElseGet(() -> new ArrayList<>());
            toiletDto.setFolderId(isBookmark);
        }else {
            // member가 null이면 빈 배열 넣어주기
            toiletDto.setFolderId(new ArrayList<>());
        }

        toiletDto.setReviewId(alreadyReviewed);
        toiletDto.setComment(review_cnt);


        result.put("content", toiletDto);

        return result;
    }
}
