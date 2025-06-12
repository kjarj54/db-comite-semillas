-- filepath: d:\carpetaU\PrimerSemestre2025\diseñoOfDB\Proiyecto#2\db-comite-semillas\scripts\datos.sql

-- DATOS DE PRUEBA PARA EL SISTEMA DE COMITÉ DE SEMILLAS
-- Insertando datos base necesarios para las pruebas

-- 1. ASOCIACIÓN
INSERT INTO dcs_asociacion (asociacion_cedula_juridica, asociacion_nombre, asociacion_logo) 
VALUES (3001234567, 'Asociación Productores Tarrazú', 'https://tarrazu.com/logo.png');

-- 2. CATEGORÍAS DE ASOCIADOS
INSERT INTO dcs_categoria_asociado (cat_descripcion, cat_monto_cuota_mensual) 
VALUES ('Productor Básico', 15000);

INSERT INTO dcs_categoria_asociado (cat_descripcion, cat_monto_cuota_mensual) 
VALUES ('Productor Intermedio', 25000);

INSERT INTO dcs_categoria_asociado (cat_descripcion, cat_monto_cuota_mensual) 
VALUES ('Productor Avanzado', 35000);

-- 3. TIPOS DE CONTACTO
INSERT INTO dcs_tipo_contacto (tc_nombre) VALUES ('Teléfono');
INSERT INTO dcs_tipo_contacto (tc_nombre) VALUES ('Email');
INSERT INTO dcs_tipo_contacto (tc_nombre) VALUES ('WhatsApp');

-- 4. ESTADOS GENERALES
INSERT INTO dcs_estado_general (est_descripcion) VALUES ('Activo');
INSERT INTO dcs_estado_general (est_descripcion) VALUES ('Inactivo');
INSERT INTO dcs_estado_general (est_descripcion) VALUES ('Pendiente');
INSERT INTO dcs_estado_general (est_descripcion) VALUES ('Aprobado');
INSERT INTO dcs_estado_general (est_descripcion) VALUES ('Rechazado');
INSERT INTO dcs_estado_general (est_descripcion) VALUES ('Cancelado');

-- 5. ETAPAS DE ENSAYO
INSERT INTO dcs_etapa_ensayo (eta_nombre, eta_estado, eta_comentario) 
VALUES ('Germinación y Vigor', 'A', 'Etapa inicial de desarrollo');

INSERT INTO dcs_etapa_ensayo (eta_nombre, eta_estado, eta_comentario) 
VALUES ('Floración', 'A', 'Etapa de floración del cultivo');

INSERT INTO dcs_etapa_ensayo (eta_nombre, eta_estado, eta_comentario) 
VALUES ('Maduración', 'A', 'Etapa final de maduración');

-- 6. COSECHAS
INSERT INTO dcs_cosecha (cos_nombre, cos_fecha_inicio, cos_fecha_fin) 
VALUES ('Cosecha 2024-2025', DATE '2024-10-01', DATE '2025-03-31');

INSERT INTO dcs_cosecha (cos_nombre, cos_fecha_inicio, cos_fecha_fin) 
VALUES ('Cosecha 2025-2026', DATE '2025-04-01', DATE '2025-09-30');

-- 7. PERSONAS FÍSICAS (Incluye productores, ingenieros, asociados)
INSERT INTO dcs_persona_fisica (per_identificacion, per_nombre, per_apellido1, per_apellido2, per_fecha_nacimiento, per_sexo) 
VALUES ('105470123', 'Carlos', 'Rodríguez', 'Mora', DATE '1975-03-15', 'M');

INSERT INTO dcs_persona_fisica (per_identificacion, per_nombre, per_apellido1, per_apellido2, per_fecha_nacimiento, per_sexo) 
VALUES ('204560789', 'María', 'González', 'Vega', DATE '1980-07-22', 'F');

INSERT INTO dcs_persona_fisica (per_identificacion, per_nombre, per_apellido1, per_apellido2, per_fecha_nacimiento, per_sexo) 
VALUES ('301230456', 'Luis', 'Chacón', 'Jiménez', DATE '1978-11-10', 'M');

INSERT INTO dcs_persona_fisica (per_identificacion, per_nombre, per_apellido1, per_apellido2, per_fecha_nacimiento, per_sexo) 
VALUES ('402340567', 'Ana', 'Vargas', 'Castro', DATE '1982-02-28', 'F');

INSERT INTO dcs_persona_fisica (per_identificacion, per_nombre, per_apellido1, per_apellido2, per_fecha_nacimiento, per_sexo) 
VALUES ('503450678', 'José', 'Pérez', 'Morales', DATE '1976-09-14', 'M');

-- 8. INGENIEROS
INSERT INTO dcs_ingeniero (codigo, per_id) VALUES (1001, 3); -- Luis Chacón
INSERT INTO dcs_ingeniero (codigo, per_id) VALUES (1002, 4); -- Ana Vargas

-- 9. FINCAS
INSERT INTO dcs_finca (fin_numero_registro, fin_nombre, fin_tamano_hectareas, fin_estado, fin_direccion, per_id) 
VALUES ('REG-001', 'Finca El Cafetal', 15.5, 'A', 'San Marcos de Tarrazú, 2km norte del centro', 1);

INSERT INTO dcs_finca (fin_numero_registro, fin_nombre, fin_tamano_hectareas, fin_estado, fin_direccion, per_id) 
VALUES ('REG-002', 'Finca Santa Rosa', 8.3, 'A', 'Santa María de Dota, 1km este de la iglesia', 2);

INSERT INTO dcs_finca (fin_numero_registro, fin_nombre, fin_tamano_hectareas, fin_estado, fin_direccion, per_id) 
VALUES ('REG-003', 'Finca Los Cedros', 12.0, 'A', 'San Lorenzo de Tarrazú, entrada principal', 5);

-- 10. LOTES
INSERT INTO dcs_lote (lot_nombre, lot_tamano_hectareas, lot_descripcion, lot_direccion, fin_id) 
VALUES ('Lote A1', 3.5, 'Lote principal con exposición sur', 'Sector norte de la finca', 1);

INSERT INTO dcs_lote (lot_nombre, lot_tamano_hectareas, lot_descripcion, lot_direccion, fin_id) 
VALUES ('Lote A2', 2.8, 'Lote experimental', 'Sector este de la finca', 1);

INSERT INTO dcs_lote (lot_nombre, lot_tamano_hectareas, lot_descripcion, lot_direccion, fin_id) 
VALUES ('Lote B1', 4.0, 'Lote para reproducción', 'Sector central de la finca', 2);

INSERT INTO dcs_lote (lot_nombre, lot_tamano_hectareas, lot_descripcion, lot_direccion, fin_id) 
VALUES ('Lote C1', 5.2, 'Lote principal de producción', 'Ladera oeste de la finca', 3);

-- 11. ASOCIADOS
INSERT INTO dcs_asociado (aso_fecha_ingreso, aso_estado, aso_cuota_afiliacion, per_id, cat_id, asociacion_id) 
VALUES (DATE '2023-01-15', 'A', 50000, 1, 2, 1); -- Carlos Rodríguez

INSERT INTO dcs_asociado (aso_fecha_ingreso, aso_estado, aso_cuota_afiliacion, per_id, cat_id, asociacion_id) 
VALUES (DATE '2023-03-20', 'A', 50000, 2, 1, 1); -- María González

INSERT INTO dcs_asociado (aso_fecha_ingreso, aso_estado, aso_cuota_afiliacion, per_id, cat_id, asociacion_id) 
VALUES (DATE '2023-06-10', 'A', 50000, 5, 3, 1); -- José Pérez

-- 12. JUNTA DIRECTIVA
INSERT INTO dcs_junta_directiva (jun_puesto, jun_fecha_inicio, jun_fecha_fin, aso_id, per_id, asociacion_id) 
VALUES ('Presidente', DATE '2024-01-01', DATE '2025-12-31', 1, 1, 1);

INSERT INTO dcs_junta_directiva (jun_puesto, jun_fecha_inicio, jun_fecha_fin, aso_id, per_id, asociacion_id) 
VALUES ('Secretaria', DATE '2024-01-01', DATE '2025-12-31', 2, 2, 1);

-- 13. CONTACTOS
INSERT INTO dcs_contacto (con_valor, tc_id, per_id, asociacion_id) 
VALUES ('8765-4321', 1, 1, NULL); -- Teléfono Carlos

INSERT INTO dcs_contacto (con_valor, tc_id, per_id, asociacion_id) 
VALUES ('carlos@email.com', 2, 1, NULL); -- Email Carlos

INSERT INTO dcs_contacto (con_valor, tc_id, per_id, asociacion_id) 
VALUES ('8888-9999', 1, 2, NULL); -- Teléfono María

INSERT INTO dcs_contacto (con_valor, tc_id, per_id, asociacion_id) 
VALUES ('info@tarrazu.com', 2, NULL, 1); -- Email Asociación

-- 14. UNIDADES DE MEDIDA
INSERT INTO dcs_unidad_medida (uni_descripcion, uni_conversion_base) 
VALUES ('Kilogramos', 1.0);

INSERT INTO dcs_unidad_medida (uni_descripcion, uni_conversion_base) 
VALUES ('Quintales', 46.0);

INSERT INTO dcs_unidad_medida (uni_descripcion, uni_conversion_base) 
VALUES ('Libras', 0.454);

-- 15. SEMILLAS
INSERT INTO dcs_semilla (sem_nombre) VALUES ('Café Arábica');
INSERT INTO dcs_semilla (sem_nombre) VALUES ('Café Robusta'); 

-- 16. VARIEDADES
INSERT INTO dcs_variedad (var_nombre, var_tiempo_cosecha_dias, var_precio_unitario, sem_id, uni_id) 
VALUES ('Geisha', 270, 8500, 1, 1);

INSERT INTO dcs_variedad (var_nombre, var_tiempo_cosecha_dias, var_precio_unitario, sem_id, uni_id) 
VALUES ('Caturra', 240, 6200, 1, 1);

INSERT INTO dcs_variedad (var_nombre, var_tiempo_cosecha_dias, var_precio_unitario, sem_id, uni_id) 
VALUES ('Villa Sarchí', 260, 7300, 1, 1);

-- 17. PLAGAS
INSERT INTO dcs_plaga (pla_nombre, pla_descripcion, pla_tratamiento, pla_etapa_desarrollo) 
VALUES ('Broca del café', 'Insecto que perfora los granos de café', 'Aplicación de insecticida específico', '2');

INSERT INTO dcs_plaga (pla_nombre, pla_descripcion, pla_tratamiento, pla_etapa_desarrollo) 
VALUES ('Minador de la hoja', 'Larva que daña las hojas del café', 'Control biológico con parasitoides', '1');

-- 18. ENFERMEDADES
INSERT INTO dcs_enfermedad (enf_nombre, enf_ubicacion_planta, enf_tratamiento, enf_etapa_desarrollo) 
VALUES ('Roya del café', 'Hojas', 'Fungicida cúprico', 'Vegetativa');

INSERT INTO dcs_enfermedad (enf_nombre, enf_ubicacion_planta, enf_tratamiento, enf_etapa_desarrollo) 
VALUES ('Antracnosis', 'Frutos', 'Fungicida sistémico', 'Reproductiva');

-- 19. SÍNTOMAS
INSERT INTO dcs_sintomas (sin_tipo, sin_nombre, enf_id) 
VALUES ('V', 'Manchas amarillas en hojas', 1);

INSERT INTO dcs_sintomas (sin_tipo, sin_nombre, enf_id) 
VALUES ('F', 'Lesiones oscuras en frutos', 2);

-- 20. REPRODUCCIÓN
INSERT INTO dcs_reproduccion (rep_numero_contrato, rep_fecha_siembra_inicio, rep_fecha_siembra_fin, 
                             rep_fecha_cosecha_inicio, rep_fecha_cosecha_fin, rep_hectareas_sembradas, 
                             per_id, fin_id, lot_id, est_id, cos_id, inge_id) 
VALUES (2024001, DATE '2024-10-15', DATE '2024-11-30', DATE '2025-07-01', DATE '2025-08-15', 
        3.5, 1, 1, 1, 1, 1, 
        (SELECT inge_id FROM dcs_ingeniero WHERE per_id = 3)); -- Luis Chacón

INSERT INTO dcs_reproduccion (rep_numero_contrato, rep_fecha_siembra_inicio, rep_fecha_siembra_fin, 
                             rep_fecha_cosecha_inicio, rep_fecha_cosecha_fin, rep_hectareas_sembradas, 
                             per_id, fin_id, lot_id, est_id, cos_id, inge_id) 
VALUES (2024002, DATE '2024-11-01', DATE '2024-12-15', DATE '2025-07-15', DATE '2025-08-30', 
        4.0, 2, 2, 3, 1, 1, 
        (SELECT inge_id FROM dcs_ingeniero WHERE per_id = 4)); -- Ana Vargas

INSERT INTO dcs_reproduccion (rep_numero_contrato, rep_fecha_siembra_inicio, rep_fecha_siembra_fin, 
                             rep_fecha_cosecha_inicio, rep_fecha_cosecha_fin, rep_hectareas_sembradas, 
                             per_id, fin_id, lot_id, est_id, cos_id, inge_id) 
VALUES (2024003, DATE '2024-12-01', DATE '2025-01-15', DATE '2025-08-01', DATE '2025-09-15', 
        5.2, 5, 3, 4, 1, 1, 
        (SELECT inge_id FROM dcs_ingeniero WHERE per_id = 3)); -- Luis Chacón

-- 21. INSPECCIONES
INSERT INTO dcs_inspeccion (ins_fecha, ins_comentario, rep_id) 
VALUES (DATE '2025-01-15', 'Desarrollo normal de plantas, buen establecimiento del cultivo', 
        (SELECT rep_id FROM dcs_reproduccion WHERE rep_numero_contrato = 2024001));

INSERT INTO dcs_inspeccion (ins_fecha, ins_comentario, rep_id) 
VALUES (DATE '2025-02-20', 'Se observa presencia leve de malezas, se recomienda control', 
        (SELECT rep_id FROM dcs_reproduccion WHERE rep_numero_contrato = 2024002));

INSERT INTO dcs_inspeccion (ins_fecha, ins_comentario, rep_id) 
VALUES (DATE '2025-03-10', 'Excelente desarrollo vegetativo, plantas vigorosas', 
        (SELECT rep_id FROM dcs_reproduccion WHERE rep_numero_contrato = 2024003));

-- 22. ANÁLISIS DE LABORATORIO
INSERT INTO dcs_analisis (ana_motivo, ana_porcentaje_semilla_sana, ana_monto, ana_estado, rep_id) 
VALUES ('Control de calidad rutinario', 95.5, 75000, 'A', 
        (SELECT rep_id FROM dcs_reproduccion WHERE rep_numero_contrato = 2024001));

INSERT INTO dcs_analisis (ana_motivo, ana_porcentaje_semilla_sana, ana_monto, ana_estado, rep_id) 
VALUES ('Análisis pre-cosecha', 88.2, 65000, 'A', 
        (SELECT rep_id FROM dcs_reproduccion WHERE rep_numero_contrato = 2024002));

INSERT INTO dcs_analisis (ana_motivo, ana_porcentaje_semilla_sana, ana_monto, ana_estado, rep_id) 
VALUES ('Verificación fitosanitaria', 92.8, 70000, 'P', 
        (SELECT rep_id FROM dcs_reproduccion WHERE rep_numero_contrato = 2024003));

-- 23. ANÁLISIS - PLAGAS
INSERT INTO dcs_analisis_plaga (ana_id, pla_id) 
VALUES ((SELECT ana_id FROM dcs_analisis WHERE ana_motivo = 'Control de calidad rutinario'), 1);

INSERT INTO dcs_analisis_plaga (ana_id, pla_id) 
VALUES ((SELECT ana_id FROM dcs_analisis WHERE ana_motivo = 'Análisis pre-cosecha'), 2);

-- 24. ANÁLISIS - ENFERMEDADES  
INSERT INTO dcs_analisis_enfermedad (ana_id, enf_id) 
VALUES ((SELECT ana_id FROM dcs_analisis WHERE ana_motivo = 'Control de calidad rutinario'), 1);

INSERT INTO dcs_analisis_enfermedad (ana_id, enf_id) 
VALUES ((SELECT ana_id FROM dcs_analisis WHERE ana_motivo = 'Verificación fitosanitaria'), 2);

-- 25. PRODUCTOS
INSERT INTO dcs_producto (pro_nombre, pro_cantidad, var_id, rep_id) 
VALUES ('Café Geisha Premium', 850.5, 1, 
        (SELECT rep_id FROM dcs_reproduccion WHERE rep_numero_contrato = 2024001));

INSERT INTO dcs_producto (pro_nombre, pro_cantidad, var_id, rep_id) 
VALUES ('Café Caturra Tradicional', 1200.3, 2, 
        (SELECT rep_id FROM dcs_reproduccion WHERE rep_numero_contrato = 2024002));

INSERT INTO dcs_producto (pro_nombre, pro_cantidad, var_id, rep_id) 
VALUES ('Café Villa Sarchí Especial', 1450.8, 3, 
        (SELECT rep_id FROM dcs_reproduccion WHERE rep_numero_contrato = 2024003));

-- 26. PAGOS A PRODUCTORES
INSERT INTO dcs_pago_productor (pag_cantidad, pag_precio_unitario, pag_fecha_pago, per_id, pro_id) 
VALUES (850.5, 8500, DATE '2025-08-20', 1, 
        (SELECT pro_id FROM dcs_producto WHERE pro_nombre = 'Café Geisha Premium'));

INSERT INTO dcs_pago_productor (pag_cantidad, pag_precio_unitario, pag_fecha_pago, per_id, pro_id) 
VALUES (1200.3, 6200, DATE '2025-09-05', 2, 
        (SELECT pro_id FROM dcs_producto WHERE pro_nombre = 'Café Caturra Tradicional'));

INSERT INTO dcs_pago_productor (pag_cantidad, pag_precio_unitario, pag_fecha_pago, per_id, pro_id) 
VALUES (1450.8, 7300, DATE '2025-09-20', 5, 
        (SELECT pro_id FROM dcs_producto WHERE pro_nombre = 'Café Villa Sarchí Especial'));

-- 27. ENSAYOS
INSERT INTO dcs_ensayo (ens_nombre, ens_fecha_siembra_inicio, ens_fecha_siembra_fin, 
                       ens_fecha_cosecha_inicio, ens_fecha_cosecha_fin, ens_usuario_registro, 
                       cos_id, per_id, lot_id, est_id, eta_id) 
VALUES ('Ensayo Resistencia Roya', DATE '2024-11-15', DATE '2024-12-01', 
        DATE '2025-08-01', DATE '2025-08-15', 'ing_luis', 1, 3, 2, 1, 2);

INSERT INTO dcs_ensayo (ens_nombre, ens_fecha_siembra_inicio, ens_fecha_siembra_fin, 
                       ens_fecha_cosecha_inicio, ens_fecha_cosecha_fin, ens_usuario_registro, 
                       cos_id, per_id, lot_id, est_id, eta_id) 
VALUES ('Ensayo Productividad', DATE '2025-01-10', DATE '2025-01-25', 
        DATE '2025-09-01', DATE '2025-09-15', 'ing_ana', 2, 4, 1, 1, 1);

COMMIT;