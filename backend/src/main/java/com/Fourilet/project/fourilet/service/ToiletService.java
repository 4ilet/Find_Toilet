package com.Fourilet.project.fourilet.service;

import com.Fourilet.project.fourilet.data.entity.Toilet;
import com.Fourilet.project.fourilet.data.repository.MemberRepository;
import com.Fourilet.project.fourilet.data.repository.ToiletRepository;
import com.Fourilet.project.fourilet.dto.ToiletDto;
import org.springframework.beans.NotWritablePropertyException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.JpaSort;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.math.BigDecimal;
import java.util.Iterator;
import java.util.List;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
public class ToiletService {
    @Autowired
    ToiletRepository toiletRepository;

    public Page<ToiletDto> getSearchResult(String keyword, String order, BigDecimal nowLon, BigDecimal nowLat, Boolean allDay, Boolean disabled, Boolean kids, Boolean diaper, Pageable pageable){

         if(order.equals("score")){
             if((allDay == false) && (disabled == false) && (kids == false) && (diaper == false)){
                 System.out.println("here!1");
                 return toiletRepository.findContainByToiletOrderScore(nowLon, nowLat, keyword, keyword, pageable);
             }else if((allDay == true) && (disabled == false) && (kids == false) && (diaper == false)){
                 System.out.println("here!2");
                 return toiletRepository.findContainByAllDayToiletOrderScore(nowLon, nowLat, keyword, keyword, pageable);
             }else if((allDay == false) && (disabled == true) && (kids == false) && (diaper == false)){
                 System.out.println("here!3");
                 return toiletRepository.findContainByDisabledToiletOrderScore(nowLon, nowLat, keyword, keyword, pageable);
             }else if((allDay == false) && (disabled == false) && (kids == true) && (diaper == false)){
                 System.out.println("here!4");
                 return toiletRepository.findContainByKidsToiletOrderScore(nowLon, nowLat, keyword, keyword, pageable);
             }else if((allDay == false) && (disabled == false) && (kids == false) && (diaper == true)){
                 System.out.println("here!5");
                 return toiletRepository.findContainByDiaperToiletOrderScore(nowLon, nowLat, keyword, keyword, pageable);
             }else if((allDay == true) && (disabled == true) && (kids == false) && (diaper == false)){
                 System.out.println("here!6");
                 return toiletRepository.findContainByAllDayDiabledToiletOrderScore(nowLon, nowLat, keyword, keyword, pageable);
             }else if((allDay == true) && (disabled == false) && (kids == true) && (diaper == false)){
                 System.out.println("here!7");
                 return toiletRepository.findContainByAllDayKidsToiletOrderScore(nowLon, nowLat, keyword, keyword, pageable);
             }else if((allDay == true) && (disabled == false) && (kids == false) && (diaper == true)){
                 System.out.println("here!8");
                 return toiletRepository.findContainByAllDayDiaperToiletOrderScore(nowLon, nowLat, keyword, keyword, pageable);
             }else if((allDay == false) && (disabled == true) && (kids == true) && (diaper == false)){
                 System.out.println("here!9");
                 return toiletRepository.findContainByDisabledKidsToiletOrderScore(nowLon, nowLat, keyword, keyword, pageable);
             }else if((allDay == false) && (disabled == true) && (kids == false) && (diaper == true)){
                 System.out.println("here!10");
                 return toiletRepository.findContainByDisabledDiaperToiletOrderScore(nowLon, nowLat, keyword, keyword, pageable);
             }else if((allDay == false) && (disabled == false) && (kids == true) && (diaper == true)){
                 System.out.println("here!11");
                 return toiletRepository.findContainByKidsDiaperToiletOrderScore(nowLon, nowLat, keyword, keyword, pageable);
             }else if((allDay == true) && (disabled == true) && (kids == true) && (diaper == false)){
                 System.out.println("here!12");
                 return toiletRepository.findContainByAllDayDisabledKidsToiletOrderScore(nowLon, nowLat, keyword, keyword, pageable);
             }else if((allDay == true) && (disabled == true) && (kids == false) && (diaper == true)){
                 System.out.println("here!13");
                 return toiletRepository.findContainByAllDayDisabledDiaperToiletOrderScore(nowLon, nowLat, keyword, keyword, pageable);
             } else if ((allDay == false) && (disabled == true) && (kids == true) && (diaper == true)) {
                 System.out.println("here!14");
                 return toiletRepository.findContainByDisabledKidsDiaperToiletOrderScore(nowLon, nowLat, keyword, keyword, pageable);
             }
             return toiletRepository.findContainByAllOrderScore(nowLon, nowLat, keyword, keyword, pageable);
         } else if (order.equals("comment")) {
             if((allDay == false) && (disabled == false) && (kids == false) && (diaper == false)){
                 System.out.println("here!1");
                 return toiletRepository.findContainByToiletOrderComment(nowLon, nowLat, keyword, keyword, pageable);
             }else if((allDay == true) && (disabled == false) && (kids == false) && (diaper == false)){
                 System.out.println("here!2");
                 return toiletRepository.findContainByAllDayToiletOrderComment(nowLon, nowLat, keyword, keyword, pageable);
             }else if((allDay == false) && (disabled == true) && (kids == false) && (diaper == false)){
                 System.out.println("here!3");
                 return toiletRepository.findContainByDisabledToiletOrderComment(nowLon, nowLat, keyword, keyword, pageable);
             }else if((allDay == false) && (disabled == false) && (kids == true) && (diaper == false)){
                 System.out.println("here!4");
                 return toiletRepository.findContainByKidsToiletOrderComment(nowLon, nowLat, keyword, keyword, pageable);
             }else if((allDay == false) && (disabled == false) && (kids == false) && (diaper == true)){
                 System.out.println("here!5");
                 return toiletRepository.findContainByDiaperToiletOrderComment(nowLon, nowLat, keyword, keyword, pageable);
             }else if((allDay == true) && (disabled == true) && (kids == false) && (diaper == false)){
                 System.out.println("here!6");
                 return toiletRepository.findContainByAllDayDiabledToiletOrderComment(nowLon, nowLat, keyword, keyword, pageable);
             }else if((allDay == true) && (disabled == false) && (kids == true) && (diaper == false)){
                 System.out.println("here!7");
                 return toiletRepository.findContainByAllDayKidsToiletOrderComment(nowLon, nowLat, keyword, keyword, pageable);
             }else if((allDay == true) && (disabled == false) && (kids == false) && (diaper == true)){
                 System.out.println("here!8");
                 return toiletRepository.findContainByAllDayDiaperToiletOrderComment(nowLon, nowLat, keyword, keyword, pageable);
             }else if((allDay == false) && (disabled == true) && (kids == true) && (diaper == false)){
                 System.out.println("here!9");
                 return toiletRepository.findContainByDisabledKidsToiletOrderComment(nowLon, nowLat, keyword, keyword, pageable);
             }else if((allDay == false) && (disabled == true) && (kids == false) && (diaper == true)){
                 System.out.println("here!10");
                 return toiletRepository.findContainByDisabledDiaperToiletOrderComment(nowLon, nowLat, keyword, keyword, pageable);
             }else if((allDay == false) && (disabled == false) && (kids == true) && (diaper == true)){
                 System.out.println("here!11");
                 return toiletRepository.findContainByKidsDiaperToiletOrderComment(nowLon, nowLat, keyword, keyword, pageable);
             }else if((allDay == true) && (disabled == true) && (kids == true) && (diaper == false)){
                 System.out.println("here!12");
                 return toiletRepository.findContainByAllDayDisabledKidsToiletOrderComment(nowLon, nowLat, keyword, keyword, pageable);
             }else if((allDay == true) && (disabled == true) && (kids == false) && (diaper == true)){
                 System.out.println("here!13");
                 return toiletRepository.findContainByAllDayDisabledDiaperToiletOrderComment(nowLon, nowLat, keyword, keyword, pageable);
             } else if ((allDay == false) && (disabled == true) && (kids == true) && (diaper == true)) {
                 System.out.println("here!14");
                 return toiletRepository.findContainByDisabledKidsDiaperToiletOrderComment(nowLon, nowLat, keyword, keyword, pageable);
             }
             return toiletRepository.findContainByAllOrderComment(nowLon, nowLat, keyword, keyword, pageable);
         } else{
             if((allDay == false) && (disabled == false) && (kids == false) && (diaper == false)){
                 System.out.println("here!1");
                 return toiletRepository.findContainByToiletOrderDistance(nowLon, nowLat, keyword, keyword, pageable);
             }else if((allDay == true) && (disabled == false) && (kids == false) && (diaper == false)){
                 System.out.println("here!2");
                 return toiletRepository.findContainByAllDayToiletOrderDistance(nowLon, nowLat, keyword, keyword, pageable);
             }else if((allDay == false) && (disabled == true) && (kids == false) && (diaper == false)){
                 System.out.println("here!3");
                 return toiletRepository.findContainByDisabledToiletOrderDistance(nowLon, nowLat, keyword, keyword, pageable);
             }else if((allDay == false) && (disabled == false) && (kids == true) && (diaper == false)){
                 System.out.println("here!4");
                 return toiletRepository.findContainByKidsToiletOrderDistance(nowLon, nowLat, keyword, keyword, pageable);
             }else if((allDay == false) && (disabled == false) && (kids == false) && (diaper == true)){
                 System.out.println("here!5");
                 return toiletRepository.findContainByDiaperToiletOrderDistance(nowLon, nowLat, keyword, keyword, pageable);
             }else if((allDay == true) && (disabled == true) && (kids == false) && (diaper == false)){
                 System.out.println("here!6");
                 return toiletRepository.findContainByAllDayDiabledToiletOrderDistance(nowLon, nowLat, keyword, keyword, pageable);
             }else if((allDay == true) && (disabled == false) && (kids == true) && (diaper == false)){
                 System.out.println("here!7");
                 return toiletRepository.findContainByAllDayKidsToiletOrderDistance(nowLon, nowLat, keyword, keyword, pageable);
             }else if((allDay == true) && (disabled == false) && (kids == false) && (diaper == true)){
                 System.out.println("here!8");
                 return toiletRepository.findContainByAllDayDiaperToiletOrderDistance(nowLon, nowLat, keyword, keyword, pageable);
             }else if((allDay == false) && (disabled == true) && (kids == true) && (diaper == false)){
                 System.out.println("here!9");
                 return toiletRepository.findContainByDisabledKidsToiletOrderDistance(nowLon, nowLat, keyword, keyword, pageable);
             }else if((allDay == false) && (disabled == true) && (kids == false) && (diaper == true)){
                 System.out.println("here!10");
                 return toiletRepository.findContainByDisabledDiaperToiletOrderDistance(nowLon, nowLat, keyword, keyword, pageable);
             }else if((allDay == false) && (disabled == false) && (kids == true) && (diaper == true)){
                 System.out.println("here!11");
                 return toiletRepository.findContainByKidsDiaperToiletOrderDistance(nowLon, nowLat, keyword, keyword, pageable);
             }else if((allDay == true) && (disabled == true) && (kids == true) && (diaper == false)){
                 System.out.println("here!12");
                 return toiletRepository.findContainByAllDayDisabledKidsToiletOrderDistance(nowLon, nowLat, keyword, keyword, pageable);
             }else if((allDay == true) && (disabled == true) && (kids == false) && (diaper == true)){
                 System.out.println("here!13");
                 return toiletRepository.findContainByAllDayDisabledDiaperToiletOrderDistance(nowLon, nowLat, keyword, keyword, pageable);
             } else if ((allDay == false) && (disabled == true) && (kids == true) && (diaper == true)) {
                 System.out.println("here!14");
                 return toiletRepository.findContainByDisabledKidsDiaperToiletOrderDistance(nowLon, nowLat, keyword, keyword, pageable);
             }
             return toiletRepository.findContainByAllOrderDistance(nowLon, nowLat, keyword, keyword, pageable);
         }
     }

    public Page<ToiletDto> getNearByToilet(BigDecimal nowLon, BigDecimal nowLat, int radius, Boolean allDay, Boolean disabled, Boolean kids, Boolean diaper, Pageable pageable){

        System.out.println("allDay" + allDay + " disabled" + disabled + " kids" + kids + " diaper" + diaper);

         if((allDay == false) && (disabled == false) && (kids == false) && (diaper == false)){
             System.out.println("here!1");
             return toiletRepository.findNearByToilet(nowLon, nowLat, radius, pageable);
         }else if((allDay == true) && (disabled == false) && (kids == false) && (diaper == false)){
             System.out.println("here!2");
             return toiletRepository.findNearByAllDayToilet(nowLon, nowLat, radius, pageable);
         }else if((allDay == false) && (disabled == true) && (kids == false) && (diaper == false)){
             System.out.println("here!3");
             return toiletRepository.findNearByDisabledToilet(nowLon, nowLat, radius, pageable);
         }else if((allDay == false) && (disabled == false) && (kids == true) && (diaper == false)){
             System.out.println("here!4");
             return toiletRepository.findNearByKidsToilet(nowLon, nowLat, radius, pageable);
         }else if((allDay == false) && (disabled == false) && (kids == false) && (diaper == true)){
             System.out.println("here!5");
             return toiletRepository.findNearByDiaperToilet(nowLon, nowLat, radius, pageable);
         }else if((allDay == true) && (disabled == true) && (kids == false) && (diaper == false)){
             System.out.println("here!6");
             return toiletRepository.findNearByAllDayDiabledToilet(nowLon, nowLat, radius, pageable);
         }else if((allDay == true) && (disabled == false) && (kids == true) && (diaper == false)){
             System.out.println("here!7");
             return toiletRepository.findNearByAllDayKidsToilet(nowLon, nowLat, radius, pageable);
         }else if((allDay == true) && (disabled == false) && (kids == false) && (diaper == true)){
             System.out.println("here!8");
             return toiletRepository.findNearByAllDayDiaperToilet(nowLon, nowLat, radius, pageable);
         }else if((allDay == false) && (disabled == true) && (kids == true) && (diaper == false)){
             System.out.println("here!9");
             return toiletRepository.findNearByDisabledKidsToilet(nowLon, nowLat, radius, pageable);
         }else if((allDay == false) && (disabled == true) && (kids == false) && (diaper == true)){
             System.out.println("here!10");
             return toiletRepository.findNearByDisabledDiaperToilet(nowLon, nowLat, radius, pageable);
         }else if((allDay == false) && (disabled == false) && (kids == true) && (diaper == true)){
             System.out.println("here!11");
             return toiletRepository.findNearByKidsDiaperToilet(nowLon, nowLat, radius, pageable);
         }else if((allDay == true) && (disabled == true) && (kids == true) && (diaper == false)){
             System.out.println("here!12");
             return toiletRepository.findNearByAllDayDisabledKidsToilet(nowLon, nowLat, radius, pageable);
         }else if((allDay == true) && (disabled == true) && (kids == false) && (diaper == true)){
             System.out.println("here!13");
             return toiletRepository.findNearByAllDayDisabledDiaperToilet(nowLon, nowLat, radius, pageable);
         } else if ((allDay == false) && (disabled == true) && (kids == true) && (diaper == true)) {
             System.out.println("here!14");
             return toiletRepository.findNearByDisabledKidsDiaperToilet(nowLon, nowLat, radius, pageable);
         }
        System.out.println("here!15");
        return toiletRepository.findNearByAll(nowLon, nowLat, radius, pageable);
    }

}
