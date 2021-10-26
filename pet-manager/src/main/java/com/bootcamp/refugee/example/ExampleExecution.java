package com.bootcamp.refugee.example;

import com.bootcamp.refugee.exception.PetException;
import com.bootcamp.refugee.model.Pet;
import com.bootcamp.refugee.model.PetType;
import com.bootcamp.refugee.service.AdoptionService;
import com.bootcamp.refugee.service.PetInformationService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

@Component
public class ExampleExecution {
    private final PetInformationService petInformationService;
    private final AdoptionService adoptionService;
    Logger logger = LoggerFactory.getLogger(ExampleExecution.class);

    public ExampleExecution(PetInformationService petInformationService, AdoptionService adoptionService) {
        this.petInformationService = petInformationService;
        this.adoptionService = adoptionService;
    }

    @EventListener(ApplicationReadyEvent.class)
    public void executeExample() throws PetException {
        logger.info("I am executing this code when Spring Boot is ready :)");
        this.insertInitialPets();
        this.showAtlasIsAdopted();
        this.showAllPetsInRefugee();
    }

    public void insertInitialPets() throws PetException {
        logger.info("Let's tell the program that we have some pets already (only if the program doesn't knows!");

        logger.info("Adding our beloved Eagle Rasal");
        Pet rasal = Pet.builder()
                .petType(PetType.EAGLE)
                .petName("Rasal")
                .build();
        this.adoptionService.addPetToRefugee(rasal);

        logger.info("Adding our fat cat Minimiau");
        Pet minimiau = Pet.builder()
                .petType(PetType.CAT)
                .petName("Minimiau")
                .build();
        this.adoptionService.addPetToRefugee(minimiau);

        logger.info("Adding our fancy dog Atlas");
        Pet atlas = Pet.builder()
                .petType(PetType.CAT)
                .petName("Atlas")
                .build();
        this.adoptionService.addPetToRefugee(atlas);
    }

    public void showAtlasIsAdopted() throws PetException {
        logger.info("Atlas was adopted by Andrei!");
        this.adoptionService.petAdoptedLeftRefugee("Atlas");
    }

    public void showAllPetsInRefugee() {

        logger.info("Cats: ");
        this.petInformationService.getAllCats().forEach(System.out::println);
        logger.info("Eagles: ");
        this.petInformationService.getAllEagles().forEach(System.out::println);
        logger.info("Dogs: ");
        this.petInformationService.getAllDogs().forEach(System.out::println);
        logger.info("All pets: ");
        this.petInformationService.getAllPets().forEach(System.out::println);
    }

}
