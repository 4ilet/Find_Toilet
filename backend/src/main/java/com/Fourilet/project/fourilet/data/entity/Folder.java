package com.Fourilet.project.fourilet.data.entity;

import lombok.*;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@NoArgsConstructor
@Entity
@Getter @Setter
@AllArgsConstructor
@Builder
@Table(name="folder")
public class Folder {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "folderId")
    private long folderId;

    @Column(name = "folderName")
    private String folderName;

    @ManyToOne
    @JoinColumn(name = "member")
    private Member member;


}
