package com.bootcamp.refugee.repository;


import com.bootcamp.refugee.model.Food;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FoodRepository extends JpaRepository<Food, Long> {

}