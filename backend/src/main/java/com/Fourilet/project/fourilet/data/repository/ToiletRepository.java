package com.Fourilet.project.fourilet.data.repository;

import com.Fourilet.project.fourilet.data.entity.Toilet;
import com.Fourilet.project.fourilet.dto.ToiletDto;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Repository
public interface ToiletRepository extends JpaRepository<Toilet, Long> {

    Optional<Toilet> findById(long toiletId);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) <= :radius " +
            " GROUP BY t.toilet_id " +
            "ORDER BY distance"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) <= :radius " +
            " GROUP BY t.toilet_id " +
            "ORDER BY distance",nativeQuery = true)
    Page<ToiletDto> findNearByToilet(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("radius") int radius, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN  review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) <= :radius) and t.all_day is true" +
            " GROUP BY t.toilet_id " +
            "ORDER BY distance"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN  review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) <= :radius) and t.all_day is true" +
            " GROUP BY t.toilet_id " +
            "ORDER BY distance",nativeQuery = true)
    Page<ToiletDto> findNearByAllDayToilet(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("radius") int radius, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) <= :radius) and (t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true)" +
            " GROUP BY t.toilet_id " +
            "ORDER BY distance"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) <= :radius) and (t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true)" +
            " GROUP BY t.toilet_id " +
            "ORDER BY distance",nativeQuery = true)
    Page<ToiletDto> findNearByDisabledToilet(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("radius") int radius, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) <= :radius) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true)" +
            " GROUP BY t.toilet_id " +
            "ORDER BY distance"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) <= :radius) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true)" +
            " GROUP BY t.toilet_id " +
            "ORDER BY distance",nativeQuery = true)
    Page<ToiletDto> findNearByKidsToilet(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("radius") int radius, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) <= :radius and t.diaper is true" +
            " GROUP BY t.toilet_id " +
            "ORDER BY distance"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) <= :radius) and t.diaper is true" +
            " GROUP BY t.toilet_id " +
            "ORDER BY distance",nativeQuery = true)
    Page<ToiletDto> findNearByDiaperToilet(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("radius") int radius, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) <= :radius and (t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true) and t.all_day is true" +
            " GROUP BY t.toilet_id " +
            "ORDER BY distance"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) <= :radius) and (t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true) and t.all_day is true" +
            " GROUP BY t.toilet_id " +
            "ORDER BY distance",nativeQuery = true)
    Page<ToiletDto> findNearByAllDayDiabledToilet(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("radius") int radius, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) <= :radius) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and t.all_day is true" +
            " GROUP BY t.toilet_id " +
            "ORDER BY distance"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) <= :radius) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and t.all_day is true" +
            " GROUP BY t.toilet_id " +
            "ORDER BY distance",nativeQuery = true)
    Page<ToiletDto> findNearByAllDayKidsToilet(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("radius") int radius, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) <= :radius and t.diaper is true and t.all_day is true" +
            " GROUP BY t.toilet_id " +
            "ORDER BY distance"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) <= :radius) and t.diaper is true and t.all_day is true" +
            " GROUP BY t.toilet_id " +
            "ORDER BY distance",nativeQuery = true)
    Page<ToiletDto> findNearByAllDayDiaperToilet(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("radius") int radius, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) <= :radius) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and (t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true)" +
            " GROUP BY t.toilet_id " +
            "ORDER BY distance"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) <= :radius) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and (t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true)" +
            " GROUP BY t.toilet_id " +
            "ORDER BY distance",nativeQuery = true)
    Page<ToiletDto> findNearByDisabledKidsToilet(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("radius") int radius, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) <= :radius) and t.diaper is true and (t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true)" +
            " GROUP BY t.toilet_id " +
            "ORDER BY distance"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) <= :radius) and t.diaper is true and (t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true)" +
            " GROUP BY t.toilet_id " +
            "ORDER BY distance",nativeQuery = true)
    Page<ToiletDto> findNearByDisabledDiaperToilet(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("radius") int radius, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) <= :radius) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and t.diaper is true" +
            " GROUP BY t.toilet_id " +
            "ORDER BY distance"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) <= :radius) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and t.diaper is true" +
            " GROUP BY t.toilet_id " +
            "ORDER BY distance",nativeQuery = true)
    Page<ToiletDto> findNearByKidsDiaperToilet(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("radius") int radius, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) <= :radius) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and " +
            "(t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true) and t.all_day is true" +
            " GROUP BY t.toilet_id " +
            "ORDER BY distance"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) <= :radius) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and " +
            "(t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true) and t.all_day is true" +
            " GROUP BY t.toilet_id " +
            "ORDER BY distance",nativeQuery = true)
    Page<ToiletDto> findNearByAllDayDisabledKidsToilet(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("radius") int radius, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) <= :radius) and t.diaper is true and " +
            "(t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true) and t.all_day is true" +
            " GROUP BY t.toilet_id " +
            "ORDER BY distance"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) <= :radius) and t.diaper is true and " +
            "(t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true) and t.all_day is true" +
            " GROUP BY t.toilet_id " +
            "ORDER BY distance",nativeQuery = true)
    Page<ToiletDto> findNearByAllDayDisabledDiaperToilet(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("radius") int radius, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) <= :radius) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and " +
            "(t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true) and t.diaper is true" +
            " GROUP BY t.toilet_id " +
            "ORDER BY distance"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) <= :radius) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and " +
            "(t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true) and t.diaper is true" +
            " GROUP BY t.toilet_id " +
            "ORDER BY distance",nativeQuery = true)
    Page<ToiletDto> findNearByDisabledKidsDiaperToilet(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("radius") int radius, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) <= :radius) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and " +
            "(t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true) and t.all_day is true and t.diaper is true" +
            " GROUP BY t.toilet_id " +
            "ORDER BY distance"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) <= :radius) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and " +
            "(t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true) and t.all_day is true and t.diaper is true" +
            " GROUP BY t.toilet_id " +
            "ORDER BY distance",nativeQuery = true)
    Page<ToiletDto> findNearByAll(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("radius") int radius, Pageable pageable);


    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%" +
            " GROUP BY t.toilet_id ORDER BY distance"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%" +
            " GROUP BY t.toilet_id ORDER BY distance ",nativeQuery = true)
    Page<ToiletDto> findContainByToiletOrderDistance(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN  review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and t.all_day is true" +
            " GROUP BY t.toilet_id ORDER BY distance"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN  review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and t.all_day is true" +
            " GROUP BY t.toilet_id ORDER BY distance",nativeQuery = true)
    Page<ToiletDto> findContainByAllDayToiletOrderDistance(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true)" +
            " GROUP BY t.toilet_id ORDER BY distance"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true)" +
            " GROUP BY t.toilet_id ORDER BY distance",nativeQuery = true)
    Page<ToiletDto> findContainByDisabledToiletOrderDistance(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true)" +
            " GROUP BY t.toilet_id ORDER BY distance"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true)" +
            " GROUP BY t.toilet_id ORDER BY distance",nativeQuery = true)
    Page<ToiletDto> findContainByKidsToiletOrderDistance(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address% and t.diaper is true" +
            " GROUP BY t.toilet_id ORDER BY distance"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and t.diaper is true" +
            " GROUP BY t.toilet_id ORDER BY distance",nativeQuery = true)
    Page<ToiletDto> findContainByDiaperToiletOrderDistance(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address% and (t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true) and t.all_day is true" +
            " GROUP BY t.toilet_id ORDER BY distance"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true) and t.all_day is true" +
            " GROUP BY t.toilet_id ORDER BY distance",nativeQuery = true)
    Page<ToiletDto> findContainByAllDayDiabledToiletOrderDistance(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and t.all_day is true" +
            " GROUP BY t.toilet_id ORDER BY distance"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and t.all_day is true" +
            " GROUP BY t.toilet_id ORDER BY distance",nativeQuery = true)
    Page<ToiletDto> findContainByAllDayKidsToiletOrderDistance(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address% and t.diaper is true and t.all_day is true" +
            " GROUP BY t.toilet_id ORDER BY distance"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and t.diaper is true and t.all_day is true" +
            " GROUP BY t.toilet_id ORDER BY distance",nativeQuery = true)
    Page<ToiletDto> findContainByAllDayDiaperToiletOrderDistance(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and (t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true)" +
            " GROUP BY t.toilet_id ORDER BY distance"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and (t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true)" +
            " GROUP BY t.toilet_id ORDER BY distance",nativeQuery = true)
    Page<ToiletDto> findContainByDisabledKidsToiletOrderDistance(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and t.diaper is true and (t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true)" +
            " GROUP BY t.toilet_id ORDER BY distance"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and t.diaper is true and (t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true)" +
            " GROUP BY t.toilet_id ORDER BY distance",nativeQuery = true)
    Page<ToiletDto> findContainByDisabledDiaperToiletOrderDistance(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and t.diaper is true" +
            " GROUP BY t.toilet_id ORDER BY distance"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and t.diaper is true" +
            " GROUP BY t.toilet_id ORDER BY distance",nativeQuery = true)
    Page<ToiletDto> findContainByKidsDiaperToiletOrderDistance(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and " +
            "(t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true) and t.all_day is true" +
            " GROUP BY t.toilet_id ORDER BY distance"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and " +
            "(t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true) and t.all_day is true" +
            " GROUP BY t.toilet_id ORDER BY distance",nativeQuery = true)
    Page<ToiletDto> findContainByAllDayDisabledKidsToiletOrderDistance(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and t.diaper is true and " +
            "(t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true) and t.all_day is true" +
            " GROUP BY t.toilet_id ORDER BY distance"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and t.diaper is true and " +
            "(t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true) and t.all_day is true" +
            " GROUP BY t.toilet_id ORDER BY distance",nativeQuery = true)
    Page<ToiletDto> findContainByAllDayDisabledDiaperToiletOrderDistance(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and " +
            "(t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true) and t.diaper is true" +
            " GROUP BY t.toilet_id ORDER BY distance"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and " +
            "(t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true) and t.diaper is true" +
            " GROUP BY t.toilet_id ORDER BY distance",nativeQuery = true)
    Page<ToiletDto> findContainByDisabledKidsDiaperToiletOrderDistance(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and " +
            "(t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true) and t.all_day is true and t.diaper is true" +
            " GROUP BY t.toilet_id ORDER BY distance"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and " +
            "(t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true) and t.all_day is true and t.diaper is true" +
            " GROUP BY t.toilet_id ORDER BY distance", nativeQuery = true)
    Page<ToiletDto> findContainByAllOrderDistance(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%" +
            " GROUP BY t.toilet_id ORDER BY score DESC"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%" +
            " GROUP BY t.toilet_id ORDER BY score DESC ",nativeQuery = true)
    Page<ToiletDto> findContainByToiletOrderScore(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN  review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and t.all_day is true" +
            " GROUP BY t.toilet_id ORDER BY score DESC"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN  review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and t.all_day is true" +
            " GROUP BY t.toilet_id ORDER BY score DESC",nativeQuery = true)
    Page<ToiletDto> findContainByAllDayToiletOrderScore(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true)" +
            " GROUP BY t.toilet_id ORDER BY score DESC"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true)" +
            " GROUP BY t.toilet_id ORDER BY score DESC",nativeQuery = true)
    Page<ToiletDto> findContainByDisabledToiletOrderScore(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true)" +
            " GROUP BY t.toilet_id ORDER BY score DESC"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true)" +
            " GROUP BY t.toilet_id ORDER BY score DESC",nativeQuery = true)
    Page<ToiletDto> findContainByKidsToiletOrderScore(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address% and t.diaper is true" +
            " GROUP BY t.toilet_id ORDER BY score DESC"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and t.diaper is true" +
            " GROUP BY t.toilet_id ORDER BY score DESC",nativeQuery = true)
    Page<ToiletDto> findContainByDiaperToiletOrderScore(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address% and (t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true) and t.all_day is true" +
            " GROUP BY t.toilet_id ORDER BY score DESC"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true) and t.all_day is true" +
            " GROUP BY t.toilet_id ORDER BY score DESC",nativeQuery = true)
    Page<ToiletDto> findContainByAllDayDiabledToiletOrderScore(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and t.all_day is true" +
            " GROUP BY t.toilet_id ORDER BY score DESC"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and t.all_day is true" +
            " GROUP BY t.toilet_id ORDER BY score DESC",nativeQuery = true)
    Page<ToiletDto> findContainByAllDayKidsToiletOrderScore(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address% and t.diaper is true and t.all_day is true" +
            " GROUP BY t.toilet_id ORDER BY score DESC"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and t.diaper is true and t.all_day is true" +
            " GROUP BY t.toilet_id ORDER BY score DESC",nativeQuery = true)
    Page<ToiletDto> findContainByAllDayDiaperToiletOrderScore(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and (t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true)" +
            " GROUP BY t.toilet_id ORDER BY score DESC"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and (t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true)" +
            " GROUP BY t.toilet_id ORDER BY score DESC",nativeQuery = true)
    Page<ToiletDto> findContainByDisabledKidsToiletOrderScore(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and t.diaper is true and (t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true)" +
            " GROUP BY t.toilet_id ORDER BY score DESC"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and t.diaper is true and (t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true)" +
            " GROUP BY t.toilet_id ORDER BY score DESC",nativeQuery = true)
    Page<ToiletDto> findContainByDisabledDiaperToiletOrderScore(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and t.diaper is true" +
            " GROUP BY t.toilet_id ORDER BY score DESC"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and t.diaper is true" +
            " GROUP BY t.toilet_id ORDER BY score DESC",nativeQuery = true)
    Page<ToiletDto> findContainByKidsDiaperToiletOrderScore(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and " +
            "(t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true) and t.all_day is true" +
            " GROUP BY t.toilet_id ORDER BY score DESC"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and " +
            "(t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true) and t.all_day is true" +
            " GROUP BY t.toilet_id ORDER BY score DESC",nativeQuery = true)
    Page<ToiletDto> findContainByAllDayDisabledKidsToiletOrderScore(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and t.diaper is true and " +
            "(t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true) and t.all_day is true" +
            " GROUP BY t.toilet_id ORDER BY score DESC"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and t.diaper is true and " +
            "(t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true) and t.all_day is true" +
            " GROUP BY t.toilet_id ORDER BY score DESC",nativeQuery = true)
    Page<ToiletDto> findContainByAllDayDisabledDiaperToiletOrderScore(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and " +
            "(t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true) and t.diaper is true" +
            " GROUP BY t.toilet_id ORDER BY score DESC"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and " +
            "(t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true) and t.diaper is true" +
            " GROUP BY t.toilet_id ORDER BY score DESC",nativeQuery = true)
    Page<ToiletDto> findContainByDisabledKidsDiaperToiletOrderScore(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and " +
            "(t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true) and t.all_day is true and t.diaper is true" +
            " GROUP BY t.toilet_id ORDER BY score DESC"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and " +
            "(t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true) and t.all_day is true and t.diaper is true" +
            " GROUP BY t.toilet_id ORDER BY score DESC", nativeQuery = true)
    Page<ToiletDto> findContainByAllOrderScore(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%" +
            " GROUP BY t.toilet_id ORDER BY comment DESC"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%" +
            " GROUP BY t.toilet_id ORDER BY comment DESC ",nativeQuery = true)
    Page<ToiletDto> findContainByToiletOrderComment(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN  review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and t.all_day is true" +
            " GROUP BY t.toilet_id ORDER BY comment DESC"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN  review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and t.all_day is true" +
            " GROUP BY t.toilet_id ORDER BY comment DESC",nativeQuery = true)
    Page<ToiletDto> findContainByAllDayToiletOrderComment(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true)" +
            " GROUP BY t.toilet_id ORDER BY comment DESC"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true)" +
            " GROUP BY t.toilet_id ORDER BY comment DESC",nativeQuery = true)
    Page<ToiletDto> findContainByDisabledToiletOrderComment(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true)" +
            " GROUP BY t.toilet_id ORDER BY comment DESC"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true)" +
            " GROUP BY t.toilet_id ORDER BY comment DESC",nativeQuery = true)
    Page<ToiletDto> findContainByKidsToiletOrderComment(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address% and t.diaper is true" +
            " GROUP BY t.toilet_id ORDER BY comment DESC"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and t.diaper is true" +
            " GROUP BY t.toilet_id ORDER BY comment DESC",nativeQuery = true)
    Page<ToiletDto> findContainByDiaperToiletOrderComment(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address% and (t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true) and t.all_day is true" +
            " GROUP BY t.toilet_id ORDER BY comment DESC"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true) and t.all_day is true" +
            " GROUP BY t.toilet_id ORDER BY comment DESC",nativeQuery = true)
    Page<ToiletDto> findContainByAllDayDiabledToiletOrderComment(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and t.all_day is true" +
            " GROUP BY t.toilet_id ORDER BY comment DESC"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and t.all_day is true" +
            " GROUP BY t.toilet_id ORDER BY comment DESC",nativeQuery = true)
    Page<ToiletDto> findContainByAllDayKidsToiletOrderComment(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address% and t.diaper is true and t.all_day is true" +
            " GROUP BY t.toilet_id ORDER BY comment DESC"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and t.diaper is true and t.all_day is true" +
            " GROUP BY t.toilet_id ORDER BY comment DESC",nativeQuery = true)
    Page<ToiletDto> findContainByAllDayDiaperToiletOrderComment(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and (t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true)" +
            " GROUP BY t.toilet_id ORDER BY comment DESC"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and (t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true)" +
            " GROUP BY t.toilet_id ORDER BY comment DESC",nativeQuery = true)
    Page<ToiletDto> findContainByDisabledKidsToiletOrderComment(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and t.diaper is true and (t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true)" +
            " GROUP BY t.toilet_id ORDER BY comment DESC"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and t.diaper is true and (t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true)" +
            " GROUP BY t.toilet_id ORDER BY comment DESC",nativeQuery = true)
    Page<ToiletDto> findContainByDisabledDiaperToiletOrderComment(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and t.diaper is true" +
            " GROUP BY t.toilet_id ORDER BY comment DESC"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and t.diaper is true" +
            " GROUP BY t.toilet_id ORDER BY comment DESC",nativeQuery = true)
    Page<ToiletDto> findContainByKidsDiaperToiletOrderComment(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and " +
            "(t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true) and t.all_day is true" +
            " GROUP BY t.toilet_id ORDER BY comment DESC"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and " +
            "(t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true) and t.all_day is true" +
            " GROUP BY t.toilet_id ORDER BY comment DESC",nativeQuery = true)
    Page<ToiletDto> findContainByAllDayDisabledKidsToiletOrderComment(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and t.diaper is true and " +
            "(t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true) and t.all_day is true" +
            " GROUP BY t.toilet_id ORDER BY comment DESC"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and t.diaper is true and " +
            "(t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true) and t.all_day is true" +
            " GROUP BY t.toilet_id ORDER BY comment DESC",nativeQuery = true)
    Page<ToiletDto> findContainByAllDayDisabledDiaperToiletOrderComment(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and " +
            "(t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true) and t.diaper is true" +
            " GROUP BY t.toilet_id ORDER BY comment DESC"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and " +
            "(t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true) and t.diaper is true" +
            " GROUP BY t.toilet_id ORDER BY comment DESC",nativeQuery = true)
    Page<ToiletDto> findContainByDisabledKidsDiaperToiletOrderComment(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);

    @Query(value = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and " +
            "(t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true) and t.all_day is true and t.diaper is true" +
            " GROUP BY t.toilet_id ORDER BY comment DESC"
            , countQuery = "SELECT t.toilet_id as toiletId, t.toilet_name as toiletName, t.address as address, t.operation_time as operationTime, t.lon as lon, t.lat as lat, " +
            "t.phone_number as phoneNumber, t.d_male_pee as dMalePee, t.d_male_poo as dMalePoo, t.d_female_poo as dFemalePoo, t.c_female_poo as cFemalePoo, " +
            "t.c_male_pee as cMalePee, t.c_male_poo as cMalePoo, t.all_day as allDay, t.diaper as diaper, Round(ST_Distance_Sphere(Point(:nowLon,:nowLat),POINT(t.lon, t.lat)), 0) as distance," +
            "COALESCE(avg(r.score), 0) as score, COUNT(r.review_id) as comment, CASE WHEN toilet_id in (SELECT toilet FROM bookmark" +
            "WHERE FOLDER IN (SELECT folder_id FROM folder where member = 16)) " +
            "THEN TRUE ELSE FALSE END AS isLike " +
            "FROM toilet as t " +
            "LEFT JOIN review as r ON r.toilet_id = t.toilet_id " +
            "WHERE (t.toilet_Name LIKE %:toiletName% or t.address LIKE %:address%) and (t.c_female_poo is true or t.c_male_pee is true or t.c_male_poo is true) and " +
            "(t.d_female_poo is true or t.d_male_pee is true or t.d_male_poo is true) and t.all_day is true and t.diaper is true" +
            " GROUP BY t.toilet_id ORDER BY comment DESC", nativeQuery = true)
    Page<ToiletDto> findContainByAllOrderComment(@Param("nowLon") BigDecimal nowLon, @Param("nowLat") BigDecimal nowLat, @Param("toiletName") String toiletName, @Param("address") String address, Pageable pageable);
}
