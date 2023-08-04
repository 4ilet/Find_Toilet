package com.Fourilet.project.fourilet.data.repository;

import com.Fourilet.project.fourilet.dto.QToiletDto;
import com.Fourilet.project.fourilet.dto.ToiletDto;
import com.Fourilet.project.fourilet.dto.ToiletGetCondition;
import com.Fourilet.project.fourilet.dto.ToiletSearchCondition;
import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.QueryResults;
import com.querydsl.core.types.Order;
import com.querydsl.core.types.OrderSpecifier;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.core.types.dsl.Expressions;
import com.querydsl.jpa.impl.JPAQueryFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.querydsl.QuerydslUtils;

import javax.persistence.EntityManager;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import static com.Fourilet.project.fourilet.data.entity.QReview.review;
import static com.Fourilet.project.fourilet.data.entity.QToilet.toilet;

public class ToiletRepositoryImpl implements ToiletRepositoryCustom{

    private final JPAQueryFactory queryFactory;

    public ToiletRepositoryImpl(EntityManager em){
        this.queryFactory = new JPAQueryFactory(em);
    }

    public List<Long> emptyList = Collections.emptyList();
    @Override
    public Page<ToiletDto> nearByToilet(ToiletGetCondition condition, Pageable pageable){
        int maxPageSize = 150;
        int requestedPageSize = pageable.getPageSize();
        int effectivePageSize = Math.min(maxPageSize, requestedPageSize);
        QueryResults<ToiletDto> result = queryFactory.select(
                        new QToiletDto(
                                toilet.toiletId,
                                toilet.toiletName,
                                toilet.address,
                                toilet.operationTime,
                                toilet.lat,
                                toilet.lon,
                                toilet.phoneNumber,
                                review.score.coalesce((float)0).avg().as("score"),
                                review.count().as("comment"),
                                toilet.dMalePee,
                                toilet.dMalePoo,
                                toilet.dFemalePoo,
                                toilet.cFemalePoo,
                                toilet.cMalePee,
                                toilet.cMalePoo,
                                toilet.allDay,
                                toilet.diaper,
                                Expressions.constant(Collections.emptyList()),
                                toilet.toiletId,
                                toilet.toiletId
                        )).from(toilet)
                .leftJoin(toilet.reviewList, review)
                .where(
                        Expressions.stringTemplate("ST_Distance_Sphere({0}, {1})",
                                Expressions.stringTemplate("POINT({0}, {1})",
                                        condition.getNowLon(),
                                        condition.getNowLat()
                                ),
                                Expressions.stringTemplate("POINT({0}, {1})",
                                        toilet.lon,
                                        toilet.lat
                                )).loe(condition.getRadius().toString()),
                        disabledEq(condition.isDisabled()),
                        diaperEq(condition.isDiaper()),
                        kidsEq(condition.isKids()),
                        alldayEq(condition.isAllDay())
                )
                .groupBy(toilet.toiletId)
                .orderBy(Expressions.stringTemplate("ST_Distance_Sphere({0}, {1})",
                        Expressions.stringTemplate("POINT({0}, {1})",
                                condition.getNowLon(),
                                condition.getNowLat()
                        ),
                        Expressions.stringTemplate("POINT({0}, {1})",
                                toilet.lon,
                                toilet.lat
                        )).asc())
                .offset(pageable.getOffset())
                .limit(effectivePageSize)
                .fetchResults();

        List<ToiletDto> content = result.getResults();
        long total = Math.min(result.getTotal(), maxPageSize);

        return new PageImpl<>(content, pageable, total);
    }

    @Override
    public Page<ToiletDto> searchToiletDistance(ToiletSearchCondition condition, Pageable pageable){
        int maxPageSize = 150;
        int requestedPageSize = pageable.getPageSize();
        int effectivePageSize = Math.min(maxPageSize, requestedPageSize);
        QueryResults<ToiletDto> result = queryFactory.select(
                        new QToiletDto(
                                toilet.toiletId,
                                toilet.toiletName,
                                toilet.address,
                                toilet.operationTime,
                                toilet.lat,
                                toilet.lon,
                                toilet.phoneNumber,
                                review.score.coalesce((float)0).avg().as("score"),
                                review.count().as("comment"),
                                toilet.dMalePee,
                                toilet.dMalePoo,
                                toilet.dFemalePoo,
                                toilet.cFemalePoo,
                                toilet.cMalePee,
                                toilet.cMalePoo,
                                toilet.allDay,
                                toilet.diaper,
                                Expressions.constant(Collections.emptyList()),
                                toilet.toiletId,
                                toilet.toiletId
                        )).from(toilet)
                .leftJoin(toilet.reviewList, review)
                .where(
                        keywordEq(condition.getKeyword()),
                        disabledEq(condition.isDisabled()),
                        diaperEq(condition.isDiaper()),
                        kidsEq(condition.isKids()),
                        alldayEq(condition.isAllDay())
                )
                .groupBy(toilet.toiletId)
                .orderBy(
                        Expressions.stringTemplate("ST_Distance_Sphere({0}, {1})",
                        Expressions.stringTemplate("POINT({0}, {1})",
                                condition.getNowLon(),
                                condition.getNowLat()
                        ),
                        Expressions.stringTemplate("POINT({0}, {1})",
                                toilet.lon,
                                toilet.lat
                        )).asc()
                )
                .offset(pageable.getOffset())
                .limit(effectivePageSize)
                .fetchResults();

        List<ToiletDto> content = result.getResults();
        long total = Math.min(result.getTotal(), maxPageSize);

        return new PageImpl<>(content, pageable, total);
    }

    @Override
    public Page<ToiletDto> searchToiletScore(ToiletSearchCondition condition, Pageable pageable){
        int maxPageSize = 150;
        int requestedPageSize = pageable.getPageSize();
        int effectivePageSize = Math.min(maxPageSize, requestedPageSize);
        QueryResults<ToiletDto> result = queryFactory.select(
                        new QToiletDto(
                                toilet.toiletId,
                                toilet.toiletName,
                                toilet.address,
                                toilet.operationTime,
                                toilet.lat,
                                toilet.lon,
                                toilet.phoneNumber,
                                review.score.coalesce((float)0).avg().as("score"),
                                review.count().as("comment"),
                                toilet.dMalePee,
                                toilet.dMalePoo,
                                toilet.dFemalePoo,
                                toilet.cFemalePoo,
                                toilet.cMalePee,
                                toilet.cMalePoo,
                                toilet.allDay,
                                toilet.diaper,
                                Expressions.constant(Collections.emptyList()),
                                toilet.toiletId,
                                toilet.toiletId
                        )).from(toilet)
                .leftJoin(toilet.reviewList, review)
                .where(
                        keywordEq(condition.getKeyword()),
                        disabledEq(condition.isDisabled()),
                        diaperEq(condition.isDiaper()),
                        kidsEq(condition.isKids()),
                        alldayEq(condition.isAllDay())
                )
                .groupBy(toilet.toiletId)
                .orderBy(
                        review.score.coalesce((float)0).avg().desc(), review.count().desc()
                )
                .offset(pageable.getOffset())
                .limit(effectivePageSize)
                .fetchResults();

        List<ToiletDto> content = result.getResults();
        long total = Math.min(result.getTotal(), maxPageSize);

        return new PageImpl<>(content, pageable, total);
    }

    @Override
    public Page<ToiletDto> searchToiletComment(ToiletSearchCondition condition, Pageable pageable){
        int maxPageSize = 150;
        int requestedPageSize = pageable.getPageSize();
        int effectivePageSize = Math.min(maxPageSize, requestedPageSize);
        QueryResults<ToiletDto> result = queryFactory.select(
                        new QToiletDto(
                                toilet.toiletId,
                                toilet.toiletName,
                                toilet.address,
                                toilet.operationTime,
                                toilet.lat,
                                toilet.lon,
                                toilet.phoneNumber,
                                review.score.coalesce((float)0).avg().as("score"),
                                review.count().as("comment"),
                                toilet.dMalePee,
                                toilet.dMalePoo,
                                toilet.dFemalePoo,
                                toilet.cFemalePoo,
                                toilet.cMalePee,
                                toilet.cMalePoo,
                                toilet.allDay,
                                toilet.diaper,
                                Expressions.constant(Collections.emptyList()),
                                toilet.toiletId,
                                toilet.toiletId
                        )).from(toilet)
                .leftJoin(toilet.reviewList, review)
                .where(
                        keywordEq(condition.getKeyword()),
                        disabledEq(condition.isDisabled()),
                        diaperEq(condition.isDiaper()),
                        kidsEq(condition.isKids()),
                        alldayEq(condition.isAllDay())
                )
                .groupBy(toilet.toiletId)
                .orderBy(
                        review.count().desc(), review.score.coalesce((float)0).avg().desc()
                )
                .offset(pageable.getOffset())
                .limit(effectivePageSize)
                .fetchResults();

        List<ToiletDto> content = result.getResults();
        long total = Math.min(result.getTotal(), maxPageSize);

        return new PageImpl<>(content, pageable, total);
    }

    private BooleanBuilder disabledEq(boolean disabled){
        BooleanBuilder booleanBuilder = new BooleanBuilder();

        if(disabled == true){
            booleanBuilder.or(toilet.dMalePee.isTrue());
            booleanBuilder.or(toilet.dMalePoo.isTrue());
            booleanBuilder.or(toilet.dFemalePoo.isTrue());
        }

        return booleanBuilder;
    }

    private BooleanBuilder kidsEq(boolean kids){

        BooleanBuilder booleanBuilder = new BooleanBuilder();

        if(kids == true){
            booleanBuilder.or(toilet.cFemalePoo.isTrue());
            booleanBuilder.or(toilet.cMalePee.isTrue());
            booleanBuilder.or(toilet.cMalePoo.isTrue());
        }

        return booleanBuilder;
    }

    private BooleanExpression diaperEq(boolean diaper){
        return diaper == false ? null : toilet.diaper.isTrue();
    }

    private BooleanExpression alldayEq(boolean allDay){
        BooleanExpression result = allDay == false ? null : Expressions.asBoolean(toilet.allDay);
        return allDay == false ? null : toilet.allDay.isTrue();
    }

    private BooleanBuilder keywordEq(String keyword){
        BooleanBuilder booleanBuilder = new BooleanBuilder();

        if(keyword != null){
            booleanBuilder.or(toilet.toiletName.contains(keyword));
            booleanBuilder.or(toilet.address.contains(keyword));
        }
        return booleanBuilder;
    }

}
