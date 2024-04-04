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


/*EJERCIIO 1 - El siguiente código, ¿crees que puede dar error?*/

SET SERVEROUTPUT ON
DECLARE
    Num NUMBER := 5; -- Comentario
/* A continuacion comienza el bloque,
Mediante un BEGIN, y finaliza mediante un END */
BEGIN
    Num := num*2;
    DBMS_OUTPUT.PUT_LINE(Num);
END;


/*Ejercicio 2 - Vamos a sacar el resultado por pantalla.*/

SET SERVEROUTPUT ON
DECLARE
    num NUMBER:=5;
BEGIN
    num := num*2;
    DBMS_OUTPUT.PUT_LINE(num);
END;

/*Ejercicio 3: Hola mundo
Declarar una variable tipo varchar que contenga la cadena “Hola Mundo” y 
en el bloque BEGIN imprimir por consola un mensaje con el contenido de dicha variable.
*/
SET SERVEROUTPUT ON
DECLARE
    frase VARCHAR (100):='Hola Mundo';
BEGIN
    DBMS_OUTPUT.PUT_LINE(frase);
END;

/*Ejercicio 4: SELECT en PL/SQL
Escribir un bloque PL/SQL que busque el producto con el precio más alto, 
guarde el nombre en una variable llamada “v_nombre” e imprima el siguiente mensaje por consola:
El producto más caro es [v_nombre]
*/

SET SERVEROUTPUT ON
DECLARE
    v_nombre varchar(100);
BEGIN
    select max(precio) into v_nombre from producto;
    DBMS_OUTPUT.PUT_LINE('Precio mas Alto: '||v_nombre);
END;


/*Ejercicio 5: Condicionales con IF
Realizar una sentencia SELECT que obtenga el precio de un producto cuyo identificador se pida por consola.
Crear una estructura if donde se compruebe si el precio es superior, inferior o igual a 185€ y 
salga un mensaje por pantalla de la siguiente forma:
El precio del producto es superior/igual/inferior a 185€
*/

SET SERVEROUTPUT ON
DECLARE 
    v_number number;
BEGIN
    select precio into v_number from producto where id=&id;
    if v_number > 185 then 
        DBMS_OUTPUT.PUT_LINE('El precio del producto es superior 185€');
    elsif v_number <185 then
        DBMS_OUTPUT.PUT_LINE('El precio del producto es inferior 185€');
    else DBMS_OUTPUT.PUT_LINE('El precio del producto es igual 185€');
    end if;    
END;

/*Ejercicio 6: Condicionales con CASE
Realizar una sentencia SELECT que obtenga el id de fabricante de un producto 
cuyo identificador se meta por consola. Haciendo uso de una estructura CASE con los id y 
nombre de fabricantes sacar el siguiente mensaje:
El producto v_nombre pertenece al fabricante v_fabricante.
*/

SET SERVEROUTPUT ON
DECLARE
    v_idfabricante number;
    v_nombre varchar (100);
BEGIN
    select id_fabricante, nombre into v_idfabricante, v_nombre from producto where id=&id;
    
    CASE v_idfabricante 
        when 1 then
            DBMS_OUTPUT.PUT_LINE('El producto '||v_nombre||' pertenece al fabricante Asus');
        when 2 then
            DBMS_OUTPUT.PUT_LINE('El producto '||v_nombre||' pertenece al fabricante Lenovo');
        when 3 then
            DBMS_OUTPUT.PUT_LINE('El producto '||v_nombre||' pertenece al fabricante Hewlett-Packard');
        when 4 then
            DBMS_OUTPUT.PUT_LINE('El producto '||v_nombre||' pertenece al fabricante Samsung');
        when 5 then
            DBMS_OUTPUT.PUT_LINE('El producto '||v_nombre||' pertenece al fabricante Seagate');
        when 6 then
            DBMS_OUTPUT.PUT_LINE('El producto '||v_nombre||' pertenece al fabricante Crucial');
        when 7 then
            DBMS_OUTPUT.PUT_LINE('El producto '||v_nombre||' pertenece al fabricante Gigabyte');
        when 8 then
            DBMS_OUTPUT.PUT_LINE('El producto '||v_nombre||' pertenece al fabricante Huawei');
        when 9 then
            DBMS_OUTPUT.PUT_LINE('El producto '||v_nombre||' pertenece al fabricante Xiaomi');
        when 10 then
            DBMS_OUTPUT.PUT_LINE('El producto '||v_nombre||' pertenece al fabricante Amazon');
        ELSE
            DBMS_OUTPUT.PUT_LINE('El producto '||v_nombre||' NO tiene Fabricante');
    end case;
    

END;


/*Ejercicio 8: Bucles con WHILE
Realizar un bucle que vaya consultando todos los productos desde el 1 hasta que 
encuentre un producto sin fabricante. En cada iteración se deberá imprimir el siguiente mensaje:
El producto v_nombre cuesta v_precio€
*/
SET SERVEROUTPUT ON
DECLARE
    v_nombre varchar(100);
    v_precio number;
BEGIN
    
    SELECT 
    
    WHILE DO
    
END;











