/*ejercicios con TRIGGER*/

/*/a) Crear un trigger que se active por cada delete de una reposición con una id_reposicion par. Se deberá imprimir el siguiente mensaje:
'La reposicion [id_reposicion] ha sido eliminada' */

/*Cuando el ID fabricante sea par*/
CREATE OR REPLACE TRIGGER fabricante_eliminado
BEFORE DELETE ON t_fabricante
FOR EACH ROW
WHEN (MOD(OLD.id,2)=0)
BEGIN
    DBMS_OUTPUT.PUT_LINE('el farbicante' || :OLD.id
        || ' ha sido eliminado');
END fabricante_eliminado;

Delete from t_fabricante where id=1;

/*TRIGGER PARA FABRICANTE*/

CREATE OR REPLACE TRIGGER nuevo_fabricante
BEFORE INSERT ON t_fabricante
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('Nuevo fabricante a insertar: ' || :NEW.nombre);
END;


INSERT INTO T_FABRICANTE VALUES (20,'ALCIDES');

/*/* Ejemplo complejo disparadores UPDATE*/
CREATE OR REPLACE TRIGGER auditoria_fabrica
BEFORE UPDATE OF nombre ON t_fabricante
FOR EACH ROW
WHEN (OLD.nombre <> NEW.nombre)
BEGIN
    DBMS_OUTPUT.PUT_LINE('El producto =' || :OLD.nombre || ' ha cambiado de nombre a= ' || :NEW.nombre );
END;

UPDATE t_fabricante SET nombre='EL LOCO'
WHERE id = 1;

DECLARE
    -- Declarar una variable del tipo objeto o_fabricante
    v_fabricante o_fabricante;
BEGIN
    -- Crear una instancia del objeto o_fabricante
    v_fabricante := o_fabricante(90, 'Nombre del fabricante');

    -- Insertar una fila en la tabla t_producto con el objeto fabricante
    INSERT INTO t_producto (id, nombre, precio, fabricante)
    VALUES (28, 'Nombre del producto', 100.00, v_fabricante);
END;


CREATE OR REPLACE TRIGGER t_producto_insert_trigger
BEFORE INSERT ON t_producto
FOR EACH ROW
DECLARE
    -- Declarar una variable del tipo objeto o_fabricante
    v_fabricante o_fabricante;
BEGIN
    -- Crear una instancia del objeto o_fabricante
    v_fabricante := o_fabricante(:NEW.fabricante.id, :NEW.fabricante.nombre);

    -- Actualizar el objeto fabricante en la fila a insertar
    :NEW.fabricante := v_fabricante;
END;

/*-----------------ejemplo de inserccion de producto con trigger ----------*/

INSERT INTO t_producto
VALUES (1, 'Producto1', 120, o_fabricante(99, 'Fabricante34'));

CREATE OR REPLACE TRIGGER producto_insertado
AFTER INSERT ON t_producto
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('Se ha insertado un nuevo producto: ' || :NEW.nombre);
END producto_insertado;

/*------inserccion con WHEN--------*/

CREATE OR REPLACE TRIGGER producto_insertado2
AFTER INSERT ON t_producto
FOR EACH ROW
WHEN (NEW.precio > 100)
BEGIN
    DBMS_OUTPUT.PUT_LINE('Se ha insertado un nuevo producto con precio alto: ' || :NEW.nombre);
END producto_insertado2;
