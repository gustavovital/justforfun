package com.bootcamp.refugee.service;

import com.bootcamp.refugee.model.Pet;
import com.bootcamp.refugee.model.PetType;
import com.bootcamp.refugee.repository.PetRepository;
import org.springframework.stereotype.Service;

import java.util.Set;

@Service
public class PetInformationService {

    private final PetRepository petRepository;

    public PetInformationService(PetRepository petRepository) {
        this.petRepository = petRepository;
    }

    public Set<Pet> getAllPets() {
        return Set.copyOf(this.petRepository.findAll());
    }

    public Set<Pet> getAllDogs() {
        return this.petRepository.findByPetType(PetType.DOG);
    }

    public Set<Pet> getAllCats() {
        return this.petRepository.findByPetType(PetType.CAT);
    }

    public Set<Pet> getAllEagles() {
        return this.petRepository.findByPetType(PetType.EAGLE);
    }
}
