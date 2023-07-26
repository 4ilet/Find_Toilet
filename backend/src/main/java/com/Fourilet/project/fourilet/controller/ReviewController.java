package com.Fourilet.project.fourilet.controller;

import com.Fourilet.project.fourilet.config.jwt.service.JwtService;
import com.Fourilet.project.fourilet.dto.Message;
import com.Fourilet.project.fourilet.dto.Message2;
import com.Fourilet.project.fourilet.dto.ReviewDto;
import com.Fourilet.project.fourilet.dto.StatusEnum;
import com.Fourilet.project.fourilet.exception.DuplicatedReviewerException;
import com.Fourilet.project.fourilet.service.ReviewService;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.RequiredArgsConstructor;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.slf4j.Logger;

import javax.servlet.http.HttpServletRequest;
import java.nio.charset.Charset;
import java.util.List;
import java.util.NoSuchElementException;

@RestController
@RequestMapping("/review")
@RequiredArgsConstructor
public class ReviewController {
    private final Logger LOGGER = LoggerFactory.getLogger(ReviewController.class);
    private final ReviewService reviewService;

    private final JwtService jwtService;

    @PostMapping("/post/{toiletId}")
    @ApiOperation(value = "화장실 리뷰 생성", notes = "특정 화장실의 리뷰를 생성한다.")
    public ResponseEntity<?> postReview(HttpServletRequest request, @PathVariable("toiletId") long toiletId, @RequestBody ReviewDto.PostReviewDto postReviewDto){
        Message message = new Message();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(new MediaType("application", "json", Charset.forName("UTF-8")));
        String accessToken = request.getHeader("Authorization").replace("Bearer ", "");
        Long reqMemberId = jwtService.extractId(accessToken).get();
        try {
            reviewService.postReview(reqMemberId, toiletId, postReviewDto);
            message.setStatus(StatusEnum.OK);
            message.setMessage("리뷰 작성 성공");
            return new ResponseEntity<>(message, headers, HttpStatus.OK);

        } catch (NullPointerException e){
            message.setStatus(StatusEnum.BAD_REQUEST);
            message.setMessage(String.valueOf(e));
            return new ResponseEntity<>(message, headers, HttpStatus.BAD_REQUEST);

        } catch (IllegalArgumentException e){
            message.setStatus(StatusEnum.BAD_REQUEST);
            message.setMessage(String.valueOf(e));
            return new ResponseEntity<>(message, headers, HttpStatus.BAD_REQUEST);

        } catch (DuplicatedReviewerException e) {
            message.setStatus(StatusEnum.BAD_REQUEST);
            message.setMessage(String.valueOf(e));
            return new ResponseEntity<>(message, headers, HttpStatus.BAD_REQUEST);

        }
    }
    @GetMapping("/{toiletId}")
    @ApiOperation(value = "화장실 리뷰 목록", notes = "특정 화장실의 리뷰 목록들을 가져온다.")
    public ResponseEntity<?> getReviewList(@PathVariable("toiletId") long toiletId, @ApiParam(value = "page=int(시작은 0)") int page){
        Message2 message2 = new Message2();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(new MediaType("application", "json", Charset.forName("UTF-8")));

        try {
            ReviewDto.GetReviewListDto result = reviewService.getReview(toiletId,  page);
            message2.setStatus(StatusEnum.OK);
            message2.setSize(result.getTotalPage());
            message2.setData(result.getResponse());
            message2.setMessage("화장실 리뷰 가져오기 성공");
            return new ResponseEntity<>(message2, headers, HttpStatus.OK);

        } catch (NoSuchElementException e){

            message2.setStatus(StatusEnum.NO_CONTENT);
            message2.setMessage(String.valueOf(e));

            return new ResponseEntity<>(message2, headers, HttpStatus.NO_CONTENT);

        } catch (NullPointerException e) {

            message2.setStatus(StatusEnum.BAD_REQUEST);
            message2.setMessage(String.valueOf(e));

            return new ResponseEntity<>(message2, headers, HttpStatus.BAD_REQUEST);
        }

    }
    @DeleteMapping("/delete/{reviewId}")
    @ApiOperation(value = "화장실 리뷰 삭제", notes = "특정 화장실의 리뷰를 삭제한다..")
    public ResponseEntity<?> deleteReview(@PathVariable("reviewId") long reviewId){
        Message message = new Message();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(new MediaType("application", "json", Charset.forName("UTF-8")));
        try {
            reviewService.deleteReview(reviewId);
            message.setStatus(StatusEnum.OK);
            message.setMessage("리뷰 삭제 성공");
            return new ResponseEntity<>(message, headers, HttpStatus.OK);

        } catch (NullPointerException e){
            message.setStatus(StatusEnum.BAD_REQUEST);
            message.setMessage(String.valueOf(e));
            return new ResponseEntity<>(message, headers, HttpStatus.BAD_REQUEST);

        }
    }
    @PutMapping("/update/{reviewId}")
    @ApiOperation(value = "화장실 리뷰 수정", notes = "특정 화장실의 리뷰를 수정한다.")
    public ResponseEntity<?> updateReview(@PathVariable("reviewId") long reviewId, @RequestBody ReviewDto.UpdateReviewDto updateReviewDto){
        Message message = new Message();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(new MediaType("application", "json", Charset.forName("UTF-8")));
        try {
            reviewService.updateReview(reviewId, updateReviewDto);
            message.setStatus(StatusEnum.OK);
            message.setMessage("리뷰 수정 완료");
            return new ResponseEntity<>(message, headers, HttpStatus.OK);
        } catch (NullPointerException e){
            message.setStatus(StatusEnum.BAD_REQUEST);
            message.setMessage(String.valueOf(e));
            return new ResponseEntity<>(message, headers, HttpStatus.BAD_REQUEST);
        } catch (IllegalArgumentException e){
            message.setStatus(StatusEnum.BAD_REQUEST);
            message.setMessage(String.valueOf(e));
            return new ResponseEntity<>(message, headers, HttpStatus.BAD_REQUEST);
        }
    }
    @GetMapping("/get/{reviewId}")
    @ApiOperation(value = "개별 화장실 리뷰 가져오기", notes = "특정 리뷰를 가져온다")
    public ResponseEntity<?> getEachReview(@PathVariable("reviewId") long reviewId) {
        Message message = new Message();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(new MediaType("application", "json", Charset.forName("UTF-8")));
        try {
            ReviewDto.GetReviewDto result = reviewService.getEachReview(reviewId);
            message.setStatus(StatusEnum.OK);
            message.setData(result);
            message.setMessage("리뷰 가져오기 성공");
            return new ResponseEntity<>(message, headers, HttpStatus.OK);

        } catch (NullPointerException e) {
            message.setStatus(StatusEnum.BAD_REQUEST);
            message.setMessage(String.valueOf(e));
            return new ResponseEntity<>(message, headers, HttpStatus.BAD_REQUEST);
        }
    }

}