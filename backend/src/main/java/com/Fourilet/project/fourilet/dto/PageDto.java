package com.Fourilet.project.fourilet.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
public class PageDto {
    private int page; // 현재 페이지 번호
    private int recodeSize; // 페이지당 출력할 데이터 개수
    private int pageSize; // 화면 하단에 출력할 페이지 사이즈

    public  PageDto() {
        this.page = 1;
        this.recodeSize = 10;
    }
    public int getOffset() {
        return (page - 1) * recodeSize;
    }
}
