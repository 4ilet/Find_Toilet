package com.Fourilet.project.fourilet.controller;

import com.Fourilet.project.fourilet.data.repository.FolderRepository;
import com.Fourilet.project.fourilet.dto.FolderDto;
import com.Fourilet.project.fourilet.service.FolderService;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.parameters.P;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/like") // 고정 url 설정
@RequiredArgsConstructor
public class FolderController {
    private final Logger LOGGER = LoggerFactory.getLogger(FolderController.class);
    private final FolderService folderService;

    @GetMapping("/folder/{memberId}")
    public ResponseEntity<List<FolderDto.FolderListDto>> getFolderList(@PathVariable long memberId) {
        LOGGER.info("Call getFolderList");
        List<FolderDto.FolderListDto> folderList = folderService.getFolderList(memberId);
        return new ResponseEntity<>(folderList, HttpStatus.OK);

    }

    @DeleteMapping("/delete/folder/{folderId}")
    public void deleteFolder(@PathVariable long folderId){
        folderService.deleteFolder(folderId);
    }
}
