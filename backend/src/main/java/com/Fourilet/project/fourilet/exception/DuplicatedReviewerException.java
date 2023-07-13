package com.Fourilet.project.fourilet.exception;

public class DuplicatedReviewerException  extends RuntimeException{
    public DuplicatedReviewerException(){
        super("리뷰는 회원 당 한번만 작성할 수 있습니다.");
    }
    public DuplicatedReviewerException(String msg){
        super(msg);
    }

}
