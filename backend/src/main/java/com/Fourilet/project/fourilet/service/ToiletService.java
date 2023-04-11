package com.Fourilet.project.fourilet.service;

import com.Fourilet.project.fourilet.data.entity.BookMark;
import com.Fourilet.project.fourilet.data.entity.Folder;
import com.Fourilet.project.fourilet.data.repository.ToiletRepository;
import com.Fourilet.project.fourilet.dto.ToiletDto;
import com.Fourilet.project.fourilet.dto.ToiletGetCondition;
import com.Fourilet.project.fourilet.dto.ToiletSearchCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.List;

@Service
public class ToiletService {
    @Autowired
    ToiletRepository toiletRepository;
    public Page<ToiletDto> getNearToilet(Long memberId, BigDecimal nowLon, BigDecimal nowLat, Long radius, Boolean allDay, Boolean disabled, Boolean kids, Boolean diaper, Pageable pageable) {
        ToiletGetCondition condition = new ToiletGetCondition(memberId, nowLat, nowLon, radius, allDay, disabled, kids, diaper);
        Page<ToiletDto> result = toiletRepository.nearByToilet(condition, pageable);
        for(ToiletDto toiletDto : result) {
            Long distance = toiletRepository.calDistance(condition.getNowLon(), condition.getNowLat(), toiletDto.getToiletId());
            toiletDto.setDistance(distance);
            if(memberId == null){
                toiletDto.setBookmark(false);
            }else{
                int isBookmark = toiletRepository.isBookmark(memberId, toiletDto.getToiletId()).intValue();
                if(isBookmark == 1){
                    toiletDto.setBookmark(true);
                }else{
                    toiletDto.setBookmark(false);
                }
            }
        }
        return result;
    }

    public Page<ToiletDto> getSearchToilet(Long memberId, BigDecimal nowLon, BigDecimal nowLat, Boolean allDay, Boolean disabled, Boolean kids, Boolean diaper, String keyword, String order, Pageable pageable) {
        ToiletSearchCondition condition = new ToiletSearchCondition(memberId, nowLat, nowLon, allDay, disabled, kids, diaper, keyword, order);


        Page<ToiletDto> result = null;

        if(order.equals("distance") || order == null){
            result = toiletRepository.searchToiletDistance(condition, pageable);
        }else if(order.equals("score")){
            result = toiletRepository.searchToiletScore(condition, pageable);
        }else if(order.equals("comment")){
            result = toiletRepository.searchToiletComment(condition, pageable);
        }else{
            throw new IllegalArgumentException();
        }

        for(ToiletDto toiletDto : result) {
            Long distance = toiletRepository.calDistance(condition.getNowLon(), condition.getNowLat(), toiletDto.getToiletId());
            toiletDto.setDistance(distance);
            if(memberId == null){
                toiletDto.setBookmark(false);
            }else{
                int isBookmark = toiletRepository.isBookmark(memberId, toiletDto.getToiletId()).intValue();
                if(isBookmark == 1){
                    toiletDto.setBookmark(true);
                }else{
                    toiletDto.setBookmark(false);
                }
            }
        }
        return result;
    }
}
