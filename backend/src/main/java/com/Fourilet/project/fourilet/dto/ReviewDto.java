package com.Fourilet.project.fourilet.dto;

import com.Fourilet.project.fourilet.data.entity.Member;
import com.Fourilet.project.fourilet.data.entity.Toilet;
import io.swagger.annotations.ApiParam;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ReviewDto {
    @ApiParam(value = "리뷰 아이디", type = "long")
    private long reviewId;
    @ApiParam(value = "리뷰", type = "String")
    private String comment;
    @ApiParam(value = "점수", type = "float")
    private float score;
    @ApiParam(value = "유저 아이디", type = "long")
    private Member member;
    @ApiParam(value = "화장실 아이디", type = "long")
    private Toilet toilet;

    @Getter
    @Setter
    public static class PostReviewDto {
        @ApiParam(value = "리뷰",type = "String")
        private String comment;
        @ApiParam(value = "점수", type = "float")
        private float score;

    }
    @Getter
    @Setter
    public static class GetReviewDto {
        @ApiParam(value = "리뷰 아이디", type = "long")
        private long reviewId;
        @ApiParam(value = "리뷰",type = "String")
        private String comment;
        @ApiParam(value = "점수", type = "float")
        private float score;
        @ApiParam(value = "유저 닉네임", type = "String")
        private String nickname;
    }
    @Getter
    @Setter
    public static class UpdateReviewDto{
        @ApiParam(value = "리뷰", type = "String")
        private String comment;
        @ApiParam(value = "점수", type = "float")
        private float score;

    }
}
