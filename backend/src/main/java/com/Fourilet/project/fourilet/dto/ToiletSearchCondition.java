package com.Fourilet.project.fourilet.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
@AllArgsConstructor
public class ToiletSearchCondition {
    private Long memberId;
    private BigDecimal nowLat;
    private BigDecimal nowLon;
    private boolean allDay;
    private boolean disabled;
    private boolean kids;
    private boolean diaper;
    private String keyword;
}
