package com.Fourilet.project.fourilet.controller;

import com.Fourilet.project.fourilet.dto.FolderDto;
import com.Fourilet.project.fourilet.service.FolderService;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/like") // 고정 url 설정
@RequiredArgsConstructor

public class FolderController {
    private final Logger LOGGER = LoggerFactory.getLogger(FolderController.class);

    private final FolderService folderService;

    @GetMapping("/folder/{member_id}")
    public ResponseEntity<List<FolderDto.FolderListDto>> getFolderList(@PathVariable long member_id) {
        LOGGER.info("Call getFolderList");
        List<FolderDto.FolderListDto> folderList = folderService.getFolderList(member_id);
        return new ResponseEntity<>(folderList, HttpStatus.OK);
    }
}