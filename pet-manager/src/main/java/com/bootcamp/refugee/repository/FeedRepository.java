package com.bootcamp.refugee.repository;


import com.bootcamp.refugee.model.Feed;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FeedRepository extends JpaRepository<Feed, Long> {

}