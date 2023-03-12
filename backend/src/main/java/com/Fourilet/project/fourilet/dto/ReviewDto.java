package com.Fourilet.project.fourilet.dto;

import com.Fourilet.project.fourilet.data.entity.Member;
import com.Fourilet.project.fourilet.data.entity.Toilet;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ReviewDto {
    private long reviewId;
    private String comment;
    private float score;
    private Member member;
    private Toilet toilet;

    @Getter
    @Setter
    public static class PostReviewDto {
        private String comment;
        private float score;

    }
    @Getter
    @Setter
    public static class GetReviewDto {
        private String comment;
        private float score;
        private String nickname;
    }
    @Getter
    @Setter
    public static class UpdateReviewDto{
        private String comment;
        private float score;

    }
}
