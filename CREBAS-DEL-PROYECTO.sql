/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     29/06/2017 23:53:14                          */
/*==============================================================*/


alter table AGENCIA
   drop constraint FK_AGENCIA_RELATIONS_BANCO;

alter table CLIENTE
   drop constraint FK_CLIENTE_RELATIONS_BANCO;

alter table CUENTA
   drop constraint FK_CUENTA_RELATIONS_CLIENTE;

alter table INVERSION
   drop constraint FK_INVERSIO_RELATIONS_CLIENTE;

alter table PAGO
   drop constraint FK_PAGO_RELATIONS_PRESTAMO;

alter table PRESTAMO
   drop constraint FK_PRESTAMO_RELATIONS_CLIENTE;

drop table AGENCIA cascade constraints;

drop table AUDITORIA_PRESTAMO cascade constraints;

drop table BANCO cascade constraints;

drop table CLIENTE cascade constraints;

drop table CUENTA cascade constraints;

drop table INVERSION cascade constraints;

drop table PAGO cascade constraints;

drop table PRESTAMO cascade constraints;

/*==============================================================*/
/* Table: AGENCIA                                               */
/*==============================================================*/
create table AGENCIA 
(
   CODIGO_AGENCIA       INTEGER              not null,
   RUC                  INTEGER,
   NOMBRE_GERENTE       VARCHAR2(120),
   CIUDAD_AGENCIA       VARCHAR2(40),
   TELEFONO_AGENCIA     INTEGER,
   CORREO_AGENCIA       VARCHAR2(100),
   constraint PK_AGENCIA primary key (CODIGO_AGENCIA)
);

/*==============================================================*/
/* Table: AUDITORIA_PRESTAMO                                    */
/*==============================================================*/
create table AUDITORIA_PRESTAMO 
(
   CEDULA_CLIENTE_PRE   INTEGER,
   FECHA_AUD            DATE,
   FECHA_PRESTAMO       DATE,
   MONTO_PRESTAMO       FLOAT,
   INTERES_PRESTAMO     FLOAT,
   NUMERO_CUOTAS        INTEGER,
   SALDO_PRESTAMO       FLOAT,
   LO_REALIZADO         VARCHAR2(20)
);

/*==============================================================*/
/* Table: BANCO                                                 */
/*==============================================================*/
create table BANCO 
(
   RUC                  INTEGER              not null,
   RAZON_SOCIAL         VARCHAR2(100),
   ANIO_FUNDACION       INTEGER,
   ACTIVOS_ACTUALES     FLOAT,
   SITIO_WEB            VARCHAR2(100),
   constraint PK_BANCO primary key (RUC)
);

/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
create table CLIENTE 
(
   CEDULA_CLIENTE       INTEGER              not null,
   RUC                  INTEGER,
   NOMBRE_CLIENTE       VARCHAR2(120),
   SITUACION_LABORAL    VARCHAR2(40),
   DIRECCION_CLIENTE    VARCHAR2(100),
   CORREO_CLIENTE       VARCHAR2(100),
   TELEFONO_CLIENTE     INTEGER,
   constraint PK_CLIENTE primary key (CEDULA_CLIENTE)
);

/*==============================================================*/
/* Table: CUENTA                                                */
/*==============================================================*/
create table CUENTA 
(
   NUMERO_CUENTA        INTEGER              not null,
   CEDULA_CLIENTE       INTEGER,
   TIPO_CUENTA          VARCHAR2(40),
   FECHA_APERTURA       DATE,
   BALANCE_MINIMO_CA    FLOAT,
   TASA_INTERES_CC      Float,
   constraint PK_CUENTA primary key (NUMERO_CUENTA)
);

/*==============================================================*/
/* Table: INVERSION                                             */
/*==============================================================*/
create table INVERSION 
(
   ID_INVERSION         INTEGER              not null,
   CEDULA_CLIENTE       INTEGER,
   FECHA_INVERSION      DATE,
   CAPITAL_INVERSION    FLOAT,
   PLAZO_INVERSION      DATE,
   INTERES_INVERSION    FLOAT,
   constraint PK_INVERSION primary key (ID_INVERSION)
);

/*==============================================================*/
/* Table: PAGO                                                  */
/*==============================================================*/
create table PAGO 
(
   ID_PAGO              INTEGER              not null,
   NUMERO_PRES          INTEGER,
   NUMERO_PAGO          SMALLINT,
   FECHA_PAGO           DATE,
   CAPITAL_INICIAL      FLOAT,
   AMORTIZACION_CAPITAL FLOAT,
   INTERES_MENSUAL      FLOAT,
   VALOR_CUOTA          FLOAT,
   VALOR_PAGO           FLOAT,
   constraint PK_PAGO primary key (ID_PAGO)
);

/*==============================================================*/
/* Table: PRESTAMO                                              */
/*==============================================================*/
create table PRESTAMO 
(
   NUMERO_PRES          INTEGER              not null,
   CEDULA_CLIENTE       INTEGER,
   FECHA_PRESTAMO       DATE,
   TIPO_PRESTAMO        VARCHAR2(40),
   MONTO_PRESTAMO       FLOAT,
   INTERES_PRESTAMO     FLOAT,
   FRECUENCIA_PAGO_DIAS INTEGER,
   NUMERO_CUOTAS        INTEGER,
   SALDO_PRESTAMO       FLOAT,
   SIGUIENTE_PAGO       DATE,
   constraint PK_PRESTAMO primary key (NUMERO_PRES)
);

alter table AGENCIA
   add constraint FK_AGENCIA_RELATIONS_BANCO foreign key (RUC)
      references BANCO (RUC);

alter table CLIENTE
   add constraint FK_CLIENTE_RELATIONS_BANCO foreign key (RUC)
      references BANCO (RUC);

alter table CUENTA
   add constraint FK_CUENTA_RELATIONS_CLIENTE foreign key (CEDULA_CLIENTE)
      references CLIENTE (CEDULA_CLIENTE);

alter table INVERSION
   add constraint FK_INVERSIO_RELATIONS_CLIENTE foreign key (CEDULA_CLIENTE)
      references CLIENTE (CEDULA_CLIENTE);

alter table PAGO
   add constraint FK_PAGO_RELATIONS_PRESTAMO foreign key (NUMERO_PRES)
      references PRESTAMO (NUMERO_PRES);

alter table PRESTAMO
   add constraint FK_PRESTAMO_RELATIONS_CLIENTE foreign key (CEDULA_CLIENTE)
      references CLIENTE (CEDULA_CLIENTE);

