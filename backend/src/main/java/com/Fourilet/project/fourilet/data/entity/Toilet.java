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

    private BigDecimal lat;

    private BigDecimal log;

    private String phoneNumber;

    private boolean dMalePee;

    private boolean dMalePoo;

    private boolean dFemalePee;

    private boolean dFemalePoo;

    private boolean cFemalePoo;

    private boolean cMalePee;

    private boolean cMalePoo;

    private boolean allDay;

    private boolean diaper;

}
