package com.Fourilet.project.fourilet.controller;

import com.Fourilet.project.fourilet.data.entity.Review;
import com.Fourilet.project.fourilet.dto.ReviewDto;
import com.Fourilet.project.fourilet.dto.ToiletDto;
import com.Fourilet.project.fourilet.service.ReviewService;
import lombok.RequiredArgsConstructor;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.nio.file.Path;
import java.util.List;

@RestController
@RequestMapping("/review")
@RequiredArgsConstructor
public class ReviewController {
    private final Logger LOGGER = LoggerFactory.getLogger(ReviewController.class);
    private final ReviewService reviewService;

    @PostMapping("/post/{memberId}/{toiletId}")
    public ResponseEntity<?> postReview(@PathVariable long memberId, @PathVariable long toiletId, @RequestBody ReviewDto.PostReviewDto postReviewDto){
        reviewService.postReview(memberId, toiletId, postReviewDto);

        return new ResponseEntity<>(HttpStatus.OK);
    }
    @GetMapping("/{toiletId}")
    public List<ReviewDto.GetReviewDto> getReviewList(@PathVariable long toiletId){
        List<ReviewDto.GetReviewDto> result = reviewService.getReview(toiletId);
        return result;
    }
    @DeleteMapping("/delete/{reviewId}")
    public ResponseEntity<?> deleteReview(@PathVariable long reviewId){
        reviewService.deleteReview(reviewId);
        return new ResponseEntity<>(HttpStatus.OK);
    }
    @PutMapping("/update/{reviewId}")
    public void updateReview(@PathVariable long reviewId, @RequestBody ReviewDto.UpdateReviewDto updateReviewDto){
        reviewService.updateReview(reviewId, updateReviewDto);

    }

}
