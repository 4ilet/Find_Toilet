package com.Fourilet.project.fourilet.data.repository;

import com.Fourilet.project.fourilet.dto.ToiletDto;
import com.Fourilet.project.fourilet.dto.ToiletGetCondition;
import com.Fourilet.project.fourilet.dto.ToiletSearchCondition;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface ToiletRepositoryCustom {
    Page<ToiletDto> nearByToilet(ToiletGetCondition condition, Pageable pageable);
    Page<ToiletDto> searchToiletDistance(ToiletSearchCondition condition, Pageable pageable);
    Page<ToiletDto> searchToiletScore(ToiletSearchCondition condition, Pageable pageable);
    Page<ToiletDto> searchToiletComment(ToiletSearchCondition condition, Pageable pageable);
}
