prompt PL/SQL Developer Export Tables for user KARAUZ@192.168.0.20:1521/XEPDB1
prompt Created by kevin on miércoles, 11 de junio de 2025
set feedback off
set define off

prompt Dropping DCS_FINCA...
drop table DCS_FINCA cascade constraints;
prompt Dropping DCS_PERSONA_FISICA...
drop table DCS_PERSONA_FISICA cascade constraints;
prompt Dropping DCS_COSECHA...
drop table DCS_COSECHA cascade constraints;
prompt Dropping DCS_ESTADO_GENERAL...
drop table DCS_ESTADO_GENERAL cascade constraints;
prompt Dropping DCS_LOTE...
drop table DCS_LOTE cascade constraints;
prompt Dropping DCS_INGENIERO...
drop table DCS_INGENIERO cascade constraints;
prompt Dropping DCS_REPRODUCCION...
drop table DCS_REPRODUCCION cascade constraints;
prompt Dropping DCS_ANALISIS...
drop table DCS_ANALISIS cascade constraints;
prompt Dropping DCS_ENFERMEDAD...
drop table DCS_ENFERMEDAD cascade constraints;
prompt Dropping DCS_ANALISIS_ENFERMEDAD...
drop table DCS_ANALISIS_ENFERMEDAD cascade constraints;
prompt Dropping DCS_PLAGA...
drop table DCS_PLAGA cascade constraints;
prompt Dropping DCS_ANALISIS_PLAGA...
drop table DCS_ANALISIS_PLAGA cascade constraints;
prompt Dropping DCS_ASOCIACION...
drop table DCS_ASOCIACION cascade constraints;
prompt Dropping DCS_CATEGORIA_ASOCIADO...
drop table DCS_CATEGORIA_ASOCIADO cascade constraints;
prompt Dropping DCS_ASOCIADO...
drop table DCS_ASOCIADO cascade constraints;
prompt Dropping DCS_TIPO_CONTACTO...
drop table DCS_TIPO_CONTACTO cascade constraints;
prompt Dropping DCS_CONTACTO...
drop table DCS_CONTACTO cascade constraints;
prompt Dropping DCS_ETAPA_ENSAYO...
drop table DCS_ETAPA_ENSAYO cascade constraints;
prompt Dropping DCS_ENSAYO...
drop table DCS_ENSAYO cascade constraints;
prompt Dropping DCS_INSPECCION...
drop table DCS_INSPECCION cascade constraints;
prompt Dropping DCS_JUNTA_DIRECTIVA...
drop table DCS_JUNTA_DIRECTIVA cascade constraints;
prompt Dropping DCS_SEMILLA...
drop table DCS_SEMILLA cascade constraints;
prompt Dropping DCS_UNIDAD_MEDIDA...
drop table DCS_UNIDAD_MEDIDA cascade constraints;
prompt Dropping DCS_VARIEDAD...
drop table DCS_VARIEDAD cascade constraints;
prompt Dropping DCS_PRODUCTO...
drop table DCS_PRODUCTO cascade constraints;
prompt Dropping DCS_PAGO_PRODUCTOR...
drop table DCS_PAGO_PRODUCTOR cascade constraints;
prompt Dropping DCS_SINTOMAS...
drop table DCS_SINTOMAS cascade constraints;
prompt Creating DCS_FINCA...
create table DCS_FINCA
(
  fin_id               NUMBER not null,
  fin_numero_registro  VARCHAR2(15) not null,
  fin_nombre           VARCHAR2(30),
  fin_tamano_hectareas NUMBER not null,
  fin_estado           VARCHAR2(1),
  fin_direccion        VARCHAR2(500) not null,
  per_id               NUMBER
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index DCS_PERSO_FINCA_FK01 on DCS_FINCA (PER_ID)
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_FINCA
  add constraint PK_DCS_FINCA primary key (FIN_ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_FINCA
  add constraint DCS_PERSO_FINCA_FK01 foreign key (PER_ID)
  references DCS_PERSONA_FISICA (PER_ID);

prompt Creating DCS_PERSONA_FISICA...
create table DCS_PERSONA_FISICA
(
  per_id               NUMBER not null,
  per_identificacion   VARCHAR2(30) not null,
  per_nombre           VARCHAR2(40) not null,
  per_apellido1        VARCHAR2(20) not null,
  per_apellido2        VARCHAR2(20),
  per_fecha_nacimiento DATE,
  per_sexo             VARCHAR2(1),
  fin_id               NUMBER
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index DCS_FINCA_PERSO_FK01 on DCS_PERSONA_FISICA (FIN_ID)
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_PERSONA_FISICA
  add constraint PK_DCS_PERSONA_FISICA primary key (PER_ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_PERSONA_FISICA
  add constraint DCS_FINCA_PERSO_FK01 foreign key (FIN_ID)
  references DCS_FINCA (FIN_ID);
alter table DCS_PERSONA_FISICA
  add constraint DCS_PERSONA_FISICA_CK01
  check (per_sexo in ('M','F'));

prompt Creating DCS_COSECHA...
create table DCS_COSECHA
(
  cos_id           NUMBER not null,
  cos_nombre       VARCHAR2(50),
  cos_fecha_inicio DATE,
  cos_fecha_fin    DATE
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_COSECHA
  add constraint PK_DCS_COSECHA primary key (COS_ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating DCS_ESTADO_GENERAL...
create table DCS_ESTADO_GENERAL
(
  est_id          NUMBER not null,
  est_descripcion VARCHAR2(500)
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_ESTADO_GENERAL
  add constraint PK_DCS_ESTADO_GENERAL primary key (EST_ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating DCS_LOTE...
create table DCS_LOTE
(
  lot_id               NUMBER not null,
  lot_nombre           VARCHAR2(50),
  lot_tamano_hectareas NUMBER not null,
  lot_descripcion      VARCHAR2(500),
  lot_direccion        VARCHAR2(500) not null,
  fin_id               NUMBER
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index DCS_FINCA_LOTE_FK01 on DCS_LOTE (FIN_ID)
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_LOTE
  add constraint PK_DCS_LOTE primary key (LOT_ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_LOTE
  add constraint DCS_FINCA_LOTE_FK01 foreign key (FIN_ID)
  references DCS_FINCA (FIN_ID);

prompt Creating DCS_INGENIERO...
create table DCS_INGENIERO
(
  inge_id NUMBER not null,
  codigo  NUMBER,
  per_id  NUMBER
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index DCS_PER_ING_FK01 on DCS_INGENIERO (PER_ID)
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_INGENIERO
  add constraint PK_DCS_INGENIERO primary key (INGE_ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_INGENIERO
  add constraint DCS_PER_ING_FK01 foreign key (PER_ID)
  references DCS_PERSONA_FISICA (PER_ID);

prompt Creating DCS_REPRODUCCION...
create table DCS_REPRODUCCION
(
  rep_id                   NUMBER not null,
  rep_numero_contrato      NUMBER,
  rep_fecha_siembra_inicio DATE not null,
  rep_fecha_siembra_fin    DATE not null,
  rep_fecha_cosecha_inicio DATE not null,
  rep_fecha_cosecha_fin    DATE not null,
  rep_hectareas_sembradas  NUMBER not null,
  per_id                   NUMBER,
  fin_id                   NUMBER,
  lot_id                   NUMBER,
  est_id                   NUMBER,
  cos_id                   NUMBER,
  inge_id                  NUMBER
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index DCS_COSECHA_REPRO_FK01 on DCS_REPRODUCCION (COS_ID)
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index DCS_ESTADO_REPRODUCCION_FK01 on DCS_REPRODUCCION (EST_ID)
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index DCS_FINCA_REPRO_FK01 on DCS_REPRODUCCION (FIN_ID)
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index DCS_ING_REPRO_FK01 on DCS_REPRODUCCION (INGE_ID)
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index DCS_LOTE_REPRO_FK01 on DCS_REPRODUCCION (LOT_ID)
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index DCS_PERSONA_REPRO_FK01 on DCS_REPRODUCCION (PER_ID)
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_REPRODUCCION
  add constraint PK_DCS_REPRODUCCION primary key (REP_ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_REPRODUCCION
  add constraint DCS_COSECHA_REPRO_FK01 foreign key (COS_ID)
  references DCS_COSECHA (COS_ID);
alter table DCS_REPRODUCCION
  add constraint DCS_ESTADO_REPRODUCCION_FK01 foreign key (EST_ID)
  references DCS_ESTADO_GENERAL (EST_ID);
alter table DCS_REPRODUCCION
  add constraint DCS_FINCA_REPRO_FK01 foreign key (FIN_ID)
  references DCS_FINCA (FIN_ID);
alter table DCS_REPRODUCCION
  add constraint DCS_ING_REPRO_FK01 foreign key (INGE_ID)
  references DCS_INGENIERO (INGE_ID);
alter table DCS_REPRODUCCION
  add constraint DCS_LOTE_REPRO_FK01 foreign key (LOT_ID)
  references DCS_LOTE (LOT_ID);
alter table DCS_REPRODUCCION
  add constraint DCS_PERSONA_REPRO_FK01 foreign key (PER_ID)
  references DCS_PERSONA_FISICA (PER_ID);

prompt Creating DCS_ANALISIS...
create table DCS_ANALISIS
(
  ana_id                      NUMBER not null,
  ana_motivo                  VARCHAR2(30),
  ana_porcentaje_semilla_sana NUMBER,
  ana_monto                   NUMBER,
  ana_estado                  VARCHAR2(1),
  rep_id                      NUMBER
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index DCS_REPRODUCCION_ANALISI_FK01 on DCS_ANALISIS (REP_ID)
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_ANALISIS
  add constraint PK_DCS_ANALISIS primary key (ANA_ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_ANALISIS
  add constraint DCS_REPRODUCCION_ANALISI_FK01 foreign key (REP_ID)
  references DCS_REPRODUCCION (REP_ID);

prompt Creating DCS_ENFERMEDAD...
create table DCS_ENFERMEDAD
(
  enf_id               NUMBER not null,
  enf_nombre           VARCHAR2(50),
  enf_ubicacion_planta VARCHAR2(20),
  enf_tratamiento      VARCHAR2(30),
  enf_etapa_desarrollo VARCHAR2(30)
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_ENFERMEDAD
  add constraint PK_DCS_ENFERMEDAD primary key (ENF_ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating DCS_ANALISIS_ENFERMEDAD...
create table DCS_ANALISIS_ENFERMEDAD
(
  ana_id NUMBER not null,
  enf_id NUMBER not null
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_ANALISIS_ENFERMEDAD
  add constraint PK_DCS_ANALISIS_ENFERMEDAD primary key (ANA_ID, ENF_ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_ANALISIS_ENFERMEDAD
  add constraint DCS_ANALISIS_ENFERMEDAD_FK01 foreign key (ANA_ID)
  references DCS_ANALISIS (ANA_ID);
alter table DCS_ANALISIS_ENFERMEDAD
  add constraint DCS_ANALISIS_ENFERMEDAD_FK02 foreign key (ENF_ID)
  references DCS_ENFERMEDAD (ENF_ID);

prompt Creating DCS_PLAGA...
create table DCS_PLAGA
(
  pla_id               NUMBER not null,
  pla_nombre           VARCHAR2(50) not null,
  pla_descripcion      VARCHAR2(500),
  pla_tratamiento      VARCHAR2(50) not null,
  pla_etapa_desarrollo VARCHAR2(1) not null
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_PLAGA
  add constraint PK_DCS_PLAGA primary key (PLA_ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating DCS_ANALISIS_PLAGA...
create table DCS_ANALISIS_PLAGA
(
  ana_id NUMBER not null,
  pla_id NUMBER not null
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_ANALISIS_PLAGA
  add constraint PK_DCS_ANALISIS_PLAGA primary key (ANA_ID, PLA_ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_ANALISIS_PLAGA
  add constraint DCS_ANALISIS_PLAGA_FK01 foreign key (ANA_ID)
  references DCS_ANALISIS (ANA_ID);
alter table DCS_ANALISIS_PLAGA
  add constraint DCS_ANALISIS_PLAGA_FK02 foreign key (PLA_ID)
  references DCS_PLAGA (PLA_ID);

prompt Creating DCS_ASOCIACION...
create table DCS_ASOCIACION
(
  asociacion_id              NUMBER not null,
  asociacion_cedula_juridica NUMBER not null,
  asociacion_nombre          VARCHAR2(40) not null,
  asociacion_logo            VARCHAR2(100)
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column DCS_ASOCIACION.asociacion_logo
  is 'URL DEL LOGO
';
alter table DCS_ASOCIACION
  add constraint PK_DCS_ASOCIACION primary key (ASOCIACION_ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating DCS_CATEGORIA_ASOCIADO...
create table DCS_CATEGORIA_ASOCIADO
(
  cat_id                  NUMBER not null,
  cat_descripcion         VARCHAR2(200),
  cat_monto_cuota_mensual NUMBER
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_CATEGORIA_ASOCIADO
  add constraint PK_DCS_CATEGORIA_ASOCIADO primary key (CAT_ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating DCS_ASOCIADO...
create table DCS_ASOCIADO
(
  aso_id               NUMBER not null,
  aso_fecha_ingreso    DATE not null,
  aso_estado           VARCHAR2(1),
  aso_cuota_afiliacion NUMBER,
  per_id               NUMBER,
  cat_id               NUMBER,
  asociacion_id        NUMBER
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index DCS_ASOCIACION_ASOCIADO_FK01 on DCS_ASOCIADO (ASOCIACION_ID)
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index DCS_CATEGO_ASOCIADO_FK01 on DCS_ASOCIADO (CAT_ID)
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index DCS_PERSO_ASOCIADO_FK01 on DCS_ASOCIADO (PER_ID)
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_ASOCIADO
  add constraint PK_DCS_ASOCIADO primary key (ASO_ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_ASOCIADO
  add constraint DCS_ASOCIACION_ASOCIADO_FK01 foreign key (ASOCIACION_ID)
  references DCS_ASOCIACION (ASOCIACION_ID);
alter table DCS_ASOCIADO
  add constraint DCS_CATEGO_ASOCIADO_FK01 foreign key (CAT_ID)
  references DCS_CATEGORIA_ASOCIADO (CAT_ID);
alter table DCS_ASOCIADO
  add constraint DCS_PERSO_ASOCIADO_FK01 foreign key (PER_ID)
  references DCS_PERSONA_FISICA (PER_ID);

prompt Creating DCS_TIPO_CONTACTO...
create table DCS_TIPO_CONTACTO
(
  tc_id     NUMBER not null,
  tc_nombre VARCHAR2(30)
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_TIPO_CONTACTO
  add constraint PK_DCS_TIPO_CONTACTO primary key (TC_ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating DCS_CONTACTO...
create table DCS_CONTACTO
(
  con_id        NUMBER not null,
  con_valor     VARCHAR2(100),
  tc_id         NUMBER,
  per_id        NUMBER,
  asociacion_id NUMBER
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index DCS_ASOCIACION_CONTACTO_FK01 on DCS_CONTACTO (ASOCIACION_ID)
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index DCS_PERSO_CONTAC_FK01 on DCS_CONTACTO (PER_ID)
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index DCS_TIPOCONT_CONTACTO_FK01 on DCS_CONTACTO (TC_ID)
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_CONTACTO
  add constraint PK_DCS_CONTACTO primary key (CON_ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_CONTACTO
  add constraint DCS_ASOCIACION_CONTACTO_FK01 foreign key (ASOCIACION_ID)
  references DCS_ASOCIACION (ASOCIACION_ID);
alter table DCS_CONTACTO
  add constraint DCS_PERSO_CONTAC_FK01 foreign key (PER_ID)
  references DCS_PERSONA_FISICA (PER_ID);
alter table DCS_CONTACTO
  add constraint DCS_TIPOCONT_CONTACTO_FK01 foreign key (TC_ID)
  references DCS_TIPO_CONTACTO (TC_ID);

prompt Creating DCS_ETAPA_ENSAYO...
create table DCS_ETAPA_ENSAYO
(
  eta_id         NUMBER not null,
  eta_nombre     VARCHAR2(100) not null,
  eta_estado     VARCHAR2(1),
  eta_comentario VARCHAR2(500)
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_ETAPA_ENSAYO
  add constraint PK_DCS_ETAPA_ENSAYO primary key (ETA_ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating DCS_ENSAYO...
create table DCS_ENSAYO
(
  ens_id                   NUMBER not null,
  ens_nombre               VARCHAR2(50) not null,
  ens_fecha_siembra_inicio DATE not null,
  ens_fecha_siembra_fin    DATE not null,
  ens_fecha_cosecha_inicio DATE not null,
  ens_fecha_cosecha_fin    DATE not null,
  ens_usuario_registro     VARCHAR2(30) not null,
  cos_id                   NUMBER,
  per_id                   NUMBER,
  lot_id                   NUMBER,
  est_id                   NUMBER,
  eta_id                   NUMBER
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index DCS_COSECHA_ENSAYO_FK01 on DCS_ENSAYO (COS_ID)
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index DCS_ESTADO_ENSAYO_FK01 on DCS_ENSAYO (EST_ID)
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index DCS_ETAPA_ENSAYO_FK01 on DCS_ENSAYO (ETA_ID)
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index DCS_LOTE_ENSAYO_FK01 on DCS_ENSAYO (LOT_ID)
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index DCS_PERSON_ENSAYO_FK01 on DCS_ENSAYO (PER_ID)
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_ENSAYO
  add constraint PK_DCS_ENSAYO primary key (ENS_ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_ENSAYO
  add constraint DCS_COSECHA_ENSAYO_FK01 foreign key (COS_ID)
  references DCS_COSECHA (COS_ID);
alter table DCS_ENSAYO
  add constraint DCS_ESTADO_ENSAYO_FK01 foreign key (EST_ID)
  references DCS_ESTADO_GENERAL (EST_ID);
alter table DCS_ENSAYO
  add constraint DCS_ETAPA_ENSAYO_FK01 foreign key (ETA_ID)
  references DCS_ETAPA_ENSAYO (ETA_ID);
alter table DCS_ENSAYO
  add constraint DCS_LOTE_ENSAYO_FK01 foreign key (LOT_ID)
  references DCS_LOTE (LOT_ID);
alter table DCS_ENSAYO
  add constraint DCS_PERSON_ENSAYO_FK01 foreign key (PER_ID)
  references DCS_PERSONA_FISICA (PER_ID);

prompt Creating DCS_INSPECCION...
create table DCS_INSPECCION
(
  ins_id         NUMBER not null,
  ins_fecha      DATE,
  ins_comentario VARCHAR2(500),
  rep_id         NUMBER
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index DCS_REPRODUCCION_INSPECCION_FK01 on DCS_INSPECCION (REP_ID)
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_INSPECCION
  add constraint PK_DCS_INSPECCION primary key (INS_ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_INSPECCION
  add constraint DCS_REPRODUCCION_INSPECCION_FK01 foreign key (REP_ID)
  references DCS_REPRODUCCION (REP_ID);

prompt Creating DCS_JUNTA_DIRECTIVA...
create table DCS_JUNTA_DIRECTIVA
(
  jun_id           NUMBER not null,
  jun_puesto       VARCHAR2(30) not null,
  jun_fecha_inicio DATE,
  jun_fecha_fin    DATE not null,
  aso_id           NUMBER,
  per_id           NUMBER,
  asociacion_id    NUMBER
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index DCS_ASOCIACION_JUNTA_FK01 on DCS_JUNTA_DIRECTIVA (ASOCIACION_ID)
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index DCS_ASO_JUNTA_FK01 on DCS_JUNTA_DIRECTIVA (ASO_ID)
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index DCS_PERSONA_JUNTA_FK01 on DCS_JUNTA_DIRECTIVA (PER_ID)
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_JUNTA_DIRECTIVA
  add constraint PK_DCS_JUNTA_DIRECTIVA primary key (JUN_ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_JUNTA_DIRECTIVA
  add constraint DCS_ASOCIACION_JUNTA_FK01 foreign key (ASOCIACION_ID)
  references DCS_ASOCIACION (ASOCIACION_ID);
alter table DCS_JUNTA_DIRECTIVA
  add constraint DCS_ASO_JUNTA_FK01 foreign key (ASO_ID)
  references DCS_ASOCIADO (ASO_ID);
alter table DCS_JUNTA_DIRECTIVA
  add constraint DCS_PERSONA_JUNTA_FK01 foreign key (PER_ID)
  references DCS_PERSONA_FISICA (PER_ID);

prompt Creating DCS_SEMILLA...
create table DCS_SEMILLA
(
  sem_id     NUMBER not null,
  sem_nombre VARCHAR2(30)
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_SEMILLA
  add constraint PK_DCS_SEMILLA primary key (SEM_ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating DCS_UNIDAD_MEDIDA...
create table DCS_UNIDAD_MEDIDA
(
  uni_id              NUMBER not null,
  uni_descripcion     VARCHAR2(200),
  uni_conversion_base NUMBER
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_UNIDAD_MEDIDA
  add constraint PK_DCS_UNIDAD_MEDIDA primary key (UNI_ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating DCS_VARIEDAD...
create table DCS_VARIEDAD
(
  var_id                  NUMBER not null,
  var_nombre              VARCHAR2(50),
  var_tiempo_cosecha_dias NUMBER,
  var_precio_unitario     NUMBER,
  sem_id                  NUMBER,
  uni_id                  NUMBER
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index DCS_SEMILLA_VARIEDAD_FK01 on DCS_VARIEDAD (SEM_ID)
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index DCS_UNIDAD_VARIEDAD_FK01 on DCS_VARIEDAD (UNI_ID)
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_VARIEDAD
  add constraint PK_DCS_VARIEDAD primary key (VAR_ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_VARIEDAD
  add constraint DCS_SEMILLA_VARIEDAD_FK01 foreign key (SEM_ID)
  references DCS_SEMILLA (SEM_ID);
alter table DCS_VARIEDAD
  add constraint DCS_UNIDAD_VARIEDAD_FK01 foreign key (UNI_ID)
  references DCS_UNIDAD_MEDIDA (UNI_ID);

prompt Creating DCS_PRODUCTO...
create table DCS_PRODUCTO
(
  pro_id       NUMBER not null,
  pro_nombre   VARCHAR2(50),
  pro_cantidad NUMBER,
  var_id       NUMBER,
  rep_id       NUMBER
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index DCS_REPRO_PRODUC_FK01 on DCS_PRODUCTO (REP_ID)
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index DCS_VARIEDAD_PRODUC_FK01 on DCS_PRODUCTO (VAR_ID)
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_PRODUCTO
  add constraint PK_DCS_PRODUCTO primary key (PRO_ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_PRODUCTO
  add constraint DCS_REPRO_PRODUC_FK01 foreign key (REP_ID)
  references DCS_REPRODUCCION (REP_ID);
alter table DCS_PRODUCTO
  add constraint DCS_VARIEDAD_PRODUC_FK01 foreign key (VAR_ID)
  references DCS_VARIEDAD (VAR_ID);

prompt Creating DCS_PAGO_PRODUCTOR...
create table DCS_PAGO_PRODUCTOR
(
  pag_id              NUMBER not null,
  pag_cantidad        NUMBER,
  pag_precio_unitario NUMBER,
  pag_fecha_pago      DATE not null,
  per_id              NUMBER,
  pro_id              NUMBER
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index DCS_PER_PAGO_FK01 on DCS_PAGO_PRODUCTOR (PER_ID)
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index DCS_PRODUC_PAGO_FK01 on DCS_PAGO_PRODUCTOR (PRO_ID)
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_PAGO_PRODUCTOR
  add constraint PK_DCS_PAGO_PRODUCTOR primary key (PAG_ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_PAGO_PRODUCTOR
  add constraint DCS_PER_PAGO_FK01 foreign key (PER_ID)
  references DCS_PERSONA_FISICA (PER_ID);
alter table DCS_PAGO_PRODUCTOR
  add constraint DCS_PRODUC_PAGO_FK01 foreign key (PRO_ID)
  references DCS_PRODUCTO (PRO_ID);

prompt Creating DCS_SINTOMAS...
create table DCS_SINTOMAS
(
  sin_id     NUMBER not null,
  sin_tipo   VARCHAR2(1),
  sin_nombre VARCHAR2(50),
  enf_id     NUMBER
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index DCS_ENFERMEDAD_SINTOMAS_FK01 on DCS_SINTOMAS (ENF_ID)
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_SINTOMAS
  add constraint PK_DCS_SINTOMAS primary key (SIN_ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DCS_SINTOMAS
  add constraint DCS_ENFERMEDAD_SINTOMAS_FK01 foreign key (ENF_ID)
  references DCS_ENFERMEDAD (ENF_ID);

prompt Loading DCS_FINCA...
insert into DCS_FINCA (fin_id, fin_numero_registro, fin_nombre, fin_tamano_hectareas, fin_estado, fin_direccion, per_id)
values (1, 'REG-001', 'Finca El Cafetal', 15.5, 'A', 'San Marcos de Tarraz�, 2km norte del centro', 1);
insert into DCS_FINCA (fin_id, fin_numero_registro, fin_nombre, fin_tamano_hectareas, fin_estado, fin_direccion, per_id)
values (2, 'REG-002', 'Finca Santa Rosa', 8.3, 'A', 'Santa Mar�a de Dota, 1km este de la iglesia', 2);
insert into DCS_FINCA (fin_id, fin_numero_registro, fin_nombre, fin_tamano_hectareas, fin_estado, fin_direccion, per_id)
values (3, 'REG-003', 'Finca Los Cedros', 12, 'A', 'San Lorenzo de Tarraz�, entrada principal', 5);
commit;
prompt 3 records loaded
prompt Loading DCS_PERSONA_FISICA...
insert into DCS_PERSONA_FISICA (per_id, per_identificacion, per_nombre, per_apellido1, per_apellido2, per_fecha_nacimiento, per_sexo, fin_id)
values (1, '105470123', 'Carlos', 'Rodr�guez', 'Mora', to_date('15-03-1975', 'dd-mm-yyyy'), 'M', null);
insert into DCS_PERSONA_FISICA (per_id, per_identificacion, per_nombre, per_apellido1, per_apellido2, per_fecha_nacimiento, per_sexo, fin_id)
values (2, '204560789', 'Mar�a', 'Gonz�lez', 'Vega', to_date('22-07-1980', 'dd-mm-yyyy'), 'F', null);
insert into DCS_PERSONA_FISICA (per_id, per_identificacion, per_nombre, per_apellido1, per_apellido2, per_fecha_nacimiento, per_sexo, fin_id)
values (3, '301230456', 'Luis', 'Chac�n', 'Jim�nez', to_date('10-11-1978', 'dd-mm-yyyy'), 'M', null);
insert into DCS_PERSONA_FISICA (per_id, per_identificacion, per_nombre, per_apellido1, per_apellido2, per_fecha_nacimiento, per_sexo, fin_id)
values (4, '402340567', 'Ana', 'Vargas', 'Castro', to_date('28-02-1982', 'dd-mm-yyyy'), 'F', null);
insert into DCS_PERSONA_FISICA (per_id, per_identificacion, per_nombre, per_apellido1, per_apellido2, per_fecha_nacimiento, per_sexo, fin_id)
values (5, '503450678', 'Jos�', 'P�rez', 'Morales', to_date('14-09-1976', 'dd-mm-yyyy'), 'M', null);
commit;
prompt 5 records loaded
prompt Loading DCS_COSECHA...
insert into DCS_COSECHA (cos_id, cos_nombre, cos_fecha_inicio, cos_fecha_fin)
values (1, 'Cosecha 2024-2025', to_date('01-10-2024', 'dd-mm-yyyy'), to_date('31-03-2025', 'dd-mm-yyyy'));
insert into DCS_COSECHA (cos_id, cos_nombre, cos_fecha_inicio, cos_fecha_fin)
values (2, 'Cosecha 2025-2026', to_date('01-04-2025', 'dd-mm-yyyy'), to_date('30-09-2025', 'dd-mm-yyyy'));
commit;
prompt 2 records loaded
prompt Loading DCS_ESTADO_GENERAL...
insert into DCS_ESTADO_GENERAL (est_id, est_descripcion)
values (1, 'Activo');
insert into DCS_ESTADO_GENERAL (est_id, est_descripcion)
values (2, 'Inactivo');
insert into DCS_ESTADO_GENERAL (est_id, est_descripcion)
values (3, 'Pendiente');
insert into DCS_ESTADO_GENERAL (est_id, est_descripcion)
values (4, 'Aprobado');
insert into DCS_ESTADO_GENERAL (est_id, est_descripcion)
values (5, 'Rechazado');
insert into DCS_ESTADO_GENERAL (est_id, est_descripcion)
values (6, 'Cancelado');
commit;
prompt 6 records loaded
prompt Loading DCS_LOTE...
insert into DCS_LOTE (lot_id, lot_nombre, lot_tamano_hectareas, lot_descripcion, lot_direccion, fin_id)
values (1, 'Lote A1', 3.5, 'Lote principal con exposici�n sur', 'Sector norte de la finca', 1);
insert into DCS_LOTE (lot_id, lot_nombre, lot_tamano_hectareas, lot_descripcion, lot_direccion, fin_id)
values (2, 'Lote A2', 2.8, 'Lote experimental', 'Sector este de la finca', 1);
insert into DCS_LOTE (lot_id, lot_nombre, lot_tamano_hectareas, lot_descripcion, lot_direccion, fin_id)
values (3, 'Lote B1', 4, 'Lote para reproducci�n', 'Sector central de la finca', 2);
insert into DCS_LOTE (lot_id, lot_nombre, lot_tamano_hectareas, lot_descripcion, lot_direccion, fin_id)
values (4, 'Lote C1', 5.2, 'Lote principal de producci�n', 'Ladera oeste de la finca', 3);
commit;
prompt 4 records loaded
prompt Loading DCS_INGENIERO...
insert into DCS_INGENIERO (inge_id, codigo, per_id)
values (1, 1001, 3);
insert into DCS_INGENIERO (inge_id, codigo, per_id)
values (2, 1002, 4);
commit;
prompt 2 records loaded
prompt Loading DCS_REPRODUCCION...
insert into DCS_REPRODUCCION (rep_id, rep_numero_contrato, rep_fecha_siembra_inicio, rep_fecha_siembra_fin, rep_fecha_cosecha_inicio, rep_fecha_cosecha_fin, rep_hectareas_sembradas, per_id, fin_id, lot_id, est_id, cos_id, inge_id)
values (1, 2024001, to_date('15-10-2024', 'dd-mm-yyyy'), to_date('30-11-2024', 'dd-mm-yyyy'), to_date('01-07-2025', 'dd-mm-yyyy'), to_date('15-08-2025', 'dd-mm-yyyy'), 3.5, 1, 1, 1, 1, 1, 1);
insert into DCS_REPRODUCCION (rep_id, rep_numero_contrato, rep_fecha_siembra_inicio, rep_fecha_siembra_fin, rep_fecha_cosecha_inicio, rep_fecha_cosecha_fin, rep_hectareas_sembradas, per_id, fin_id, lot_id, est_id, cos_id, inge_id)
values (2, 2024002, to_date('01-11-2024', 'dd-mm-yyyy'), to_date('15-12-2024', 'dd-mm-yyyy'), to_date('15-07-2025', 'dd-mm-yyyy'), to_date('30-08-2025', 'dd-mm-yyyy'), 4, 2, 2, 3, 1, 1, 2);
insert into DCS_REPRODUCCION (rep_id, rep_numero_contrato, rep_fecha_siembra_inicio, rep_fecha_siembra_fin, rep_fecha_cosecha_inicio, rep_fecha_cosecha_fin, rep_hectareas_sembradas, per_id, fin_id, lot_id, est_id, cos_id, inge_id)
values (3, 2024003, to_date('01-12-2024', 'dd-mm-yyyy'), to_date('15-01-2025', 'dd-mm-yyyy'), to_date('01-08-2025', 'dd-mm-yyyy'), to_date('15-09-2025', 'dd-mm-yyyy'), 5.2, 5, 3, 4, 1, 1, 1);
insert into DCS_REPRODUCCION (rep_id, rep_numero_contrato, rep_fecha_siembra_inicio, rep_fecha_siembra_fin, rep_fecha_cosecha_inicio, rep_fecha_cosecha_fin, rep_hectareas_sembradas, per_id, fin_id, lot_id, est_id, cos_id, inge_id)
values (4, 2024004, to_date('15-04-2025', 'dd-mm-yyyy'), to_date('15-05-2025', 'dd-mm-yyyy'), to_date('10-01-2026', 'dd-mm-yyyy'), to_date('09-02-2026', 'dd-mm-yyyy'), 2.8, 1, 1, 2, 1, 2, 1);
commit;
prompt 4 records loaded
prompt Loading DCS_ANALISIS...
insert into DCS_ANALISIS (ana_id, ana_motivo, ana_porcentaje_semilla_sana, ana_monto, ana_estado, rep_id)
values (1, 'Control de calidad rutinario', 95.5, 75000, 'A', 1);
insert into DCS_ANALISIS (ana_id, ana_motivo, ana_porcentaje_semilla_sana, ana_monto, ana_estado, rep_id)
values (2, 'An�lisis pre-cosecha', 88.2, 65000, 'A', 2);
insert into DCS_ANALISIS (ana_id, ana_motivo, ana_porcentaje_semilla_sana, ana_monto, ana_estado, rep_id)
values (3, 'Verificaci�n fitosanitaria', 92.8, 70000, 'P', 3);
insert into DCS_ANALISIS (ana_id, ana_motivo, ana_porcentaje_semilla_sana, ana_monto, ana_estado, rep_id)
values (4, 'An�lisis Roya', 75.5, 45000, 'A', 1);
insert into DCS_ANALISIS (ana_id, ana_motivo, ana_porcentaje_semilla_sana, ana_monto, ana_estado, rep_id)
values (5, 'An�lisis Roya', 75.5, 45000, 'A', 1);
commit;
prompt 5 records loaded
prompt Loading DCS_ENFERMEDAD...
insert into DCS_ENFERMEDAD (enf_id, enf_nombre, enf_ubicacion_planta, enf_tratamiento, enf_etapa_desarrollo)
values (1, 'Roya del caf�', 'Hojas', 'Fungicida c�prico', 'Vegetativa');
insert into DCS_ENFERMEDAD (enf_id, enf_nombre, enf_ubicacion_planta, enf_tratamiento, enf_etapa_desarrollo)
values (2, 'Antracnosis', 'Frutos', 'Fungicida sist�mico', 'Reproductiva');
commit;
prompt 2 records loaded
prompt Loading DCS_ANALISIS_ENFERMEDAD...
insert into DCS_ANALISIS_ENFERMEDAD (ana_id, enf_id)
values (1, 1);
insert into DCS_ANALISIS_ENFERMEDAD (ana_id, enf_id)
values (3, 2);
insert into DCS_ANALISIS_ENFERMEDAD (ana_id, enf_id)
values (4, 1);
insert into DCS_ANALISIS_ENFERMEDAD (ana_id, enf_id)
values (5, 1);
commit;
prompt 4 records loaded
prompt Loading DCS_PLAGA...
insert into DCS_PLAGA (pla_id, pla_nombre, pla_descripcion, pla_tratamiento, pla_etapa_desarrollo)
values (1, 'Broca del caf�', 'Insecto que perfora los granos de caf�', 'Aplicaci�n de insecticida espec�fico', '2');
insert into DCS_PLAGA (pla_id, pla_nombre, pla_descripcion, pla_tratamiento, pla_etapa_desarrollo)
values (2, 'Minador de la hoja', 'Larva que da�a las hojas del caf�', 'Control biol�gico con parasitoides', '1');
commit;
prompt 2 records loaded
prompt Loading DCS_ANALISIS_PLAGA...
insert into DCS_ANALISIS_PLAGA (ana_id, pla_id)
values (1, 1);
insert into DCS_ANALISIS_PLAGA (ana_id, pla_id)
values (2, 2);
commit;
prompt 2 records loaded
prompt Loading DCS_ASOCIACION...
insert into DCS_ASOCIACION (asociacion_id, asociacion_cedula_juridica, asociacion_nombre, asociacion_logo)
values (1, 3001234567, 'Asociaci�n Productores Tarraz�', 'https://tarrazu.com/logo.png');
commit;
prompt 1 records loaded
prompt Loading DCS_CATEGORIA_ASOCIADO...
insert into DCS_CATEGORIA_ASOCIADO (cat_id, cat_descripcion, cat_monto_cuota_mensual)
values (1, 'Productor B�sico', 8250);
insert into DCS_CATEGORIA_ASOCIADO (cat_id, cat_descripcion, cat_monto_cuota_mensual)
values (2, 'Productor Intermedio', 13750);
insert into DCS_CATEGORIA_ASOCIADO (cat_id, cat_descripcion, cat_monto_cuota_mensual)
values (3, 'Productor Avanzado', 19250);
commit;
prompt 3 records loaded
prompt Loading DCS_ASOCIADO...
insert into DCS_ASOCIADO (aso_id, aso_fecha_ingreso, aso_estado, aso_cuota_afiliacion, per_id, cat_id, asociacion_id)
values (1, to_date('15-01-2023', 'dd-mm-yyyy'), 'A', 50000, 1, 2, 1);
insert into DCS_ASOCIADO (aso_id, aso_fecha_ingreso, aso_estado, aso_cuota_afiliacion, per_id, cat_id, asociacion_id)
values (2, to_date('20-03-2023', 'dd-mm-yyyy'), 'A', 50000, 2, 1, 1);
insert into DCS_ASOCIADO (aso_id, aso_fecha_ingreso, aso_estado, aso_cuota_afiliacion, per_id, cat_id, asociacion_id)
values (3, to_date('10-06-2023', 'dd-mm-yyyy'), 'A', 50000, 5, 3, 1);
commit;
prompt 3 records loaded
prompt Loading DCS_TIPO_CONTACTO...
insert into DCS_TIPO_CONTACTO (tc_id, tc_nombre)
values (1, 'Tel�fono');
insert into DCS_TIPO_CONTACTO (tc_id, tc_nombre)
values (2, 'Email');
insert into DCS_TIPO_CONTACTO (tc_id, tc_nombre)
values (3, 'WhatsApp');
commit;
prompt 3 records loaded
prompt Loading DCS_CONTACTO...
insert into DCS_CONTACTO (con_id, con_valor, tc_id, per_id, asociacion_id)
values (1, '8765-4321', 1, 1, null);
insert into DCS_CONTACTO (con_id, con_valor, tc_id, per_id, asociacion_id)
values (2, 'carlos@email.com', 2, 1, null);
insert into DCS_CONTACTO (con_id, con_valor, tc_id, per_id, asociacion_id)
values (3, '8888-9999', 1, 2, null);
insert into DCS_CONTACTO (con_id, con_valor, tc_id, per_id, asociacion_id)
values (4, 'info@tarrazu.com', 2, null, 1);
commit;
prompt 4 records loaded
prompt Loading DCS_ETAPA_ENSAYO...
insert into DCS_ETAPA_ENSAYO (eta_id, eta_nombre, eta_estado, eta_comentario)
values (1, 'Germinaci�n y Vigor', 'A', 'Etapa inicial de desarrollo');
insert into DCS_ETAPA_ENSAYO (eta_id, eta_nombre, eta_estado, eta_comentario)
values (2, 'Floraci�n', 'A', 'Etapa de floraci�n del cultivo');
insert into DCS_ETAPA_ENSAYO (eta_id, eta_nombre, eta_estado, eta_comentario)
values (3, 'Maduraci�n', 'A', 'Etapa final de maduraci�n');
commit;
prompt 3 records loaded
prompt Loading DCS_ENSAYO...
insert into DCS_ENSAYO (ens_id, ens_nombre, ens_fecha_siembra_inicio, ens_fecha_siembra_fin, ens_fecha_cosecha_inicio, ens_fecha_cosecha_fin, ens_usuario_registro, cos_id, per_id, lot_id, est_id, eta_id)
values (1, 'Ensayo Resistencia Roya', to_date('15-11-2024', 'dd-mm-yyyy'), to_date('01-12-2024', 'dd-mm-yyyy'), to_date('01-08-2025', 'dd-mm-yyyy'), to_date('15-08-2025', 'dd-mm-yyyy'), 'ing_luis', 1, 3, 2, 1, 2);
insert into DCS_ENSAYO (ens_id, ens_nombre, ens_fecha_siembra_inicio, ens_fecha_siembra_fin, ens_fecha_cosecha_inicio, ens_fecha_cosecha_fin, ens_usuario_registro, cos_id, per_id, lot_id, est_id, eta_id)
values (2, 'Ensayo Productividad', to_date('10-01-2025', 'dd-mm-yyyy'), to_date('25-01-2025', 'dd-mm-yyyy'), to_date('01-09-2025', 'dd-mm-yyyy'), to_date('15-09-2025', 'dd-mm-yyyy'), 'ing_ana', 2, 4, 1, 1, 1);
commit;
prompt 2 records loaded
prompt Loading DCS_INSPECCION...
insert into DCS_INSPECCION (ins_id, ins_fecha, ins_comentario, rep_id)
values (1, to_date('15-01-2025', 'dd-mm-yyyy'), 'Desarrollo normal de plantas, buen establecimiento del cultivo', 1);
insert into DCS_INSPECCION (ins_id, ins_fecha, ins_comentario, rep_id)
values (2, to_date('20-02-2025', 'dd-mm-yyyy'), 'Se observa presencia leve de malezas, se recomienda control', 2);
insert into DCS_INSPECCION (ins_id, ins_fecha, ins_comentario, rep_id)
values (3, to_date('10-03-2025', 'dd-mm-yyyy'), 'Excelente desarrollo vegetativo, plantas vigorosas', 3);
insert into DCS_INSPECCION (ins_id, ins_fecha, ins_comentario, rep_id)
values (5, to_date('12-06-2025 03:01:58', 'dd-mm-yyyy hh24:mi:ss'), 'An�lisis enfermedad: Se detect� presencia de roya en hojas superiores', 1);
insert into DCS_INSPECCION (ins_id, ins_fecha, ins_comentario, rep_id)
values (6, to_date('12-06-2025 03:02:37', 'dd-mm-yyyy hh24:mi:ss'), 'An�lisis enfermedad: Se detect� presencia de roya en hojas superiores', 1);
insert into DCS_INSPECCION (ins_id, ins_fecha, ins_comentario, rep_id)
values (4, to_date('12-06-2025 02:25:25', 'dd-mm-yyyy hh24:mi:ss'), 'Inspecci�n de prueba - desarrollo normal del cultivo', 1);
commit;
prompt 6 records loaded
prompt Loading DCS_JUNTA_DIRECTIVA...
insert into DCS_JUNTA_DIRECTIVA (jun_id, jun_puesto, jun_fecha_inicio, jun_fecha_fin, aso_id, per_id, asociacion_id)
values (1, 'Presidente', to_date('01-01-2024', 'dd-mm-yyyy'), to_date('31-12-2025', 'dd-mm-yyyy'), 1, 1, 1);
insert into DCS_JUNTA_DIRECTIVA (jun_id, jun_puesto, jun_fecha_inicio, jun_fecha_fin, aso_id, per_id, asociacion_id)
values (2, 'Secretaria', to_date('01-01-2024', 'dd-mm-yyyy'), to_date('31-12-2025', 'dd-mm-yyyy'), 2, 2, 1);
commit;
prompt 2 records loaded
prompt Loading DCS_SEMILLA...
insert into DCS_SEMILLA (sem_id, sem_nombre)
values (1, 'Caf� Ar�bica');
insert into DCS_SEMILLA (sem_id, sem_nombre)
values (2, 'Caf� Robusta');
commit;
prompt 2 records loaded
prompt Loading DCS_UNIDAD_MEDIDA...
insert into DCS_UNIDAD_MEDIDA (uni_id, uni_descripcion, uni_conversion_base)
values (1, 'Kilogramos', 1);
insert into DCS_UNIDAD_MEDIDA (uni_id, uni_descripcion, uni_conversion_base)
values (2, 'Quintales', 46);
insert into DCS_UNIDAD_MEDIDA (uni_id, uni_descripcion, uni_conversion_base)
values (3, 'Libras', .454);
commit;
prompt 3 records loaded
prompt Loading DCS_VARIEDAD...
insert into DCS_VARIEDAD (var_id, var_nombre, var_tiempo_cosecha_dias, var_precio_unitario, sem_id, uni_id)
values (1, 'Geisha', 270, 8500, 1, 1);
insert into DCS_VARIEDAD (var_id, var_nombre, var_tiempo_cosecha_dias, var_precio_unitario, sem_id, uni_id)
values (2, 'Caturra', 240, 6200, 1, 1);
insert into DCS_VARIEDAD (var_id, var_nombre, var_tiempo_cosecha_dias, var_precio_unitario, sem_id, uni_id)
values (3, 'Villa Sarch�', 260, 7300, 1, 1);
commit;
prompt 3 records loaded
prompt Loading DCS_PRODUCTO...
insert into DCS_PRODUCTO (pro_id, pro_nombre, pro_cantidad, var_id, rep_id)
values (1, 'Caf� Geisha Premium', 850.5, 1, 1);
insert into DCS_PRODUCTO (pro_id, pro_nombre, pro_cantidad, var_id, rep_id)
values (2, 'Caf� Caturra Tradicional', 1200.3, 2, 2);
insert into DCS_PRODUCTO (pro_id, pro_nombre, pro_cantidad, var_id, rep_id)
values (3, 'Caf� Villa Sarch� Especial', 1450.8, 3, 3);
commit;
prompt 3 records loaded
prompt Loading DCS_PAGO_PRODUCTOR...
insert into DCS_PAGO_PRODUCTOR (pag_id, pag_cantidad, pag_precio_unitario, pag_fecha_pago, per_id, pro_id)
values (1, 850.5, 8500, to_date('20-08-2025', 'dd-mm-yyyy'), 1, 1);
insert into DCS_PAGO_PRODUCTOR (pag_id, pag_cantidad, pag_precio_unitario, pag_fecha_pago, per_id, pro_id)
values (2, 1200.3, 6200, to_date('05-09-2025', 'dd-mm-yyyy'), 2, 2);
insert into DCS_PAGO_PRODUCTOR (pag_id, pag_cantidad, pag_precio_unitario, pag_fecha_pago, per_id, pro_id)
values (3, 1450.8, 7300, to_date('20-09-2025', 'dd-mm-yyyy'), 5, 3);
commit;
prompt 3 records loaded
prompt Loading DCS_SINTOMAS...
insert into DCS_SINTOMAS (sin_id, sin_tipo, sin_nombre, enf_id)
values (1, 'V', 'Manchas amarillas en hojas', 1);
insert into DCS_SINTOMAS (sin_id, sin_tipo, sin_nombre, enf_id)
values (2, 'F', 'Lesiones oscuras en frutos', 2);
commit;
prompt 2 records loaded

set feedback on
set define on
prompt Done
