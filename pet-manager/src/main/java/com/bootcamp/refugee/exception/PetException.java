package com.bootcamp.refugee.exception;

public class PetException extends Exception {
    public PetException() {
        super();
    }

    public PetException(String message) {
        super(message);
    }

    public PetException(String message, Throwable cause) {
        super(message, cause);
    }

    public PetException(Throwable cause) {
        super(cause);
    }

    protected PetException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
