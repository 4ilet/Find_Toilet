package com.Fourilet.project.fourilet.data.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
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

    @JsonBackReference
    @ManyToOne
    @JoinColumn(name = "toiletId")
    private Toilet reviewedToilet;

    @JsonBackReference
    @ManyToOne
    @JoinColumn(name = "member")
    private Member member;

    private String comment;

    private float score;

}
