package com.Fourilet.project.fourilet.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ToiletDto2 {
    private Long toiletId;
    private String toiletName;
    private String address;
    private String operationTime;
    private BigDecimal lat;
    private BigDecimal lon;
    private String phoneNumber;
    private float score;
    private long comment;
    private boolean dMalePee;
    private boolean dMalePoo;
    private boolean dFemalePoo;
    private boolean cFemalePoo;
    private boolean cMalePee;
    private boolean cMalePoo;
    private boolean allDay;
    private boolean diaper;
    private Long folderId;
    private Long reviewId;

}
