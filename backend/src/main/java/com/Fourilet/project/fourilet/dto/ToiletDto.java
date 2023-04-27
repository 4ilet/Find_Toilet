package com.Fourilet.project.fourilet.dto;

import com.querydsl.core.annotations.QueryProjection;
import lombok.Data;

import java.math.BigDecimal;

@Data
public class ToiletDto {
    private Long toiletId;
    private String toiletName;
    private String address;
    private String operationTime;
    private BigDecimal lat;
    private BigDecimal lon;
    private String phoneNumber;
    private Double score;
    private Long comment;
    private boolean dMalePee;
    private boolean dMalePoo;
    private boolean dFemalePoo;
    private boolean cFemalePoo;
    private boolean cMalePee;
    private boolean cMalePoo;
    private boolean allDay;
    private boolean diaper;
    private Long folderId;
    private Long distance;

    @QueryProjection
    public ToiletDto(Long toiletId, String toiletName, String address, String operationTime, BigDecimal lat,
                     BigDecimal lon, String phoneNumber, Double score, Long comment, boolean dMalePee, boolean dMalePoo,
                     boolean dFemalePoo, boolean cFemalePoo, boolean cMalePee, boolean cMalePoo, boolean allDay, boolean diaper,
                     Long folderId, Long distance
    ){
        this.toiletId = toiletId;
        this.toiletName = toiletName;
        this.address = address;
        this.operationTime = operationTime;
        this.lat = lat;
        this.lon = lon;
        this.phoneNumber = phoneNumber;
        this.score = score;
        this.comment = comment;
        this.dFemalePoo = dFemalePoo;
        this.dMalePee = dMalePee;
        this.dMalePoo = dMalePoo;
        this.cFemalePoo = cFemalePoo;
        this.cMalePee = cMalePee;
        this.cMalePoo = cMalePoo;
        this.allDay = allDay;
        this.diaper = diaper;
        this.folderId = folderId;
        this.distance = distance;
    }
}
