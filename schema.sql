#drop schema d_blog;
-- -----------------------------------------------------
-- Schema d_blog
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `d_blog` DEFAULT CHARACTER SET utf8 ;
USE `d_blog` ;

-- -----------------------------------------------------
-- Table `d_blog`.`usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `d_blog`.`usuario` ;

CREATE TABLE IF NOT EXISTS `d_blog`.`usuario` (
  `idusuario` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `login` VARCHAR(50) NOT NULL,
  `senha` VARCHAR(12) NOT NULL,
  `perfil` VARCHAR(45) NULL DEFAULT 'COMUM',
  PRIMARY KEY (`idusuario`),
  UNIQUE INDEX `login_UNIQUE` (`login` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `d_blog`.`post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `d_blog`.`post` ;

CREATE TABLE IF NOT EXISTS `d_blog`.`post` (
  `idpost` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(200) NOT NULL,
  `texto` TEXT NOT NULL,
  `idusuario` INT NOT NULL,
  `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idpost`),
  UNIQUE INDEX `titulo_UNIQUE` (`titulo` ASC) VISIBLE,
  INDEX `fk_post_usuario_idx` (`idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_post_usuario`
    FOREIGN KEY (`idusuario`)
    REFERENCES `d_blog`.`usuario` (`idusuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `d_blog`.`comentario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `d_blog`.`comentario` ;

CREATE TABLE IF NOT EXISTS `d_blog`.`comentario` (
  `idcomentario` INT NOT NULL AUTO_INCREMENT,
  `texto` TEXT NOT NULL,
  `status_aprovacao` TINYINT NULL DEFAULT 0,
  `idpost` INT NOT NULL,
  `idusuario` INT NOT NULL,
  `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idcomentario`),
  INDEX `fk_comentario_post1_idx` (`idpost` ASC) VISIBLE,
  INDEX `fk_comentario_usuario1_idx` (`idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_comentario_post1`
    FOREIGN KEY (`idpost`)
    REFERENCES `d_blog`.`post` (`idpost`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comentario_usuario1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `d_blog`.`usuario` (`idusuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Data for table `d_blog`.`usuario`
-- -----------------------------------------------------
START TRANSACTION;
USE `d_blog`;
INSERT INTO `d_blog`.`usuario` (`idusuario`, `nome`, `login`, `senha`, `perfil`) VALUES (DEFAULT, 'admin', 'admin', 'admin', 'MOD');
INSERT INTO `d_blog`.`usuario` (`idusuario`, `nome`, `login`, `senha`, `perfil`) VALUES (DEFAULT, 'doug', 'doug', '0000', 'COMUM');
INSERT INTO `d_blog`.`usuario` (`idusuario`, `nome`, `login`, `senha`, `perfil`) VALUES (DEFAULT, 'maria', 'maria', '1111', 'COMUM');

COMMIT;

START TRANSACTION;
USE `d_blog`;
insert into `d_blog`.`post`(`titulo`, `texto`, `timestamp`, `idusuario`) values
("Primeiro", "Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro Primeiro FIM", "2022-10-01 00:00:00", 1),
("Segundo", "Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo Segundo FIM", "2022-10-02 00:00:00", 1),
("Terceiro", "Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro Terceiro FIM", "2022-10-03 00:00:00", 1),
("Quarto", "Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto Quarto FIM", "2022-10-04 00:00:00", 1),
("Quinto", "Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto Quinto FIM", "2022-10-05 00:00:00", 1),
("Sexto", "Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto Sexto FIM", "2022-10-06 00:00:00", 1),
("Sétimo", "Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo Sétimo FIM", "2022-10-07 00:00:00", 1),
("Oitavo", "Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo Oitavo FIM", "2022-10-08 00:00:00", 1),
("Nono", "Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono Nono FIM", "2022-10-09 00:00:00", 1),
("Décimo", "Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo Décimo FIM", "2022-10-10 00:00:00", 1),
("Décimo Primeiro", "Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro Décimo Primeiro FIM", "2022-10-11 00:00:00", 1),
("Décimo Segundo", "Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo Décimo Segundo FIM", "2022-10-12 00:00:00", 1),
("Décimo Terceiro", "Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro Décimo Terceiro FIM", "2022-10-13 00:00:00", 1),
("Décimo Quarto", "Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto Décimo Quarto FIM", "2022-10-14 00:00:00", 1)
;

COMMIT;

START TRANSACTION;
USE `d_blog`;
insert into comentario (`texto`, `status_aprovacao`, `idpost`, `idusuario`) values
("First", 1, 14, 2),
("Second", 1, 14, 2),
("Third", 1, 14, 3)
;

COMMIT;