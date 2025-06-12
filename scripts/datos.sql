-- Fecha: 11/6/2025

-- Insertar datos básicos para asociación
INSERT INTO dcs_asociacion (asociacion_cedula_juridica, asociacion_nombre, asociacion_logo) 
VALUES (310234567890, 'Asociación de Productores de Semillas Tarrazú', 'http://www.tarrazu.com/logo.png');

-- Insertar tipos de contacto
INSERT INTO dcs_tipo_contacto (tc_nombre) VALUES ('Teléfono');
INSERT INTO dcs_tipo_contacto (tc_nombre) VALUES ('Email');
INSERT INTO dcs_tipo_contacto (tc_nombre) VALUES ('Celular');

-- Insertar categorías de asociados
INSERT INTO dcs_categoria_asociado (cat_descripcion, cat_monto_cuota_mensual) 
VALUES ('Productor Básico', 15000);
INSERT INTO dcs_categoria_asociado (cat_descripcion, cat_monto_cuota_mensual) 
VALUES ('Productor Avanzado', 25000);
INSERT INTO dcs_categoria_asociado (cat_descripcion, cat_monto_cuota_mensual) 
VALUES ('Productor Premium', 35000);

-- Insertar estados generales
INSERT INTO dcs_estado_general (est_descripcion) VALUES ('Activo');
INSERT INTO dcs_estado_general (est_descripcion) VALUES ('Inactivo');
INSERT INTO dcs_estado_general (est_descripcion) VALUES ('Aprobado');
INSERT INTO dcs_estado_general (est_descripcion) VALUES ('Rechazado');
INSERT INTO dcs_estado_general (est_descripcion) VALUES ('En Proceso');
INSERT INTO dcs_estado_general (est_descripcion) VALUES ('Finalizado');

-- Insertar etapas de ensayo
INSERT INTO dcs_etapa_ensayo (eta_nombre, eta_estado, eta_comentario) 
VALUES ('Germinación y Vigor', 'A', 'Etapa inicial de crecimiento');
INSERT INTO dcs_etapa_ensayo (eta_nombre, eta_estado, eta_comentario) 
VALUES ('Floración', 'A', 'Etapa de desarrollo floral');
INSERT INTO dcs_etapa_ensayo (eta_nombre, eta_estado, eta_comentario) 
VALUES ('Maduración', 'A', 'Etapa final de desarrollo');

-- Insertar cosechas
INSERT INTO dcs_cosecha (cos_nombre, cos_fecha_inicio, cos_fecha_fin) 
VALUES ('Cosecha 2024-1', DATE '2024-01-15', DATE '2024-06-30');
INSERT INTO dcs_cosecha (cos_nombre, cos_fecha_inicio, cos_fecha_fin) 
VALUES ('Cosecha 2024-2', DATE '2024-07-01', DATE '2024-12-31');
INSERT INTO dcs_cosecha (cos_nombre, cos_fecha_inicio, cos_fecha_fin) 
VALUES ('Cosecha 2025-1', DATE '2025-01-01', DATE '2025-06-30');

-- Insertar personas físicas
INSERT INTO dcs_persona_fisica (per_identificacion, per_nombre, per_apellido1, per_apellido2, per_fecha_nacimiento, per_sexo, fin_id) 
VALUES ('105550001', 'Juan Carlos', 'Rodríguez', 'Morales', DATE '1980-03-15', 'M', NULL);
INSERT INTO dcs_persona_fisica (per_identificacion, per_nombre, per_apellido1, per_apellido2, per_fecha_nacimiento, per_sexo, fin_id) 
VALUES ('204440002', 'María Elena', 'González', 'Vargas', DATE '1975-08-22', 'F', NULL);
INSERT INTO dcs_persona_fisica (per_identificacion, per_nombre, per_apellido1, per_apellido2, per_fecha_nacimiento, per_sexo, fin_id) 
VALUES ('303330003', 'Carlos Alberto', 'Jiménez', 'Solís', DATE '1985-11-10', 'M', NULL);
INSERT INTO dcs_persona_fisica (per_identificacion, per_nombre, per_apellido1, per_apellido2, per_fecha_nacimiento, per_sexo, fin_id) 
VALUES ('402220004', 'Ana Lucía', 'Herrera', 'Castro', DATE '1978-05-30', 'F', NULL);
INSERT INTO dcs_persona_fisica (per_identificacion, per_nombre, per_apellido1, per_apellido2, per_fecha_nacimiento, per_sexo, fin_id) 
VALUES ('501110005', 'Roberto', 'Alfaro', 'Pérez', DATE '1982-09-12', 'M', NULL);
INSERT INTO dcs_persona_fisica (per_identificacion, per_nombre, per_apellido1, per_apellido2, per_fecha_nacimiento, per_sexo, fin_id) 
VALUES ('600000006', 'Ingeniero Luis', 'Martínez', 'Rojas', DATE '1979-01-20', 'M', NULL);

-- Insertar fincas
INSERT INTO dcs_finca (fin_numero_registro, fin_nombre, fin_tamano_hectareas, fin_estado, fin_direccion, per_id) 
VALUES ('F001-2024', 'Finca El Cafetal', 25.5, 'A', 'San Marcos de Tarrazú, 2km norte del centro', 1);
INSERT INTO dcs_finca (fin_numero_registro, fin_nombre, fin_tamano_hectareas, fin_estado, fin_direccion, per_id) 
VALUES ('F002-2024', 'Finca Los Naranjos', 18.0, 'A', 'San Lorenzo de Tarrazú, 1.5km sur de la escuela', 2);
INSERT INTO dcs_finca (fin_numero_registro, fin_nombre, fin_tamano_hectareas, fin_estado, fin_direccion, per_id) 
VALUES ('F003-2024', 'Finca Santa Rosa', 32.2, 'A', 'San Carlos de Tarrazú, 3km oeste del pueblo', 3);
INSERT INTO dcs_finca (fin_numero_registro, fin_nombre, fin_tamano_hectareas, fin_estado, fin_direccion, per_id) 
VALUES ('F004-2024', 'Finca La Esperanza', 15.8, 'A', 'Dota, 2.5km norte de la iglesia', 4);

-- Insertar lotes
INSERT INTO dcs_lote (lot_nombre, lot_tamano_hectareas, lot_descripcion, lot_direccion, fin_id) 
VALUES ('Lote A1', 8.5, 'Lote con excelente drenaje', 'Sector norte de la finca', 1);
INSERT INTO dcs_lote (lot_nombre, lot_tamano_hectareas, lot_descripcion, lot_direccion, fin_id) 
VALUES ('Lote A2', 10.0, 'Lote en terreno plano', 'Sector central de la finca', 1);
INSERT INTO dcs_lote (lot_nombre, lot_tamano_hectareas, lot_descripcion, lot_direccion, fin_id) 
VALUES ('Lote B1', 9.0, 'Lote con pendiente suave', 'Sector sur de la finca', 2);
INSERT INTO dcs_lote (lot_nombre, lot_tamano_hectareas, lot_descripcion, lot_direccion, fin_id) 
VALUES ('Lote B2', 9.0, 'Lote cerca del río', 'Sector este de la finca', 2);
INSERT INTO dcs_lote (lot_nombre, lot_tamano_hectareas, lot_descripcion, lot_direccion, fin_id) 
VALUES ('Lote C1', 12.0, 'Lote en altura', 'Sector montañoso', 3);
INSERT INTO dcs_lote (lot_nombre, lot_tamano_hectareas, lot_descripcion, lot_direccion, fin_id) 
VALUES ('Lote C2', 15.0, 'Lote experimental', 'Sector oeste de la finca', 3);

-- Insertar asociados
INSERT INTO dcs_asociado (aso_fecha_ingreso, aso_estado, aso_cuota_afiliacion, per_id, cat_id, asociacion_id) 
VALUES (DATE '2023-01-15', 'A', 50000, 1, 1, 1);
INSERT INTO dcs_asociado (aso_fecha_ingreso, aso_estado, aso_cuota_afiliacion, per_id, cat_id, asociacion_id) 
VALUES (DATE '2023-02-20', 'A', 50000, 2, 2, 1);
INSERT INTO dcs_asociado (aso_fecha_ingreso, aso_estado, aso_cuota_afiliacion, per_id, cat_id, asociacion_id) 
VALUES (DATE '2023-03-10', 'A', 50000, 3, 2, 1);
INSERT INTO dcs_asociado (aso_fecha_ingreso, aso_estado, aso_cuota_afiliacion, per_id, cat_id, asociacion_id) 
VALUES (DATE '2023-04-05', 'A', 50000, 4, 3, 1);
INSERT INTO dcs_asociado (aso_fecha_ingreso, aso_estado, aso_cuota_afiliacion, per_id, cat_id, asociacion_id) 
VALUES (DATE '2023-05-12', 'A', 50000, 5, 1, 1);

-- Insertar ingenieros
INSERT INTO dcs_ingeniero (codigo, per_id) VALUES (1001, 6);

-- Insertar unidades de medida
INSERT INTO dcs_unidad_medida (uni_descripcion, uni_conversion_base) 
VALUES ('Kilogramo', 1.0);
INSERT INTO dcs_unidad_medida (uni_descripcion, uni_conversion_base) 
VALUES ('Libra', 0.453592);
INSERT INTO dcs_unidad_medida (uni_descripcion, uni_conversion_base) 
VALUES ('Quintal', 45.3592);

-- Insertar semillas
INSERT INTO dcs_semilla (sem_nombre) VALUES ('Café Arábica');
INSERT INTO dcs_semilla (sem_nombre) VALUES ('Café Robusta');
INSERT INTO dcs_semilla (sem_nombre) VALUES ('Frijol Negro');

-- Insertar variedades
INSERT INTO dcs_variedad (var_nombre, var_tiempo_cosecha_dias, var_precio_unitario, sem_id, uni_id) 
VALUES ('Caturra', 240, 3500.00, 1, 1);
INSERT INTO dcs_variedad (var_nombre, var_tiempo_cosecha_dias, var_precio_unitario, sem_id, uni_id) 
VALUES ('Catuaí Rojo', 250, 3800.00, 1, 1);
INSERT INTO dcs_variedad (var_nombre, var_tiempo_cosecha_dias, var_precio_unitario, sem_id, uni_id) 
VALUES ('Villa Sarchí', 260, 4000.00, 1, 1);
INSERT INTO dcs_variedad (var_nombre, var_tiempo_cosecha_dias, var_precio_unitario, sem_id, uni_id) 
VALUES ('Frijol Criollo', 90, 2500.00, 3, 1);

-- Insertar plagas
INSERT INTO dcs_plaga (pla_nombre, pla_descripcion, pla_tratamiento, pla_etapa_desarrollo) 
VALUES ('Broca del Café', 'Insecto que perfora los granos de café', 'Aplicación de insecticida específico', 'F');
INSERT INTO dcs_plaga (pla_nombre, pla_descripcion, pla_tratamiento, pla_etapa_desarrollo) 
VALUES ('Cochinilla', 'Insecto que succiona la savia', 'Control biológico con depredadores', 'V');

-- Insertar enfermedades
INSERT INTO dcs_enfermedad (enf_nombre, enf_ubicacion_planta, enf_tratamiento, enf_etapa_desarrollo) 
VALUES ('Roya del Café', 'Hojas', 'Fungicida sistémico', 'Vegetativa');
INSERT INTO dcs_enfermedad (enf_nombre, enf_ubicacion_planta, enf_tratamiento, enf_etapa_desarrollo) 
VALUES ('Antracnosis', 'Frutos', 'Fungicida preventivo', 'Reproductiva');

-- Insertar síntomas
INSERT INTO dcs_sintomas (sin_tipo, sin_nombre, enf_id) 
VALUES ('V', 'Manchas amarillas en hojas', 1);
INSERT INTO dcs_sintomas (sin_tipo, sin_nombre, enf_id) 
VALUES ('F', 'Manchas negras en frutos', 2);

-- Insertar reproducciones
INSERT INTO dcs_reproduccion (rep_numero_contrato, rep_fecha_siembra_inicio, rep_fecha_siembra_fin, 
                             rep_fecha_cosecha_inicio, rep_fecha_cosecha_fin, rep_hectareas_sembradas, 
                             per_id, fin_id, lot_id, est_id, cos_id, inge_id) 
VALUES (2024001, DATE '2024-02-01', DATE '2024-02-15', DATE '2024-09-01', DATE '2024-09-30', 
        8.5, 1, 1, 1, 6, 1, 1);
INSERT INTO dcs_reproduccion (rep_numero_contrato, rep_fecha_siembra_inicio, rep_fecha_siembra_fin, 
                             rep_fecha_cosecha_inicio, rep_fecha_cosecha_fin, rep_hectareas_sembradas, 
                             per_id, fin_id, lot_id, est_id, cos_id, inge_id) 
VALUES (2024002, DATE '2024-02-10', DATE '2024-02-25', DATE '2024-09-15', DATE '2024-10-15', 
        9.0, 2, 2, 3, 6, 1, 1);
INSERT INTO dcs_reproduccion (rep_numero_contrato, rep_fecha_siembra_inicio, rep_fecha_siembra_fin, 
                             rep_fecha_cosecha_inicio, rep_fecha_cosecha_fin, rep_hectareas_sembradas, 
                             per_id, fin_id, lot_id, est_id, cos_id, inge_id) 
VALUES (2024003, DATE '2024-03-01', DATE '2024-03-15', DATE '2024-10-01', DATE '2024-10-31', 
        12.0, 3, 3, 5, 6, 1, 1);

-- Insertar inspecciones
INSERT INTO dcs_inspeccion (ins_fecha, ins_comentario, rep_id) 
VALUES (DATE '2024-04-15', 'Plantación en buen estado, crecimiento normal', 1);
INSERT INTO dcs_inspeccion (ins_fecha, ins_comentario, rep_id) 
VALUES (DATE '2024-05-20', 'Se detectaron algunos síntomas de roya en sector norte', 1);
INSERT INTO dcs_inspeccion (ins_fecha, ins_comentario, rep_id) 
VALUES (DATE '2024-04-25', 'Excelente desarrollo de las plantas', 2);
INSERT INTO dcs_inspeccion (ins_fecha, ins_comentario, rep_id) 
VALUES (DATE '2024-05-10', 'Plantación sin problemas aparentes', 3);

-- Insertar análisis
INSERT INTO dcs_analisis (ana_motivo, ana_porcentaje_semilla_sana, ana_monto, ana_estado, rep_id) 
VALUES ('Análisis de calidad rutinario', 95.5, 75000, 'A', 1);
INSERT INTO dcs_analisis (ana_motivo, ana_porcentaje_semilla_sana, ana_monto, ana_estado, rep_id) 
VALUES ('Análisis por sospecha de enfermedad', 88.2, 85000, 'A', 1);
INSERT INTO dcs_analisis (ana_motivo, ana_porcentaje_semilla_sana, ana_monto, ana_estado, rep_id) 
VALUES ('Análisis de calidad rutinario', 92.8, 75000, 'A', 2);
INSERT INTO dcs_analisis (ana_motivo, ana_porcentaje_semilla_sana, ana_monto, ana_estado, rep_id) 
VALUES ('Análisis final de cosecha', 97.1, 80000, 'A', 3);

-- Insertar relaciones análisis-enfermedad
INSERT INTO dcs_analisis_enfermedad (ana_id, enf_id) VALUES (2, 1);

-- Insertar relaciones análisis-plaga
INSERT INTO dcs_analisis_plaga (ana_id, pla_id) VALUES (2, 1);

-- Insertar productos
INSERT INTO dcs_producto (pro_nombre, pro_cantidad, var_id, rep_id) 
VALUES ('Café Caturra Premium', 1200.5, 1, 1);
INSERT INTO dcs_producto (pro_nombre, pro_cantidad, var_id, rep_id) 
VALUES ('Café Catuaí Especial', 980.2, 2, 2);
INSERT INTO dcs_producto (pro_nombre, pro_cantidad, var_id, rep_id) 
VALUES ('Café Villa Sarchí Select', 1450.8, 3, 3);

-- Insertar pagos a productores
INSERT INTO dcs_pago_productor (pag_cantidad, pag_precio_unitario, pag_fecha_pago, per_id, pro_id) 
VALUES (1200.5, 3500.00, DATE '2024-10-15', 1, 1);
INSERT INTO dcs_pago_productor (pag_cantidad, pag_precio_unitario, pag_fecha_pago, per_id, pro_id) 
VALUES (980.2, 3800.00, DATE '2024-10-20', 2, 2);
INSERT INTO dcs_pago_productor (pag_cantidad, pag_precio_unitario, pag_fecha_pago, per_id, pro_id) 
VALUES (1450.8, 4000.00, DATE '2024-11-05', 3, 3);

-- Insertar ensayos
INSERT INTO dcs_ensayo (ens_nombre, ens_fecha_siembra_inicio, ens_fecha_siembra_fin, 
                       ens_fecha_cosecha_inicio, ens_fecha_cosecha_fin, ens_usuario_registro, 
                       cos_id, per_id, lot_id, est_id, eta_id) 
VALUES ('Ensayo Resistencia Roya 2024', DATE '2024-03-01', DATE '2024-03-10', 
        DATE '2024-10-01', DATE '2024-10-15', 'admin', 1, 4, 2, 5, 1);
INSERT INTO dcs_ensayo (ens_nombre, ens_fecha_siembra_inicio, ens_fecha_siembra_fin, 
                       ens_fecha_cosecha_inicio, ens_fecha_cosecha_fin, ens_usuario_registro, 
                       cos_id, per_id, lot_id, est_id, eta_id) 
VALUES ('Ensayo Nuevas Variedades', DATE '2024-04-01', DATE '2024-04-10', 
        DATE '2024-11-01', DATE '2024-11-15', 'admin', 1, 5, 4, 5, 2);

-- Insertar contactos
INSERT INTO dcs_contacto (con_valor, tc_id, per_id, asociacion_id) 
VALUES ('8888-1111', 1, 1, NULL);
INSERT INTO dcs_contacto (con_valor, tc_id, per_id, asociacion_id) 
VALUES ('juan.rodriguez@email.com', 2, 1, NULL);
INSERT INTO dcs_contacto (con_valor, tc_id, per_id, asociacion_id) 
VALUES ('8888-2222', 1, 2, NULL);
INSERT INTO dcs_contacto (con_valor, tc_id, per_id, asociacion_id) 
VALUES ('maria.gonzalez@email.com', 2, 2, NULL);
INSERT INTO dcs_contacto (con_valor, tc_id, per_id, asociacion_id) 
VALUES ('8888-6666', 1, 6, NULL);
INSERT INTO dcs_contacto (con_valor, tc_id, per_id, asociacion_id) 
VALUES ('ing.martinez@email.com', 2, 6, NULL);
INSERT INTO dcs_contacto (con_valor, tc_id, per_id, asociacion_id) 
VALUES ('2222-3333', 1, NULL, 1);
INSERT INTO dcs_contacto (con_valor, tc_id, per_id, asociacion_id) 
VALUES ('info@tarrazu.com', 2, NULL, 1);

-- Insertar junta directiva
INSERT INTO dcs_junta_directiva (jun_puesto, jun_fecha_inicio, jun_fecha_fin, aso_id, per_id, asociacion_id) 
VALUES ('Presidente', DATE '2024-01-01', DATE '2024-12-31', 1, 1, 1);
INSERT INTO dcs_junta_directiva (jun_puesto, jun_fecha_inicio, jun_fecha_fin, aso_id, per_id, asociacion_id) 
VALUES ('Vicepresidente', DATE '2024-01-01', DATE '2024-12-31', 2, 2, 1);
INSERT INTO dcs_junta_directiva (jun_puesto, jun_fecha_inicio, jun_fecha_fin, aso_id, per_id, asociacion_id) 
VALUES ('Secretario', DATE '2024-01-01', DATE '2024-12-31', 3, 3, 1);
INSERT INTO dcs_junta_directiva (jun_puesto, jun_fecha_inicio, jun_fecha_fin, aso_id, per_id, asociacion_id) 
VALUES ('Tesorero', DATE '2024-01-01', DATE '2024-12-31', 4, 4, 1);

COMMIT;