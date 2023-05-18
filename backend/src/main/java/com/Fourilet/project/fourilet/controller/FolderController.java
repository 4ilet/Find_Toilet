package com.Fourilet.project.fourilet.controller;

import com.Fourilet.project.fourilet.config.jwt.service.JwtService;
import com.Fourilet.project.fourilet.data.entity.Folder;
import com.Fourilet.project.fourilet.data.entity.Toilet;
import com.Fourilet.project.fourilet.data.repository.FolderRepository;
import com.Fourilet.project.fourilet.dto.*;
import com.Fourilet.project.fourilet.exception.AtLeastException;
import com.Fourilet.project.fourilet.exception.DuplicationNameException;
import com.Fourilet.project.fourilet.exception.LimitException;
import com.Fourilet.project.fourilet.service.FolderService;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.RequiredArgsConstructor;
import net.bytebuddy.implementation.bytecode.Duplication;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.parameters.P;
import org.springframework.web.bind.annotation.*;

import javax.print.attribute.standard.Media;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.nio.charset.Charset;
import java.util.DuplicateFormatFlagsException;
import java.util.List;

@RestController
@RequestMapping("/like") // 고정 url 설정
@RequiredArgsConstructor
public class FolderController {
    private final Logger LOGGER = LoggerFactory.getLogger(FolderController.class);
    private final FolderService folderService;
    private final JwtService jwtService;

    @GetMapping("/folder")
    @ApiOperation(value = "즐겨찾기 목록", notes = "해당 멤버의 즐겨찾기 목록을 가져온다.")
    public ResponseEntity<?> getFolderList(HttpServletRequest request) {
        String accessToken = request.getHeader("Authorization").replace("Bearer ", "");
        // accessToken으로 id 추출
        Long reqMemberId = jwtService.extractId(accessToken).get();
        Message message = new Message();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(new MediaType("application", "json", Charset.forName("UTF-8")));
        LOGGER.info("Call getFolderList");
        try {
            List<FolderDto.FolderListDto> folderList = folderService.getFolderList(reqMemberId);
            message.setStatus(StatusEnum.OK);
            message.setMessage("즐겨찾기 목록 가져오기 성공");
            message.setData(folderList);
            return new ResponseEntity<>(message, headers, HttpStatus.OK);

        } catch (NullPointerException e){
            message.setStatus(StatusEnum.BAD_REQUEST);
            message.setMessage(String.valueOf(e));
            return new ResponseEntity<>(message, headers, HttpStatus.BAD_REQUEST);
        }
        catch (Exception e) {
            message.setStatus(StatusEnum.INTERNAL_SERVER_ERROR);
            message.setMessage("서버 에러 발생");
            return new ResponseEntity<>(message, headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }

    @DeleteMapping("/delete/folder/{folderId}")
    @ApiOperation(value = "즐겨찾기 삭제", notes = "특정 즐겨찾기 삭제.")
    public ResponseEntity<?> deleteFolder(HttpServletRequest request, @PathVariable long folderId){
        String accessToken = request.getHeader("Authorization").replace("Bearer ", "");
        // accessToken으로 id 추출
        Long reqMemberId = jwtService.extractId(accessToken).get();
        Message message = new Message();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(new MediaType("application", "json", Charset.forName("UTF-8")));

        try {
            folderService.deleteFolder(folderId, reqMemberId);
            message.setStatus(StatusEnum.OK);
            message.setMessage("즐겨찾기 폴더 삭제 성공");
            return new ResponseEntity<>(message, headers, HttpStatus.OK);

        } catch (NullPointerException e) {
            message.setStatus(StatusEnum.BAD_REQUEST);
            message.setMessage(String.valueOf(e));
            return new ResponseEntity<>(message, headers, HttpStatus.BAD_REQUEST);

        } catch (AtLeastException e) {
            message.setStatus(StatusEnum.BAD_REQUEST);
            message.setMessage(String.valueOf(e));
            return new ResponseEntity<>(message, headers, HttpStatus.BAD_REQUEST);
        }
        catch (Exception e) {
            message.setStatus(StatusEnum.INTERNAL_SERVER_ERROR);
            message.setMessage("서버 에러");
            return new ResponseEntity<>(message, headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PutMapping("/update/folder/{folderId}")
    @ApiOperation(value = "즐겨찾기 폴더 이름 수정", notes = "즐겨찾기 폴더의 이름을 변경한다")
    public ResponseEntity<?> updateFolderName(@PathVariable long folderId, @RequestBody FolderDto.UpdateFolderDto update){
        Message message = new Message();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(new MediaType("application", "json", Charset.forName("UTF-8")));
        try {
            folderService.updateFolderName(folderId, update);
            message.setMessage("폴더 이름 변경 성공");
            message.setStatus(StatusEnum.OK);
            return new ResponseEntity<>(message, headers, HttpStatus.OK);

        } catch (IllegalArgumentException e) {
            message.setStatus(StatusEnum.BAD_REQUEST);
            message.setMessage(String.valueOf(e));
            return new ResponseEntity<>(message, headers, HttpStatus.BAD_REQUEST);
        }
    }
    @PostMapping("/create/folder")
    @ApiOperation(value = "즐겨찾기 생성", notes = "해당 멤버의 즐겨찾기 폴더를 생성한다.")
    public ResponseEntity<?> createFolder(HttpServletRequest request, @RequestBody FolderDto.NewFolderDto newFolderDto) throws IOException {
        String accessToken = request.getHeader("Authorization").replace("Bearer ", "");
        // accessToken으로 id 추출
        Long reqMemberId = jwtService.extractId(accessToken).get();
        Message message = new Message();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(new MediaType("application", "json", Charset.forName("UTF-8")));
        try {
            if (newFolderDto.getFolderName() == null){
                message.setStatus(StatusEnum.BAD_REQUEST);
                message.setMessage("잘못된 요청입니다");
                return new ResponseEntity<>(message, headers, HttpStatus.BAD_REQUEST);
            }
            folderService.createFolder(reqMemberId, newFolderDto);
            message.setStatus(StatusEnum.OK);
            message.setMessage("폴더 생성 성공");
            return new ResponseEntity<>(message, headers, HttpStatus.OK);
        } catch (NullPointerException e) {
            message.setStatus(StatusEnum.BAD_REQUEST);
            message.setMessage(String.valueOf(e));
            return new ResponseEntity<>(message, headers, HttpStatus.BAD_REQUEST);

        } catch (LimitException e){
            message.setStatus(StatusEnum.BAD_REQUEST);
            message.setMessage(String.valueOf(e));
            return new ResponseEntity<>(message, headers, HttpStatus.BAD_REQUEST);
        } catch (DuplicationNameException e){
            message.setStatus(StatusEnum.BAD_REQUEST);
            message.setMessage(String.valueOf(e));
            return new ResponseEntity<>(message, headers, HttpStatus.BAD_REQUEST);

        } catch (IllegalArgumentException e) {
            message.setStatus(StatusEnum.BAD_REQUEST);
            message.setMessage(String.valueOf(e));
            return new ResponseEntity<>(message, headers, HttpStatus.BAD_REQUEST);
        }
        catch (Exception e){
            message.setStatus(StatusEnum.INTERNAL_SERVER_ERROR);
            message.setMessage("서버 에러 발생");
            return new ResponseEntity<>(message, headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PostMapping("/add/{folderId}/{toiletId}")
    @ApiOperation(value = "즐겨찾기에 화장실 추가", notes = "즐겨찾기 폴더에 화장실을 추가한다..")
    public ResponseEntity<?> addToilet(@PathVariable("folderId") long folderId, @PathVariable("toiletId") long toiletId){
        Message message = new Message();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(new MediaType("application", "json", Charset.forName("UTF-8")));
        try{
            folderService.addToilet(folderId, toiletId);
            message.setStatus(StatusEnum.OK);
            message.setMessage("화장실 추가 성공");
            return new ResponseEntity<>(message, headers, HttpStatus.OK);
        } catch (NullPointerException e) {
            message.setStatus(StatusEnum.BAD_REQUEST);
            message.setMessage("폴더 혹은 화장실이 존재하지 않습니다");
            return new ResponseEntity<>(message, headers, HttpStatus.BAD_REQUEST);
        } catch (IllegalStateException e){
            message.setStatus(StatusEnum.BAD_REQUEST);
            message.setMessage(String.valueOf(e));
            return new ResponseEntity<>(message, headers, HttpStatus.BAD_REQUEST);
        } catch (Exception e) {
            message.setStatus(StatusEnum.INTERNAL_SERVER_ERROR);
            message.setMessage("서버 에러 발생");
            return new ResponseEntity<>(message, headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @DeleteMapping("/delete/toilet/{folderId}/{toiletId}")
    @ApiOperation(value = "특정 화장실을 즐겨찾기에서 삭제", notes = "특정 화장실을 즐겨찾기에서 삭제")
    public ResponseEntity<?> deleteToilet(HttpServletRequest request, @PathVariable("folderId") long folderId, @PathVariable("toiletId") long toiletId){
        Message message = new Message();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(new MediaType("application", "json", Charset.forName("UTF-8")));
        try {
            folderService.deleteToilet(folderId, toiletId);
            message.setStatus(StatusEnum.OK);
            message.setMessage("삭제 성공");
            return new ResponseEntity<>(message, headers, HttpStatus.OK);
        } catch (NullPointerException e) {
            message.setStatus(StatusEnum.BAD_REQUEST);
            message.setMessage(String.valueOf(e));
            return new ResponseEntity<>(message, headers, HttpStatus.BAD_REQUEST);
        } catch (Exception e) {
            message.setStatus(StatusEnum.INTERNAL_SERVER_ERROR);
            message.setMessage("서버 에러 발생");
            return new ResponseEntity<>(message, headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("/folder/toiletlist/{folderId}")
    @ApiOperation(value = "즐겨찾기 화장실 목록 가져오기", notes = "즐겨찾기 폴더 안에 있는 화장실 목록을 가져온다.")
    public ResponseEntity<?> getToiletList(HttpServletRequest request, @PathVariable("folderId") long folderId, @ApiParam(value = "page=int(시작은 0)") int page){
//        Message message = new Message();
        Message2 message = new Message2();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(new MediaType("application", "json", Charset.forName("UTF-8")));
        String accessToken = request.getHeader("Authorization");
        Long reqMemberId = null;

        if(accessToken != null){
            reqMemberId = jwtService.extractId(accessToken.replace("Bearer ", "")).get();
        }
        System.out.println("reqmemberid" + reqMemberId);
        try {
            ToiletDto2.ToiletDto2WithSize result = folderService.getToiletList(folderId, reqMemberId, page);
            message.setStatus(StatusEnum.OK);
            if (result.getTotalPage() > 0) {
                message.setMessage("목록 가져오기 성공");
            } else {
                message.setMessage("화장실이 즐겨찾기에 없습니다.");
            }
            message.setData(result.getResponse());
            message.setSize(result.getTotalPage());
            return new ResponseEntity<>(message, headers, HttpStatus.OK);
        } catch (NullPointerException e) {
            message.setStatus(StatusEnum.BAD_REQUEST);
            message.setMessage("즐겨찾기 폴더가 존재하지 않습니다.");
            return new ResponseEntity<>(message, headers, HttpStatus.BAD_REQUEST);

        } catch (Exception e) {
            message.setStatus(StatusEnum.INTERNAL_SERVER_ERROR);
            message.setMessage("서버 에러 발생");
            return new ResponseEntity<>(message, headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
