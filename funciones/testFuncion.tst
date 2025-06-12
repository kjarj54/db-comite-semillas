PL/SQL Developer Test script 3.0
17
DECLARE
    CURSOR cur_cuotas IS
        SELECT ca.cat_id, ca.cat_descripcion, ca.cat_monto_cuota_mensual,
               COUNT(a.aso_id) as asociados_count
        FROM dcs_categoria_asociado ca
        LEFT JOIN dcs_asociado a ON ca.cat_id = a.cat_id
        GROUP BY ca.cat_id, ca.cat_descripcion, ca.cat_monto_cuota_mensual
        ORDER BY ca.cat_id;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== CUOTAS ACTUALES ANTES DE LAS PRUEBAS ===');
    FOR rec IN cur_cuotas LOOP
        DBMS_OUTPUT.PUT_LINE('Categoría: ' || rec.cat_descripcion || 
                           ', Cuota: ₡' || TO_CHAR(rec.cat_monto_cuota_mensual, '999,999') ||
                           ', Asociados: ' || rec.asociados_count);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');
END;
3
result
0
-5
p_cosecha_id
0
-4
p_porcentaje_aumento
0
-4
0
