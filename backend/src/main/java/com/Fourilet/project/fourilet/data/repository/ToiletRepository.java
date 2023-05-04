package com.Fourilet.project.fourilet.data.repository;

import com.Fourilet.project.fourilet.data.entity.Toilet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.Optional;

@Repository
public interface ToiletRepository extends JpaRepository<Toilet, Long>, ToiletRepositoryCustom {

    Optional<Toilet> findById(long toiletId);

    @Query(value = "SELECT CASE WHEN :toiletId in (SELECT toilet FROM bookmark WHERE folder IN (SELECT folder_id FROM folder where member = :memberId)) then (select folder FROM bookmark WHERE toilet = :toiletId) else 0 end FROM toilet as t " +
            "where t.toilet_id = :toiletId",
            nativeQuery = true)
    Long isBookmark(@Param("memberId") long memberId, @Param("toiletId") long toiletId);

    @Query(value = "SELECT Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) FROM toilet as t where t.toilet_id = :toiletId", nativeQuery = true)
    Long calDistance(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletId") long toiletId);
}
