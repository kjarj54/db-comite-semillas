PL/SQL Developer Test script 3.0
21
DECLARE
    v_mensaje VARCHAR2(1000);
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== TEST 1: Caso exitoso - Nueva reproducción ===');
    
    pcRegistraReproduccion(
        1,                              -- p_finca_id (Finca El Cafetal)
        2,                              -- p_lote_id (Lote A2)
        2,                              -- p_variedad_id (Caturra)
        2,                              -- p_cosecha_id (Cosecha 2025-2026)
        DATE '2025-04-15',              -- p_fecha_siembra_inicio
        DATE '2025-05-15',              -- p_fecha_siembra_fin
        1,                              -- p_ingeniero_id (Luis Chacón)
        v_mensaje
    );
    
    DBMS_OUTPUT.PUT_LINE('Finca: El Cafetal, Lote: A2, Variedad: Caturra');
    DBMS_OUTPUT.PUT_LINE('Cosecha: 2025-2026, Ingeniero: Luis Chacón');
    DBMS_OUTPUT.PUT_LINE('Mensaje: ' || v_mensaje);
    DBMS_OUTPUT.PUT_LINE('');
END;
8
p_finca_id
0
-4
p_lote_id
0
-4
p_variedad_id
0
-4
p_cosecha_id
0
-4
p_fecha_siembra_inicio
0
-12
p_fecha_siembra_fin
0
-12
p_ingeniero_id
0
-4
p_mensaje
0
-5
0
