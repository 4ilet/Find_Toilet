package com.Fourilet.project.fourilet.data.repository;

import com.Fourilet.project.fourilet.data.entity.Review;
import com.Fourilet.project.fourilet.data.entity.Toilet;
import com.Fourilet.project.fourilet.dto.ReviewDto;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;
import java.util.Optional;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Long> {

      List<Review> findAllByToilet(Toilet toilet);

      Optional<Review> findById(long reviewId);

      List<Review> findAllByToilet(Toilet toilet, PageRequest pageRequest);


      List<Review> findAllByToilet(Toilet toilet, PageRequest pageRequest, Sort reviewId);

}
