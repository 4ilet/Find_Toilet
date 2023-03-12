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
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

//import javax.xml.ws.Response;
//import java.sql.Array;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ReviewService {
    private final Logger LOGGER = LoggerFactory.getLogger(FolderService.class);

    private final MemberRepository memberRepository;
    private final ToiletRepository toiletRepository;
    private final ReviewRepository reviewRepository;


    public ResponseEntity<?> postReview(long memberId, long toiletId, ReviewDto.PostReviewDto postReviewDto){
        LOGGER.info("CALL postReview");
        Member member = memberRepository.findById(memberId);
        Toilet toilet = toiletRepository.findById(toiletId).orElse(null);

        Review newReview = new Review();

        newReview.setToilet(toilet);
        newReview.setMember(member);
        newReview.setComment(postReviewDto.getComment());
        newReview.setScore(postReviewDto.getScore());

        reviewRepository.save(newReview);
        return new ResponseEntity<>(HttpStatus.OK);
    }
    public List<ReviewDto.GetReviewDto> getReview(long toiletId){
        LOGGER.info("CALL GET REVIEW");
        Toilet toilet = toiletRepository.findById(toiletId).orElse(null);
        List<Review> reviewList = reviewRepository.findAllByToilet(toilet);
        if (reviewList.size() > 0 ) {
            List<ReviewDto.GetReviewDto> result = new ArrayList<>();
            for (Review review : reviewList) {
                ReviewDto.GetReviewDto reviewListDto = new ReviewDto.GetReviewDto();
                Member member = memberRepository.findById(review.getMember().getMemberId());
                reviewListDto.setComment(review.getComment());
                reviewListDto.setScore(review.getScore());
                reviewListDto.setNickname(member.getNickname());
                result.add(reviewListDto);
            }
            return result;
        }
        else {
            return null;
        }


    }
    public void deleteReview(long reviewId){
        LOGGER.info("CALL DELETE REVIEW");
        Review review = reviewRepository.findById(reviewId).orElse(null);
        reviewRepository.delete(review);
    }

    public void updateReview(long reviewId, ReviewDto.UpdateReviewDto updateReviewDto){
        LOGGER.info("CALL UPDATE REVIEW");
        Review review = reviewRepository.findById(reviewId).orElse(null);
        review.setComment(updateReviewDto.getComment());
        review.setScore(updateReviewDto.getScore());
        reviewRepository.save(review);
    }
}
