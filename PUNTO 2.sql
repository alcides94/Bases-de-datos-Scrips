CREATE TABLE t_fabricante OF o_fabricante;

CREATE TABLE t_producto OF o_producto;

CREATE TABLE t_reposicion OF o_reposicion;



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

