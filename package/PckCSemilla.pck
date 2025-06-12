create or replace package PckCSemilla is

  -- Author  : KEVIN
  -- Created : 11/6/2025 21:02:26
  -- Purpose : Paquete para gestión del comité de semillas
  
  -- Funciones públicas
  function fcActualizaCuota(
    p_cosecha_id IN NUMBER,
    p_porcentaje_aumento IN NUMBER
  ) return VARCHAR2;
  
  function fcRegistraAnalisisEnfermedad(
    p_reproduccion_id IN NUMBER,
    p_motivo IN VARCHAR2,
    p_porcentaje_semilla_sana IN NUMBER,
    p_monto IN NUMBER,
    p_enfermedad_id IN NUMBER,
    p_observaciones IN VARCHAR2 DEFAULT NULL
  ) return VARCHAR2;
  
  -- Procedimientos públicos
  procedure pcPagoRealizado(
    p_cedula_asociado IN VARCHAR2,
    p_cosecha_id IN NUMBER,
    p_monto_total OUT NUMBER,
    p_cantidad_total OUT NUMBER,
    p_mensaje OUT VARCHAR2
  );
  
  procedure pcRegistraInspeccion(
    p_lote_id IN NUMBER,
    p_ingeniero_id IN NUMBER,
    p_comentario IN VARCHAR2,
    p_mensaje OUT VARCHAR2
  );
  
  procedure pcRegistraReproduccion(
    p_finca_id IN NUMBER,
    p_lote_id IN NUMBER,
    p_variedad_id IN NUMBER,
    p_cosecha_id IN NUMBER,
    p_fecha_siembra_inicio IN DATE,
    p_fecha_siembra_fin IN DATE,
    p_ingeniero_id IN NUMBER,
    p_mensaje OUT VARCHAR2
  );

end PckCSemilla;
/
create or replace package body PckCSemilla is

  -- Implementación de funciones
  function fcActualizaCuota(
    p_cosecha_id IN NUMBER,
    p_porcentaje_aumento IN NUMBER
  ) return VARCHAR2 IS
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
  
  function fcRegistraAnalisisEnfermedad(
    p_reproduccion_id IN NUMBER,
    p_motivo IN VARCHAR2,
    p_porcentaje_semilla_sana IN NUMBER,
    p_monto IN NUMBER,
    p_enfermedad_id IN NUMBER,
    p_observaciones IN VARCHAR2 DEFAULT NULL
  ) return VARCHAR2 IS
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
  
  -- Implementación de procedimientos
  procedure pcPagoRealizado(
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
  
  procedure pcRegistraInspeccion(
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
  
  procedure pcRegistraReproduccion(
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
            RETURN;
    END;
    
    -- Validar que las fechas de siembra estén dentro del período de la cosecha
    IF p_fecha_siembra_inicio < v_fecha_cosecha_inicio OR p_fecha_siembra_fin > v_fecha_cosecha_fin THEN
        p_mensaje := 'ADVERTENCIA: Las fechas de siembra están fuera del período de la cosecha (' || 
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
             OR (p_fecha_siembra_fin BETWEEN r.rep_fecha_siembra_inicio AND r.rep_fecha_cosecha_fin));
        
        IF v_count_overlap > 0 THEN
            p_mensaje := 'ERROR: Ya existe una reproducción activa en el mismo lote durante el período especificado';
            RETURN;
        END IF;
        
    EXCEPTION
        WHEN OTHERS THEN
            p_mensaje := 'ERROR: Error al verificar solapamiento de reproducciones - ' || SQLERRM;
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
            fin_id,
            lot_id,
            var_id,
            cos_id,
            est_id,
            inge_id
        ) VALUES (
            v_contrato_numero,
            p_fecha_siembra_inicio,
            p_fecha_siembra_fin,
            v_fecha_cosecha_inicio,
            v_fecha_cosecha_fin,
            p_finca_id,
            p_lote_id,
            p_variedad_id,
            p_cosecha_id,
            v_est_activo_id,
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
                    'Ingeniero: ' || v_ingeniero_nombre;
        
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
end PckCSemilla;
/
