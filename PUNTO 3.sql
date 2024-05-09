/* Tema 20 */
/* Ejemplo lista de objetos */
SET SERVEROUTPUT ON
DECLARE
    TYPE tipo_lista_fabricante IS TABLE OF o_fabricante;
    fabricantes tipo_lista_fabricante := tipo_lista_fabricante();
BEGIN
    DBMS_OUTPUT.PUT_LINE('Esto es una prueba para definir una lista con
        elementos de tipo objeto');
END;

/* Crear una tabla con un objeto como base */
CREATE TABLE t_fabricante OF o_fabricante;

/* Crear una tabla con un objeto como base
y con alguna columna tipo objeto*/
CREATE TABLE t_producto OF o_producto;

/* Ejemplo para insertar datos en tablas con objetos */
SET SERVEROUTPUT ON
DECLARE
    fab o_fabricante := o_fabricante(1,'NomFab');
    prod o_producto := o_producto(1,'NomProd',0,fab);
BEGIN
    INSERT INTO t_producto VALUES prod;
END;

/* Ejemplo para seleccionar datos de tablas con objetos */
SET SERVEROUTPUT ON
DECLARE
    prod_select o_producto := o_producto();
BEGIN
    --SELECT * INTO prod_select FROM t_producto WHERE id = 1;
    SELECT o_producto(id,nombre,precio,fabricante)
        INTO prod_select FROM t_producto WHERE id = 1;
    DBMS_OUTPUT.PUT_LINE(prod_select.to_string);
END;

/* 20.1. */
/* 20.1.1. */
DECLARE
    CURSOR cursor_fabricante IS
        (SELECT o_fabricante(id,nombre) FROM fabricante);
    fab o_fabricante := o_fabricante();
BEGIN
    OPEN cursor_fabricante;
    LOOP
        FETCH cursor_fabricante INTO fab;
        EXIT WHEN (cursor_fabricante%NOTFOUND);
        INSERT INTO t_fabricante VALUES fab;
    END LOOP;
    CLOSE cursor_fabricante;
END;

/* 20.1.2. */
DECLARE
    CURSOR cursor_producto IS
        (SELECT * FROM producto);
    var_prod producto%ROWTYPE;
    prod o_producto;
    fab o_fabricante;
BEGIN
    OPEN cursor_producto;
    LOOP
        FETCH cursor_producto INTO var_prod;
        EXIT WHEN (cursor_producto%NOTFOUND);
        IF (var_prod.id_fabricante IS NOT NULL) THEN
            SELECT o_fabricante(id,nombre) INTO fab
                FROM fabricante WHERE id = var_prod.id_fabricante;
        ELSE
            fab := o_fabricante(null,null);
        END IF;           
        prod := o_producto(var_prod.id, var_prod.nombre, var_prod.precio, fab);
        INSERT INTO t_producto VALUES prod;
    END LOOP;
    CLOSE cursor_producto;
END;

/* Pruebas de select MUESTRA LOS PRODUCTOS */
SET SERVEROUTPUT ON
DECLARE
    CURSOR cursor_producto IS
        SELECT o_producto(id,nombre,precio,fabricante) FROM t_producto;
    prod o_producto;
BEGIN
    OPEN cursor_producto;
    LOOP
        FETCH cursor_producto INTO prod;
        EXIT WHEN cursor_producto%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(prod.to_string);
    END LOOP;
END;

/* 20.1.3. */
DECLARE
    CURSOR cursor_reposicion IS
        (SELECT o_reposicion(id_reposicion,
                o_producto(id,nombre,precio,fabricante),unidades,fecha)
            FROM reposicion JOIN t_producto 
                ON reposicion.id_producto = t_producto.id);
    repo o_reposicion;
BEGIN
    OPEN cursor_reposicion;
    LOOP
        FETCH cursor_reposicion INTO repo;
        EXIT WHEN (cursor_reposicion%NOTFOUND);       
        INSERT INTO t_reposicion VALUES repo;
    END LOOP;
    CLOSE cursor_reposicion;
END;


/* 20.1.3. Sin join*/
DECLARE
    CURSOR cursor_reposicion IS
        (SELECT * FROM reposicion);
    var_repo reposicion%ROWTYPE;
    prod o_producto;
    repo o_reposicion;
BEGIN
    OPEN cursor_reposicion;
    LOOP
        FETCH cursor_reposicion INTO var_repo;
        EXIT WHEN (cursor_reposicion%NOTFOUND);  
        SELECT o_producto(id,nombre,precio,fabricante) INTO prod
            FROM t_producto WHERE id = var_repo.id_producto;
        repo := o_reposicion(var_repo.id_reposicion, prod,
            var_repo.unidades, var_repo.fecha);
        INSERT INTO t_reposicion VALUES repo;
    END LOOP;
    CLOSE cursor_reposicion;
END;
/* Pruebas de select */
SET SERVEROUTPUT ON
DECLARE
    CURSOR cursor_reposicion IS
        SELECT o_reposicion(id_reposicion,producto,unidades,fecha) FROM t_reposicion;
    repo o_reposicion;
BEGIN
    OPEN cursor_reposicion;
    LOOP
        FETCH cursor_reposicion INTO repo;
        EXIT WHEN cursor_reposicion%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(repo.to_string);
    END LOOP;
END;