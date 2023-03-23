package com.Fourilet.project.fourilet.dto;

import com.Fourilet.project.fourilet.data.entity.Review;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;



public interface ToiletDto {
    Long getToiletId();

    String getToiletName();

    String getAddress();

    String getOperationTime();

    BigDecimal getLat();

    BigDecimal getLon();

    String getPhoneNumber();

    Boolean getDMalePee();

    Boolean getDMalePoo();

    Boolean getDFemalePoo();

    Boolean getCFemalePoo();

    Boolean getCMalePee();

    Boolean getCMalePoo();

    Boolean getAllDay();

    Boolean getDiaper();
    Boolean getIsLike();

    int getDistance();

    float getScore();
    int getComment();
}
