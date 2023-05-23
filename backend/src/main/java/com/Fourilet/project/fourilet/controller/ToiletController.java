package com.Fourilet.project.fourilet.controller;

import com.Fourilet.project.fourilet.config.jwt.service.JwtService;
import com.Fourilet.project.fourilet.data.entity.Toilet;
import com.Fourilet.project.fourilet.dto.Message;
import com.Fourilet.project.fourilet.dto.StatusEnum;
import com.Fourilet.project.fourilet.dto.ToiletDto;
import com.Fourilet.project.fourilet.service.ToiletService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.nio.charset.Charset;
import java.util.Map;

@Api(tags = "Toilet API")
@RestController
@AllArgsConstructor
@RequestMapping("/toilet")
public class ToiletController {
    @Autowired
    private ToiletService toiletService;
    private final JwtService jwtService;

    @GetMapping("/search")
    @ApiOperation(value = "화장실 검색 API", notes = "order는 없을 시 가까운 순으로 정렬됩니다! \n 예시 : http://localhost:8080/toilet/search?lon=127.0590&lat=37.5842&page=0&size=10&allDay=0&disabled=0&kids=0&diaper=0&keyword=종로구 청운동")
    public ResponseEntity<?> getSearchToilet(
            HttpServletRequest request,
            @ApiParam(value = "유저의 경도(longitude)") @RequestParam("lon") BigDecimal lon, @ApiParam(value = "유저의 위도(latitude)") @RequestParam("lat") BigDecimal lat,
            @ApiParam(value = "검색 키워드") @RequestParam("keyword") String keyword, @ApiParam(value = "정렬 기준 (distance(가까운 순, 기본값) / score(평점 높은 순) / comment(리뷰 많은 순))") @RequestParam(value = "order", required = false, defaultValue = "distance") String order,
            @ApiParam(value = "24시간 유무 (필터링 사용하면 1 / 사용 안 하면 0)") @RequestParam("allDay") Boolean allDay, @ApiParam(value = "장애인용 유무 (필터링 사용하면 1 / 사용 안 하면 0)") @RequestParam("disabled") Boolean disabled,
            @ApiParam(value = "어린이용 유무 (필터링 사용하면 1 / 사용 안 하면 0)") @RequestParam("kids") Boolean kids, @ApiParam(value = "기저귀 교환대 유무 (필터링 사용하면 1 / 사용 안 하면 0)") @RequestParam("diaper") Boolean diaper,
            @ApiParam(value = "page=int(시작은 0)?size=int(한 페이지당 나올 개수)") Pageable pageable) {

        Message message = new Message();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(new MediaType("application", "json", Charset.forName("UTF-8")));

        String accessToken = request.getHeader("Authorization");

        Long reqMemberId = null;

        if (accessToken != null) {
            reqMemberId = jwtService.extractId(accessToken.replace("Bearer ", "")).get();
        }

        try {
            Map<String, Object> page = toiletService.getSearchToilet(reqMemberId, lon, lat, allDay, disabled, kids, diaper, keyword, order, pageable);
            return ResponseEntity.ok().body(page);

        } catch (IllegalArgumentException e) {
            message.setStatus(StatusEnum.BAD_REQUEST);
            message.setMessage("정렬 기준이 올바르지 않습니다.");
            return new ResponseEntity<>(message, headers, HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping("/near")
    @ApiOperation(value = "주변 화장실 API", notes = "유저 좌표 기준 지정한 반경 내 주변 화장실 목록을 반환합니다!")
    public ResponseEntity<?> getNearByToilet(HttpServletRequest request, @ApiParam(value = "유저의 경도(longitude)") @RequestParam("lon") BigDecimal lon, @ApiParam(value = "유저의 위도(latitude)") @RequestParam("lat") BigDecimal lat, @ApiParam(value = "반경") @RequestParam("radius") long radius,
                                                           @ApiParam(value = "24시간 유무 (필터링 사용하면 1 / 사용 안 하면 0)") @RequestParam("allDay") Boolean allDay, @ApiParam(value = "장애인용 유무 (필터링 사용하면 1 / 사용 안 하면 0)") @RequestParam("disabled") Boolean disabled,
                                                           @ApiParam(value = "어린이용 유무 (필터링 사용하면 1 / 사용 안 하면 0)") @RequestParam("kids") Boolean kids, @ApiParam(value = "기저귀 교환대 유무 (필터링 사용하면 1 / 사용 안 하면 0)") @RequestParam("diaper") Boolean diaper,
                                                           @ApiParam(value = "page=int(시작은 0)?size=int(한 페이지당 나올 개수)") Pageable pageable) {

        String accessToken = request.getHeader("Authorization");

        Long reqMemberId = null;

        if (accessToken != null) {
            reqMemberId = jwtService.extractId(accessToken.replace("Bearer ", "")).get();
        }

        System.out.println("memberId"+reqMemberId);

        Map<String, Object> page = toiletService.getNearToilet(reqMemberId, lon, lat, radius, allDay, disabled, kids, diaper, pageable);

        return ResponseEntity.ok().body(page);
    }
}
