package com.Fourilet.project.fourilet.dto;


import com.Fourilet.project.fourilet.data.entity.Member;
import io.swagger.annotations.ApiParam;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class FolderDto {
    private long folderId;
    private String folderName;
    private Member member;
    @Getter
    @Setter
    public static class FolderListDto {
        @ApiParam(value = "즐겨찾기 폴더 이름", type = "String")
        private String FolderName;
        @ApiParam(value = "즐겨찾기 폴더 ID", type = "long")
        private long folderId;
        @ApiParam(value = "즐겨찾기 폴더의 길이", type = "long")
        private long folderLen;
    }
    @Getter
    @Setter
    public static class NewFolderDto {
        @ApiParam(value = "즐겨찾기 폴더 이름", type = "String")
        private String folderName;

    }
    @Getter
    @Setter
    public static class UpdateFolderDto {
        @ApiParam(value = "즐겨찾기 폴더 이름", type = "String")
        private String folderName;
    }
    @Getter
    @Setter
    public static class AddOrDelToiletDto {
        @ApiParam(value = "추가할 즐겨찾기 폴더 목록", type = "List")
        private List<Long> AddFolderIdList;
        @ApiParam(value = "삭제할 즐겨찾기 폴더 목록", type = "List")
        private List<Long> DelFolderIdList;
        @ApiParam(value = "화장실 아이디", type = "long")
        private long toiletId;
    }

}

