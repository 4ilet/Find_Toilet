package com.Fourilet.project.fourilet.controller;

import com.Fourilet.project.fourilet.data.entity.Review;
import com.Fourilet.project.fourilet.dto.ReviewDto;
import com.Fourilet.project.fourilet.dto.ToiletDto;
import com.Fourilet.project.fourilet.service.ReviewService;
import io.swagger.annotations.ApiOperation;
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
    @ApiOperation(value = "화장실 리뷰 생성", notes = "특정 화장실의 리뷰를 생성한다.")
    public ResponseEntity<?> postReview(@PathVariable("memberId") long memberId, @PathVariable("toiletId") long toiletId, @RequestBody ReviewDto.PostReviewDto postReviewDto){
        reviewService.postReview(memberId, toiletId, postReviewDto);
        return new ResponseEntity<>(HttpStatus.OK);
    }
    @GetMapping("/{toiletId}")
    @ApiOperation(value = "화장실 리뷰 목록", notes = "특정 화장실의 리뷰 목록들을 가져온다.")
    public List<ReviewDto.GetReviewDto> getReviewList(@PathVariable("toiletId") long toiletId){
        List<ReviewDto.GetReviewDto> result = reviewService.getReview(toiletId);
        return result;
    }
    @DeleteMapping("/delete/{reviewId}")
    @ApiOperation(value = "화장실 리뷰 삭제", notes = "특정 화장실의 리뷰를 삭제한다..")
    public ResponseEntity<?> deleteReview(@PathVariable("reviewId") long reviewId){
        reviewService.deleteReview(reviewId);
        return new ResponseEntity<>(HttpStatus.OK);
    }
    @PutMapping("/update/{reviewId}")
    @ApiOperation(value = "화장실 리뷰 수정", notes = "특정 화장실의 리뷰를 수정한다.")
    public void updateReview(@PathVariable("reviewId") long reviewId, @RequestBody ReviewDto.UpdateReviewDto updateReviewDto){
        reviewService.updateReview(reviewId, updateReviewDto);

    }

}
