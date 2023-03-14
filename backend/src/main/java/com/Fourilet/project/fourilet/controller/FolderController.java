package com.Fourilet.project.fourilet.controller;

import com.Fourilet.project.fourilet.data.entity.Folder;
import com.Fourilet.project.fourilet.data.entity.Toilet;
import com.Fourilet.project.fourilet.data.repository.FolderRepository;
import com.Fourilet.project.fourilet.dto.FolderDto;
import com.Fourilet.project.fourilet.dto.ToiletDto;
import com.Fourilet.project.fourilet.dto.ToiletDto2;
import com.Fourilet.project.fourilet.service.FolderService;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/like") // 고정 url 설정
@RequiredArgsConstructor
public class FolderController {
    private final Logger LOGGER = LoggerFactory.getLogger(FolderController.class);
    private final FolderService folderService;

    @GetMapping("/folder/{memberId}")
    @ApiOperation(value = "즐겨찾기 목록", notes = "해당 멤버의 즐겨찾기 목록을 가져온다.")
    public ResponseEntity<List<FolderDto.FolderListDto>> getFolderList(@PathVariable long memberId) {
        LOGGER.info("Call getFolderList");
        List<FolderDto.FolderListDto> folderList = folderService.getFolderList(memberId);
        return new ResponseEntity<>(folderList, HttpStatus.OK);

    }

    @DeleteMapping("/delete/folder/{folderId}")
    @ApiOperation(value = "즐겨찾기 삭제", notes = "특정 즐겨찾기 삭제.")

    public void deleteFolder(@PathVariable long folderId){
        folderService.deleteFolder(folderId);
    }

    @PutMapping("/update/folder/{folderId}")
    @ApiOperation(value = "즐겨찾기 폴더 이름 수정", notes = "즐겨찾기 폴더의 이름을 변경한다")
    public ResponseEntity<?> updateFolderName(@PathVariable long folderId, @RequestBody FolderDto folderDto){

        folderService.updateFolderName(folderId, folderDto);
        return new ResponseEntity<>(HttpStatus.OK);
    }
    @PostMapping("/create/folder/{memberId}")
    @ApiOperation(value = "즐겨찾기 생성", notes = "해당 멤버의 즐겨찾기 폴더를 생성한다.")
    public ResponseEntity<?> createFolder(@PathVariable("memberId") long memberId, @RequestBody FolderDto newFolderDto){
        folderService.createFolder(memberId, newFolderDto);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @PostMapping("/add/{folderId}/{toiletId}")
    @ApiOperation(value = "즐겨찾기에 화장실 추가", notes = "즐겨찾기 폴더에 화장실을 추가한다..")
    public ResponseEntity<?> addToilet(@PathVariable("folderId") long folderId, @PathVariable("toiletId") long toiletId){
        folderService.addToilet(folderId, toiletId);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @DeleteMapping("/delete/toilet/{folderId}/{toiletId}")
    @ApiOperation(value = "특정 화장실을 즐겨찾기에서 삭제", notes = "특정 화장실을 즐겨찾기에서 삭제")
    public ResponseEntity<?> deleteToilet(@PathVariable("folderId") long folderId, @PathVariable("toiletId") long toiletId){
        folderService.deleteToilet(folderId, toiletId);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @GetMapping("/folder/toiletlist/{folderId}")
    @ApiOperation(value = "즐겨찾기 화장실 목록 가져오기", notes = "즐겨찾기 폴더 안에 있는 화장실 목록을 가져온다.")
    public ResponseEntity<?> getToiletList(@PathVariable("folderId") long folderId){
        List<ToiletDto2> toiletDtoList = folderService.getToiletList(folderId);
        return new ResponseEntity<>(toiletDtoList, HttpStatus.OK);
    }
}
