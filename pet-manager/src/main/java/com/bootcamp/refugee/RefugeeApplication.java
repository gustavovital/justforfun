package com.bootcamp.refugee;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EnableJpaRepositories
public class RefugeeApplication {

    public static void main(String[] args) {
        SpringApplication.run(RefugeeApplication.class, args);
    }

}