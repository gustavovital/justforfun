package com.bootcamp.refugee.service;

import com.bootcamp.refugee.exception.PetException;
import com.bootcamp.refugee.model.Pet;
import com.bootcamp.refugee.repository.PetRepository;
import org.springframework.stereotype.Service;

@Service
public class AdoptionService {
    private final PetRepository petRepository;

    public AdoptionService(PetRepository petRepository) {
        this.petRepository = petRepository;
    }

    public void petAdoptedLeftRefugee(String name) throws PetException {
        Pet pet = this.petRepository.findFirstByPetNameIgnoreCase(name).orElseThrow(() -> new PetException(
                String.format("%s was not found on our refugee!", name)
        ));
        this.petRepository.delete(pet);
    }

    public void addPetToRefugee(Pet pet) throws PetException {
        if (this.checkIfPetIsOnRefugee(pet)) {
            throw new PetException("Pet is already on database.");
        }
        this.petRepository.save(pet);
    }

    public boolean checkIfPetIsOnRefugee(Pet pet) {
        if(pet.getId() == null) {
            return false;
        }
        return this.petRepository.existsById(pet.getId());
    }
}
