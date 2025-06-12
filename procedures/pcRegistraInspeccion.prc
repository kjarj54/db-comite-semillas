CREATE OR REPLACE PROCEDURE pcRegistraInspeccion(
    p_lote_id IN NUMBER,
    p_ingeniero_id IN NUMBER,
    p_comentario IN VARCHAR2,
    p_mensaje OUT VARCHAR2
) IS
    v_count_lote NUMBER := 0;
    v_count_ingeniero NUMBER := 0;
    v_count_reproduccion NUMBER := 0;
    v_rep_id NUMBER;
    v_ins_id NUMBER;
    v_lote_nombre VARCHAR2(50);
    v_ingeniero_nombre VARCHAR2(100);
    v_fecha_inspeccion DATE := SYSDATE;
    
BEGIN
    -- Inicializar variable de salida
    p_mensaje := '';
    
    -- Validar que los parámetros obligatorios no sean nulos
    IF p_lote_id IS NULL THEN
        p_mensaje := 'ERROR: El ID del lote no puede ser nulo';
        RETURN;
    END IF;
    
    IF p_ingeniero_id IS NULL THEN
        p_mensaje := 'ERROR: El ID del ingeniero no puede ser nulo';
        RETURN;
    END IF;
    
    -- Validar longitud del comentario
    IF p_comentario IS NOT NULL AND LENGTH(p_comentario) > 500 THEN
        p_mensaje := 'ERROR: El comentario no puede exceder 500 caracteres';
        RETURN;
    END IF;
    
    -- Validar que el lote exista
    BEGIN
        SELECT COUNT(lot_id), MAX(lot_nombre)
        INTO v_count_lote, v_lote_nombre
        FROM dcs_lote
        WHERE lot_id = p_lote_id;
        
        IF v_count_lote = 0 THEN
            p_mensaje := 'ERROR: El lote especificado no existe (ID: ' || p_lote_id || ')';
            RETURN;
        END IF;
        
    EXCEPTION
        WHEN OTHERS THEN
            p_mensaje := 'ERROR: Error al validar el lote - ' || SQLERRM;
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
    
    -- Buscar reproducciones activas para el lote especificado
    BEGIN
        SELECT COUNT(r.rep_id), MAX(r.rep_id)
        INTO v_count_reproduccion, v_rep_id
        FROM dcs_reproduccion r
        INNER JOIN dcs_estado_general eg ON r.est_id = eg.est_id
        WHERE r.lot_id = p_lote_id
        AND (eg.est_descripcion = 'Activo' OR eg.est_descripcion = 'Pendiente')
        AND r.rep_fecha_siembra_inicio <= SYSDATE
        AND r.rep_fecha_cosecha_fin >= SYSDATE;
        
        IF v_count_reproduccion = 0 THEN
            -- Buscar cualquier reproducción para el lote (aunque no esté activa)
            SELECT COUNT(rep_id), MAX(rep_id)
            INTO v_count_reproduccion, v_rep_id
            FROM dcs_reproduccion
            WHERE lot_id = p_lote_id;
            
            IF v_count_reproduccion = 0 THEN
                p_mensaje := 'ERROR: No existen reproducciones registradas para el lote especificado (' || v_lote_nombre || ')';
                RETURN;
            ELSE
                -- Usar la reproducción más reciente si no hay activas
                SELECT rep_id
                INTO v_rep_id
                FROM (
                    SELECT rep_id, ROW_NUMBER() OVER (ORDER BY rep_fecha_siembra_inicio DESC) AS rn
                    FROM dcs_reproduccion
                    WHERE lot_id = p_lote_id
                )
                WHERE rn = 1;
            END IF;
        END IF;
        
    EXCEPTION
        WHEN OTHERS THEN
            p_mensaje := 'ERROR: Error al buscar reproducciones para el lote - ' || SQLERRM;
            RETURN;
    END;
    
    -- Validar que el ingeniero asignado coincida con el de la reproducción (opcional)
    DECLARE
        v_ingeniero_asignado NUMBER;
        v_ingeniero_asignado_nombre VARCHAR2(100);
    BEGIN
        SELECT r.inge_id, pf.per_nombre || ' ' || pf.per_apellido1 || ' ' || NVL(pf.per_apellido2, '')
        INTO v_ingeniero_asignado, v_ingeniero_asignado_nombre
        FROM dcs_reproduccion r
        INNER JOIN dcs_ingeniero i ON r.inge_id = i.inge_id
        INNER JOIN dcs_persona_fisica pf ON i.per_id = pf.per_id
        WHERE r.rep_id = v_rep_id;
        
        -- Permitir que cualquier ingeniero haga la inspección, pero informar si es diferente
        IF v_ingeniero_asignado != p_ingeniero_id THEN
            DBMS_OUTPUT.PUT_LINE('NOTA: El ingeniero que realiza la inspección (' || v_ingeniero_nombre || 
                               ') es diferente al asignado a la reproducción (' || v_ingeniero_asignado_nombre || ')');
        END IF;
        
    EXCEPTION
        WHEN OTHERS THEN
            -- Si no se puede obtener el ingeniero asignado, continuar
            NULL;
    END;
    
    -- Insertar la nueva inspección
    BEGIN
        INSERT INTO dcs_inspeccion (
            ins_fecha,
            ins_comentario,
            rep_id
        ) VALUES (
            v_fecha_inspeccion,
            p_comentario,
            v_rep_id
        ) RETURNING ins_id INTO v_ins_id;
        
        -- Confirmar la transacción
        COMMIT;
        
        -- Mensaje de confirmación exitosa
        p_mensaje := 'EXITO: Inspección registrada correctamente. ' ||
                    'ID Inspección: ' || v_ins_id || ', ' ||
                    'Lote: ' || v_lote_nombre || ', ' ||
                    'Ingeniero: ' || v_ingeniero_nombre || ', ' ||
                    'Fecha: ' || TO_CHAR(v_fecha_inspeccion, 'DD/MM/YYYY HH24:MI:SS');
        
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            ROLLBACK;
            p_mensaje := 'ERROR: Ya existe una inspección con los datos especificados';
        WHEN OTHERS THEN
            ROLLBACK;
            p_mensaje := 'ERROR: Error al insertar la inspección - ' || SQLERRM;
    END;
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        p_mensaje := 'ERROR: Error inesperado en el procedimiento - ' || SQLERRM;
        
END pcRegistraInspeccion;
/
