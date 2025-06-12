PL/SQL Developer Test script 3.0
39
DECLARE
    resultado VARCHAR2(2000);
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PRUEBA 1: Registro exitoso de análisis de enfermedad ===');
    resultado := fcRegistraAnalisisEnfermedad(
        p_reproduccion_id => 1,
        p_motivo => 'Análisis Roya',
        p_porcentaje_semilla_sana => 75.5,
        p_monto => 45000,
        p_enfermedad_id => 1,
        p_observaciones => 'Se detectó presencia de roya en hojas superiores'
    );
    DBMS_OUTPUT.PUT_LINE('Resultado: ' || resultado);
    DBMS_OUTPUT.PUT_LINE('');
    
    DBMS_OUTPUT.PUT_LINE('=== PRUEBA 2: Error con ID de reproducción inexistente ===');
    resultado := fcRegistraAnalisisEnfermedad(
        p_reproduccion_id => 999,
        p_motivo => 'Análisis Test',
        p_porcentaje_semilla_sana => 80.0,
        p_monto => 35000,
        p_enfermedad_id => 1,
        p_observaciones => 'Prueba con reproducción inexistente'
    );
    DBMS_OUTPUT.PUT_LINE('Resultado: ' || resultado);
    DBMS_OUTPUT.PUT_LINE('');
    
    DBMS_OUTPUT.PUT_LINE('=== PRUEBA 3: Error con ID de enfermedad inexistente ===');
    resultado := fcRegistraAnalisisEnfermedad(
        p_reproduccion_id => 1,
        p_motivo => 'Análisis Test',
        p_porcentaje_semilla_sana => 65.0,
        p_monto => 25000,
        p_enfermedad_id => 999,
        p_observaciones => 'Prueba con enfermedad inexistente'
    );
    DBMS_OUTPUT.PUT_LINE('Resultado: ' || resultado);
    DBMS_OUTPUT.PUT_LINE('');
END;
7
result
0
-5
p_reproduccion_id
0
-4
p_motivo
0
-5
p_porcentaje_semilla_sana
0
-4
p_monto
0
-4
p_enfermedad_id
0
-4
p_observaciones
0
-5
0
