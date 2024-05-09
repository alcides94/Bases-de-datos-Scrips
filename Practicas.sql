/*crea una funcion llamada get_nombre que reciba una id de producto y devuelva su nombre

crear una funcion llamada get_fabricante que reciba una id de producto y devuelva el
nombre de su fabricante suponiendo que no hay ningun null
crea un bloque de codigo que pida una id de producto por pantalla y saque el mensaje. no
uses selects usa las funciones que has creado antes*/

CREATE OR REPLACE FUNCTION GET_NOMBRE (ID_PRO NUMBER)
RETURN VARCHAR
IS
    V_NOMBRE VARCHAR(100);
BEGIN
    SELECT NOMBRE INTO V_NOMBRE FROM PRODUCTO WHERE ID=ID_PRO;
    RETURN V_NOMBRE;
END GET_NOMBRE;

CREATE OR REPLACE FUNCTION GET_FABRICANTE (ID_PRO NUMBER)
RETURN VARCHAR
IS
    V_PRODUCTO PRODUCTO%ROWTYPE;
    F_NOMBRE VARCHAR(100);
BEGIN
    
    SELECT ID_FABRICANTE INTO V_PRODUCTO.ID_FABRICANTE FROM PRODUCTO WHERE ID=ID_PRO;
    SELECT NOMBRE INTO F_NOMBRE FROM FABRICANTE WHERE ID=V_PRODUCTO.ID_FABRICANTE;
    RETURN F_NOMBRE;
END GET_FABRICANTE;



SET SERVEROUTPUT ON
DECLARE
    V_NOMBREPRO PRODUCTO.NOMBRE%TYPE;
    V_NOMBREFAB FABRICANTE.NOMBRE%TYPE;
BEGIN
    V_NOMBREPRO:=GET_NOMBRE(&ID_PRO);
    V_NOMBREFAB:=GET_FABRICANTE(&ID_PRO);
    DBMS_OUTPUT.PUT_LINE('EL PRODUCTO: '||V_NOMBREPRO||' PERTENECE AL FABRICANTE'||V_NOMBREFAB);
END;

CREATE OR REPLACE TRIGGER ELIMINAR_REPOSICION
BEFORE DELETE ON REPOSICION
FOR EACH ROW
BEGIN
    IF (MOD(:OLD.ID_REPOSICION, 2)=0)THEN    
        DBMS_OUTPUT.PUT_LINE('La reposicion'||:OLD.ID_REPOSICION||' ha sido eliminada');
    END IF;
END;

DELETE FROM reposicion WHERE id_reposicion = &p_id;

DELETE FROM reposicion WHERE id_reposicion = &p_id;

/*
Define un registro con todos los campos de la tabla reposicion.Hacer uso de la clausula
%TYPE para que todos los campos tengan los mismos que los de la tabla. 
Solicitar una id de producto por consola. 
Con un bucle FOR, hacer tantas iteraciones como elementos
tenga la tabla reposicion. cada iteracion debe recoger los datos de una reposicion y
volcarlos en una variable del tipo registro definido antes. saca por pantalla el siguiente
mensaje solo si dicha reposicion pertenece al producto cuya id se ha solicitado por consola.
El producto [producto.nombre] repuso [reposicion.unidades] unidades el reposicion
[reposicion.fecha]

*/

DECLARE
    TYPE R_REPOSICION IS RECORD (
        ID_REPOSICION REPOSICION.ID_REPOSICION%TYPE,
        ID_PRODUCTO REPOSICION.ID_PRODUCTO%TYPE,
        UNIDADES REPOSICION.UNIDADES%TYPE,
        FECHA REPOSICION.FECHA%TYPE
    );
    V_REPO R_REPOSICION;
    ID_PRO PRODUCTO.ID%TYPE;
    CONTADOR NUMBER:=0;
    V_NOMBRE PRODUCTO.NOMBRE%TYPE;
BEGIN
    ID_PRO:=&ID_PRO;
    SELECT COUNT (*) INTO CONTADOR FROM REPOSICION ;
    
    FOR I IN 1..CONTADOR LOOP
        SELECT * INTO V_REPO FROM REPOSICION WHERE ID_REPOSICION=I;
        SELECT NOMBRE INTO V_NOMBRE FROM PRODUCTO WHERE ID=V_REPO.ID_PRODUCTO;
        IF (ID_PRO=V_REPO.ID_REPOSICION)THEN
            DBMS_OUTPUT.PUT_LINE('El producto'||V_NOMBRE||' repuso '||V_REPO.UNIDADES||' unidades el reposicion'||V_REPO.FECHA);
        END IF;
        
    END LOOP;
END;

/*
Crear un cursor que realice una busqueda sobre los productos cuyo id de fabricante se pase
por parametro. Solicita una id de fabricante por consola e invocar al cursor con dicho id.
Recorrer el cursor y meter todos los datos de los productos en una lista de productos
En otro bucle recorrer dicha lista y sacar este mensaje:
El producto[producto.nombre] tiene un precio de [producto.precio]

*/
DECLARE
    CURSOR CURSOR_PRODUCTO (V_FAB NUMBER) IS SELECT * FROM PRODUCTO WHERE ID_FABRICANTE=V_FAB;
    TYPE LISTA_PRODUCTOS IS TABLE OF PRODUCTO%ROWTYPE;
BEGIN
   OPEN CURSOR_PRODUCTO (&V_FAB);
        LOOP
            FETCH CURSOR_PRODUCTO INTO LISTA_PRODUCTO;
            EXIT WHEN CURSOR_PRODUCTO%NOTFOUND;
        END LOOP;
   CLOSE CURSOR_PRODUCTO;
END;



