package com.Fourilet.project.fourilet.dto;

import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class UpdateNicknameDto {
    @ApiModelProperty(value = "변경할 닉네임", required = true)
    private String nickname;
}
