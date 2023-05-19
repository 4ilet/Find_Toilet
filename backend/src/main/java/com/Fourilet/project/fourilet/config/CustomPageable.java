package com.Fourilet.project.fourilet.config;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@ApiModel
public class CustomPageable {
    @ApiModelProperty(value="페이지 번호 (0부터 시작)")
    private int page;
    @ApiModelProperty(value="한 페이지에 나올 개수")
    private int size;
}
