
DROP TABLE fabricante CASCADE CONSTRAINTS;
DROP TABLE producto CASCADE CONSTRAINTS;
DROP TABLE reposicion CASCADE CONSTRAINTS;


CREATE TABLE fabricante (
  id INT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
);


INSERT INTO fabricante VALUES(1, 'Asus');
INSERT INTO fabricante VALUES(2, 'Lenovo');
INSERT INTO fabricante VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricante VALUES(4, 'Samsung');
INSERT INTO fabricante VALUES(5, 'Seagate');
INSERT INTO fabricante VALUES(6, 'Crucial');
INSERT INTO fabricante VALUES(7, 'Gigabyte');
INSERT INTO fabricante VALUES(8, 'Huawei');
INSERT INTO fabricante VALUES(9, 'Xiaomi');
INSERT INTO fabricante VALUES (10, 'Amazon');
INSERT INTO fabricante VALUES (11, 'Hitachi');


CREATE TABLE producto (
  id INT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  precio NUMBER NOT NULL,
  id_fabricante INT,
  FOREIGN KEY (id_fabricante) REFERENCES fabricante(id)
);


INSERT INTO producto VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO producto VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO producto VALUES(3, 'Disco SSD 1 TB', 49.99, 4);
INSERT INTO producto VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO producto VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT INTO producto VALUES(9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO producto VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);
INSERT INTO producto VALUES(12, 'Raton Optico', 20, NULL);
INSERT INTO producto VALUES (13, 'Alexa Echo Dot', 69.99, 10);
INSERT INTO producto VALUES (14, 'ThinkPad E16 Gen 1', 943.49, 2);
INSERT INTO producto VALUES (15, 'Disco duro SATA3 1TB mejorado', 173.98, 5);


CREATE TABLE reposicion(
  id_reposicion INT PRIMARY KEY,
  id_producto INT NOT NULL,
  unidades INT DEFAULT(0),
  fecha DATE,
  CONSTRAINT FK_ReposicionProducto FOREIGN KEY
  (id_producto) REFERENCES producto(id)
);


INSERT INTO reposicion VALUES(1, 1, 2, '25/01/2023');
INSERT INTO reposicion VALUES(2, 2, 5, '15/08/2005');
INSERT INTO reposicion VALUES(3, 3, 3, '20/04/2010');
INSERT INTO reposicion VALUES(4, 4, 1, '03/11/2015');
INSERT INTO reposicion VALUES(5, 5, 2, '10/02/2003');
INSERT INTO reposicion VALUES(6, 6, 4, '28/06/2018');
INSERT INTO reposicion VALUES(7, 7, 3, '15/09/2009');
INSERT INTO reposicion VALUES(8, 8, 6, '22/07/2012');
INSERT INTO reposicion VALUES(9, 9, 8, '08/10/2017');
INSERT INTO reposicion VALUES(10, 10, 10, '17/12/2006');
INSERT INTO reposicion VALUES(11, 11, 2, '05/01/2022');
INSERT INTO reposicion VALUES(12, 2, 3, '10/04/2002');
INSERT INTO reposicion VALUES(13, 3, 6, '01/09/2018');
INSERT INTO reposicion VALUES(14, 4, 2, '12/11/2007');
INSERT INTO reposicion VALUES(15, 5, 4, '25/02/2013');
INSERT INTO reposicion VALUES(16, 6, 1, '18/07/2004');
INSERT INTO reposicion VALUES(17, 7, 5, '30/10/2010');
INSERT INTO reposicion VALUES(18, 8, 7, '05/06/2015');
INSERT INTO reposicion VALUES(19, 9, 9, '22/12/2006');
INSERT INTO reposicion VALUES(20, 10, 2, '08/03/2021');
INSERT INTO reposicion VALUES(21, 11, 8, '14/08/2009');
INSERT INTO reposicion VALUES(22, 1, 2, '08/03/2024');
INSERT INTO reposicion VALUES(23, 11, 8, '02/01/2022');


/*
Ejercicio 1: Creación y uso de procedimientos
Definir un procedimiento donde se reciba una id de producto por parámetro, 
consulte el precio de dicho producto en la tabla PRODUCTO y lo imprima por pantalla.
Declarar un bloque donde se invoque dicho procedimiento pasándole una id que pertenezca a la tabla.
*/

CREATE OR REPLACE PROCEDURE buscadorNombre (ID_PRO NUMBER)
IS
    V_nombre varchar (100);
BEGIN
    SELECT NOMBRE INTO V_NOMBRE FROM PRODUCTO WHERE ID=ID_PRO;
    DBMS_OUTPUT.PUT_LINE('El producto '||v_nombre);
END BUSCADORNOMBRE;

SET SERVEROUTPUT ON
DECLARE
BEGIN 
    
    BUSCADORNOMBRE(&ID_PRO);
    
END;

/*Ejercicio 2: Creación y uso de funciones
Definir una función que reciba una id de producto, consulte la tabla PRODUCTO y 
devuelva una variable con todos los datos de dicho producto.
Declarar un bloque donde se invoque dicha función.
Imprimir por pantalla todos los datos de dicho producto.
*/

CREATE OR REPLACE FUNCTION DATOS (ID_PRO NUMBER)
RETURN PRODUCTO%ROWTYPE
IS
V_DATOS PRODUCTO%ROWTYPE;
BEGIN
    SELECT * INTO V_DATOS FROM PRODUCTO WHERE ID=ID_PRO;
    RETURN V_DATOS;
END DATOS;

SET SERVEROUTPUT ON
DECLARE
    VA_DATOS PRODUCTO%ROWTYPE;
BEGIN 
    VA_DATOS:=DATOS(&ID_PRO);
    DBMS_OUTPUT.PUT_LINE('El producto '||VA_DATOS.NOMBRE);
END;



/*Ejercicio 3:  Creación y uso de funciones caso 2
Crear una función que devuelva si un precio introducido como parámetro es superior 
o no al precio medio de todos los productos.
Crear un bloque de código con un cursor que recorre, en bucle, toda la tabla PRODUCTO 
y vaya comprobando, producto a producto, si su precio es superior a la media o no. 
En cada iteración del bucle se deberá imprimir el siguiente mensaje (si aplica):
El producto [nombre] cuesta más que la media
*/

CREATE OR REPLACE FUNCTION DATOSPRECIO (PRECIO NUMBER)
RETURN BOOLEAN
IS 
    MEDIA NUMBER;
    V_DATOS BOOLEAN:=FALSE;
BEGIN
    SELECT AVG(PRECIO) INTO MEDIA FROM PRODUCTO;
    IF (PRECIO > MEDIA) THEN
        V_DATOS:=TRUE;
    END IF;
    RETURN V_DATOS;
END DATOSPRECIO;

DECLARE
    DATOS BOOLEAN;  
    CURSOR cursor_productos IS SELECT * FROM producto;
    V_PRODUCTO PRODUCTO%ROWTYPE;
BEGIN
    
    OPEN CURSOR_PRODUCTOS; 
    LOOP
        FETCH CURSOR_PRODUCTOS INTO V_PRODUCTO;
        EXIT WHEN (CURSOR_PRODUCTOS%NOTFOUND);
        IF (DATOSPRECIO(V_PRODUCTO.PRECIO))THEN
            DBMS_OUTPUT.PUT_LINE('EL PRODUCTO: '||V_PRODUCTO.NOMBRE||' ES SUPERIROR A LA MEDIA');
        END IF;
    END LOOP;    
    CLOSE CURSOR_PRODUCTOS;
   
END;

/*
Ejercicio 4: Creación y uso de disparadores
Crear una tabla auditoria_producto con 4 campos:
id NUMBER
precio_ant NUMBER
precio_nue NUMBER
fecha DATE
Crear un disparador que actúe antes de un update en la tabla “producto”.
El disparador deberá comprobar si se actualiza el campo precio.
En ese caso deberá insertar los datos correspondientes en la nueva tabla.
*/
DROP TABLE auditoria_producto;
CREATE TABLE auditoria_producto (
id INT,
precio_ant NUMBER,
precio_nue NUMBER,
fecha DATE,
PRIMARY KEY(id,precio_ant,fecha)
);

CREATE OR REPLACE TRIGGER check_nuevo_precio
    BEFORE UPDATE OF precio ON producto
    FOR EACH ROW
BEGIN
    INSERT INTO auditoria_producto
    VALUES (:OLD.id, :OLD.precio, :NEW.precio, SYSDATE);
END;

UPDATE producto SET precio = precio * 2 WHERE id = 1;
/* Devolver precio original */
UPDATE producto SET precio = precio / 2 WHERE id = 1;


/******************************bateria de ejercicios********************/

/*
Crear una función que devuelva el factorial de un número que se pase como parámetro. Crear un bloque de código para probarlo.
*/

CREATE OR REPLACE FUNCTION FACTOR (NUMERO NUMBER)
RETURN NUMBER
IS 
    FACTORIAL NUMBER:=1;
BEGIN
    FOR I IN 1..NUMERO LOOP
        FACTORIAL:=FACTORIAL*I;
    END LOOP;   
    RETURN FACTORIAL;
END FACTOR;

DECLARE 
   
BEGIN
   
     DBMS_OUTPUT.PUT_LINE(FACTOR(&NUMERO));

END;

/* 17.5.2. Crear una funcion, calculadora, que realice una operacion
con dos numeros y devuelva su resultado. Tendra como parametro de entrada
ambos numeros y un tercer parametro con un numero del
1. al 4 que indicara la operacion
a realizar:
1. Suma
2. Resta
3. Multiplicacion
4. Division
Se debera controlar que no se divide por 0, en ese caso devolver un 0.
Crear un bloque de código, que coja 2 numeros por teclado, para probarlo
*/

CREATE OR REPLACE FUNCTION CALCULADORA (NUM1 NUMBER, NUM2 NUMBER, OP NUMBER)
RETURN NUMBER
IS 
OPERACION NUMBER;
BEGIN
    IF (OP=1) THEN
        OPERACION:=NUM1+NUM2;
    ELSIF (OP=2)THEN
        OPERACION :=NUM1 -NUM2;
    ELSIF (OP=3) THEN
        OPERACION :=NUM1*NUM2;
    ELSE
        OPERACION :=NUM1/NUM2;
    END IF;
    
    RETURN OPERACION;

END;

DECLARE
BEGIN
    DBMS_OUTPUT.PUT_LINE(CALCULADORA(&NUM1,&NUM2,&OP));
END;

/* 17.5.3. Crear una funcion que reciba una cadena de texto y la
devuelva al reves. Crear un bloque de código para probarlo */

CREATE OR REPLACE FUNCTION sacar_de_fecha (fecha DATE, elemento VARCHAR2)
RETURN NUMBER
IS
resultado NUMBER := 0;
BEGIN
CASE (elemento)
WHEN 'dia' THEN
resultado := SUBSTR(fecha,1,2);
WHEN 'mes' THEN
resultado := SUBSTR(fecha,4,2);
WHEN 'anio' THEN
resultado := SUBSTR(fecha,7,2);
ELSE
DBMS_OUTPUT.PUT_LINE('Elemento indicado no existe');
END CASE;
RETURN resultado;
END sacar_de_fecha;
SET SERVEROUTPUT ON
DECLARE
fecha DATE := '&fecha';
BEGIN
DBMS_OUTPUT.PUT_LINE('Fecha: ' || fecha);
DBMS_OUTPUT.PUT_LINE('Dia: ' || sacar_de_fecha(fecha,'dia'));
DBMS_OUTPUT.PUT_LINE('Mes: ' || sacar_de_fecha(fecha,'mes'));
DBMS_OUTPUT.PUT_LINE('Anio: ' || sacar_de_fecha(fecha,'anio'));
END;















