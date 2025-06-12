/*
Created: 19/4/2025
Modified: 11/6/2025
Model: db-comite-semillas
Database: Oracle 18c
*/


-- Create sequences section -------------------------------------------------

CREATE SEQUENCE dcs_asociacion_seq01
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 MINVALUE 0
 NOCACHE
;

CREATE SEQUENCE dcs_tipocontacto_seq01
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 MINVALUE 0
 NOCACHE
;

CREATE SEQUENCE dcs_contacto_seq01
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 MINVALUE 0
 NOCACHE
;

CREATE SEQUENCE dcs_junta_seq01
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 MINVALUE 0
 NOCACHE
;

CREATE SEQUENCE dcs_persona_seq01
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 MINVALUE 0
 NOCACHE
;

CREATE SEQUENCE dcs_finca_seq01
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 MINVALUE 0
 NOCACHE
;

CREATE SEQUENCE dcs_lote_seq01
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 MINVALUE 0
 NOCACHE
;

CREATE SEQUENCE dcs_pago_seq01
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 MINVALUE 0
 NOCACHE
;

CREATE SEQUENCE dcs_asociado_seq01
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 MINVALUE 0
 NOCACHE
;

CREATE SEQUENCE dcs_categoriaaso_seq01
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 MINVALUE 0
 NOCACHE
;

CREATE SEQUENCE dcs_ensayo_seq01
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 MINVALUE 0
 NOCACHE
;

CREATE SEQUENCE dcs_etaensayo_seq01
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 MINVALUE 0
 NOCACHE
;

CREATE SEQUENCE dcs_estado_seq01
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 MINVALUE 0
 NOCACHE
;

CREATE SEQUENCE dcs_cosecha_seq01
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 MINVALUE 0
 NOCACHE
;

CREATE SEQUENCE dcs_reproduccion_seq01
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 MINVALUE 0
 NOCACHE
;

CREATE SEQUENCE dcs_producto_seq01
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 MINVALUE 0
 NOCACHE
;

CREATE SEQUENCE dcs_semillas_seq01
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 MINVALUE 0
 NOCACHE
;

CREATE SEQUENCE dcs_umedida_seq01
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 MINVALUE 0
 NOCACHE
;

CREATE SEQUENCE dcs_variedad_seq01
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 MINVALUE 0
 NOCACHE
;

CREATE SEQUENCE dcs_inspeccion_seq01
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 MINVALUE 0
 NOCACHE
;

CREATE SEQUENCE dcs_analisis_seq01
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 MINVALUE 0
 NOCACHE
;

CREATE SEQUENCE dcs_enfermedad_seq01
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 MINVALUE 0
 NOCACHE
;

CREATE SEQUENCE dcs_sintoma_seq01
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 MINVALUE 0
 NOCACHE
;

CREATE SEQUENCE dcs_plaga_seq01
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 MINVALUE 0
 NOCACHE
;

CREATE SEQUENCE dcs_ingeniero_seq01
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 MINVALUE 0
 NOCACHE
;

-- Create tables section -------------------------------------------------

-- Table dcs_persona_fisica

CREATE TABLE dcs_persona_fisica(
  per_id Number NOT NULL,
  per_identificacion Varchar2(30 ) NOT NULL,
  per_nombre Varchar2(40 ) NOT NULL,
  per_apellido1 Varchar2(20 ) NOT NULL,
  per_apellido2 Varchar2(20 ),
  per_fecha_nacimiento Date,
  per_sexo Varchar2(1 ),
  fin_id Number,
  CONSTRAINT dcs_persona_fisica_ck01 CHECK (per_sexo in ('M','F'))
)
;

-- Create indexes for table dcs_persona_fisica

CREATE INDEX dcs_finca_perso_fk01 ON dcs_persona_fisica (fin_id)
;

-- Add keys for table dcs_persona_fisica

ALTER TABLE dcs_persona_fisica ADD CONSTRAINT PK_dcs_persona_fisica PRIMARY KEY (per_id)
;

-- Table dcs_asociado

CREATE TABLE dcs_asociado(
  aso_id Number NOT NULL,
  aso_fecha_ingreso Date NOT NULL,
  aso_estado Varchar2(1 ),
  aso_cuota_afiliacion Number,
  per_id Number,
  cat_id Number,
  asociacion_id Number
)
;

-- Create indexes for table dcs_asociado

CREATE INDEX dcs_perso_asociado_fk01 ON dcs_asociado (per_id)
;

CREATE INDEX dcs_catego_asociado_fk01 ON dcs_asociado (cat_id)
;

CREATE INDEX dcs_asociacion_asociado_fk01 ON dcs_asociado (asociacion_id)
;

-- Add keys for table dcs_asociado

ALTER TABLE dcs_asociado ADD CONSTRAINT PK_dcs_asociado PRIMARY KEY (aso_id)
;

-- Table dcs_categoria_asociado

CREATE TABLE dcs_categoria_asociado(
  cat_id Number NOT NULL,
  cat_descripcion Varchar2(200 ),
  cat_monto_cuota_mensual Number
)
;

-- Add keys for table dcs_categoria_asociado

ALTER TABLE dcs_categoria_asociado ADD CONSTRAINT PK_dcs_categoria_asociado PRIMARY KEY (cat_id)
;

-- Table dcs_cosecha

CREATE TABLE dcs_cosecha(
  cos_id Number NOT NULL,
  cos_nombre Varchar2(50 ),
  cos_fecha_inicio Date,
  cos_fecha_fin Date
)
;

-- Add keys for table dcs_cosecha

ALTER TABLE dcs_cosecha ADD CONSTRAINT PK_dcs_cosecha PRIMARY KEY (cos_id)
;

-- Table dcs_enfermedad

CREATE TABLE dcs_enfermedad(
  enf_id Number NOT NULL,
  enf_nombre Varchar2(50 ),
  enf_ubicacion_planta Varchar2(20 ),
  enf_tratamiento Varchar2(30 ),
  enf_etapa_desarrollo Varchar2(30 )
)
;

-- Add keys for table dcs_enfermedad

ALTER TABLE dcs_enfermedad ADD CONSTRAINT PK_dcs_enfermedad PRIMARY KEY (enf_id)
;

-- Table dcs_plaga

CREATE TABLE dcs_plaga(
  pla_id Number NOT NULL,
  pla_nombre Varchar2(50 ) NOT NULL,
  pla_descripcion Varchar2(500 ),
  pla_tratamiento Varchar2(50 ) NOT NULL,
  pla_etapa_desarrollo Varchar2(1 ) NOT NULL
)
;

-- Add keys for table dcs_plaga

ALTER TABLE dcs_plaga ADD CONSTRAINT PK_dcs_plaga PRIMARY KEY (pla_id)
;

-- Table dcs_finca

CREATE TABLE dcs_finca(
  fin_id Number NOT NULL,
  fin_numero_registro Varchar2(15 ) NOT NULL,
  fin_nombre Varchar2(30 ),
  fin_tamano_hectareas Number NOT NULL,
  fin_estado Varchar2(1 ),
  fin_direccion Varchar2(500 ) NOT NULL,
  per_id Number
)
;

-- Create indexes for table dcs_finca

CREATE INDEX dcs_perso_finca_fk01 ON dcs_finca (per_id)
;

-- Add keys for table dcs_finca

ALTER TABLE dcs_finca ADD CONSTRAINT PK_dcs_finca PRIMARY KEY (fin_id)
;

-- Table dcs_lote

CREATE TABLE dcs_lote(
  lot_id Number NOT NULL,
  lot_nombre Varchar2(50 ),
  lot_tamano_hectareas Number NOT NULL,
  lot_descripcion Varchar2(500 ),
  lot_direccion Varchar2(500 ) NOT NULL,
  fin_id Number
)
;

-- Create indexes for table dcs_lote

CREATE INDEX dcs_finca_lote_fk01 ON dcs_lote (fin_id)
;

-- Add keys for table dcs_lote

ALTER TABLE dcs_lote ADD CONSTRAINT PK_dcs_lote PRIMARY KEY (lot_id)
;

-- Table dcs_semilla

CREATE TABLE dcs_semilla(
  sem_id Number NOT NULL,
  sem_nombre Varchar2(30 )
)
;

-- Add keys for table dcs_semilla

ALTER TABLE dcs_semilla ADD CONSTRAINT PK_dcs_semilla PRIMARY KEY (sem_id)
;

-- Table dcs_variedad

CREATE TABLE dcs_variedad(
  var_id Number NOT NULL,
  var_nombre Varchar2(50 ),
  var_tiempo_cosecha_dias Number,
  var_precio_unitario Number,
  sem_id Number,
  uni_id Number
)
;

-- Create indexes for table dcs_variedad

CREATE INDEX dcs_semilla_variedad_fk01 ON dcs_variedad (sem_id)
;

CREATE INDEX dcs_unidad_variedad_fk01 ON dcs_variedad (uni_id)
;

-- Add keys for table dcs_variedad

ALTER TABLE dcs_variedad ADD CONSTRAINT PK_dcs_variedad PRIMARY KEY (var_id)
;

-- Table dcs_unidad_medida

CREATE TABLE dcs_unidad_medida(
  uni_id Number NOT NULL,
  uni_descripcion Varchar2(200 ),
  uni_conversion_base Number
)
;

-- Add keys for table dcs_unidad_medida

ALTER TABLE dcs_unidad_medida ADD CONSTRAINT PK_dcs_unidad_medida PRIMARY KEY (uni_id)
;

-- Table dcs_reproduccion

CREATE TABLE dcs_reproduccion(
  rep_id Number NOT NULL,
  rep_numero_contrato Number,
  rep_fecha_siembra_inicio Date NOT NULL,
  rep_fecha_siembra_fin Date NOT NULL,
  rep_fecha_cosecha_inicio Date NOT NULL,
  rep_fecha_cosecha_fin Date NOT NULL,
  rep_hectareas_sembradas Number NOT NULL,
  per_id Number,
  fin_id Number,
  lot_id Number,
  est_id Number,
  cos_id Number,
  inge_id Number
)
;

-- Create indexes for table dcs_reproduccion

CREATE INDEX dcs_persona_repro_fk01 ON dcs_reproduccion (per_id)
;

CREATE INDEX dcs_finca_repro_fk01 ON dcs_reproduccion (fin_id)
;

CREATE INDEX dcs_lote_repro_fk01 ON dcs_reproduccion (lot_id)
;

CREATE INDEX dcs_estado_reproduccion_fk01 ON dcs_reproduccion (est_id)
;

CREATE INDEX dcs_cosecha_repro_fk01 ON dcs_reproduccion (cos_id)
;

CREATE INDEX dcs_ing_repro_fk01 ON dcs_reproduccion (inge_id)
;

-- Add keys for table dcs_reproduccion

ALTER TABLE dcs_reproduccion ADD CONSTRAINT PK_dcs_reproduccion PRIMARY KEY (rep_id)
;

-- Table dcs_inspeccion

CREATE TABLE dcs_inspeccion(
  ins_id Number NOT NULL,
  ins_fecha Date,
  ins_comentario Varchar2(500 ),
  rep_id Number
)
;

-- Create indexes for table dcs_inspeccion

CREATE INDEX dcs_reproduccion_inspeccion_fk01 ON dcs_inspeccion (rep_id)
;

-- Add keys for table dcs_inspeccion

ALTER TABLE dcs_inspeccion ADD CONSTRAINT PK_dcs_inspeccion PRIMARY KEY (ins_id)
;

-- Table dcs_analisis

CREATE TABLE dcs_analisis(
  ana_id Number NOT NULL,
  ana_motivo Varchar2(30 ),
  ana_porcentaje_semilla_sana Number,
  ana_monto Number,
  ana_estado Varchar2(1 ),
  rep_id Number
)
;

-- Create indexes for table dcs_analisis

CREATE INDEX dcs_reproduccion_analisi_fk01 ON dcs_analisis (rep_id)
;

-- Add keys for table dcs_analisis

ALTER TABLE dcs_analisis ADD CONSTRAINT PK_dcs_analisis PRIMARY KEY (ana_id)
;

-- Table dcs_producto

CREATE TABLE dcs_producto(
  pro_id Number NOT NULL,
  pro_nombre Varchar2(50 ),
  pro_cantidad Number,
  var_id Number,
  rep_id Number
)
;

-- Create indexes for table dcs_producto

CREATE INDEX dcs_variedad_produc_fk01 ON dcs_producto (var_id)
;

CREATE INDEX dcs_repro_produc_fk01 ON dcs_producto (rep_id)
;

-- Add keys for table dcs_producto

ALTER TABLE dcs_producto ADD CONSTRAINT PK_dcs_producto PRIMARY KEY (pro_id)
;

-- Table dcs_pago_productor

CREATE TABLE dcs_pago_productor(
  pag_id Number NOT NULL,
  pag_cantidad Number,
  pag_precio_unitario Number,
  pag_fecha_pago Date NOT NULL,
  per_id Number,
  pro_id Number
)
;

-- Create indexes for table dcs_pago_productor

CREATE INDEX dcs_per_pago_fk01 ON dcs_pago_productor (per_id)
;

CREATE INDEX dcs_produc_pago_fk01 ON dcs_pago_productor (pro_id)
;

-- Add keys for table dcs_pago_productor

ALTER TABLE dcs_pago_productor ADD CONSTRAINT PK_dcs_pago_productor PRIMARY KEY (pag_id)
;

-- Table dcs_ensayo

CREATE TABLE dcs_ensayo(
  ens_id Number NOT NULL,
  ens_nombre Varchar2(50 ) NOT NULL,
  ens_fecha_siembra_inicio Date NOT NULL,
  ens_fecha_siembra_fin Date NOT NULL,
  ens_fecha_cosecha_inicio Date NOT NULL,
  ens_fecha_cosecha_fin Date NOT NULL,
  ens_usuario_registro Varchar2(30 ) NOT NULL,
  cos_id Number,
  per_id Number,
  lot_id Number,
  est_id Number,
  eta_id Number
)
;

-- Create indexes for table dcs_ensayo

CREATE INDEX dcs_cosecha_ensayo_fk01 ON dcs_ensayo (cos_id)
;

CREATE INDEX dcs_person_ensayo_fk01 ON dcs_ensayo (per_id)
;

CREATE INDEX dcs_lote_ensayo_fk01 ON dcs_ensayo (lot_id)
;

CREATE INDEX dcs_estado_ensayo_fk01 ON dcs_ensayo (est_id)
;

CREATE INDEX dcs_etapa_ensayo_fk01 ON dcs_ensayo (eta_id)
;

-- Add keys for table dcs_ensayo

ALTER TABLE dcs_ensayo ADD CONSTRAINT PK_dcs_ensayo PRIMARY KEY (ens_id)
;

-- Table dcs_etapa_ensayo

CREATE TABLE dcs_etapa_ensayo(
  eta_id Number NOT NULL,
  eta_nombre Varchar2(100 ) NOT NULL,
  eta_estado Varchar2(1 ),
  eta_comentario Varchar2(500 )
)
;

-- Add keys for table dcs_etapa_ensayo

ALTER TABLE dcs_etapa_ensayo ADD CONSTRAINT PK_dcs_etapa_ensayo PRIMARY KEY (eta_id)
;

-- Table dcs_estado_general

CREATE TABLE dcs_estado_general(
  est_id Number NOT NULL,
  est_descripcion Varchar2(500 )
)
;

-- Add keys for table dcs_estado_general

ALTER TABLE dcs_estado_general ADD CONSTRAINT PK_dcs_estado_general PRIMARY KEY (est_id)
;

-- Table dcs_junta_directiva

CREATE TABLE dcs_junta_directiva(
  jun_id Number NOT NULL,
  jun_puesto Varchar2(30 ) NOT NULL,
  jun_fecha_inicio Date,
  jun_fecha_fin Date NOT NULL,
  aso_id Number,
  per_id Number,
  asociacion_id Number
)
;

-- Create indexes for table dcs_junta_directiva

CREATE INDEX dcs_aso_junta_fk01 ON dcs_junta_directiva (aso_id)
;

CREATE INDEX dcs_persona_junta_fk01 ON dcs_junta_directiva (per_id)
;

CREATE INDEX dcs_asociacion_junta_fk01 ON dcs_junta_directiva (asociacion_id)
;

-- Add keys for table dcs_junta_directiva

ALTER TABLE dcs_junta_directiva ADD CONSTRAINT PK_dcs_junta_directiva PRIMARY KEY (jun_id)
;

-- Table dcs_analisis_plaga

CREATE TABLE dcs_analisis_plaga(
  ana_id Number NOT NULL,
  pla_id Number NOT NULL
)
;

-- Add keys for table dcs_analisis_plaga

ALTER TABLE dcs_analisis_plaga ADD CONSTRAINT PK_dcs_analisis_plaga PRIMARY KEY (ana_id,pla_id)
;

-- Table dcs_analisis_enfermedad

CREATE TABLE dcs_analisis_enfermedad(
  ana_id Number NOT NULL,
  enf_id Number NOT NULL
)
;

-- Add keys for table dcs_analisis_enfermedad

ALTER TABLE dcs_analisis_enfermedad ADD CONSTRAINT PK_dcs_analisis_enfermedad PRIMARY KEY (ana_id,enf_id)
;

-- Table dcs_asociacion

CREATE TABLE dcs_asociacion(
  asociacion_id Number NOT NULL,
  asociacion_cedula_juridica Number NOT NULL,
  asociacion_nombre Varchar2(40 ) NOT NULL,
  asociacion_logo Varchar2(100 )
)
;

-- Add keys for table dcs_asociacion

ALTER TABLE dcs_asociacion ADD CONSTRAINT PK_dcs_asociacion PRIMARY KEY (asociacion_id)
;

-- Table and Columns comments section

COMMENT ON COLUMN dcs_asociacion.asociacion_logo IS 'URL DEL LOGO
'
;

-- Table dcs_tipo_contacto

CREATE TABLE dcs_tipo_contacto(
  tc_id Number NOT NULL,
  tc_nombre Varchar2(30 )
)
;

-- Add keys for table dcs_tipo_contacto

ALTER TABLE dcs_tipo_contacto ADD CONSTRAINT PK_dcs_tipo_contacto PRIMARY KEY (tc_id)
;

-- Table dcs_contacto

CREATE TABLE dcs_contacto(
  con_id Number NOT NULL,
  con_valor Varchar2(100 ),
  tc_id Number,
  per_id Number,
  asociacion_id Number
)
;

-- Create indexes for table dcs_contacto

CREATE INDEX dcs_tipocont_contacto_fk01 ON dcs_contacto (tc_id)
;

CREATE INDEX dcs_perso_contac_fk01 ON dcs_contacto (per_id)
;

CREATE INDEX dcs_asociacion_contacto_fk01 ON dcs_contacto (asociacion_id)
;

-- Add keys for table dcs_contacto

ALTER TABLE dcs_contacto ADD CONSTRAINT PK_dcs_contacto PRIMARY KEY (con_id)
;

-- Table dcs_sintomas

CREATE TABLE dcs_sintomas(
  sin_id Number NOT NULL,
  sin_tipo Varchar2(1 ),
  sin_nombre Varchar2(50 ),
  enf_id Number
)
;

-- Create indexes for table dcs_sintomas

CREATE INDEX dcs_enfermedad_sintomas_fk01 ON dcs_sintomas (enf_id)
;

-- Add keys for table dcs_sintomas

ALTER TABLE dcs_sintomas ADD CONSTRAINT PK_dcs_sintomas PRIMARY KEY (sin_id)
;

-- Table dcs_ingeniero

CREATE TABLE dcs_ingeniero(
  inge_id Number NOT NULL,
  codigo Number,
  per_id Number
)
;

-- Create indexes for table dcs_ingeniero

CREATE INDEX dcs_per_ing_fk01 ON dcs_ingeniero (per_id)
;

-- Add keys for table dcs_ingeniero

ALTER TABLE dcs_ingeniero ADD CONSTRAINT PK_dcs_ingeniero PRIMARY KEY (inge_id)
;

-- Trigger for sequence dcs_persona_seq01 for column per_id in table dcs_persona_fisica ---------
CREATE OR REPLACE TRIGGER ts_dcs_persona_fisica_dcs_persona_seq01 BEFORE INSERT
ON dcs_persona_fisica FOR EACH ROW
BEGIN
  :new.per_id := dcs_persona_seq01.nextval;
END;
;
CREATE OR REPLACE TRIGGER tsu_dcs_persona_fisica_dcs_persona_seq01 AFTER UPDATE OF per_id
ON dcs_persona_fisica FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column per_id in table dcs_persona_fisica as it uses sequence.');
END;
;

-- Trigger for sequence dcs_asociado_seq01 for column aso_id in table dcs_asociado ---------
CREATE OR REPLACE TRIGGER ts_dcs_asociado_dcs_asociado_seq01 BEFORE INSERT
ON dcs_asociado FOR EACH ROW
BEGIN
  :new.aso_id := dcs_asociado_seq01.nextval;
END;
;
CREATE OR REPLACE TRIGGER tsu_dcs_asociado_dcs_asociado_seq01 AFTER UPDATE OF aso_id
ON dcs_asociado FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column aso_id in table dcs_asociado as it uses sequence.');
END;
;

-- Trigger for sequence dcs_categoriaaso_seq01 for column cat_id in table dcs_categoria_asociado ---------
CREATE OR REPLACE TRIGGER ts_dcs_categoria_asociado_dcs_categoriaaso_seq01 BEFORE INSERT
ON dcs_categoria_asociado FOR EACH ROW
BEGIN
  :new.cat_id := dcs_categoriaaso_seq01.nextval;
END;
;
CREATE OR REPLACE TRIGGER tsu_dcs_categoria_asociado_dcs_categoriaaso_seq01 AFTER UPDATE OF cat_id
ON dcs_categoria_asociado FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column cat_id in table dcs_categoria_asociado as it uses sequence.');
END;
;

-- Trigger for sequence dcs_cosecha_seq01 for column cos_id in table dcs_cosecha ---------
CREATE OR REPLACE TRIGGER ts_dcs_cosecha_dcs_cosecha_seq01 BEFORE INSERT
ON dcs_cosecha FOR EACH ROW
BEGIN
  :new.cos_id := dcs_cosecha_seq01.nextval;
END;
;
CREATE OR REPLACE TRIGGER tsu_dcs_cosecha_dcs_cosecha_seq01 AFTER UPDATE OF cos_id
ON dcs_cosecha FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column cos_id in table dcs_cosecha as it uses sequence.');
END;
;

-- Trigger for sequence dcs_enfermedad_seq01 for column enf_id in table dcs_enfermedad ---------
CREATE OR REPLACE TRIGGER ts_dcs_enfermedad_dcs_enfermedad_seq01 BEFORE INSERT
ON dcs_enfermedad FOR EACH ROW
BEGIN
  :new.enf_id := dcs_enfermedad_seq01.nextval;
END;
;
CREATE OR REPLACE TRIGGER tsu_dcs_enfermedad_dcs_enfermedad_seq01 AFTER UPDATE OF enf_id
ON dcs_enfermedad FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column enf_id in table dcs_enfermedad as it uses sequence.');
END;
;

-- Trigger for sequence dcs_plaga_seq01 for column pla_id in table dcs_plaga ---------
CREATE OR REPLACE TRIGGER ts_dcs_plaga_dcs_plaga_seq01 BEFORE INSERT
ON dcs_plaga FOR EACH ROW
BEGIN
  :new.pla_id := dcs_plaga_seq01.nextval;
END;
;
CREATE OR REPLACE TRIGGER tsu_dcs_plaga_dcs_plaga_seq01 AFTER UPDATE OF pla_id
ON dcs_plaga FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column pla_id in table dcs_plaga as it uses sequence.');
END;
;

-- Trigger for sequence dcs_finca_seq01 for column fin_id in table dcs_finca ---------
CREATE OR REPLACE TRIGGER ts_dcs_finca_dcs_finca_seq01 BEFORE INSERT
ON dcs_finca FOR EACH ROW
BEGIN
  :new.fin_id := dcs_finca_seq01.nextval;
END;
;
CREATE OR REPLACE TRIGGER tsu_dcs_finca_dcs_finca_seq01 AFTER UPDATE OF fin_id
ON dcs_finca FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column fin_id in table dcs_finca as it uses sequence.');
END;
;

-- Trigger for sequence dcs_lote_seq01 for column lot_id in table dcs_lote ---------
CREATE OR REPLACE TRIGGER ts_dcs_lote_dcs_lote_seq01 BEFORE INSERT
ON dcs_lote FOR EACH ROW
BEGIN
  :new.lot_id := dcs_lote_seq01.nextval;
END;
;
CREATE OR REPLACE TRIGGER tsu_dcs_lote_dcs_lote_seq01 AFTER UPDATE OF lot_id
ON dcs_lote FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column lot_id in table dcs_lote as it uses sequence.');
END;
;

-- Trigger for sequence dcs_semillas_seq01 for column sem_id in table dcs_semilla ---------
CREATE OR REPLACE TRIGGER ts_dcs_semilla_dcs_semillas_seq01 BEFORE INSERT
ON dcs_semilla FOR EACH ROW
BEGIN
  :new.sem_id := dcs_semillas_seq01.nextval;
END;
;
CREATE OR REPLACE TRIGGER tsu_dcs_semilla_dcs_semillas_seq01 AFTER UPDATE OF sem_id
ON dcs_semilla FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column sem_id in table dcs_semilla as it uses sequence.');
END;
;

-- Trigger for sequence dcs_variedad_seq01 for column var_id in table dcs_variedad ---------
CREATE OR REPLACE TRIGGER ts_dcs_variedad_dcs_variedad_seq01 BEFORE INSERT
ON dcs_variedad FOR EACH ROW
BEGIN
  :new.var_id := dcs_variedad_seq01.nextval;
END;
;
CREATE OR REPLACE TRIGGER tsu_dcs_variedad_dcs_variedad_seq01 AFTER UPDATE OF var_id
ON dcs_variedad FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column var_id in table dcs_variedad as it uses sequence.');
END;
;

-- Trigger for sequence dcs_umedida_seq01 for column uni_id in table dcs_unidad_medida ---------
CREATE OR REPLACE TRIGGER ts_dcs_unidad_medida_dcs_umedida_seq01 BEFORE INSERT
ON dcs_unidad_medida FOR EACH ROW
BEGIN
  :new.uni_id := dcs_umedida_seq01.nextval;
END;
;
CREATE OR REPLACE TRIGGER tsu_dcs_unidad_medida_dcs_umedida_seq01 AFTER UPDATE OF uni_id
ON dcs_unidad_medida FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column uni_id in table dcs_unidad_medida as it uses sequence.');
END;
;

-- Trigger for sequence dcs_reproduccion_seq01 for column rep_id in table dcs_reproduccion ---------
CREATE OR REPLACE TRIGGER ts_dcs_reproduccion_dcs_reproduccion_seq01 BEFORE INSERT
ON dcs_reproduccion FOR EACH ROW
BEGIN
  :new.rep_id := dcs_reproduccion_seq01.nextval;
END;
;
CREATE OR REPLACE TRIGGER tsu_dcs_reproduccion_dcs_reproduccion_seq01 AFTER UPDATE OF rep_id
ON dcs_reproduccion FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column rep_id in table dcs_reproduccion as it uses sequence.');
END;
;

-- Trigger for sequence dcs_inspeccion_seq01 for column ins_id in table dcs_inspeccion ---------
CREATE OR REPLACE TRIGGER ts_dcs_inspeccion_dcs_inspeccion_seq01 BEFORE INSERT
ON dcs_inspeccion FOR EACH ROW
BEGIN
  :new.ins_id := dcs_inspeccion_seq01.nextval;
END;
;
CREATE OR REPLACE TRIGGER tsu_dcs_inspeccion_dcs_inspeccion_seq01 AFTER UPDATE OF ins_id
ON dcs_inspeccion FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column ins_id in table dcs_inspeccion as it uses sequence.');
END;
;

-- Trigger for sequence dcs_analisis_seq01 for column ana_id in table dcs_analisis ---------
CREATE OR REPLACE TRIGGER ts_dcs_analisis_dcs_analisis_seq01 BEFORE INSERT
ON dcs_analisis FOR EACH ROW
BEGIN
  :new.ana_id := dcs_analisis_seq01.nextval;
END;
;
CREATE OR REPLACE TRIGGER tsu_dcs_analisis_dcs_analisis_seq01 AFTER UPDATE OF ana_id
ON dcs_analisis FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column ana_id in table dcs_analisis as it uses sequence.');
END;
;

-- Trigger for sequence dcs_producto_seq01 for column pro_id in table dcs_producto ---------
CREATE OR REPLACE TRIGGER ts_dcs_producto_dcs_producto_seq01 BEFORE INSERT
ON dcs_producto FOR EACH ROW
BEGIN
  :new.pro_id := dcs_producto_seq01.nextval;
END;
;
CREATE OR REPLACE TRIGGER tsu_dcs_producto_dcs_producto_seq01 AFTER UPDATE OF pro_id
ON dcs_producto FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column pro_id in table dcs_producto as it uses sequence.');
END;
;

-- Trigger for sequence dcs_pago_seq01 for column pag_id in table dcs_pago_productor ---------
CREATE OR REPLACE TRIGGER ts_dcs_pago_productor_dcs_pago_seq01 BEFORE INSERT
ON dcs_pago_productor FOR EACH ROW
BEGIN
  :new.pag_id := dcs_pago_seq01.nextval;
END;
;
CREATE OR REPLACE TRIGGER tsu_dcs_pago_productor_dcs_pago_seq01 AFTER UPDATE OF pag_id
ON dcs_pago_productor FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column pag_id in table dcs_pago_productor as it uses sequence.');
END;
;

-- Trigger for sequence dcs_ensayo_seq01 for column ens_id in table dcs_ensayo ---------
CREATE OR REPLACE TRIGGER ts_dcs_ensayo_dcs_ensayo_seq01 BEFORE INSERT
ON dcs_ensayo FOR EACH ROW
BEGIN
  :new.ens_id := dcs_ensayo_seq01.nextval;
END;
;
CREATE OR REPLACE TRIGGER tsu_dcs_ensayo_dcs_ensayo_seq01 AFTER UPDATE OF ens_id
ON dcs_ensayo FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column ens_id in table dcs_ensayo as it uses sequence.');
END;
;

-- Trigger for sequence dcs_etaensayo_seq01 for column eta_id in table dcs_etapa_ensayo ---------
CREATE OR REPLACE TRIGGER ts_dcs_etapa_ensayo_dcs_etaensayo_seq01 BEFORE INSERT
ON dcs_etapa_ensayo FOR EACH ROW
BEGIN
  :new.eta_id := dcs_etaensayo_seq01.nextval;
END;
;
CREATE OR REPLACE TRIGGER tsu_dcs_etapa_ensayo_dcs_etaensayo_seq01 AFTER UPDATE OF eta_id
ON dcs_etapa_ensayo FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column eta_id in table dcs_etapa_ensayo as it uses sequence.');
END;
;

-- Trigger for sequence dcs_estado_seq01 for column est_id in table dcs_estado_general ---------
CREATE OR REPLACE TRIGGER ts_dcs_estado_general_dcs_estado_seq01 BEFORE INSERT
ON dcs_estado_general FOR EACH ROW
BEGIN
  :new.est_id := dcs_estado_seq01.nextval;
END;
;
CREATE OR REPLACE TRIGGER tsu_dcs_estado_general_dcs_estado_seq01 AFTER UPDATE OF est_id
ON dcs_estado_general FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column est_id in table dcs_estado_general as it uses sequence.');
END;
;

-- Trigger for sequence dcs_junta_seq01 for column jun_id in table dcs_junta_directiva ---------
CREATE OR REPLACE TRIGGER ts_dcs_junta_directiva_dcs_junta_seq01 BEFORE INSERT
ON dcs_junta_directiva FOR EACH ROW
BEGIN
  :new.jun_id := dcs_junta_seq01.nextval;
END;
;
CREATE OR REPLACE TRIGGER tsu_dcs_junta_directiva_dcs_junta_seq01 AFTER UPDATE OF jun_id
ON dcs_junta_directiva FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column jun_id in table dcs_junta_directiva as it uses sequence.');
END;
;

-- Trigger for sequence dcs_asociacion_seq01 for column asociacion_id in table dcs_asociacion ---------
CREATE OR REPLACE TRIGGER ts_dcs_asociacion_dcs_asociacion_seq01 BEFORE INSERT
ON dcs_asociacion FOR EACH ROW
BEGIN
  :new.asociacion_id := dcs_asociacion_seq01.nextval;
END;
;
CREATE OR REPLACE TRIGGER tsu_dcs_asociacion_dcs_asociacion_seq01 AFTER UPDATE OF asociacion_id
ON dcs_asociacion FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column asociacion_id in table dcs_asociacion as it uses sequence.');
END;
;

-- Trigger for sequence dcs_tipocontacto_seq01 for column tc_id in table dcs_tipo_contacto ---------
CREATE OR REPLACE TRIGGER ts_dcs_tipo_contacto_dcs_tipocontacto_seq01 BEFORE INSERT
ON dcs_tipo_contacto FOR EACH ROW
BEGIN
  :new.tc_id := dcs_tipocontacto_seq01.nextval;
END;
;
CREATE OR REPLACE TRIGGER tsu_dcs_tipo_contacto_dcs_tipocontacto_seq01 AFTER UPDATE OF tc_id
ON dcs_tipo_contacto FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column tc_id in table dcs_tipo_contacto as it uses sequence.');
END;
;

-- Trigger for sequence dcs_contacto_seq01 for column con_id in table dcs_contacto ---------
CREATE OR REPLACE TRIGGER ts_dcs_contacto_dcs_contacto_seq01 BEFORE INSERT
ON dcs_contacto FOR EACH ROW
BEGIN
  :new.con_id := dcs_contacto_seq01.nextval;
END;
;
CREATE OR REPLACE TRIGGER tsu_dcs_contacto_dcs_contacto_seq01 AFTER UPDATE OF con_id
ON dcs_contacto FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column con_id in table dcs_contacto as it uses sequence.');
END;
;

-- Trigger for sequence dcs_sintoma_seq01 for column sin_id in table dcs_sintomas ---------
CREATE OR REPLACE TRIGGER ts_dcs_sintomas_dcs_sintoma_seq01 BEFORE INSERT
ON dcs_sintomas FOR EACH ROW
BEGIN
  :new.sin_id := dcs_sintoma_seq01.nextval;
END;
;
CREATE OR REPLACE TRIGGER tsu_dcs_sintomas_dcs_sintoma_seq01 AFTER UPDATE OF sin_id
ON dcs_sintomas FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column sin_id in table dcs_sintomas as it uses sequence.');
END;
;


-- Create foreign keys (relationships) section ------------------------------------------------- 

ALTER TABLE dcs_asociado ADD CONSTRAINT dcs_perso_asociado_fk01 FOREIGN KEY (per_id) REFERENCES dcs_persona_fisica (per_id)
;



ALTER TABLE dcs_asociado ADD CONSTRAINT dcs_catego_asociado_fk01 FOREIGN KEY (cat_id) REFERENCES dcs_categoria_asociado (cat_id)
;



ALTER TABLE dcs_finca ADD CONSTRAINT dcs_perso_finca_fk01 FOREIGN KEY (per_id) REFERENCES dcs_persona_fisica (per_id)
;



ALTER TABLE dcs_lote ADD CONSTRAINT dcs_finca_lote_fk01 FOREIGN KEY (fin_id) REFERENCES dcs_finca (fin_id)
;



ALTER TABLE dcs_variedad ADD CONSTRAINT dcs_semilla_variedad_fk01 FOREIGN KEY (sem_id) REFERENCES dcs_semilla (sem_id)
;



ALTER TABLE dcs_variedad ADD CONSTRAINT dcs_unidad_variedad_fk01 FOREIGN KEY (uni_id) REFERENCES dcs_unidad_medida (uni_id)
;



ALTER TABLE dcs_reproduccion ADD CONSTRAINT dcs_persona_repro_fk01 FOREIGN KEY (per_id) REFERENCES dcs_persona_fisica (per_id)
;



ALTER TABLE dcs_reproduccion ADD CONSTRAINT dcs_finca_repro_fk01 FOREIGN KEY (fin_id) REFERENCES dcs_finca (fin_id)
;



ALTER TABLE dcs_reproduccion ADD CONSTRAINT dcs_lote_repro_fk01 FOREIGN KEY (lot_id) REFERENCES dcs_lote (lot_id)
;



ALTER TABLE dcs_reproduccion ADD CONSTRAINT dcs_estado_reproduccion_fk01 FOREIGN KEY (est_id) REFERENCES dcs_estado_general (est_id)
;



ALTER TABLE dcs_inspeccion ADD CONSTRAINT dcs_reproduccion_inspeccion_fk01 FOREIGN KEY (rep_id) REFERENCES dcs_reproduccion (rep_id)
;



ALTER TABLE dcs_analisis ADD CONSTRAINT dcs_reproduccion_analisi_fk01 FOREIGN KEY (rep_id) REFERENCES dcs_reproduccion (rep_id)
;



ALTER TABLE dcs_analisis_plaga ADD CONSTRAINT dcs_analisis_plaga_fk01 FOREIGN KEY (ana_id) REFERENCES dcs_analisis (ana_id)
;



ALTER TABLE dcs_analisis_plaga ADD CONSTRAINT dcs_analisis_plaga_fk02 FOREIGN KEY (pla_id) REFERENCES dcs_plaga (pla_id)
;



ALTER TABLE dcs_analisis_enfermedad ADD CONSTRAINT dcs_analisis_enfermedad_fk01 FOREIGN KEY (ana_id) REFERENCES dcs_analisis (ana_id)
;



ALTER TABLE dcs_analisis_enfermedad ADD CONSTRAINT dcs_analisis_enfermedad_fk02 FOREIGN KEY (enf_id) REFERENCES dcs_enfermedad (enf_id)
;



ALTER TABLE dcs_producto ADD CONSTRAINT dcs_variedad_produc_fk01 FOREIGN KEY (var_id) REFERENCES dcs_variedad (var_id)
;



ALTER TABLE dcs_producto ADD CONSTRAINT dcs_repro_produc_fk01 FOREIGN KEY (rep_id) REFERENCES dcs_reproduccion (rep_id)
;



ALTER TABLE dcs_pago_productor ADD CONSTRAINT dcs_per_pago_fk01 FOREIGN KEY (per_id) REFERENCES dcs_persona_fisica (per_id)
;



ALTER TABLE dcs_pago_productor ADD CONSTRAINT dcs_produc_pago_fk01 FOREIGN KEY (pro_id) REFERENCES dcs_producto (pro_id)
;



ALTER TABLE dcs_reproduccion ADD CONSTRAINT dcs_cosecha_repro_fk01 FOREIGN KEY (cos_id) REFERENCES dcs_cosecha (cos_id)
;



ALTER TABLE dcs_ensayo ADD CONSTRAINT dcs_cosecha_ensayo_fk01 FOREIGN KEY (cos_id) REFERENCES dcs_cosecha (cos_id)
;



ALTER TABLE dcs_ensayo ADD CONSTRAINT dcs_person_ensayo_fk01 FOREIGN KEY (per_id) REFERENCES dcs_persona_fisica (per_id)
;



ALTER TABLE dcs_ensayo ADD CONSTRAINT dcs_lote_ensayo_fk01 FOREIGN KEY (lot_id) REFERENCES dcs_lote (lot_id)
;



ALTER TABLE dcs_ensayo ADD CONSTRAINT dcs_estado_ensayo_fk01 FOREIGN KEY (est_id) REFERENCES dcs_estado_general (est_id)
;



ALTER TABLE dcs_ensayo ADD CONSTRAINT dcs_etapa_ensayo_fk01 FOREIGN KEY (eta_id) REFERENCES dcs_etapa_ensayo (eta_id)
;



ALTER TABLE dcs_junta_directiva ADD CONSTRAINT dcs_aso_junta_fk01 FOREIGN KEY (aso_id) REFERENCES dcs_asociado (aso_id)
;



ALTER TABLE dcs_junta_directiva ADD CONSTRAINT dcs_persona_junta_fk01 FOREIGN KEY (per_id) REFERENCES dcs_persona_fisica (per_id)
;



ALTER TABLE dcs_asociado ADD CONSTRAINT dcs_asociacion_asociado_fk01 FOREIGN KEY (asociacion_id) REFERENCES dcs_asociacion (asociacion_id)
;



ALTER TABLE dcs_contacto ADD CONSTRAINT dcs_tipocont_contacto_fk01 FOREIGN KEY (tc_id) REFERENCES dcs_tipo_contacto (tc_id)
;



ALTER TABLE dcs_contacto ADD CONSTRAINT dcs_perso_contac_fk01 FOREIGN KEY (per_id) REFERENCES dcs_persona_fisica (per_id)
;



ALTER TABLE dcs_contacto ADD CONSTRAINT dcs_asociacion_contacto_fk01 FOREIGN KEY (asociacion_id) REFERENCES dcs_asociacion (asociacion_id)
;



ALTER TABLE dcs_persona_fisica ADD CONSTRAINT dcs_finca_perso_fk01 FOREIGN KEY (fin_id) REFERENCES dcs_finca (fin_id)
;



ALTER TABLE dcs_sintomas ADD CONSTRAINT dcs_enfermedad_sintomas_fk01 FOREIGN KEY (enf_id) REFERENCES dcs_enfermedad (enf_id)
;



ALTER TABLE dcs_junta_directiva ADD CONSTRAINT dcs_asociacion_junta_fk01 FOREIGN KEY (asociacion_id) REFERENCES dcs_asociacion (asociacion_id)
;



ALTER TABLE dcs_ingeniero ADD CONSTRAINT dcs_per_ing_fk01 FOREIGN KEY (per_id) REFERENCES dcs_persona_fisica (per_id)
;



ALTER TABLE dcs_reproduccion ADD CONSTRAINT dcs_ing_repro_fk01 FOREIGN KEY (inge_id) REFERENCES dcs_ingeniero (inge_id)
;





