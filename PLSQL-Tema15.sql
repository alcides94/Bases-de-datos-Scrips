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
    v_id_fabricante number;
    v_id number:=1;
BEGIN
/**
Para recorrer el while tengo que prestar atencion en un contador para ir registro por registro
*/
    SELECT id_fabricante, nombre, precio into v_id_fabricante, v_nombre, v_precio from producto where id=v_id;
    WHILE (v_id_fabricante is not null) LOOP
        DBMS_OUTPUT.PUT_LINE('El producto '||v_nombre||' su precio es: '||v_precio);
        v_id:=v_id+1;
        SELECT id_fabricante, nombre, precio into v_id_fabricante, v_nombre, v_precio from producto where id=v_id;
    END LOOP;
    
END;

/*
Ejercicio 9: Bucles con FOR
Realizar un bucle que vaya consultando todos los productos desde el 1 hasta el 14 e imprimir el siguiente mensaje:
El producto v_nombre cuesta v_precio€

*/
SET SERVEROUTPUT ON
DECLARE
    v_nombre varchar(100);
    v_precio number;
    v_id number:=1;
BEGIN
    
    FOR v_id IN 1..9 LOOP
        SELECT NOMBRE, PRECIO INTO V_NOMBRE, V_PRECIO FROM PRODUCTO WHERE ID=V_ID;
        DBMS_OUTPUT.PUT_LINE('El producto '||v_nombre||' su precio es: '||v_precio);
    END LOOP;
    
    
END;


/*
Ejercicio 10: Bucle sencillo LOOP
Repetir ejercicio 15.8 con un bucle sencillo LOOP.
Realizar un bucle que vaya consultando todos los productos desde el 1 hasta que 
encuentre un producto sin fabricante. En cada iteración se deberá imprimir el siguiente mensaje:
El producto v_nombre cuesta v_precio€
*/
SET SERVEROUTPUT ON
DECLARE
    v_nombre varchar(100);
    v_precio number;
    v_id_fabricante number;
    v_id number:=1;
BEGIN

/*-----------------------BATERIA DE EJERCICIOS -----------------------*/


/**
Para recorrer el while tengo que prestar atencion en un contador para ir registro por registro
*/
    SELECT id_fabricante, nombre, precio into v_id_fabricante, v_nombre, v_precio from producto where id=v_id;
    LOOP
        DBMS_OUTPUT.PUT_LINE('El producto '||v_nombre||' su precio es: '||v_precio);
        v_id:=v_id+1;
        SELECT id_fabricante, nombre, precio into v_id_fabricante, v_nombre, v_precio from producto where id=v_id;
        IF V_ID_FABRICANTE IS NULL THEN 
            EXIT;
        END IF;
        
    END LOOP;
    
END;

/*
Declarar una variable ‘a’ y una variable ‘b’. Ambas numéricas y constantes con valores 10 y 20 respectivamente.
Sumar ambos valores en una variable llamada “result” y sacarla por consola.
Sacar por consola el valor más alto de las dos variables, usando una estructura IF.

*/
SET SERVEROUTPUT ON
DECLARE
    a number :=10;
    b number :=20;
    reult number:=0;
BEGIN
    reult:=a+b;
    DBMS_OUTPUT.PUT_LINE(reult);
    if  (a>b)then
        DBMS_OUTPUT.PUT_LINE(' a es mayor que b');
    elsif(b>a) then 
        DBMS_OUTPUT.PUT_LINE(' b es mayor que a');
    else
        DBMS_OUTPUT.PUT_LINE('tienen el mismo valor');
    end if;
END;

/*Solicita dos números por pantalla. Muestra por consola la suma, la resta,
la multiplicación, la potencia y la división de ambos números. Usa la siguiente plantilla:
La suma de __ y __ es:
La resta de __ y __ es:
La multiplicación de __ y __ es:
El cociente de __ entre __ da:
*/

SET SERVEROUTPUT ON
DECLARE
    num1 number:=&num1;
    num2 number:=&num2;
    suma number;
    resta number;
    divi number;
    multi number;

BEGIN
    
    suma:=num1+num2;
    resta:=num1-num2;
    divi:=num1/num2;
    multi:=num1*num2;
    
    /*SI O SI ENTRE PARENTESIS SINO SE PONE LA VARIABLE*/
        
    DBMS_OUTPUT.PUT_LINE('La suma de '||num1||' y '||num2||' es: '||suma);
    DBMS_OUTPUT.PUT_LINE('La resta de '||num1||' y '||num2||' es:'||resta);
    DBMS_OUTPUT.PUT_LINE('La multiplicación de '||num1||' y '||num2||'  es:'||multi);
    DBMS_OUTPUT.PUT_LINE('El cociente de '||num1||'  entre'||num2||'da:'||divi);
END;

/*Crea un algoritmo que calcule la media de 5 números que se le pasan por pantalla.*/

SET SERVEROUTPUT ON
DECLARE
    num1 number:=&num1;
    num2 number:=&num2;
    num3 number:=&num3;
    num4 number:=&num4;
    num5 number:=&num5;
BEGIN
     DBMS_OUTPUT.PUT_LINE('La media de los numeros '||num1||' - '||num2||'
     - '||num3||' - '||num4||' - '||num5||' es: '||((num1+num2+num3+num4+num5)/5));
   
END;


/*
Pedir por teclado un número entero de 4 cifras.
Devolver un mensaje si el número tiene más o menos de 4 cifras.
Mostrar cada una de sus cifras (una debajo de otra).
Crear un nuevo número con las cifras del primero pero al revés.
*/
SET SERVEROUTPUT ON
DECLARE
    numero number:=&num1;
BEGIN
    
 /*   DBMS_OUTPUT.PUT_LINE('Devolver un mensaje si el número tiene más o menos de 4 cifras.');*/
    IF (numero <= 999 OR numero >= 10000) THEN
        DBMS_OUTPUT.PUT_LINE('Numero incorrecto');
        ELSE
        DBMS_OUTPUT.PUT_LINE('Unidades: ' || SUBSTR(numero,4));
        DBMS_OUTPUT.PUT_LINE('Decenas: ' || SUBSTR(numero,3,1));
        DBMS_OUTPUT.PUT_LINE('Centenas: ' || SUBSTR(numero,2,1));
        DBMS_OUTPUT.PUT_LINE('Unidades de millar: ' || SUBSTR(numero,1,1));
        DBMS_OUTPUT.PUT_LINE('Numero al rev s: ' || SUBSTR(numero,4)
        || SUBSTR(numero,3,1) || SUBSTR(numero,2,1) || SUBSTR(numero,1,1));
    END IF;
    
END;

/*OTRA OPCION*/

SET SERVEROUTPUT ON
DECLARE
    numero number:=&num1;
    numero_total number:=4;
    reserv number;

BEGIN
    
 /*   DBMS_OUTPUT.PUT_LINE('Devolver un mensaje si el número tiene más o menos de 4 cifras.');*/
    IF (length(numero)<>numero_total) THEN
        DBMS_OUTPUT.PUT_LINE('Numero incorrecto');
        ELSE
        FOR i in  1..numero_total LOOP
            DBMS_OUTPUT.PUT_LINE('Unidades: ' || SUBSTR(numero,i,1));
            reserv:=SUBSTR(numero,i,1)||reserv;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('Numero al reves: '||reserv);
    END IF;
    
END;

/*Solicitar que el usuario introduzca una clave dos veces. 
Mostrar un mensaje indicando si las claves son iguales o si son diferentes.
*/

SET SERVEROUTPUT ON
DECLARE
    clave1 constant number:=&clave1;
    clave2 constant number:=&clave2;
BEGIN
    
 /*   DBMS_OUTPUT.PUT_LINE('Devolver un mensaje si el número tiene más o menos de 4 cifras.');*/
    IF (clave1=clave2) THEN
        DBMS_OUTPUT.PUT_LINE('Las Claves son iguales');
        ELSE
        
            DBMS_OUTPUT.PUT_LINE('Las claves son diferentes ');
     
    END IF;
    
END;

/*
Realiza un programa que dada una cantidad de dinero en Euros, realice un desglose en billetes y monedas. Ej:

Los billetes disponibles son de 500, 200, 100, 50, 20, 10 y 5€ y las monedas de 2 y 1€.

    */
    SET SERVEROUTPUT ON
    DECLARE
        DINERO NUMBER:=&DINERO;
        QUIN NUMBER:=0;
        DOSC NUMBER:=0;
        CIEN NUMBER:=0;
        CIN NUMBER:=0;
        VEI NUMBER:=0;
        DIE NUMBER:=0;
        CINCO NUMBER:=0;
        DOS NUMBER:=0;
        UNO NUMBER:=0;
    BEGIN
        
        WHILE (DINERO>0) LOOP     
            IF (DINERO>=500) THEN
                DINERO:=DINERO-500;
                QUIN:=QUIN+1;
            ELSIF (DINERO>=200) THEN
                DINERO:=DINERO-200;
                DOSC:=DOSC+1;
            ELSIF (DINERO>=100) THEN
                DINERO:=DINERO-100;
                CIEN:=CIEN+1;
            ELSIF (DINERO>=50) THEN
                DINERO:=DINERO-50;
                CIN:=CIN+1;
            ELSIF (DINERO>=20) THEN
                DINERO:=DINERO-20;
                VEI:=VEI+1;
            ELSIF (DINERO>=10) THEN
                DINERO:=DINERO-10;
                DIE:=DIE+1;
            ELSIF (DINERO>=5) THEN
                DINERO:=DINERO-5;
                CINCO:=CINCO+1;
            ELSIF (DINERO>=2) THEN
                DINERO:=DINERO-2;
                DOS:=DOS+1;
            ELSIF (DINERO>=1) THEN
                DINERO:=DINERO-1;
                UNO:=UNO+1;
            END IF;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('EL DESCGLOSE OBTENIDO ES: ');
        DBMS_OUTPUT.PUT_LINE(QUIN||' BILLETES DE 500');
        DBMS_OUTPUT.PUT_LINE(DOSC||' BILLETES DE 200');
        DBMS_OUTPUT.PUT_LINE(CIEN||' BILLETES DE 100');
        DBMS_OUTPUT.PUT_LINE(CIN|| ' BILLETES DE 50');
        DBMS_OUTPUT.PUT_LINE(VEI||' BILLETES DE 20');
        DBMS_OUTPUT.PUT_LINE(DIE||' BILLETES DE 10');
        DBMS_OUTPUT.PUT_LINE(CINCO||' BILLETES DE 5');
        DBMS_OUTPUT.PUT_LINE(DOS ||' MONEDAS DE 2');
        DBMS_OUTPUT.PUT_LINE(UNO ||' MONEDAS DE 1');
END;
    
/*Escribe un programa que lea de teclado 2 números enteros y saque en pantalla todos los números que estén entre ellos.*/
 SET SERVEROUTPUT ON
 DECLARE
    NUM1 NUMBER:=&NUM1;
    NUM2 NUMBER:=&NUM2;
 BEGIN
    IF (NUM1<=NUM2)THEN
        FOR I IN NUM1..NUM2 LOOP
            DBMS_OUTPUT.PUT_LINE(I);
        END LOOP;
    ELSE 
        FOR I IN NUM2..NUM1 LOOP
            DBMS_OUTPUT.PUT_LINE(I);
        END LOOP;
    END IF;    
 END;
 
 /*Modifica el ejercicio 7 para que solo escriba en pantalla los números pares del intervalo
*/
 SET SERVEROUTPUT ON
 DECLARE
    NUM1 NUMBER:=&NUM1;
    NUM2 NUMBER:=&NUM2;
 BEGIN
    IF (NUM1<=NUM2)THEN
        FOR I IN NUM1..NUM2 LOOP
            IF (MOD (I,2)=0)THEN 
                DBMS_OUTPUT.PUT_LINE(I);
            END IF;    
        END LOOP;
    ELSE 
        FOR I IN NUM2..NUM1 LOOP
            IF (MOD (I,2)=0)THEN 
                DBMS_OUTPUT.PUT_LINE(I);
            END IF;
        END LOOP;
    END IF;    
 END;

/*Diseña un algoritmo que calcule el factorial de un número pedido por teclado. 
El factorial de un número es la multiplicación desde el 1 hasta ese número.*/

DECLARE
    NUM1 NUMBER :=&NUM1;
    FACTORIAL NUMBER:=1;
BEGIN
    FOR I IN 1..NUM1 LOOP
        FACTORIAL:=FACTORIAL*I;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('EL FACTORIAL DE '||NUM1||' ES: ' ||FACTORIAL);
END;


/*
Realizar una sentencia SELECT que obtenga el nombre del producto con identificador 5 
y lo asigne a una variable llamada “v_nombre”. Sacar el nombre por consola.
*/    

DECLARE
    V_NOMBRE VARCHAR(100);
BEGIN 
    SELECT NOMBRE INTO V_NOMBRE FROM PRODUCTO WHERE ID=5;
    DBMS_OUTPUT.PUT_LINE(V_NOMBRE);
END;


/*
Realizar una búsqueda de productos según un identificador que se introduzca por pantalla. 
Sacar su nombre y el nombre de su fabricante. Se deberá imprimir un mensaje:
El producto v_nombre pertenece al fabricante v_fabricante.
En caso de que no tenga fabricante el mensaje deberá ser:
El producto v_nombre no tiene fabricante.
*/

DECLARE
    V_NOMBRE VARCHAR(100);
    V_FABRICANTE VARCHAR(100);
    NUM1 NUMBER :=&NUM1;
    NUM2 NUMBER;
BEGIN 
    SELECT NOMBRE, ID_FABRICANTE INTO V_NOMBRE, NUM2 FROM PRODUCTO WHERE ID=NUM1;
    
    
    IF NUM2 IS NOT NULL THEN 
        SELECT NOMBRE INTO V_FABRICANTE FROM FABRICANTE WHERE ID=NUM2;
        DBMS_OUTPUT.PUT_LINE('El producto'|| v_nombre||' pertenece al fabricante '||v_fabricante);
    ELSE
        
        DBMS_OUTPUT.PUT_LINE(V_NOMBRE|| 'NO TIENE FABRICANTE');
    END IF;
END;

/**/



