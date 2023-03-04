package com.Fourilet.project.fourilet.data.entity;

import lombok.*;

import javax.persistence.*;
@Entity
@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name= "bookmark" )
public class BookMark {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "bookmarkId")
    private long BookMarkId;

    @ManyToOne
    @JoinColumn(name = "folderId", referencedColumnName = "folderId")
    private Folder folder;

    @ManyToOne
    @JoinColumn(name = "toiletId", referencedColumnName = "toiletId")
    private Toilet toilet;

}
