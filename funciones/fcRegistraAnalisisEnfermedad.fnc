CREATE OR REPLACE FUNCTION fcRegistraAnalisisEnfermedad(
    p_reproduccion_id IN NUMBER,
    p_motivo IN VARCHAR2,
    p_porcentaje_semilla_sana IN NUMBER,
    p_monto IN NUMBER,
    p_enfermedad_id IN NUMBER,
    p_observaciones IN VARCHAR2 DEFAULT NULL
) RETURN VARCHAR2 IS
    v_count_reproduccion NUMBER := 0;
    v_count_enfermedad NUMBER := 0;
    v_ana_id NUMBER;
    v_rep_contrato NUMBER;
    v_finca_nombre VARCHAR2(30);
    v_lote_nombre VARCHAR2(50);
    v_enfermedad_nombre VARCHAR2(50);
    v_ingeniero_nombre VARCHAR2(100);
    
BEGIN
    -- Validar que los parámetros obligatorios no sean nulos
    IF p_reproduccion_id IS NULL THEN
        RETURN 'ERROR: El ID de reproducción no puede ser nulo';
    END IF;
    
    IF p_motivo IS NULL THEN
        RETURN 'ERROR: El motivo del análisis no puede ser nulo';
    END IF;
    
    IF p_porcentaje_semilla_sana IS NULL THEN
        RETURN 'ERROR: El porcentaje de semilla sana no puede ser nulo';
    END IF;
    
    IF p_monto IS NULL THEN
        RETURN 'ERROR: El monto del análisis no puede ser nulo';
    END IF;
    
    IF p_enfermedad_id IS NULL THEN
        RETURN 'ERROR: El ID de enfermedad no puede ser nulo';
    END IF;
    
    -- Validar rangos de valores
    IF p_porcentaje_semilla_sana < 0 OR p_porcentaje_semilla_sana > 100 THEN
        RETURN 'ERROR: El porcentaje de semilla sana debe estar entre 0 y 100';
    END IF;
    
    IF p_monto <= 0 THEN
        RETURN 'ERROR: El monto del análisis debe ser mayor a cero';
    END IF;
    
    -- Validar longitud del motivo
    IF LENGTH(p_motivo) > 30 THEN
        RETURN 'ERROR: El motivo no puede exceder 30 caracteres';
    END IF;
    
    -- Validar longitud de observaciones
    IF p_observaciones IS NOT NULL AND LENGTH(p_observaciones) > 500 THEN
        RETURN 'ERROR: Las observaciones no pueden exceder 500 caracteres';
    END IF;
    
    -- Validar que la reproducción exista y obtener información
    BEGIN
        SELECT COUNT(r.rep_id), MAX(r.rep_numero_contrato), MAX(f.fin_nombre), 
               MAX(l.lot_nombre), MAX(pf.per_nombre || ' ' || pf.per_apellido1 || ' ' || NVL(pf.per_apellido2, ''))
        INTO v_count_reproduccion, v_rep_contrato, v_finca_nombre, v_lote_nombre, v_ingeniero_nombre
        FROM dcs_reproduccion r
        INNER JOIN dcs_finca f ON r.fin_id = f.fin_id
        INNER JOIN dcs_lote l ON r.lot_id = l.lot_id
        INNER JOIN dcs_ingeniero i ON r.inge_id = i.inge_id
        INNER JOIN dcs_persona_fisica pf ON i.per_id = pf.per_id
        WHERE r.rep_id = p_reproduccion_id;
        
        IF v_count_reproduccion = 0 THEN
            RETURN 'ERROR: La reproducción especificada no existe (ID: ' || p_reproduccion_id || ')';
        END IF;
        
    EXCEPTION
        WHEN OTHERS THEN
            RETURN 'ERROR: Error al validar la reproducción - ' || SQLERRM;
    END;
    
    -- Validar que la enfermedad exista
    BEGIN
        SELECT COUNT(enf_id), MAX(enf_nombre)
        INTO v_count_enfermedad, v_enfermedad_nombre
        FROM dcs_enfermedad
        WHERE enf_id = p_enfermedad_id;
        
        IF v_count_enfermedad = 0 THEN
            RETURN 'ERROR: La enfermedad especificada no existe (ID: ' || p_enfermedad_id || ')';
        END IF;
        
    EXCEPTION
        WHEN OTHERS THEN
            RETURN 'ERROR: Error al validar la enfermedad - ' || SQLERRM;
    END;
    
    -- Insertar el nuevo análisis
    BEGIN
        INSERT INTO dcs_analisis (
            ana_motivo,
            ana_porcentaje_semilla_sana,
            ana_monto,
            ana_estado,
            rep_id
        ) VALUES (
            p_motivo,
            p_porcentaje_semilla_sana,
            p_monto,
            'A',
            p_reproduccion_id
        ) RETURNING ana_id INTO v_ana_id;
        
        -- Insertar la relación análisis-enfermedad
        INSERT INTO dcs_analisis_enfermedad (
            ana_id,
            enf_id
        ) VALUES (
            v_ana_id,
            p_enfermedad_id
        );
        
        -- Si hay observaciones, crear inspección complementaria
        IF p_observaciones IS NOT NULL THEN
            DECLARE
                v_ins_id NUMBER;
            BEGIN
                INSERT INTO dcs_inspeccion (
                    ins_fecha,
                    ins_comentario,
                    rep_id
                ) VALUES (
                    SYSDATE,
                    'Análisis enfermedad: ' || SUBSTR(p_observaciones, 1, 450),
                    p_reproduccion_id
                ) RETURNING ins_id INTO v_ins_id;
                
            EXCEPTION
                WHEN OTHERS THEN
                    NULL;
            END;
        END IF;
        
        -- Confirmar la transacción
        COMMIT;
        
        -- Mensaje de confirmación exitosa
        RETURN 'EXITO: Análisis de enfermedad registrado correctamente. ' ||
               'ID Análisis: ' || v_ana_id || ', ' ||
               'Contrato: ' || v_rep_contrato || ', ' ||
               'Finca: ' || v_finca_nombre || ', ' ||
               'Lote: ' || v_lote_nombre || ', ' ||
               'Enfermedad: ' || v_enfermedad_nombre || ', ' ||
               'Semilla sana: ' || TO_CHAR(p_porcentaje_semilla_sana, 'FM999.00') || '%, ' ||
               'Monto: ₡' || TO_CHAR(p_monto, 'FM999,999,990') || ', ' ||
               'Ingeniero: ' || v_ingeniero_nombre;
        
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            ROLLBACK;
            RETURN 'ERROR: Ya existe un análisis con características similares';
        WHEN OTHERS THEN
            ROLLBACK;
            RETURN 'ERROR: Error al insertar el análisis - ' || SQLERRM;
    END;
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RETURN 'ERROR: Error inesperado en la función - ' || SQLERRM;
        
END fcRegistraAnalisisEnfermedad;
/
