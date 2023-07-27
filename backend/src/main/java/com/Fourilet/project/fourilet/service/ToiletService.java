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

import java.math.BigDecimal;
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
            long alreadyReviewed = 0; 
            if(member != null) {
                Toilet toilet = toiletRepository.findById(toiletDto.getToiletId()).orElse(null);
                List<Review> reviewList = reviewRepository.findAllByToilet(toilet);
                for (Review review : reviewList) {
                    if (review.getMember().getMemberId() == memberId) { 
                        alreadyReviewed = review.getReviewId();
                    }
                }
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
            long alreadyReviewed = 0; 
            if(member != null){
                Toilet toilet = toiletRepository.findById(toiletDto.getToiletId()).orElse(null);
                List<Review> reviewList = reviewRepository.findAllByToilet(toilet);
                for (Review review : reviewList) {
                    if (review.getMember().getMemberId() == memberId) { 
                        alreadyReviewed = review.getReviewId();
                    }
                }
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
        long alreadyReviewed = 0; 
        List<Review> reviewList = reviewRepository.findAllByToilet(toilet);
        if (reviewList.size() > 0 ) {
            for (Review review : reviewList) {
                review_cnt += 1;
                review_score += review.getScore();
                if(member != null) {
                    if (review.getMember().getMemberId() == memberId) { 
                        alreadyReviewed = review.getReviewId();
                    }
                }
            }
            toiletDto.setScore(Double.valueOf(String.format("%.2f", review_score / review_cnt)));
        }else{
            toiletDto.setScore((double) 0);
        }

        if(member != null){
            List<Folder> folderList = folderRepository.findAllByMember(member);
            List<Long> isBookmark = bookMarkRepository.isBookmark(folderList, toiletDto.getToiletId()).orElseGet(() -> new ArrayList<>());
            toiletDto.setFolderId(isBookmark);
        }else {
            toiletDto.setFolderId(new ArrayList<>());
        }

        toiletDto.setReviewId(alreadyReviewed);
        toiletDto.setComment(review_cnt);
        result.put("content", toiletDto);

        return result;
    }
}
