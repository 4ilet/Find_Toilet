package com.Fourilet.project.fourilet.data.entity;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.processing.Generated;
import com.querydsl.core.types.Path;
import com.querydsl.core.types.dsl.PathInits;


/**
 * QToilet is a Querydsl query type for Toilet
 */
@Generated("com.querydsl.codegen.DefaultEntitySerializer")
public class QToilet extends EntityPathBase<Toilet> {

    private static final long serialVersionUID = 491320364L;

    public static final QToilet toilet = new QToilet("toilet");

    public final StringPath address = createString("address");

    public final BooleanPath allDay = createBoolean("allDay");

    public final BooleanPath cFemalePoo = createBoolean("cFemalePoo");

    public final BooleanPath cMalePee = createBoolean("cMalePee");

    public final BooleanPath cMalePoo = createBoolean("cMalePoo");

    public final BooleanPath dFemalePoo = createBoolean("dFemalePoo");

    public final BooleanPath diaper = createBoolean("diaper");

    public final BooleanPath dMalePee = createBoolean("dMalePee");

    public final BooleanPath dMalePoo = createBoolean("dMalePoo");

    public final NumberPath<java.math.BigDecimal> lat = createNumber("lat", java.math.BigDecimal.class);

    public final NumberPath<java.math.BigDecimal> lon = createNumber("lon", java.math.BigDecimal.class);

    public final StringPath operationTime = createString("operationTime");

    public final StringPath phoneNumber = createString("phoneNumber");

    public final ListPath<Review, QReview> reviewList = this.<Review, QReview>createList("reviewList", Review.class, QReview.class, PathInits.DIRECT2);

    public final NumberPath<Long> toiletId = createNumber("toiletId", Long.class);

    public final StringPath toiletName = createString("toiletName");

    public QToilet(String variable) {
        super(Toilet.class, forVariable(variable));
    }

    public QToilet(Path<? extends Toilet> path) {
        super(path.getType(), path.getMetadata());
    }

    public QToilet(PathMetadata metadata) {
        super(Toilet.class, metadata);
    }

}

