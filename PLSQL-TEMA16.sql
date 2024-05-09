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
SET SERVEROUTPUT ON

DECLARE
    TYPE R_PRODUCTO IS RECORD (
        ID NUMBER,
        NOMBRE VARCHAR (100),
        PRECIO NUMBER,
        ID_FABRICANTE NUMBER
    );

    V_PRODUCTO R_PRODUCTO;
BEGIN
    SELECT *
            INTO V_PRODUCTO
    FROM PRODUCTO WHERE ID=1;
    SELECT MAX(ID)+1 INTO V_PRODUCTO.ID  FROM PRODUCTO; 
    V_PRODUCTO.NOMBRE:=V_PRODUCTO.NOMBRE||'MEJORADO';
    V_PRODUCTO.PRECIO:=V_PRODUCTO.PRECIO*2;
   
    DBMS_OUTPUT.PUT_LINE(V_PRODUCTO.ID);
    DBMS_OUTPUT.PUT_LINE(V_PRODUCTO.NOMBRE);
    DBMS_OUTPUT.PUT_LINE(V_PRODUCTO.PRECIO);
    
    INSERT INTO PRODUCTO VALUES V_PRODUCTO;

END;

/*
Ejercicio 4: VARRAY con tipos complejos
Definir un array, de un tipo que contenga todos los campos de la tabla PRODUCTO, con 100 espacios pero sin rellenar.
Rellenar, en un bucle, el nuevo array con todos los elementos de la tabla. 
En dicho bucle se deberá fijar el límite de iteraciones con el total de elementos de la tabla.
Mostrar el siguiente mensaje por cada producto:
El producto [nombre] cuesta [precio]€
*/

DECLARE
/*SE DECLARA EL ARRAY*/
    TYPE A_PRODUCTO IS VARRAY (100) OF PRODUCTO%ROWTYPE;
/*SE INICIALIZA CON EL CONSTRUCTOR VACIO*/
    PRODUCTOS A_PRODUCTO:=A_PRODUCTO();
    CONTADO NUMBER;
BEGIN
    SELECT COUNT (*) INTO CONTADO FROM PRODUCTO;
    
    FOR I IN 1..CONTADO LOOP
        PRODUCTOS.EXTEND();
        SELECT * INTO PRODUCTOS(I) FROM PRODUCTO WHERE ID=I;
        DBMS_OUTPUT.PUT_LINE('El producto ' || productos(i).nombre ||
        ' cuesta ' || productos(i).precio || '€');
    END LOOP;
    
END;

/*Ejercicio 5: Tablas Anidadas (listas)
Repetir ejercicio 4 pero con tablas anidadas.
*/

DECLARE
    TYPE A_PRODUCTO IS TABLE OF PRODUCTO%ROWTYPE;
    PRODUCTOS A_PRODUCTO:=A_PRODUCTO();
    CONTADOR NUMBER;
BEGIN
    SELECT COUNT (*) INTO CONTADOR FROM PRODUCTO;
    FOR I IN 1..CONTADOR LOOP
        PRODUCTOS.EXTEND();
        SELECT * INTO PRODUCTOS(I) FROM PRODUCTO WHERE ID=I;
        DBMS_OUTPUT.PUT_LINE('PRODUCTO'||PRODUCTOS(I).NOMBRE||' CUESTA '||PRODUCTOS(I).PRECIO);
    END LOOP;
    
END;

/*Ejercicio 6: Cursores
Definir un cursor “cursor_fabricantes” donde se realice una consulta de todos los fabricantes.
Abrir el cursor y realizar fetch en bucle imprimiendo el siguiente mensaje por cada iteración:
El fabricante [id] es [nombre]
La condición para romper el bucle es que el FETCH no devuelve resultado.
*/

DECLARE 
    CURSOR C_FABRICANTES IS SELECT * FROM FABRICANTE;
    
    V_FABRICANTE FABRICANTE%ROWTYPE;
    
BEGIN 
    
    OPEN C_FABRICANTES;
    LOOP
        FETCH C_FABRICANTES INTO V_FABRICANTE;
        
        EXIT WHEN (C_FABRICANTES%NOTFOUND);
        DBMS_OUTPUT.PUT_LINE('El fabricante ' || V_fabricante.id ||
                            ' es ' || v_fabricante.nombre);
    END LOOP;
    CLOSE C_FABRICANTES;
    
    
END;

/*Hacer uso de la cláusula %TYPE para definir un registro llamado “registro_reposicion”,
que contenga todos los campos de la tabla REPOSICION, del que se definirá una variable llamada “info_reposicion”.
Recorrer en bucle la tabla REPOSICION y, haciendo uso de la variable “info_reposicion” ir imprimiendo por pantalla el siguiente mensaje:
En la reposicion [id], con fecha [fecha], se repusieron [unidades] unidades del producto de código [id_producto]
*/

DECLARE
    TYPE REGISTRO_REPOSICION IS RECORD(
        ID_REPOSICION REPOSICION.ID_REPOSICION%TYPE,
        ID_PRODUCTO REPOSICION.ID_PRODUCTO%TYPE,
        UNIDADES REPOSICION.UNIDADES%TYPE,
        FECHA REPOSICION.FECHA%TYPE
    );
    INFO_REPOSICION REGISTRO_REPOSICION;
    CONTADOR NUMBER;
BEGIN 
    SELECT COUNT (*) INTO CONTADOR FROM REPOSICION;
    
    FOR I IN 1..CONTADOR LOOP
        SELECT * INTO INFO_REPOSICION FROM REPOSICION WHERE ID_REPOSICION=I;
        
        DBMS_OUTPUT.PUT_LINE('En la reposicion'||INFO_REPOSICION.ID_REPOSICION||', con fecha '||INFO_REPOSICION.FECHA||', 
        se repusieron '||INFO_REPOSICION.UNIDADES||' unidades del producto de código '||INFO_REPOSICION.ID_PRODUCTO);
    END LOOP;
END;

/*Repetir el ejercicio anterior pero añadir una consulta dentro del bucle donde se obtenga el nombre de cada producto.
El mensaje quedaría de la siguiente forma:
En la reposicion [id], con fecha [fecha], se repusieron [unidades] unidades del producto [producto.nombre]
*/

DECLARE
    TYPE REGISTRO_REPOSICION IS RECORD(
        ID_REPOSICION REPOSICION.ID_REPOSICION%TYPE,
        ID_PRODUCTO REPOSICION.ID_PRODUCTO%TYPE,
        UNIDADES REPOSICION.UNIDADES%TYPE,
        FECHA REPOSICION.FECHA%TYPE
    );
    INFO_REPOSICION REGISTRO_REPOSICION;
    INFO_NOMBRE PRODUCTO.NOMBRE%TYPE;
    CONTADOR NUMBER;
BEGIN 
    SELECT COUNT (*) INTO CONTADOR FROM REPOSICION;
    
    FOR I IN 1..CONTADOR LOOP
        SELECT * INTO INFO_REPOSICION FROM REPOSICION WHERE ID_REPOSICION=I;
        SELECT NOMBRE INTO INFO_NOMBRE FROM PRODUCTO WHERE ID=INFO_REPOSICION.ID_PRODUCTO;
        DBMS_OUTPUT.PUT_LINE('En la reposicion'||INFO_REPOSICION.ID_REPOSICION||', con fecha '||INFO_REPOSICION.FECHA||', 
        se repusieron '||INFO_REPOSICION.UNIDADES||' unidades del producto de código '||INFO_REPOSICION.ID_PRODUCTO
        ||' NOMBRE '||INFO_NOMBRE);
    END LOOP;
END;

/*Declara un VARRAY llamado "mi_varray" que pueda contener hasta 5 números enteros.
Pedir 5 números por consola e insertarlos en el VARRAY. Luego recorre el VARRAY en bucle para mostrar todos los elementos.
*/

DECLARE
    TYPE MI_VARRAY IS VARRAY (5) OF NUMBER;
    NUMEROS MI_VARRAY:=MI_VARRAY(&A,&B,&C,&D,&E);
BEGIN
    
    FOR I IN 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE(NUMEROS(I));
    END LOOP;
    
    
END;

/*Definir un VARRAY de tipo number, llamada “numbers_type”, con un tamaño límite de 10.
Definir una variable del tipo “numbers_type”.
Crear un bucle (da igual cual sea) para realizar 15 iteraciones 
donde se insertarán en el array los 15 primeros números de la sucesión de Fibonacci, empezando por 0. 
Se podrá hacer uso de tantas variables como sea necesario.
Crear otro bucle donde se imprima el contenido del array haciendo uso de 
funciones del array para fijar el inicio y fin de dicho bucle.
*/

DECLARE
    TYPE NUMBERS_TYPE IS VARRAY (10) OF NUMBER;
     FIBO NUMBERS_TYPE:=NUMBERS_TYPE();
    A NUMBER:=0;
    B NUMBER:=1;
    F NUMBER:=0;
BEGIN 
    FOR I IN 2..15 LOOP
        F:=A+B;
        A:=B;
        B:=F;
      
        DBMS_OUTPUT.PUT_LINE(F);
    END LOOP;
    
END;







