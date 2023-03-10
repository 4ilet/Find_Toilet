package com.Fourilet.project.fourilet.data.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
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

    @JsonBackReference
    @ManyToOne
    @JoinColumn(name = "folderId", referencedColumnName = "folderId")
    private Folder folderId;

    @JsonBackReference
    @ManyToOne
    @JoinColumn(name = "toiletId", referencedColumnName = "toiletId")
    private Toilet toilet;

}
