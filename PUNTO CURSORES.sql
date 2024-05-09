SET SERVEROUTPUT ON
DECLARE
    CURSOR cursor_producto IS
        SELECT P.nombre as nombre_pro, F.nombre as nombre_fab
        FROM t_producto P
        JOIN t_fabricante F ON P.fabricante.id = F.id;
    v_nombre_producto t_producto.nombre%TYPE;
    v_nombre_fabricante t_fabricante.nombre%TYPE;
BEGIN
    OPEN cursor_producto;
    LOOP
        FETCH cursor_producto INTO v_nombre_producto, v_nombre_fabricante;
        EXIT WHEN cursor_producto%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Nombre Producto: ' || v_nombre_producto || ', Fabricante: ' || v_nombre_fabricante);
    END LOOP;
    CLOSE cursor_producto;
END;