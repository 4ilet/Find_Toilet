package com.Fourilet.project.fourilet.data.entity;

import lombok.*;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name="toilet")
public class Toilet {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "toiletId")
    private long toiletId;

    @OneToMany(mappedBy = "reviewedToilet")
    private List<Review> reviewList = new ArrayList<>();

    private String toiletName;

    private String address;

    private String operationTime;

    @Column(precision =18, scale = 10)
    private BigDecimal lat;

    @Column(precision =18, scale = 10)
    private BigDecimal log;

    private String phoneNumber;

    @Column(columnDefinition = "TINYINT(1)")
    private boolean dMalePee;

    @Column(columnDefinition = "TINYINT(1)")
    private boolean dMalePoo;

    @Column(columnDefinition = "TINYINT(1)")
    private boolean dFemalePee;

    @Column(columnDefinition = "TINYINT(1)")
    private boolean dFemalePoo;

    @Column(columnDefinition = "TINYINT(1)")
    private boolean cFemalePoo;

    @Column(columnDefinition = "TINYINT(1)")
    private boolean cMalePee;

    @Column(columnDefinition = "TINYINT(1)")
    private boolean cMalePoo;

    @Column(columnDefinition = "TINYINT(1)")
    private boolean allDay;

    @Column(columnDefinition = "TINYINT(1)")
    private boolean diaper;

}
