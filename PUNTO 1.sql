DROP TYPE o_reposicion;
DROP TYPE o_producto;
DROP TYPE o_fabricante;

CREATE TYPE o_fabricante AS OBJECT(
    id NUMBER,
    nombre VARCHAR(100),
    CONSTRUCTOR FUNCTION o_fabricante RETURN SELF AS RESULT,
    MEMBER FUNCTION get_id RETURN NUMBER,
    MEMBER FUNCTION get_nombre RETURN VARCHAR,
    MEMBER PROCEDURE set_id (p_id NUMBER),
    MEMBER PROCEDURE set_nombre (p_nombre VARCHAR),
    MEMBER FUNCTION to_string RETURN VARCHAR,
    MAP MEMBER FUNCTION ordenar RETURN NUMBER
);

CREATE TYPE BODY o_fabricante AS
    CONSTRUCTOR FUNCTION o_fabricante RETURN SELF AS RESULT
    IS
    BEGIN
        RETURN;
    END o_fabricante;

    MEMBER FUNCTION get_id RETURN NUMBER
    IS
    BEGIN
        RETURN SELF.id;
    END get_id;
    
    MEMBER PROCEDURE set_id (p_id NUMBER)
    IS
    BEGIN
        SELF.id := p_id;
    END set_id;
    
    MEMBER FUNCTION get_nombre RETURN VARCHAR
    IS
    BEGIN
        RETURN SELF.nombre;
    END get_nombre;
    
    MEMBER PROCEDURE set_nombre (p_nombre VARCHAR)
    IS
    BEGIN
        SELF.nombre := p_nombre;
    END set_nombre;
        
    MEMBER FUNCTION to_string RETURN VARCHAR
    IS
        result VARCHAR(255);
    BEGIN
        result := ('Fabricante [id = ' || SELF.id
        || ', nombre = ' || SELF.nombre || ']');
        RETURN result;
    END to_string;
    
    MAP MEMBER FUNCTION ordenar RETURN NUMBER
    IS
    BEGIN
        RETURN SELF.id;
    END ordenar;
END;

CREATE TYPE o_producto AS OBJECT(
    id NUMBER,
    nombre VARCHAR(100),
    precio NUMBER,
    fabricante o_fabricante,
    CONSTRUCTOR FUNCTION o_producto RETURN SELF AS RESULT,
    MEMBER FUNCTION get_id RETURN NUMBER,
    MEMBER PROCEDURE set_id (p_id NUMBER),
    MEMBER FUNCTION get_nombre RETURN VARCHAR,    
    MEMBER PROCEDURE set_nombre (p_nombre VARCHAR),
    MEMBER FUNCTION get_precio RETURN NUMBER,    
    MEMBER PROCEDURE set_precio (p_precio NUMBER),
    MEMBER FUNCTION get_fabricante RETURN o_fabricante,    
    MEMBER PROCEDURE set_fabricante (p_fabricante o_fabricante),
    MEMBER FUNCTION to_string RETURN VARCHAR,
    MAP MEMBER FUNCTION ordenar RETURN NUMBER
);

CREATE TYPE BODY o_producto AS
    CONSTRUCTOR FUNCTION o_producto RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.fabricante := o_fabricante();
        RETURN;
    END o_producto;

    MEMBER FUNCTION get_id RETURN NUMBER
    IS
    BEGIN
        RETURN SELF.id;
    END get_id;
    
    MEMBER PROCEDURE set_id (p_id NUMBER)
    IS
    BEGIN
        SELF.id := p_id;
    END set_id;
    
    MEMBER FUNCTION get_nombre RETURN VARCHAR
    IS
    BEGIN
        RETURN SELF.nombre;
    END get_nombre;
    
    MEMBER PROCEDURE set_nombre (p_nombre VARCHAR)
    IS
    BEGIN
        SELF.nombre := p_nombre;
    END set_nombre;
    
    MEMBER FUNCTION get_precio RETURN NUMBER
    IS
    BEGIN
        RETURN SELF.precio;
    END get_precio;
    
    MEMBER PROCEDURE set_precio (p_precio NUMBER)
    IS
    BEGIN
        SELF.precio := p_precio;
    END set_precio;
    
    MEMBER FUNCTION get_fabricante RETURN o_fabricante
    IS
    BEGIN
        RETURN SELF.fabricante;
    END get_fabricante;
    
    MEMBER PROCEDURE set_fabricante (p_fabricante o_fabricante)
    IS
    BEGIN
        SELF.fabricante := p_fabricante;
    END set_fabricante;
        
    MEMBER FUNCTION to_string RETURN VARCHAR
    IS
        result VARCHAR(255);
    BEGIN
        result := ('Producto [id = ' || SELF.id
        || ', nombre = ' || SELF.nombre || ', precio = ' || SELF.precio
        || ', fabricante = ' || SELF.fabricante.to_string || ']');
        RETURN result;
    END to_string;

    MAP MEMBER FUNCTION ordenar RETURN NUMBER
    IS
    BEGIN
        RETURN SELF.id;
    END ordenar;   
END;

CREATE TYPE o_reposicion AS OBJECT(
    id_reposicion NUMBER,
    producto o_producto,
    unidades NUMBER,
    fecha DATE,
    CONSTRUCTOR FUNCTION o_reposicion RETURN SELF AS RESULT,
    MEMBER FUNCTION get_id_reposicion RETURN NUMBER,
    MEMBER PROCEDURE set_id_reposicion (p_id_reposicion NUMBER),
    MEMBER FUNCTION get_producto RETURN o_producto,    
    MEMBER PROCEDURE set_producto (p_producto o_producto),
    MEMBER FUNCTION get_unidades RETURN NUMBER,    
    MEMBER PROCEDURE set_unidades (p_unidades NUMBER),
    MEMBER FUNCTION get_fecha RETURN DATE,    
    MEMBER PROCEDURE set_fecha (p_fecha DATE),
    MEMBER FUNCTION to_string RETURN VARCHAR,
    MAP MEMBER FUNCTION ordenar RETURN NUMBER
);

CREATE TYPE BODY o_reposicion AS
    CONSTRUCTOR FUNCTION o_reposicion RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.producto := o_producto();
        RETURN;
    END o_reposicion;

    MEMBER FUNCTION get_id_reposicion RETURN NUMBER
    IS
    BEGIN
        RETURN SELF.id_reposicion;
    END get_id_reposicion;
    
    MEMBER PROCEDURE set_id_reposicion (p_id_reposicion NUMBER)
    IS
    BEGIN
        SELF.id_reposicion := p_id_reposicion;
    END set_id_reposicion;
    
    MEMBER FUNCTION get_producto RETURN o_producto
    IS
    BEGIN
        RETURN SELF.producto;
    END get_producto;
    
    MEMBER PROCEDURE set_producto (p_producto o_producto)
    IS
    BEGIN
        SELF.producto := p_producto;
    END set_producto;
    
    MEMBER FUNCTION get_unidades RETURN NUMBER
    IS
    BEGIN
        RETURN SELF.unidades;
    END get_unidades;
    
    MEMBER PROCEDURE set_unidades (p_unidades NUMBER)
    IS
    BEGIN
        SELF.unidades := p_unidades;
    END set_unidades;
    
    MEMBER FUNCTION get_fecha RETURN DATE
    IS
    BEGIN
        RETURN SELF.fecha;
    END get_fecha;
    
    MEMBER PROCEDURE set_fecha (p_fecha DATE)
    IS
    BEGIN
        SELF.fecha := p_fecha;
    END set_fecha;
        
    MEMBER FUNCTION to_string RETURN VARCHAR
    IS
        result VARCHAR(255);
    BEGIN
        result := ('Resposicion [id_reposicion = ' || SELF.id_reposicion
        || ', producto = ' || SELF.producto.to_string
        || ', unidades = ' || SELF.unidades
        || ', fecha = ' || SELF.fecha || ']');
        RETURN result;
    END to_string;
            
    MAP MEMBER FUNCTION ordenar RETURN NUMBER
    IS
    BEGIN
        RETURN SELF.id_reposicion;
    END ordenar;
END;