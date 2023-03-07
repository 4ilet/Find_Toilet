package com.Fourilet.project.fourilet.service;

import com.Fourilet.project.fourilet.data.entity.BookMark;
import com.Fourilet.project.fourilet.data.entity.Folder;
import com.Fourilet.project.fourilet.data.entity.Member;
import com.Fourilet.project.fourilet.data.repository.BookMarkRepository;
import com.Fourilet.project.fourilet.data.repository.FolderRepository;
import com.Fourilet.project.fourilet.data.repository.MemberRepository;
import com.Fourilet.project.fourilet.dto.FolderDto;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class FolderService {
    private final Logger LOGGER = LoggerFactory.getLogger(FolderService.class);
    private final FolderRepository folderRepository;
    private final MemberRepository memberRepository;
    private final BookMarkRepository bookMarkRepository;
    private final BookMarkService bookMarkService;

    public List<FolderDto.FolderListDto> getFolderList(long memberId) {
        LOGGER.info("call folderServiceIm.getFolderList");
        Member member = memberRepository.findById(memberId);
        List<Folder> memberFolderList = folderRepository.findAllByMember(member);
        List<FolderDto.FolderListDto> folderListDto = new ArrayList<>();

        for (Folder folder : memberFolderList) {
            FolderDto.FolderListDto folderListDto1 = new FolderDto.FolderListDto();
            folderListDto1.setFolderId(folder.getFolderId());
            folderListDto1.setFolderName(folder.getFolderName());
            folderListDto1.setFolderLen(bookMarkRepository.countByFolderId(folder));

            folderListDto.add(folderListDto1);
        }
        return folderListDto;
    }

    // null일때 예외처리해야함.
    public void deleteFolder(long folderId) {
        Folder folder = folderRepository.findById(folderId).orElse(null);
//        System.out.println(folder.getFolderName());
        List<BookMark> bookmarkList = bookMarkRepository.findAllByFolderId(folder);
//        System.out.println(bookmarkList.size());
        if (bookmarkList.size() > 0) {
            for (BookMark bookmark : bookmarkList) {
                bookMarkRepository.delete(bookmark);
            }
        }
        folderRepository.delete(folder);
    }
}
