CREATE OR REPLACE PROCEDURE pcPagoRealizado(
    p_cedula_asociado IN VARCHAR2,
    p_cosecha_id IN NUMBER,
    p_monto_total OUT NUMBER,
    p_cantidad_total OUT NUMBER,
    p_mensaje OUT VARCHAR2
) IS
    v_count_asociado NUMBER := 0;
    v_count_cosecha NUMBER := 0;
    v_count_pagos NUMBER := 0;
    v_persona_id NUMBER;
    
BEGIN
    -- Inicializar variables de salida
    p_monto_total := 0;
    p_cantidad_total := 0;
    p_mensaje := '';
    
    -- Validar que los parámetros de entrada no sean nulos
    IF p_cedula_asociado IS NULL THEN
        p_mensaje := 'ERROR: La cédula del asociado no puede ser nula';
        RETURN;
    END IF;
    
    IF p_cosecha_id IS NULL THEN
        p_mensaje := 'ERROR: El ID de cosecha no puede ser nulo';
        RETURN;
    END IF;
    
    -- Validar que la cosecha exista - usando columnas específicas
    SELECT COUNT(cos_id)
    INTO v_count_cosecha
    FROM dcs_cosecha
    WHERE cos_id = p_cosecha_id;
    
    IF v_count_cosecha = 0 THEN
        p_mensaje := 'ERROR: La cosecha especificada no existe';
        RETURN;
    END IF;
    
    -- Buscar la persona por cédula de forma explícita
    BEGIN
        SELECT pf.per_id
        INTO v_persona_id
        FROM dcs_persona_fisica pf
        WHERE pf.per_identificacion = p_cedula_asociado;
        
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            p_mensaje := 'ERROR: No se encontró una persona con la cédula especificada';
            RETURN;
        WHEN TOO_MANY_ROWS THEN
            p_mensaje := 'ERROR: Se encontraron múltiples personas con la misma cédula';
            RETURN;
    END;
    
    -- Verificar que la persona sea asociado - usando columnas específicas
    SELECT COUNT(aso_id)
    INTO v_count_asociado
    FROM dcs_asociado a
    WHERE a.per_id = v_persona_id;
    
    IF v_count_asociado = 0 THEN
        p_mensaje := 'ERROR: La persona con la cédula especificada no es un asociado';
        RETURN;
    END IF;
    
    -- Verificar que existan pagos para el asociado en la cosecha especificada
    -- Usando columnas específicas en lugar de COUNT(*)
    SELECT COUNT(pp.pag_id)
    INTO v_count_pagos
    FROM dcs_pago_productor pp
    INNER JOIN dcs_producto pr ON pp.pro_id = pr.pro_id
    INNER JOIN dcs_reproduccion r ON pr.rep_id = r.rep_id
    WHERE pp.per_id = v_persona_id
    AND r.cos_id = p_cosecha_id;
    
    IF v_count_pagos = 0 THEN
        p_mensaje := 'ADVERTENCIA: No se encontraron pagos para el asociado en la cosecha especificada';
        RETURN;
    END IF;
    
    -- Calcular el monto total y la cantidad total de forma explícita
    BEGIN
        SELECT 
            CASE 
                WHEN SUM(pp.pag_cantidad * pp.pag_precio_unitario) IS NULL THEN 0
                ELSE SUM(pp.pag_cantidad * pp.pag_precio_unitario) 
            END,
            CASE 
                WHEN SUM(pp.pag_cantidad) IS NULL THEN 0
                ELSE SUM(pp.pag_cantidad) 
            END
        INTO 
            p_monto_total,
            p_cantidad_total
        FROM dcs_pago_productor pp
        INNER JOIN dcs_producto pr ON pp.pro_id = pr.pro_id
        INNER JOIN dcs_reproduccion r ON pr.rep_id = r.rep_id
        WHERE pp.per_id = v_persona_id
        AND r.cos_id = p_cosecha_id;
        
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            p_monto_total := 0;
            p_cantidad_total := 0;
    END;
    
    -- Mensaje de confirmación
    p_mensaje := 'EXITO: Consulta realizada correctamente. Monto total: ' || 
                TO_CHAR(p_monto_total, 'FM999,999,999,990.00') || 
                ', Cantidad total: ' || TO_CHAR(p_cantidad_total, 'FM999,999,999,990.00');
    
EXCEPTION
    WHEN OTHERS THEN
        p_monto_total := 0;
        p_cantidad_total := 0;
        p_mensaje := 'ERROR: Error inesperado - ' || SQLERRM;
        
END pcPagoRealizado;
/