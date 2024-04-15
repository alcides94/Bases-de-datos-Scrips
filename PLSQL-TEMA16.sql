/*Ejercicio 1: Creación y uso de registros
Crear un registro que contenga todos los campos de la tabla FABRICANTE.
Crear una variable llamada “nuevo_fabricante”.
Asignar al campo id el máximo +1 de la tabla FABRICANTE.
Asignar al nombre el valor ‘Hitachi’
Imprimir por pantalla el siguiente mensaje:
Nuevo fabricante: [fabricante.nombre] con ID [fabricante.id]
*/
SET SERVEROUTPUT ON
DECLARE
    TYPE V_FABRICANTE IS RECORD (
        ID NUMBER,
        NOMBRE VARCHAR(100)
    );
    
    NUEVO_FABRICANTE V_FABRICANTE;
    
    
BEGIN
    
    SELECT MAX(ID)+1 INTO NUEVO_FABRICANTE.ID FROM FABRICANTE;
    nuevo_fabricante.NOMBRE:='HITACHI';
     DBMS_OUTPUT.PUT_LINE('Nuevo fabricante: '||NUEVO_fabricante.nombre||' con ID '||NUEVO_fabricante.id); 
END;

/*
Ejercicio 2: SELECT/INSERT de registros caso 1
Repetir el ejercicio anterior pero, esta vez, insertar el nuevo fabricante en la tabla FABRICANTE.

*/

SET SERVEROUTPUT ON
DECLARE
    TYPE V_FABRICANTE IS RECORD (
        ID NUMBER,
        NOMBRE VARCHAR(100)
    );
    
    NUEVO_FABRICANTE V_FABRICANTE;
    
    
BEGIN
    
    SELECT MAX(ID)+1 INTO NUEVO_FABRICANTE.ID FROM FABRICANTE;
    nuevo_fabricante.NOMBRE:='HITACHI';
     DBMS_OUTPUT.PUT_LINE('Nuevo fabricante: '||NUEVO_fabricante.nombre||' con ID '||NUEVO_fabricante.id); 
    INSERT INTO FABRICANTE VALUES(NUEVO_FABRICANTE.ID, NUEVO_FABRICANTE.NOMBRE);/*O DIRECTAMENTE PUEDE IR E NOMBRE DE LA TABLA */

END;

/*Ejercicio 3: SELECT/INSERT de registros caso 2
Crear un registro que contenga todos los campos de la tabla PRODUCTO.
Crear una variable llamada “v_producto”.
Coger, de base, los datos del producto 1.
Asignar al campo id el máximo +1 de la tabla PRODUCTO.
Asignar al nombre el valor actual añadiendo, al final, la palabra ‘mejorado’.
Asignar al precio el doble del valor actual.
Insertar el nuevo producto en la tabla.
*/









