package com.Fourilet.project.fourilet.exception;

public class AtLeastException extends RuntimeException{
    public AtLeastException() {
        super("적어도 하나 이상의 요소가 존재해야합니다.");
    }
    public AtLeastException(String msg){
        super(msg);
    }
}
