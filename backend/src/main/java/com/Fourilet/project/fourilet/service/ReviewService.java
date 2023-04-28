package com.Fourilet.project.fourilet.service;

import com.Fourilet.project.fourilet.data.entity.Member;
import com.Fourilet.project.fourilet.data.entity.Review;
import com.Fourilet.project.fourilet.data.entity.Toilet;
import com.Fourilet.project.fourilet.data.repository.MemberRepository;
import com.Fourilet.project.fourilet.data.repository.ReviewRepository;
import com.Fourilet.project.fourilet.data.repository.ToiletRepository;
import com.Fourilet.project.fourilet.dto.ReviewDto;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

//import javax.xml.ws.Response;
//import java.sql.Array;
import java.util.ArrayList;
import java.util.List;
import java.util.NoSuchElementException;

@Service
@RequiredArgsConstructor
public class ReviewService {
    private final Logger LOGGER = LoggerFactory.getLogger(FolderService.class);

    private final MemberRepository memberRepository;
    private final ToiletRepository toiletRepository;
    private final ReviewRepository reviewRepository;


    public void postReview(long memberId, long toiletId, ReviewDto.PostReviewDto postReviewDto){
        LOGGER.info("CALL postReview");
        Member member = memberRepository.findById(memberId);
        Toilet toilet = toiletRepository.findById(toiletId).orElse(null);
        if (member == null) {
            throw new NullPointerException("존재하지 않는 회원입니다");
        }

        if (toilet == null){
            throw new NullPointerException("존재하지 않는 화장실입니다");
        }

        if (postReviewDto.getComment().isEmpty()){
            throw new IllegalArgumentException("리뷰를 작성하지 않았습니다");
        }
        float score = (float)postReviewDto.getScore();
        if ( score < 0  || score > 5){
            throw new IllegalArgumentException("점수는 0 ~ 5 사이의 점수를 입력해주세요");
        }

        Review newReview = new Review();
        newReview.setToilet(toilet);
        newReview.setMember(member);
        newReview.setComment(postReviewDto.getComment());
        newReview.setScore(postReviewDto.getScore());
        reviewRepository.save(newReview);
    }
    public List<ReviewDto.GetReviewDto> getReview(long toiletId, int page){
        LOGGER.info("CALL GET REVIEW");
        Toilet toilet = toiletRepository.findById(toiletId).orElse(null);
        if (toilet == null) {
            throw new NullPointerException("존재하지 않는 화장실입니다.");
        }

        PageRequest pageRequest = PageRequest.of(page, 10);
        List<Review> reviewList = reviewRepository.findAllByToilet(toilet, pageRequest);


        if (toilet == null) {
            throw new NullPointerException("존재하지 않는 화장실입니다.");
        }

        if (reviewList.size() > 0 ) {
            List<ReviewDto.GetReviewDto> result = new ArrayList<>();
            for (Review review : reviewList) {
                ReviewDto.GetReviewDto reviewListDto = new ReviewDto.GetReviewDto();
                Member member = memberRepository.findById(review.getMember().getMemberId());
                reviewListDto.setReviewId(review.getReviewId());
                reviewListDto.setComment(review.getComment());
                reviewListDto.setScore(review.getScore());
                reviewListDto.setNickname(member.getNickname());
                result.add(reviewListDto);
            }
            return result;
        }
        else {
            throw new NoSuchElementException("리뷰가 존재하지 않습니다");
        }


    }
    public void deleteReview(long reviewId){
        LOGGER.info("CALL DELETE REVIEW");
        Review review = reviewRepository.findById(reviewId).orElse(null);
        if (review == null) {
            throw new NullPointerException("존재하지 않는 리뷰입니다.");
        } else {
            reviewRepository.delete(review);
        }
    }

    public void updateReview(long reviewId, ReviewDto.UpdateReviewDto updateReviewDto){
        LOGGER.info("CALL UPDATE REVIEW");
        Review review = reviewRepository.findById(reviewId).orElse(null);
        if (review == null) {
            throw new NullPointerException("존재하지 않는 리뷰입니다.");
        }
        if (updateReviewDto.getComment().isEmpty()){
            throw new NullPointerException("리뷰가 비어있습니다.");
        }
        if ( updateReviewDto.getScore() < 0  || updateReviewDto.getScore() > 5){
            throw new IllegalArgumentException("점수는 0 ~ 5 이하의 점수를 입력해주세요");
        }

        review.setComment(updateReviewDto.getComment());
        review.setScore(updateReviewDto.getScore());
        reviewRepository.save(review);
    }
}