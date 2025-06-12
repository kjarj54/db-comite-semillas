PL/SQL Developer Test script 3.0
17
DECLARE
    v_monto NUMBER;
    v_cantidad NUMBER;
    v_mensaje VARCHAR2(500);
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== TEST 1: Caso exitoso - Carlos Rodríguez ===');
    
    pcPagoRealizado('105470123', 1, v_monto, v_cantidad, v_mensaje);
    
    DBMS_OUTPUT.PUT_LINE('Cédula: 105470123 (Carlos Rodríguez)');
    DBMS_OUTPUT.PUT_LINE('Cosecha ID: 1');
    DBMS_OUTPUT.PUT_LINE('Mensaje: ' || v_mensaje);
    DBMS_OUTPUT.PUT_LINE('Monto Total: ₡' || TO_CHAR(v_monto, '999,999,999.99'));
    DBMS_OUTPUT.PUT_LINE('Cantidad Total: ' || TO_CHAR(v_cantidad, '999,999,999.99') || ' kg');
    DBMS_OUTPUT.PUT_LINE('Cálculo esperado: 850.5 kg × ₡8,500 = ₡7,229,250.00');
    DBMS_OUTPUT.PUT_LINE('');
END;
5
p_cedula_asociado
0
-5
p_cosecha_id
0
-4
p_monto_total
0
-4
p_cantidad_total
0
-4
p_mensaje
0
-5
0
