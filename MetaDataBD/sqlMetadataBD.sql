/******************************************************************************/
/***          Generated by IBExpert 2012.02.21 26/03/2021 20:29:51          ***/
/******************************************************************************/

SET SQL DIALECT 3;

SET NAMES NONE;

SET CLIENTLIB 'C:\Firebird\Firebird-2.5\bin\fbclient.dll';

CREATE DATABASE 'C:\Users\DES\Documents\Embarcadero\Studio\Projects\Win32\TesteMicroData\DataBase\TESTE_MICRODATA.FDB'
USER 'SYSDBA' PASSWORD 'masterkey'
PAGE_SIZE 16384
DEFAULT CHARACTER SET NONE COLLATION NONE;



/******************************************************************************/
/***                               Generators                               ***/
/******************************************************************************/

CREATE GENERATOR GEN_CLIENTE;
SET GENERATOR GEN_CLIENTE TO 9;

CREATE GENERATOR GEN_CONTATO;
SET GENERATOR GEN_CONTATO TO 25;



/******************************************************************************/
/***                                 Tables                                 ***/
/******************************************************************************/



CREATE TABLE CLIENTE (
    ID           INTEGER NOT NULL,
    NOME         VARCHAR(50) NOT NULL,
    CEP          VARCHAR(8) NOT NULL,
    LOGRADOURO   VARCHAR(60) NOT NULL,
    NUMERO       VARCHAR(10) NOT NULL,
    COMPLEMENTO  VARCHAR(40) NOT NULL,
    CIDADE       VARCHAR(40) NOT NULL,
    IBGE_CIDADE  VARCHAR(7) NOT NULL,
    SIGLA_UF     VARCHAR(2) NOT NULL,
    IBGE_UF      VARCHAR(2) NOT NULL
);


CREATE TABLE CONTATO (
    ID          INTEGER NOT NULL,
    NOME        VARCHAR(8) NOT NULL,
    DATA_NASC   TIMESTAMP NOT NULL,
    IDADE       INTEGER,
    TELEFONE    VARCHAR(15),
    ID_CLIENTE  INTEGER
);




/******************************************************************************/
/***                              Primary Keys                              ***/
/******************************************************************************/

ALTER TABLE CLIENTE ADD CONSTRAINT PK_CLIENTE PRIMARY KEY (ID);
ALTER TABLE CONTATO ADD CONSTRAINT PK_CONTATO PRIMARY KEY (ID);


/******************************************************************************/
/***                              Foreign Keys                              ***/
/******************************************************************************/

ALTER TABLE CONTATO ADD CONSTRAINT FK_CLIENTE_CONTATO FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE (ID) ON DELETE CASCADE ON UPDATE CASCADE;


/******************************************************************************/
/***                                Triggers                                ***/
/******************************************************************************/


SET TERM ^ ;



/******************************************************************************/
/***                          Triggers for tables                           ***/
/******************************************************************************/



/* Trigger: TR_CLIENTE */
CREATE OR ALTER TRIGGER TR_CLIENTE FOR CLIENTE
ACTIVE BEFORE INSERT POSITION 0
as
begin
  new.id = gen_id("GEN_CLIENTE",1);
end
^


/* Trigger: TR_CONTATO */
CREATE OR ALTER TRIGGER TR_CONTATO FOR CONTATO
ACTIVE BEFORE INSERT POSITION 1
as
begin
  new.id = gen_id("GEN_CONTATO",1);
end
^


/* Trigger: TR_CONTATO_IDADE */
CREATE OR ALTER TRIGGER TR_CONTATO_IDADE FOR CONTATO
ACTIVE BEFORE INSERT OR UPDATE POSITION 2
AS
begin
  NEW.IDADE = datediff(YEAR FROM NEW.DATA_NASC TO current_timestamp);
end
^


SET TERM ; ^



/******************************************************************************/
/***                              Descriptions                              ***/
/******************************************************************************/

DESCRIBE GENERATOR GEN_CLIENTE
'Incrementar no id na tabela do cliente';

DESCRIBE GENERATOR GEN_CONTATO
'Incrementar no id na tabela de contato do cliente';


/******************************************************************************/
/***                              Script Insert                             ***/
/******************************************************************************/

INSERT INTO cliente
  (id, nome, cep, logradouro, numero, complemento, cidade, ibge_cidade, sigla_uf, ibge_uf)
VALUES
  (1, 'JOS?? CALORS', '37110000', 'PRA??A PRINCIPAL', 999, 'CASA', 'S??O PAULO', '0000000', 'SP', 'SP');

INSERT INTO contato
  ( nome, data_nasc, telefone, id_cliente)
VALUES
  ('ANT??NIO', '01.01.2000', '11-99999-8888', (SELECT MAX(CLIENTE.id) FROM CLIENTE));

INSERT INTO contato
  (nome, data_nasc, telefone, id_cliente)
VALUES
  ('MARIA', '01.01.2001', '11-99999-7777', (SELECT MAX(CLIENTE.id) FROM CLIENTE));

INSERT INTO contato
  ( nome, data_nasc, telefone, id_cliente)
VALUES
  ('JOS??', '01.01.2002', '11-99999-6666', (SELECT MAX(CLIENTE.id) FROM CLIENTE));