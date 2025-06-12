CREATE OR REPLACE FUNCTION fcActualizaCuota(
    p_cosecha_id IN NUMBER,
    p_porcentaje_aumento IN NUMBER
) RETURN VARCHAR2 IS
    v_count_cosecha NUMBER := 0;
    v_count_asociados NUMBER := 0;
    v_registros_actualizados NUMBER := 0;
    v_cosecha_nombre VARCHAR2(50);
    v_mensaje VARCHAR2(500);
    
BEGIN
    -- Validar que los parámetros obligatorios no sean nulos
    IF p_cosecha_id IS NULL THEN
        RETURN 'ERROR: El ID de cosecha no puede ser nulo';
    END IF;
    
    IF p_porcentaje_aumento IS NULL THEN
        RETURN 'ERROR: El porcentaje de aumento no puede ser nulo';
    END IF;
    
    -- Validar que el porcentaje esté en un rango razonable
    IF p_porcentaje_aumento < -100 THEN
        RETURN 'ERROR: El porcentaje de aumento no puede ser menor a -100%';
    END IF;
    
    IF p_porcentaje_aumento > 1000 THEN
        RETURN 'ERROR: El porcentaje de aumento no puede ser mayor a 1000%';
    END IF;
    
    -- Validar que la cosecha exista
    BEGIN
        SELECT COUNT(cos_id), MAX(cos_nombre)
        INTO v_count_cosecha, v_cosecha_nombre
        FROM dcs_cosecha
        WHERE cos_id = p_cosecha_id;
        
        IF v_count_cosecha = 0 THEN
            RETURN 'ERROR: La cosecha especificada no existe (ID: ' || p_cosecha_id || ')';
        END IF;
        
    EXCEPTION
        WHEN OTHERS THEN
            RETURN 'ERROR: Error al validar la cosecha - ' || SQLERRM;
    END;
    
    -- Contar asociados que tienen cuotas mensuales para actualizar
    BEGIN
        SELECT COUNT(ca.cat_id)
        INTO v_count_asociados
        FROM dcs_categoria_asociado ca
        INNER JOIN dcs_asociado a ON ca.cat_id = a.cat_id
        INNER JOIN dcs_reproduccion r ON a.per_id = r.per_id
        WHERE r.cos_id = p_cosecha_id
        AND ca.cat_monto_cuota_mensual IS NOT NULL
        AND ca.cat_monto_cuota_mensual > 0;
        
        IF v_count_asociados = 0 THEN
            RETURN 'ADVERTENCIA: No se encontraron asociados con cuotas mensuales activas en la cosecha especificada (' || v_cosecha_nombre || ')';
        END IF;
        
    EXCEPTION
        WHEN OTHERS THEN
            RETURN 'ERROR: Error al contar asociados - ' || SQLERRM;
    END;
    
    -- Actualizar las cuotas mensuales de las categorías de asociados involucrados en la cosecha
    BEGIN
        UPDATE dcs_categoria_asociado ca
        SET ca.cat_monto_cuota_mensual = ca.cat_monto_cuota_mensual * (1 + (p_porcentaje_aumento / 100))
        WHERE ca.cat_id IN (
            SELECT DISTINCT a.cat_id
            FROM dcs_asociado a
            INNER JOIN dcs_reproduccion r ON a.per_id = r.per_id
            WHERE r.cos_id = p_cosecha_id
            AND ca.cat_monto_cuota_mensual IS NOT NULL
            AND ca.cat_monto_cuota_mensual > 0
        );
        
        v_registros_actualizados := SQL%ROWCOUNT;
        
        IF v_registros_actualizados = 0 THEN
            ROLLBACK;
            RETURN 'ERROR: No se pudo actualizar ninguna cuota mensual';
        END IF;
        
        -- Confirmar la transacción
        COMMIT;
        
        -- Mensaje de confirmación exitosa
        v_mensaje := 'EXITO: Cuotas actualizadas correctamente. ' ||
                    'Cosecha: ' || v_cosecha_nombre || ', ' ||
                    'Porcentaje aplicado: ' || TO_CHAR(p_porcentaje_aumento, 'FM999,999,990.00') || '%, ' ||
                    'Categorías actualizadas: ' || v_registros_actualizados || ', ' ||
                    'Asociados afectados: ' || v_count_asociados;
        
        RETURN v_mensaje;
        
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RETURN 'ERROR: Error al actualizar las cuotas mensuales - ' || SQLERRM;
    END;
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RETURN 'ERROR: Error inesperado en la función - ' || SQLERRM;
        
END fcActualizaCuota;
/
