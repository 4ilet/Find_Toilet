package com.Fourilet.project.fourilet.dto;

import lombok.Data;
import lombok.Getter;

@Data
@Getter
public class Message2 {
    private StatusEnum status;
    private String message;
    private Object data;
    private int size;

    public Message2() {
        this.status = StatusEnum.BAD_REQUEST;
        this.data = null;
        this.size = 0;
        this.message = null;
    }

    public Message2(StatusEnum status, String message, Object data, int size) {
        this.status = status;
        this.message = message;
        this.size = size;
        this.data = data;

    }
}