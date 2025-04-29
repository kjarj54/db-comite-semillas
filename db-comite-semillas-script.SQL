/*
Created: 19/04/2025
Modified: 29/04/2025
Model: db-comite-semillas
Database: Oracle 18c
*/


-- Drop relationships section -------------------------------------------------

ALTER TABLE dcs_junta_directiva DROP CONSTRAINT Relationship38
;
ALTER TABLE dcs_junta_directiva DROP CONSTRAINT Relationship37
;
ALTER TABLE dcs_ensayo DROP CONSTRAINT Relationship36
;
ALTER TABLE dcs_ensayo DROP CONSTRAINT Relationship34
;
ALTER TABLE dcs_ensayo DROP CONSTRAINT Relationship33
;
ALTER TABLE dcs_ensayo DROP CONSTRAINT Relationship32
;
ALTER TABLE dcs_ensayo DROP CONSTRAINT Relationship31
;
ALTER TABLE dcs_reproduccion DROP CONSTRAINT Relationship30
;
ALTER TABLE dcs_pago_productor DROP CONSTRAINT Relationship29
;
ALTER TABLE dcs_pago_productor DROP CONSTRAINT Relationship28
;
ALTER TABLE dcs_producto DROP CONSTRAINT Relationship27
;
ALTER TABLE dcs_producto DROP CONSTRAINT Relationship26
;
ALTER TABLE dcs_analisis_enfermedad DROP CONSTRAINT Relationship25
;
ALTER TABLE dcs_analisis_enfermedad DROP CONSTRAINT Relationship24
;
ALTER TABLE dcs_analisis_plaga DROP CONSTRAINT Relationship23
;
ALTER TABLE dcs_analisis_plaga DROP CONSTRAINT Relationship22
;
ALTER TABLE dcs_analisis DROP CONSTRAINT Relationship21
;
ALTER TABLE dcs_inspeccion DROP CONSTRAINT Relationship20
;
ALTER TABLE dcs_reproduccion DROP CONSTRAINT Relationship17
;
ALTER TABLE dcs_reproduccion DROP CONSTRAINT Relationship16
;
ALTER TABLE dcs_reproduccion DROP CONSTRAINT Relationship15
;
ALTER TABLE dcs_reproduccion DROP CONSTRAINT Relationship14
;
ALTER TABLE dcs_reproduccion DROP CONSTRAINT Relationship12
;
ALTER TABLE dcs_variedad DROP CONSTRAINT Relationship11
;
ALTER TABLE dcs_variedad DROP CONSTRAINT Relationship10
;
ALTER TABLE dcs_lote DROP CONSTRAINT Relationship9
;
ALTER TABLE dcs_finca DROP CONSTRAINT Relationship8
;
ALTER TABLE dcs_contacto DROP CONSTRAINT Relationship4
;
ALTER TABLE dcs_contacto DROP CONSTRAINT Relationship3
;
ALTER TABLE dcs_asociado DROP CONSTRAINT Relationship2
;
ALTER TABLE dcs_asociado DROP CONSTRAINT Relationship1
;




-- Drop keys for tables section -------------------------------------------------

ALTER TABLE dcs_analisis_enfermedad DROP CONSTRAINT PK_dcs_analisis_enfermedad
;
ALTER TABLE dcs_analisis_plaga DROP CONSTRAINT PK_dcs_analisis_plaga
;
ALTER TABLE dcs_tipo_contacto DROP CONSTRAINT PK_dcs_tipo_contacto
;
ALTER TABLE dcs_junta_directiva DROP CONSTRAINT PK_dcs_junta_directiva
;
ALTER TABLE dcs_estado_general DROP CONSTRAINT PK_dcs_estado_general
;
ALTER TABLE dcs_etapa_ensayo DROP CONSTRAINT PK_dcs_etapa_ensayo
;
ALTER TABLE dcs_ensayo DROP CONSTRAINT PK_dcs_ensayo
;
ALTER TABLE dcs_pago_productor DROP CONSTRAINT PK_dcs_pago_productor
;
ALTER TABLE dcs_producto DROP CONSTRAINT PK_dcs_producto
;
ALTER TABLE dcs_analisis DROP CONSTRAINT PK_dcs_analisis
;
ALTER TABLE dcs_inspeccion DROP CONSTRAINT PK_dcs_inspeccion
;
ALTER TABLE dcs_reproduccion DROP CONSTRAINT PK_dcs_reproduccion
;
ALTER TABLE dcs_unidad_medida DROP CONSTRAINT PK_dcs_unidad_medida
;
ALTER TABLE dcs_variedad DROP CONSTRAINT PK_dcs_variedad
;
ALTER TABLE dcs_semilla DROP CONSTRAINT PK_dcs_semilla
;
ALTER TABLE dcs_lote DROP CONSTRAINT PK_dcs_lote
;
ALTER TABLE dcs_finca DROP CONSTRAINT PK_dcs_finca
;
ALTER TABLE dcs_plaga DROP CONSTRAINT PK_dcs_plaga
;
ALTER TABLE dcs_enfermedad DROP CONSTRAINT PK_dcs_enfermedad
;
ALTER TABLE dcs_cosecha DROP CONSTRAINT PK_dcs_cosecha
;
ALTER TABLE dcs_contacto DROP CONSTRAINT PK_dcs_contacto
;
ALTER TABLE dcs_categoria_asociado DROP CONSTRAINT PK_dcs_categoria_asociado
;
ALTER TABLE dcs_asociado DROP CONSTRAINT PK_dcs_asociado
;
ALTER TABLE dcs_persona_fisica DROP CONSTRAINT PK_dcs_persona_fisica
;


-- Drop indexes section -------------------------------------------------

DROP INDEX IX_Relationship37
;
DROP INDEX IX_Relationship38
;
DROP INDEX IX_Relationship31
;
DROP INDEX IX_Relationship32
;
DROP INDEX IX_Relationship33
;
DROP INDEX IX_Relationship34
;
DROP INDEX IX_Relationship36
;
DROP INDEX IX_Relationship28
;
DROP INDEX IX_Relationship29
;
DROP INDEX IX_Relationship26
;
DROP INDEX IX_Relationship27
;
DROP INDEX IX_Relationship21
;
DROP INDEX IX_Relationship20
;
DROP INDEX IX_Relationship12
;
DROP INDEX IX_Relationship14
;
DROP INDEX IX_Relationship15
;
DROP INDEX IX_Relationship16
;
DROP INDEX IX_Relationship17
;
DROP INDEX IX_Relationship30
;
DROP INDEX IX_Relationship10
;
DROP INDEX IX_Relationship11
;
DROP INDEX IX_Relationship9
;
DROP INDEX IX_Relationship8
;
DROP INDEX IX_Relationship3
;
DROP INDEX IX_Relationship4
;
DROP INDEX IX_Relationship1
;
DROP INDEX IX_Relationship2
;


-- Drop tables section ---------------------------------------------------

DROP TABLE dcs_analisis_enfermedad
;
DROP TABLE dcs_analisis_plaga
;
DROP TABLE dcs_tipo_contacto
;
DROP TABLE dcs_junta_directiva
;
DROP TABLE dcs_estado_general
;
DROP TABLE dcs_etapa_ensayo
;
DROP TABLE dcs_ensayo
;
DROP TABLE dcs_pago_productor
;
DROP TABLE dcs_producto
;
DROP TABLE dcs_analisis
;
DROP TABLE dcs_inspeccion
;
DROP TABLE dcs_reproduccion
;
DROP TABLE dcs_unidad_medida
;
DROP TABLE dcs_variedad
;
DROP TABLE dcs_semilla
;
DROP TABLE dcs_lote
;
DROP TABLE dcs_finca
;
DROP TABLE dcs_plaga
;
DROP TABLE dcs_enfermedad
;
DROP TABLE dcs_cosecha
;
DROP TABLE dcs_contacto
;
DROP TABLE dcs_categoria_asociado
;
DROP TABLE dcs_asociado
;
DROP TABLE dcs_persona_fisica
;

-- Create tables section -------------------------------------------------

-- Table dcs_persona_fisica

CREATE TABLE dcs_persona_fisica(
  per_id Number NOT NULL,
  per_nombre AnyData,
  per_apellido1 AnyData,
  per_apellido2 AnyData,
  per_fecha_nacimiento AnyData,
  per_sexo AnyData,
  per_identificacion AnyData
)
;

-- Add keys for table dcs_persona_fisica

ALTER TABLE dcs_persona_fisica ADD CONSTRAINT PK_dcs_persona_fisica PRIMARY KEY (per_id)
;

-- Table dcs_asociado

CREATE TABLE dcs_asociado(
  aso_id Number NOT NULL,
  aso_fecha_ingreso AnyData,
  aso_estado AnyData,
  aso_cuota_afiliacion AnyData,
  per_id Number,
  cat_id Number
)
;

-- Create indexes for table dcs_asociado

CREATE INDEX IX_Relationship1 ON dcs_asociado (per_id)
;

CREATE INDEX IX_Relationship2 ON dcs_asociado (cat_id)
;

-- Add keys for table dcs_asociado

ALTER TABLE dcs_asociado ADD CONSTRAINT PK_dcs_asociado PRIMARY KEY (aso_id)
;

-- Table dcs_categoria_asociado

CREATE TABLE dcs_categoria_asociado(
  cat_id Number NOT NULL,
  cat_descripcion AnyData,
  cat_monto_cuota_mensual AnyData
)
;

-- Add keys for table dcs_categoria_asociado

ALTER TABLE dcs_categoria_asociado ADD CONSTRAINT PK_dcs_categoria_asociado PRIMARY KEY (cat_id)
;

-- Table dcs_contacto

CREATE TABLE dcs_contacto(
  con_id Number NOT NULL,
  con_valor AnyData,
  tco_id Number,
  aso_id Number
)
;

-- Create indexes for table dcs_contacto

CREATE INDEX IX_Relationship3 ON dcs_contacto (tco_id)
;

CREATE INDEX IX_Relationship4 ON dcs_contacto (aso_id)
;

-- Add keys for table dcs_contacto

ALTER TABLE dcs_contacto ADD CONSTRAINT PK_dcs_contacto PRIMARY KEY (con_id)
;

-- Table dcs_cosecha

CREATE TABLE dcs_cosecha(
  cos_id Number NOT NULL,
  cos_nombre AnyData,
  cos_fecha_inicio AnyData,
  cos_fecha_fin AnyData
)
;

-- Add keys for table dcs_cosecha

ALTER TABLE dcs_cosecha ADD CONSTRAINT PK_dcs_cosecha PRIMARY KEY (cos_id)
;

-- Table dcs_enfermedad

CREATE TABLE dcs_enfermedad(
  enf_id Number NOT NULL,
  enf_nombre AnyData,
  enf_ubicacion_planta AnyData,
  enf_sintomas AnyData,
  enf_tratamiento AnyData,
  enf_etapa_desarrollo AnyData
)
;

-- Add keys for table dcs_enfermedad

ALTER TABLE dcs_enfermedad ADD CONSTRAINT PK_dcs_enfermedad PRIMARY KEY (enf_id)
;

-- Table dcs_plaga

CREATE TABLE dcs_plaga(
  pla_id Number NOT NULL,
  pla_nombre AnyData,
  pla_descripcion AnyData,
  pla_tratamiento AnyData,
  pla_etapa_desarrollo AnyData
)
;

-- Add keys for table dcs_plaga

ALTER TABLE dcs_plaga ADD CONSTRAINT PK_dcs_plaga PRIMARY KEY (pla_id)
;

-- Table dcs_finca

CREATE TABLE dcs_finca(
  fin_id Number NOT NULL,
  fin_numero_registro AnyData,
  fin_nombre AnyData,
  fin_tamano_hectareas AnyData,
  fin_estado AnyData,
  fin_direccion AnyData,
  per_id Number
)
;

-- Create indexes for table dcs_finca

CREATE INDEX IX_Relationship8 ON dcs_finca (per_id)
;

-- Add keys for table dcs_finca

ALTER TABLE dcs_finca ADD CONSTRAINT PK_dcs_finca PRIMARY KEY (fin_id)
;

-- Table dcs_lote

CREATE TABLE dcs_lote(
  lot_id Number NOT NULL,
  lot_nombre AnyData,
  lot_tamano_hectareas AnyData,
  lot_descripcion AnyData,
  lot_direccion AnyData,
  fin_id Number
)
;

-- Create indexes for table dcs_lote

CREATE INDEX IX_Relationship9 ON dcs_lote (fin_id)
;

-- Add keys for table dcs_lote

ALTER TABLE dcs_lote ADD CONSTRAINT PK_dcs_lote PRIMARY KEY (lot_id)
;

-- Table dcs_semilla

CREATE TABLE dcs_semilla(
  sem_id Number NOT NULL,
  sem_nombre AnyData
)
;

-- Add keys for table dcs_semilla

ALTER TABLE dcs_semilla ADD CONSTRAINT PK_dcs_semilla PRIMARY KEY (sem_id)
;

-- Table dcs_variedad

CREATE TABLE dcs_variedad(
  var_id Number NOT NULL,
  var_nombre AnyData,
  var_tiempo_cosecha_dias AnyData,
  var_precio_unitario AnyData,
  sem_id Number,
  uni_id Number
)
;

-- Create indexes for table dcs_variedad

CREATE INDEX IX_Relationship10 ON dcs_variedad (sem_id)
;

CREATE INDEX IX_Relationship11 ON dcs_variedad (uni_id)
;

-- Add keys for table dcs_variedad

ALTER TABLE dcs_variedad ADD CONSTRAINT PK_dcs_variedad PRIMARY KEY (var_id)
;

-- Table dcs_unidad_medida

CREATE TABLE dcs_unidad_medida(
  uni_id Number NOT NULL,
  uni_descripcion AnyData,
  uni_conversion_base AnyData
)
;

-- Add keys for table dcs_unidad_medida

ALTER TABLE dcs_unidad_medida ADD CONSTRAINT PK_dcs_unidad_medida PRIMARY KEY (uni_id)
;

-- Table dcs_reproduccion

CREATE TABLE dcs_reproduccion(
  rep_id Number NOT NULL,
  rep_numero_contrato AnyData,
  rep_fecha_siembra_inicio AnyData,
  rep_fecha_siembra_fin AnyData,
  rep_fecha_cosecha_inicio AnyData,
  rep_fecha_cosecha_fin AnyData,
  rep_hectareas_sembradas AnyData,
  per_id Number,
  fin_id Number,
  lot_id Number,
  est_id Number,
  cos_id Number
)
;

-- Create indexes for table dcs_reproduccion

CREATE INDEX IX_Relationship12 ON dcs_reproduccion (per_id)
;

CREATE INDEX IX_Relationship14 ON dcs_reproduccion (fin_id)
;

CREATE INDEX IX_Relationship15 ON dcs_reproduccion (lot_id)
;

CREATE INDEX IX_Relationship16 ON dcs_reproduccion (per_id)
;

CREATE INDEX IX_Relationship17 ON dcs_reproduccion (est_id)
;

CREATE INDEX IX_Relationship30 ON dcs_reproduccion (cos_id)
;

-- Add keys for table dcs_reproduccion

ALTER TABLE dcs_reproduccion ADD CONSTRAINT PK_dcs_reproduccion PRIMARY KEY (rep_id)
;

-- Table dcs_inspeccion

CREATE TABLE dcs_inspeccion(
  ins_id Number NOT NULL,
  ins_fecha AnyData,
  ins_comentario AnyData,
  rep_id Number
)
;

-- Create indexes for table dcs_inspeccion

CREATE INDEX IX_Relationship20 ON dcs_inspeccion (rep_id)
;

-- Add keys for table dcs_inspeccion

ALTER TABLE dcs_inspeccion ADD CONSTRAINT PK_dcs_inspeccion PRIMARY KEY (ins_id)
;

-- Table dcs_analisis

CREATE TABLE dcs_analisis(
  ana_id Number NOT NULL,
  ana_motivo AnyData,
  ana_porcentaje_semilla_sana AnyData,
  ana_monto AnyData,
  rep_id Number
)
;

-- Create indexes for table dcs_analisis

CREATE INDEX IX_Relationship21 ON dcs_analisis (rep_id)
;

-- Add keys for table dcs_analisis

ALTER TABLE dcs_analisis ADD CONSTRAINT PK_dcs_analisis PRIMARY KEY (ana_id)
;

-- Table dcs_producto

CREATE TABLE dcs_producto(
  pro_id Number NOT NULL,
  pro_nombre AnyData,
  var_id Number,
  rep_id Number
)
;

-- Create indexes for table dcs_producto

CREATE INDEX IX_Relationship26 ON dcs_producto (var_id)
;

CREATE INDEX IX_Relationship27 ON dcs_producto (rep_id)
;

-- Add keys for table dcs_producto

ALTER TABLE dcs_producto ADD CONSTRAINT PK_dcs_producto PRIMARY KEY (pro_id)
;

-- Table dcs_pago_productor

CREATE TABLE dcs_pago_productor(
  pag_id Number NOT NULL,
  pag_cantidad AnyData,
  pag_precio_unitario AnyData,
  pag_fecha_pago AnyData,
  per_id Number,
  pro_id Number
)
;

-- Create indexes for table dcs_pago_productor

CREATE INDEX IX_Relationship28 ON dcs_pago_productor (per_id)
;

CREATE INDEX IX_Relationship29 ON dcs_pago_productor (pro_id)
;

-- Add keys for table dcs_pago_productor

ALTER TABLE dcs_pago_productor ADD CONSTRAINT PK_dcs_pago_productor PRIMARY KEY (pag_id)
;

-- Table dcs_ensayo

CREATE TABLE dcs_ensayo(
  ens_id Number NOT NULL,
  ens_nombre AnyData,
  ens_fecha_siembra_inicio AnyData,
  ens_fecha_siembra_fin AnyData,
  ens_fecha_cosecha_inicio AnyData,
  ens_fecha_cosecha_fin AnyData,
  ens_usuario_registro AnyData,
  cos_id Number,
  per_id Number,
  lot_id Number,
  est_id Number,
  eta_id Number
)
;

-- Create indexes for table dcs_ensayo

CREATE INDEX IX_Relationship31 ON dcs_ensayo (cos_id)
;

CREATE INDEX IX_Relationship32 ON dcs_ensayo (per_id)
;

CREATE INDEX IX_Relationship33 ON dcs_ensayo (lot_id)
;

CREATE INDEX IX_Relationship34 ON dcs_ensayo (est_id)
;

CREATE INDEX IX_Relationship36 ON dcs_ensayo (eta_id)
;

-- Add keys for table dcs_ensayo

ALTER TABLE dcs_ensayo ADD CONSTRAINT PK_dcs_ensayo PRIMARY KEY (ens_id)
;

-- Table dcs_etapa_ensayo

CREATE TABLE dcs_etapa_ensayo(
  eta_id Number NOT NULL,
  eta_nombre AnyData
)
;

-- Add keys for table dcs_etapa_ensayo

ALTER TABLE dcs_etapa_ensayo ADD CONSTRAINT PK_dcs_etapa_ensayo PRIMARY KEY (eta_id)
;

-- Table dcs_estado_general

CREATE TABLE dcs_estado_general(
  est_id Number NOT NULL,
  est_descripcion AnyData
)
;

-- Add keys for table dcs_estado_general

ALTER TABLE dcs_estado_general ADD CONSTRAINT PK_dcs_estado_general PRIMARY KEY (est_id)
;

-- Table dcs_junta_directiva

CREATE TABLE dcs_junta_directiva(
  jun_id Number NOT NULL,
  jun_puesto AnyData,
  aso_id Number,
  per_id Number
)
;

-- Create indexes for table dcs_junta_directiva

CREATE INDEX IX_Relationship37 ON dcs_junta_directiva (aso_id)
;

CREATE INDEX IX_Relationship38 ON dcs_junta_directiva (per_id)
;

-- Add keys for table dcs_junta_directiva

ALTER TABLE dcs_junta_directiva ADD CONSTRAINT PK_dcs_junta_directiva PRIMARY KEY (jun_id)
;

-- Table dcs_tipo_contacto

CREATE TABLE dcs_tipo_contacto(
  tco_id Number NOT NULL,
  tco_descripcion AnyData
)
;

-- Add keys for table dcs_tipo_contacto

ALTER TABLE dcs_tipo_contacto ADD CONSTRAINT PK_dcs_tipo_contacto PRIMARY KEY (tco_id)
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


-- Create foreign keys (relationships) section ------------------------------------------------- 

ALTER TABLE dcs_asociado ADD CONSTRAINT Relationship1 FOREIGN KEY (per_id) REFERENCES dcs_persona_fisica (per_id)
;



ALTER TABLE dcs_asociado ADD CONSTRAINT Relationship2 FOREIGN KEY (cat_id) REFERENCES dcs_categoria_asociado (cat_id)
;



ALTER TABLE dcs_contacto ADD CONSTRAINT Relationship3 FOREIGN KEY (tco_id) REFERENCES dcs_tipo_contacto (tco_id)
;



ALTER TABLE dcs_contacto ADD CONSTRAINT Relationship4 FOREIGN KEY (aso_id) REFERENCES dcs_asociado (aso_id)
;



ALTER TABLE dcs_finca ADD CONSTRAINT Relationship8 FOREIGN KEY (per_id) REFERENCES dcs_persona_fisica (per_id)
;



ALTER TABLE dcs_lote ADD CONSTRAINT Relationship9 FOREIGN KEY (fin_id) REFERENCES dcs_finca (fin_id)
;



ALTER TABLE dcs_variedad ADD CONSTRAINT Relationship10 FOREIGN KEY (sem_id) REFERENCES dcs_semilla (sem_id)
;



ALTER TABLE dcs_variedad ADD CONSTRAINT Relationship11 FOREIGN KEY (uni_id) REFERENCES dcs_unidad_medida (uni_id)
;



ALTER TABLE dcs_reproduccion ADD CONSTRAINT Relationship12 FOREIGN KEY (per_id) REFERENCES dcs_persona_fisica (per_id)
;



ALTER TABLE dcs_reproduccion ADD CONSTRAINT Relationship14 FOREIGN KEY (fin_id) REFERENCES dcs_finca (fin_id)
;



ALTER TABLE dcs_reproduccion ADD CONSTRAINT Relationship15 FOREIGN KEY (lot_id) REFERENCES dcs_lote (lot_id)
;



ALTER TABLE dcs_reproduccion ADD CONSTRAINT Relationship16 FOREIGN KEY (per_id) REFERENCES dcs_persona_fisica (per_id)
;



ALTER TABLE dcs_reproduccion ADD CONSTRAINT Relationship17 FOREIGN KEY (est_id) REFERENCES dcs_estado_general (est_id)
;



ALTER TABLE dcs_inspeccion ADD CONSTRAINT Relationship20 FOREIGN KEY (rep_id) REFERENCES dcs_reproduccion (rep_id)
;



ALTER TABLE dcs_analisis ADD CONSTRAINT Relationship21 FOREIGN KEY (rep_id) REFERENCES dcs_reproduccion (rep_id)
;



ALTER TABLE dcs_analisis_plaga ADD CONSTRAINT Relationship22 FOREIGN KEY (ana_id) REFERENCES dcs_analisis (ana_id)
;



ALTER TABLE dcs_analisis_plaga ADD CONSTRAINT Relationship23 FOREIGN KEY (pla_id) REFERENCES dcs_plaga (pla_id)
;



ALTER TABLE dcs_analisis_enfermedad ADD CONSTRAINT Relationship24 FOREIGN KEY (ana_id) REFERENCES dcs_analisis (ana_id)
;



ALTER TABLE dcs_analisis_enfermedad ADD CONSTRAINT Relationship25 FOREIGN KEY (enf_id) REFERENCES dcs_enfermedad (enf_id)
;



ALTER TABLE dcs_producto ADD CONSTRAINT Relationship26 FOREIGN KEY (var_id) REFERENCES dcs_variedad (var_id)
;



ALTER TABLE dcs_producto ADD CONSTRAINT Relationship27 FOREIGN KEY (rep_id) REFERENCES dcs_reproduccion (rep_id)
;



ALTER TABLE dcs_pago_productor ADD CONSTRAINT Relationship28 FOREIGN KEY (per_id) REFERENCES dcs_persona_fisica (per_id)
;



ALTER TABLE dcs_pago_productor ADD CONSTRAINT Relationship29 FOREIGN KEY (pro_id) REFERENCES dcs_producto (pro_id)
;



ALTER TABLE dcs_reproduccion ADD CONSTRAINT Relationship30 FOREIGN KEY (cos_id) REFERENCES dcs_cosecha (cos_id)
;



ALTER TABLE dcs_ensayo ADD CONSTRAINT Relationship31 FOREIGN KEY (cos_id) REFERENCES dcs_cosecha (cos_id)
;



ALTER TABLE dcs_ensayo ADD CONSTRAINT Relationship32 FOREIGN KEY (per_id) REFERENCES dcs_persona_fisica (per_id)
;



ALTER TABLE dcs_ensayo ADD CONSTRAINT Relationship33 FOREIGN KEY (lot_id) REFERENCES dcs_lote (lot_id)
;



ALTER TABLE dcs_ensayo ADD CONSTRAINT Relationship34 FOREIGN KEY (est_id) REFERENCES dcs_estado_general (est_id)
;



ALTER TABLE dcs_ensayo ADD CONSTRAINT Relationship36 FOREIGN KEY (eta_id) REFERENCES dcs_etapa_ensayo (eta_id)
;



ALTER TABLE dcs_junta_directiva ADD CONSTRAINT Relationship37 FOREIGN KEY (aso_id) REFERENCES dcs_asociado (aso_id)
;



ALTER TABLE dcs_junta_directiva ADD CONSTRAINT Relationship38 FOREIGN KEY (per_id) REFERENCES dcs_persona_fisica (per_id)
;





