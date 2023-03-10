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
    @JoinColumn(name = "folder")
    private Folder folder;

    @JsonBackReference
    @ManyToOne
    @JoinColumn(name = "toilet")
    private Toilet toilet;

}
