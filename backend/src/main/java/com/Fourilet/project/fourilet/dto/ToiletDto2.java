package com.Fourilet.project.fourilet.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

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
    private List<Long> folderId;
    private Long reviewId;

    @Getter
    @Setter
    public static class ToiletDto2WithSize {
        private int totalPage;
        private List<ToiletDto2> response = new ArrayList<>();

    }

}
