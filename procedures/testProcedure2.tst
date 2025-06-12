PL/SQL Developer Test script 3.0
12
DECLARE
    v_mensaje VARCHAR2(500);
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== TEST 1: Caso exitoso - Lote A1, Ingeniero Luis ===');
    
    pcRegistraInspeccion(1, 1, 'Inspección de prueba - desarrollo normal del cultivo', v_mensaje);
    
    DBMS_OUTPUT.PUT_LINE('Lote ID: 1 (Lote A1)');
    DBMS_OUTPUT.PUT_LINE('Ingeniero ID: 1 (Luis Chacón)');
    DBMS_OUTPUT.PUT_LINE('Mensaje: ' || v_mensaje);
    DBMS_OUTPUT.PUT_LINE('');
END;
4
p_lote_id
0
-4
p_ingeniero_id
0
-4
p_comentario
0
-5
p_mensaje
0
-5
0
