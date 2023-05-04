package com.Fourilet.project.fourilet.dto;

import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class LoginDto {
    @ApiModelProperty(value = "카카오에서 받은 액세스 토큰", required = true)
    private String token;
}
