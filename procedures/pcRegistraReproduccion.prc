CREATE OR REPLACE PROCEDURE pcRegistraReproduccion(
    p_finca_id IN NUMBER,
    p_lote_id IN NUMBER,
    p_variedad_id IN NUMBER,
    p_cosecha_id IN NUMBER,
    p_fecha_siembra_inicio IN DATE,
    p_fecha_siembra_fin IN DATE,
    p_ingeniero_id IN NUMBER,
    p_mensaje OUT VARCHAR2
) IS
    v_count_finca NUMBER := 0;
    v_count_lote NUMBER := 0;
    v_count_variedad NUMBER := 0;
    v_count_cosecha NUMBER := 0;
    v_count_ingeniero NUMBER := 0;
    v_rep_id NUMBER;
    v_contrato_numero NUMBER;
    v_per_id NUMBER;
    v_est_activo_id NUMBER;
    v_hectareas_lote NUMBER;
    v_fecha_cosecha_inicio DATE;
    v_fecha_cosecha_fin DATE;
    v_tiempo_cosecha_dias NUMBER;
    v_finca_nombre VARCHAR2(30);
    v_lote_nombre VARCHAR2(50);
    v_variedad_nombre VARCHAR2(50);
    v_cosecha_nombre VARCHAR2(50);
    v_ingeniero_nombre VARCHAR2(100);
    
BEGIN
    -- Inicializar variable de salida
    p_mensaje := '';
    
    -- Validar que los parámetros obligatorios no sean nulos
    IF p_finca_id IS NULL THEN
        p_mensaje := 'ERROR: El ID de la finca no puede ser nulo';
        RETURN;
    END IF;
    
    IF p_lote_id IS NULL THEN
        p_mensaje := 'ERROR: El ID del lote no puede ser nulo';
        RETURN;
    END IF;
    
    IF p_variedad_id IS NULL THEN
        p_mensaje := 'ERROR: El ID de la variedad no puede ser nulo';
        RETURN;
    END IF;
    
    IF p_cosecha_id IS NULL THEN
        p_mensaje := 'ERROR: El ID de la cosecha no puede ser nulo';
        RETURN;
    END IF;
    
    IF p_fecha_siembra_inicio IS NULL THEN
        p_mensaje := 'ERROR: La fecha de inicio de siembra no puede ser nula';
        RETURN;
    END IF;
    
    IF p_fecha_siembra_fin IS NULL THEN
        p_mensaje := 'ERROR: La fecha de fin de siembra no puede ser nula';
        RETURN;
    END IF;
    
    IF p_ingeniero_id IS NULL THEN
        p_mensaje := 'ERROR: El ID del ingeniero no puede ser nulo';
        RETURN;
    END IF;
    
    -- Validar que las fechas estén en orden lógico
    IF p_fecha_siembra_inicio > p_fecha_siembra_fin THEN
        p_mensaje := 'ERROR: La fecha de inicio de siembra no puede ser posterior a la fecha de fin';
        RETURN;
    END IF;
    
    -- Validar que la finca exista y obtener datos
    BEGIN
        SELECT COUNT(fin_id), MAX(fin_nombre), MAX(per_id)
        INTO v_count_finca, v_finca_nombre, v_per_id
        FROM dcs_finca
        WHERE fin_id = p_finca_id
        AND fin_estado = 'A';
        
        IF v_count_finca = 0 THEN
            p_mensaje := 'ERROR: La finca especificada no existe o no está activa (ID: ' || p_finca_id || ')';
            RETURN;
        END IF;
        
    EXCEPTION
        WHEN OTHERS THEN
            p_mensaje := 'ERROR: Error al validar la finca - ' || SQLERRM;
            RETURN;
    END;
    
    -- Validar que el lote exista, pertenezca a la finca y obtener datos
    BEGIN
        SELECT COUNT(lot_id), MAX(lot_nombre), MAX(lot_tamano_hectareas)
        INTO v_count_lote, v_lote_nombre, v_hectareas_lote
        FROM dcs_lote
        WHERE lot_id = p_lote_id
        AND fin_id = p_finca_id;
        
        IF v_count_lote = 0 THEN
            p_mensaje := 'ERROR: El lote especificado no existe o no pertenece a la finca (Lote ID: ' || p_lote_id || ', Finca ID: ' || p_finca_id || ')';
            RETURN;
        END IF;
        
    EXCEPTION
        WHEN OTHERS THEN
            p_mensaje := 'ERROR: Error al validar el lote - ' || SQLERRM;
            RETURN;
    END;
    
    -- Validar que la variedad exista y obtener datos
    BEGIN
        SELECT COUNT(var_id), MAX(var_nombre), MAX(var_tiempo_cosecha_dias)
        INTO v_count_variedad, v_variedad_nombre, v_tiempo_cosecha_dias
        FROM dcs_variedad
        WHERE var_id = p_variedad_id;
        
        IF v_count_variedad = 0 THEN
            p_mensaje := 'ERROR: La variedad especificada no existe (ID: ' || p_variedad_id || ')';
            RETURN;
        END IF;
        
    EXCEPTION
        WHEN OTHERS THEN
            p_mensaje := 'ERROR: Error al validar la variedad - ' || SQLERRM;
            RETURN;
    END;
    
    -- Validar que la cosecha exista y obtener fechas
    BEGIN
        SELECT COUNT(cos_id), MAX(cos_nombre), MAX(cos_fecha_inicio), MAX(cos_fecha_fin)
        INTO v_count_cosecha, v_cosecha_nombre, v_fecha_cosecha_inicio, v_fecha_cosecha_fin
        FROM dcs_cosecha
        WHERE cos_id = p_cosecha_id;
        
        IF v_count_cosecha = 0 THEN
            p_mensaje := 'ERROR: La cosecha especificada no existe (ID: ' || p_cosecha_id || ')';
            RETURN;
        END IF;
        
    EXCEPTION
        WHEN OTHERS THEN
            p_mensaje := 'ERROR: Error al validar la cosecha - ' || SQLERRM;
            RETURN;
    END;
    
    -- Validar que el ingeniero exista
    BEGIN
        SELECT COUNT(i.inge_id), MAX(pf.per_nombre || ' ' || pf.per_apellido1 || ' ' || NVL(pf.per_apellido2, ''))
        INTO v_count_ingeniero, v_ingeniero_nombre
        FROM dcs_ingeniero i
        INNER JOIN dcs_persona_fisica pf ON i.per_id = pf.per_id
        WHERE i.inge_id = p_ingeniero_id;
        
        IF v_count_ingeniero = 0 THEN
            p_mensaje := 'ERROR: El ingeniero especificado no existe (ID: ' || p_ingeniero_id || ')';
            RETURN;
        END IF;
        
    EXCEPTION
        WHEN OTHERS THEN
            p_mensaje := 'ERROR: Error al validar el ingeniero - ' || SQLERRM;
            RETURN;
    END;
    
    -- Obtener el estado "Activo"
    BEGIN
        SELECT est_id
        INTO v_est_activo_id
        FROM dcs_estado_general
        WHERE est_descripcion = 'Activo'
        AND ROWNUM = 1;
        
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            p_mensaje := 'ERROR: No se encontró el estado "Activo" en el sistema';
            RETURN;
        WHEN OTHERS THEN
            p_mensaje := 'ERROR: Error al obtener el estado activo - ' || SQLERRM;
            RETURN;
    END;
    
    -- Validar que las fechas de siembra estén dentro del período de la cosecha
    IF p_fecha_siembra_inicio < v_fecha_cosecha_inicio OR p_fecha_siembra_fin > v_fecha_cosecha_fin THEN
        p_mensaje := 'ADVERTENCIA: Las fechas de siembra están fuera del período de la cosecha (' || 
                    TO_CHAR(v_fecha_cosecha_inicio, 'DD/MM/YYYY') || ' - ' || 
                    TO_CHAR(v_fecha_cosecha_fin, 'DD/MM/YYYY') || ')';
        -- Continuar pero advertir
    END IF;
    
    -- Calcular fechas de cosecha basadas en la variedad
    v_fecha_cosecha_inicio := p_fecha_siembra_fin + v_tiempo_cosecha_dias;
    v_fecha_cosecha_fin := v_fecha_cosecha_inicio + 30; -- 30 días de ventana para cosecha
    
    -- Generar número de contrato único
    BEGIN
        SELECT NVL(MAX(rep_numero_contrato), 2023000) + 1
        INTO v_contrato_numero
        FROM dcs_reproduccion;
        
    EXCEPTION
        WHEN OTHERS THEN
            v_contrato_numero := TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY') || '001');
    END;
    
    -- Verificar que no exista otra reproducción activa en el mismo lote y período
    DECLARE
        v_count_overlap NUMBER := 0;
    BEGIN
        SELECT COUNT(rep_id)
        INTO v_count_overlap
        FROM dcs_reproduccion r
        INNER JOIN dcs_estado_general eg ON r.est_id = eg.est_id
        WHERE r.lot_id = p_lote_id
        AND eg.est_descripcion IN ('Activo', 'Pendiente')
        AND ((p_fecha_siembra_inicio BETWEEN r.rep_fecha_siembra_inicio AND r.rep_fecha_cosecha_fin)
             OR (p_fecha_siembra_fin BETWEEN r.rep_fecha_siembra_inicio AND r.rep_fecha_cosecha_fin)
             OR (r.rep_fecha_siembra_inicio BETWEEN p_fecha_siembra_inicio AND v_fecha_cosecha_fin));
        
        IF v_count_overlap > 0 THEN
            p_mensaje := 'ERROR: Ya existe una reproducción activa en el lote ' || v_lote_nombre || 
                        ' que se superpone con las fechas especificadas';
            RETURN;
        END IF;
        
    EXCEPTION
        WHEN OTHERS THEN
            p_mensaje := 'ERROR: Error al verificar superposición de reproducciones - ' || SQLERRM;
            RETURN;
    END;
    
    -- Insertar la nueva reproducción
    BEGIN
        INSERT INTO dcs_reproduccion (
            rep_numero_contrato,
            rep_fecha_siembra_inicio,
            rep_fecha_siembra_fin,
            rep_fecha_cosecha_inicio,
            rep_fecha_cosecha_fin,
            rep_hectareas_sembradas,
            per_id,
            fin_id,
            lot_id,
            est_id,
            cos_id,
            inge_id
        ) VALUES (
            v_contrato_numero,
            p_fecha_siembra_inicio,
            p_fecha_siembra_fin,
            v_fecha_cosecha_inicio,
            v_fecha_cosecha_fin,
            v_hectareas_lote,
            v_per_id,
            p_finca_id,
            p_lote_id,
            v_est_activo_id,
            p_cosecha_id,
            p_ingeniero_id
        ) RETURNING rep_id INTO v_rep_id;
        
        -- Confirmar la transacción
        COMMIT;
        
        -- Mensaje de confirmación exitosa
        p_mensaje := 'EXITO: Reproducción registrada correctamente. ' ||
                    'ID: ' || v_rep_id || ', ' ||
                    'Contrato: ' || v_contrato_numero || ', ' ||
                    'Finca: ' || v_finca_nombre || ', ' ||
                    'Lote: ' || v_lote_nombre || ', ' ||
                    'Variedad: ' || v_variedad_nombre || ', ' ||
                    'Cosecha: ' || v_cosecha_nombre || ', ' ||
                    'Ingeniero: ' || v_ingeniero_nombre || ', ' ||
                    'Hectáreas: ' || TO_CHAR(v_hectareas_lote, 'FM999,999,990.00') || ', ' ||
                    'Siembra: ' || TO_CHAR(p_fecha_siembra_inicio, 'DD/MM/YYYY') || 
                    ' - ' || TO_CHAR(p_fecha_siembra_fin, 'DD/MM/YYYY') || ', ' ||
                    'Cosecha prevista: ' || TO_CHAR(v_fecha_cosecha_inicio, 'DD/MM/YYYY') || 
                    ' - ' || TO_CHAR(v_fecha_cosecha_fin, 'DD/MM/YYYY');
        
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            ROLLBACK;
            p_mensaje := 'ERROR: Ya existe una reproducción con el número de contrato generado';
        WHEN OTHERS THEN
            ROLLBACK;
            p_mensaje := 'ERROR: Error al insertar la reproducción - ' || SQLERRM;
    END;
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        p_mensaje := 'ERROR: Error inesperado en el procedimiento - ' || SQLERRM;
        
END pcRegistraReproduccion;
/
