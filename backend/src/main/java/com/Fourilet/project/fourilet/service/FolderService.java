package com.Fourilet.project.fourilet.service;

import com.Fourilet.project.fourilet.data.entity.Folder;
import com.Fourilet.project.fourilet.data.entity.Member;
import com.Fourilet.project.fourilet.data.repository.FolderRepository;
import com.Fourilet.project.fourilet.data.repository.MemberRepository;
import com.Fourilet.project.fourilet.dto.FolderDto;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class FolderService {
    private final Logger LOGGER = LoggerFactory.getLogger(FolderService.class);

    private final FolderRepository folderRepository;
    private final MemberRepository memberRepository;
    long memberId = 1;

    public List<FolderDto.FolderListDto> getFolderList(long member_id) {
        LOGGER.info("call folderServiceIm.getFolderList");
        Member member = memberRepository.findById(memberId);
        List<Folder> folderList = folderRepository.findAllByMember(member);

        List<FolderDto.FolderListDto> folderListDto = new ArrayList<>();

        for (Folder folder : folderList) {
            FolderDto.FolderListDto folderListDto1 = new FolderDto.FolderListDto();
            folderListDto1.setFolderId(folder.getFolderId());
            folderListDto1.setFolderName(folder.getFolderName());
            folderListDto.add(folderListDto1);
        }
        return folderListDto;

    }


}
