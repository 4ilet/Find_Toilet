package com.Fourilet.project.fourilet.controller;

import com.Fourilet.project.fourilet.data.entity.Member;
import com.Fourilet.project.fourilet.data.entity.Toilet;
import com.Fourilet.project.fourilet.dto.ToiletDto;
import com.Fourilet.project.fourilet.service.ToiletService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.math.BigDecimal;
import java.util.Iterator;
import java.util.List;
import java.util.function.Function;

@Api(tags = "Toilet API")
@RestController
@AllArgsConstructor
@RequestMapping("/toilet")
public class ToiletController {
    @Autowired
    private ToiletService toiletService;

    @GetMapping("/search")
    @ApiOperation(value = "화장실 검색 API", notes = "order는 없을 시 가까운 순으로 정렬됩니다!")
    public ResponseEntity<Page<ToiletDto>> getSearchWithoutFilter(@RequestParam("lon") BigDecimal lon, @RequestParam("lat") BigDecimal lat, @RequestParam("keyword") String keyword, @RequestParam(value = "order", required = false, defaultValue = "distance") String order, @RequestParam("allDay") Boolean allDay, @RequestParam("disabled") Boolean disabled, @RequestParam("kids") Boolean kids, @RequestParam("diaper") Boolean diaper, Pageable pageable){

        Page<ToiletDto> result = toiletService.getSearchResult(keyword, order, lon, lat, allDay, disabled, kids, diaper, pageable);

        return ResponseEntity.ok().body(result);
    }

   @GetMapping("/near")
    public ResponseEntity<Page<ToiletDto>> getNearByToilet(@RequestParam("lon") BigDecimal lon, @RequestParam("lat") BigDecimal lat, @RequestParam("radius") int radius, @RequestParam("allDay") Boolean allDay, @RequestParam("disabled") Boolean disabled, @RequestParam("kids") Boolean kids, @RequestParam("diaper") Boolean diaper, Pageable pageable){
        Page<ToiletDto> page = toiletService.getNearByToilet(lon, lat, radius, allDay, disabled, kids, diaper, pageable);
        return ResponseEntity.ok().body(page);
   }

//    @GetMapping("/")
//    public Page<Toilet> getTest(Pageable pageable){
//        Page<Toilet> page = toiletService.getTest(pageable);
//        return page;
//    }
}
