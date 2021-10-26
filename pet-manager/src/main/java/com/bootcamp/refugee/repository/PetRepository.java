package com.bootcamp.refugee.repository;


import com.bootcamp.refugee.model.Pet;
import com.bootcamp.refugee.model.PetType;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;
import java.util.Set;

public interface PetRepository extends JpaRepository<Pet, Long> {
    Set<Pet> findByPetType(PetType petType);

    Optional<Pet> findFirstByPetNameIgnoreCase(String petName);
}