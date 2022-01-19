-- MySQL Script generated by MySQL Workbench
-- Wed Jan 19 22:40:08 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Library
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Library
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Library` DEFAULT CHARACTER SET utf8 ;
USE `Library` ;

-- -----------------------------------------------------
-- Table `Library`.`role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Library`.`role` (
  `id_role` INT NOT NULL AUTO_INCREMENT,
  `role` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id_role`),
  UNIQUE INDEX `role_UNIQUE` (`role` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`user_statuses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Library`.`user_statuses` (
  `id_status` INT NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id_status`),
  UNIQUE INDEX `status_UNIQUE` (`status` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Library`.`users` (
  `id_users` INT NOT NULL AUTO_INCREMENT,
  `id_status` INT NOT NULL,
  `id_role` INT NOT NULL,
  `password` VARCHAR(50) NOT NULL,
  `second_name` VARCHAR(30) NOT NULL,
  `last_name` VARCHAR(30) NOT NULL,
  `email` VARCHAR(30) NOT NULL,
  `registration` DATETIME NOT NULL DEFAULT NOW(),
  `count_violations` INT NOT NULL,
  PRIMARY KEY (`id_users`),
  INDEX `fk_users_role1_idx` (`id_role` ASC),
  INDEX `fk_users_user_status1_idx` (`id_status` ASC),
  CONSTRAINT `fk_users_role1`
    FOREIGN KEY (`id_role`)
    REFERENCES `Library`.`role` (`id_role`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_user_status1`
    FOREIGN KEY (`id_status`)
    REFERENCES `Library`.`user_statuses` (`id_status`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`library_statuses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Library`.`library_statuses` (
  `id_status` INT NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id_status`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`libraries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Library`.`libraries` (
  `id_library` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(30) NOT NULL,
  `city` VARCHAR(30) NOT NULL,
  `id_status` INT NOT NULL,
  PRIMARY KEY (`id_library`),
  UNIQUE INDEX `city_UNIQUE` (`city` ASC),
  INDEX `fk_libraries_library_srtatuses1_idx` (`id_status` ASC),
  CONSTRAINT `fk_libraries_library_srtatuses1`
    FOREIGN KEY (`id_status`)
    REFERENCES `Library`.`library_statuses` (`id_status`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`books`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Library`.`books` (
  `id_books` INT NOT NULL AUTO_INCREMENT,
  `isbn` VARCHAR(30) NOT NULL,
  `id_library` INT NOT NULL,
  `title` VARCHAR(70) NOT NULL,
  `quantity` INT NOT NULL,
  `borrow` INT NOT NULL,
  `publisher` VARCHAR(30) NOT NULL,
  `description` TEXT NULL,
  `year` VARCHAR(30) NOT NULL,
  `added` DATETIME NOT NULL DEFAULT NOW(),
  `shelf` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id_books`),
  INDEX `fk_books_library_city1_idx` (`id_library` ASC),
  CONSTRAINT `fk_books_library_city1`
    FOREIGN KEY (`id_library`)
    REFERENCES `Library`.`libraries` (`id_library`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`card_statuses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Library`.`card_statuses` (
  `id_status` INT NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id_status`),
  UNIQUE INDEX `status_UNIQUE` (`status` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`loan_cards`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Library`.`loan_cards` (
  `id_loan_cards` INT NOT NULL AUTO_INCREMENT,
  `id_users` INT NOT NULL,
  `id_library` INT NOT NULL,
  `id_book` INT NOT NULL,
  `id_status` INT NOT NULL,
  `taking_book` DATE NOT NULL,
  `return_book` DATE NULL,
  `deadline` DATE NOT NULL,
  `type_use` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id_loan_cards`),
  INDEX `fk_personal_cards_card_status1_idx` (`id_status` ASC),
  INDEX `fk_loan_cards_books1_idx` (`id_book` ASC),
  INDEX `fk_loan_cards_libraries1_idx` (`id_library` ASC),
  INDEX `fk_loan_cards_users1_idx` (`id_users` ASC),
  CONSTRAINT `fk_personal_cards_card_status1`
    FOREIGN KEY (`id_status`)
    REFERENCES `Library`.`card_statuses` (`id_status`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_loan_cards_books1`
    FOREIGN KEY (`id_book`)
    REFERENCES `Library`.`books` (`id_books`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_loan_cards_libraries1`
    FOREIGN KEY (`id_library`)
    REFERENCES `Library`.`libraries` (`id_library`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_loan_cards_users1`
    FOREIGN KEY (`id_users`)
    REFERENCES `Library`.`users` (`id_users`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`order_statuses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Library`.`order_statuses` (
  `id_status` INT NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id_status`),
  UNIQUE INDEX `status_UNIQUE` (`status` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Library`.`orders` (
  `id_orders` INT NOT NULL AUTO_INCREMENT,
  `id_admin` INT NULL,
  `id_status` INT NOT NULL,
  `id_book` INT NOT NULL,
  `id_user` INT NOT NULL,
  `id_library` INT NOT NULL,
  `date` DATETIME NOT NULL DEFAULT NOW(),
  `comment` TEXT NULL,
  PRIMARY KEY (`id_orders`),
  INDEX `fk_application_users2_idx` (`id_user` ASC),
  INDEX `fk_application_library_city1_idx` (`id_library` ASC),
  INDEX `fk_application_books1_idx` (`id_book` ASC),
  INDEX `fk_request_material_request_status1_idx` (`id_status` ASC),
  CONSTRAINT `fk_application_users2`
    FOREIGN KEY (`id_user`)
    REFERENCES `Library`.`users` (`id_users`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_application_library_city1`
    FOREIGN KEY (`id_library`)
    REFERENCES `Library`.`libraries` (`id_library`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_application_books1`
    FOREIGN KEY (`id_book`)
    REFERENCES `Library`.`books` (`id_books`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_request_material_request_status1`
    FOREIGN KEY (`id_status`)
    REFERENCES `Library`.`order_statuses` (`id_status`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`authors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Library`.`authors` (
  `id_authors` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id_authors`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`authors_has_book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Library`.`authors_has_book` (
  `id_author` INT NOT NULL,
  `id_book` INT NOT NULL,
  PRIMARY KEY (`id_author`, `id_book`),
  INDEX `fk_authors_has_book_book1_idx` (`id_book` ASC),
  INDEX `fk_authors_has_book_authors1_idx` (`id_author` ASC),
  CONSTRAINT `fk_authors_has_book_authors1`
    FOREIGN KEY (`id_author`)
    REFERENCES `Library`.`authors` (`id_authors`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_authors_has_book_book1`
    FOREIGN KEY (`id_book`)
    REFERENCES `Library`.`books` (`id_books`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`genres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Library`.`genres` (
  `id_genres` INT NOT NULL AUTO_INCREMENT,
  `genre` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id_genres`),
  UNIQUE INDEX `genre_UNIQUE` (`genre` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`genres_has_book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Library`.`genres_has_book` (
  `id_genre` INT NOT NULL,
  `id_book` INT NOT NULL,
  PRIMARY KEY (`id_genre`, `id_book`),
  INDEX `fk_ganres_has_book_book1_idx` (`id_book` ASC),
  INDEX `fk_ganres_has_book_ganres1_idx` (`id_genre` ASC),
  CONSTRAINT `fk_ganres_has_book_ganres1`
    FOREIGN KEY (`id_genre`)
    REFERENCES `Library`.`genres` (`id_genres`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ganres_has_book_book1`
    FOREIGN KEY (`id_book`)
    REFERENCES `Library`.`books` (`id_books`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`wish_books`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Library`.`wish_books` (
  `id_wish_books` INT NOT NULL AUTO_INCREMENT,
  `added` DATETIME NOT NULL DEFAULT NOW(),
  `id_books` INT NOT NULL,
  `id_users` INT NOT NULL,
  PRIMARY KEY (`id_wish_books`),
  INDEX `fk_wish_books_books1_idx` (`id_books` ASC),
  INDEX `fk_wish_books_users1_idx` (`id_users` ASC),
  CONSTRAINT `fk_wish_books_books1`
    FOREIGN KEY (`id_books`)
    REFERENCES `Library`.`books` (`id_books`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_wish_books_users1`
    FOREIGN KEY (`id_users`)
    REFERENCES `Library`.`users` (`id_users`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;