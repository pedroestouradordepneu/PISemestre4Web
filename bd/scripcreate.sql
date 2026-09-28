SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `easyclinic` DEFAULT CHARACTER SET utf8 ;
USE `easyclinic` ;

-- -----------------------------------------------------
-- Table `easyclinic`.`clinica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `easyclinic`.`clinica` (
  `cnpj` VARCHAR(14) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cnpj`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `easyclinic`.`tag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `easyclinic`.`tag` (
  `idtag` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NOT NULL,
  `clinica_cnpj` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`idtag`),
  INDEX `fk_tag_clinica1_idx` (`clinica_cnpj` ASC),
  CONSTRAINT `fk_tag_clinica1`
    FOREIGN KEY (`clinica_cnpj`)
    REFERENCES `easyclinic`.`clinica` (`cnpj`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `easyclinic`.`plano`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `easyclinic`.`plano` (
  `idplano` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NOT NULL,
  `aplicadesconto` TINYINT NOT NULL,
  `valordesconto` FLOAT NOT NULL,
  `exonera` TINYINT NOT NULL,
  `clinica_cnpj` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`idplano`),
  INDEX `fk_plano_clinica1_idx` (`clinica_cnpj` ASC),
  CONSTRAINT `fk_plano_clinica1`
    FOREIGN KEY (`clinica_cnpj`)
    REFERENCES `easyclinic`.`clinica` (`cnpj`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `easyclinic`.`pacientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `easyclinic`.`pacientes` (
  `idpacientes` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `cpf` VARCHAR(11) NULL,
  `telefone` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `complemento` VARCHAR(45) NULL,
  `tag_idtag` INT NOT NULL,
  `plano_idplano` INT NOT NULL,
  `clinica_cnpj` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`idpacientes`),
  INDEX `fk_pacientes_tag_idx` (`tag_idtag` ASC),
  INDEX `fk_pacientes_plano1_idx` (`plano_idplano` ASC),
  INDEX `fk_pacientes_clinica1_idx` (`clinica_cnpj` ASC),
  CONSTRAINT `fk_pacientes_tag`
    FOREIGN KEY (`tag_idtag`)
    REFERENCES `easyclinic`.`tag` (`idtag`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pacientes_plano1`
    FOREIGN KEY (`plano_idplano`)
    REFERENCES `easyclinic`.`plano` (`idplano`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pacientes_clinica1`
    FOREIGN KEY (`clinica_cnpj`)
    REFERENCES `easyclinic`.`clinica` (`cnpj`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `easyclinic`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `easyclinic`.`usuario` (
  `idusuario` INT NOT NULL AUTO_INCREMENT,
  `usuario` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(45) NOT NULL,
  `clinica_cnpj` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`idusuario`),
  INDEX `fk_usuario_clinica1_idx` (`clinica_cnpj` ASC),
  CONSTRAINT `fk_usuario_clinica1`
    FOREIGN KEY (`clinica_cnpj`)
    REFERENCES `easyclinic`.`clinica` (`cnpj`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `easyclinic`.`doutor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `easyclinic`.`doutor` (
  `iddoutor` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `especialidade` VARCHAR(45) NOT NULL,
  `clinica_cnpj` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`iddoutor`),
  INDEX `fk_doutor_clinica1_idx` (`clinica_cnpj` ASC),
  CONSTRAINT `fk_doutor_clinica1`
    FOREIGN KEY (`clinica_cnpj`)
    REFERENCES `easyclinic`.`clinica` (`cnpj`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `easyclinic`.`agenda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `easyclinic`.`agenda` (
  `idagenda` INT NOT NULL AUTO_INCREMENT,
  `datahora` DATETIME NOT NULL,
  `doutor_iddoutor` INT NOT NULL,
  `pacientes_idpacientes` INT NOT NULL,
  `clinica_cnpj` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`idagenda`),
  INDEX `fk_agenda_doutor1_idx` (`doutor_iddoutor` ASC),
  INDEX `fk_agenda_pacientes1_idx` (`pacientes_idpacientes` ASC),
  INDEX `fk_agenda_clinica1_idx` (`clinica_cnpj` ASC),
  CONSTRAINT `fk_agenda_doutor1`
    FOREIGN KEY (`doutor_iddoutor`)
    REFERENCES `easyclinic`.`doutor` (`iddoutor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_agenda_pacientes1`
    FOREIGN KEY (`pacientes_idpacientes`)
    REFERENCES `easyclinic`.`pacientes` (`idpacientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_agenda_clinica1`
    FOREIGN KEY (`clinica_cnpj`)
    REFERENCES `easyclinic`.`clinica` (`cnpj`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `easyclinic`.`anaminese`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `easyclinic`.`anaminese` (
  `idanaminese` INT NOT NULL AUTO_INCREMENT,
  `queixas` VARCHAR(255) NULL,
  `historicoatual` VARCHAR(255) NULL,
  `doencaspreexistentes` VARCHAR(255) NULL,
  `medicamentos` VARCHAR(255) NULL,
  `alergias` VARCHAR(255) NULL,
  `cirurgiasanteriores` VARCHAR(255) NULL,
  `historicofamiliar` VARCHAR(255) NULL,
  `pacientes_idpacientes` INT NOT NULL,
  PRIMARY KEY (`idanaminese`),
  INDEX `fk_anaminese_pacientes1_idx` (`pacientes_idpacientes` ASC),
  CONSTRAINT `fk_anaminese_pacientes1`
    FOREIGN KEY (`pacientes_idpacientes`)
    REFERENCES `easyclinic`.`pacientes` (`idpacientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- =====================================================
-- TESTE: MOSTRA AS TABELAS CRIADAS
-- =====================================================

SHOW TABLES;

use easyclinic;

select * from usuario;

select * from pacientes;

insert into tag values(2, 'teste', '12345678912349');
insert into plano values(1, 'teste', 1,0,1,'12345678912349');



-- apagar o banco de dados:
-- drop database easyclinic;