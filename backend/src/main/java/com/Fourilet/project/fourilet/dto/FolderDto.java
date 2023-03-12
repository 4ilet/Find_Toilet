package com.Fourilet.project.fourilet.dto;


import com.Fourilet.project.fourilet.data.entity.Member;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

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
        private String FolderName;
        private long folderId;
        private long folderLen;
    }
//    @Getter
//    @Setter
//    public static class newFolderDto {
//        private Member member;
//        private String folderName;
//    }

}
