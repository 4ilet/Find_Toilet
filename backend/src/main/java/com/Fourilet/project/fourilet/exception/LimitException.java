package com.Fourilet.project.fourilet.exception;

public class LimitException extends RuntimeException {
    public LimitException() {
        super("더 이상 생성하지 못합니다.");
    }
    public LimitException(String msg){
        super(msg);
    }

}
