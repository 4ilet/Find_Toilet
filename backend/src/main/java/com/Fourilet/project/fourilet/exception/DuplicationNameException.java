package com.Fourilet.project.fourilet.exception;

public class DuplicationNameException extends RuntimeException {
    public DuplicationNameException() {
        super("중복된 이름입니다.");
    }
    public DuplicationNameException(String msg){
        super(msg);
    }
}
