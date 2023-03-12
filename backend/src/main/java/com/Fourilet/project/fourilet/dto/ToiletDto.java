package com.Fourilet.project.fourilet.dto;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class ToiletDto {
    private long toiletId;
    private String toiletName;
    private String address;
    private String operationTime;
    private BigDecimal lat;
    private BigDecimal lon;
    private String phoneNumber;
    private boolean dMalePee;
    private boolean dMalePoo;
    private boolean dFemalePoo;
    private boolean cFemalePoo;
    private boolean cMalePee;
    private boolean cMalePoo;
    private boolean allDay;
    private boolean diaper;




}
