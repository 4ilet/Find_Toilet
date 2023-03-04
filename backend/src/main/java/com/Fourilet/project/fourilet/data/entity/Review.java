package com.Fourilet.project.fourilet.data.entity;

import lombok.*;
import javax.persistence.*;

@Entity
@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name="review")
public class Review {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "reviewId")
    private long reviewId;

    @ManyToOne
    @JoinColumn(name = "toiletId")
    private Toilet reviewedToilet;

    @ManyToOne
    @JoinColumn(name = "member")
    private Member member;

    private String comment;

    private float score;

}
