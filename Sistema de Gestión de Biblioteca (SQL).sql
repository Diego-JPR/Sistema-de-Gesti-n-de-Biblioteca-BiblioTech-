
    CREATE TABLE AUTORES (
        ID_Autor INT PRIMARY KEY,
        NOMBRE VARCHAR (100),
        NACIONALIDAD VARCHAR(50)
    );

    CREATE TABLE MIEMBROS(
        ID_Miembro INT PRIMARY KEY,
        NOMBRE VARCHAR (50),
        APELLIDO VARCHAR(50),
        EMAIL VARCHAR (100) UNIQUE,
        FECHA_ALTA DATE
    );

    CREATE TABLE LIBROS(
        ID_Libro INT PRIMARY KEY,
        TITULO VARCHAR(150),
        GENERO VARCHAR(50),
        STOCK INT,
        ID_Autor INT,
        FOREIGN KEY (ID_Autor) REFERENCES AUTORES (ID_Autor)
    );

    CREATE TABLE PRESTAMOS(
        ID_Prestamo INT PRIMARY KEY,
        ID_Libro INT,
        ID_Miembro INT,
        FECHA_PRESTAMO DATE,
        FECHA_DEVOLUCION_PACTADA DATE,
        FECHA_DEVOLUCION_REAL DATE,
        
        FOREIGN KEY (ID_Libro) REFERENCES LIBROS(ID_Libro),      
        FOREIGN KEY (ID_Miembro) REFERENCES MIEMBROS(ID_Miembro)    
    );

    GO

    INSERT INTO AUTORES VALUES 
    (1,'J.K Rowling','Britanica'),
    (2,'Grabiel Garcia Marquez','Colombiana'),
    (3,'Stephen King', 'Estadounidense'),
    (4,'George R.R. Martin', 'Estadounidense');

    INSERT INTO MIEMBROS VALUES
    (100,'Ana','Garcia','anagarcia@gmail.com','2024-01-10'),
    (101,'Julian', 'Fernandez','julifernandez@gmail.com','2024-02-15'),
    (102,'Jose Maria', 'Listorti', 'josema@gmail.com','2024-03-20');

    INSERT INTO LIBROS VALUES 
    (10, 'Harry Potter y la Piedra Filosofal', 'Fantasia', 5, 1),
    (20, 'Cien Años de Soledad', 'Realismo Magico', 3, 2),
    (30, 'It', 'Terror', 2, 3),
    (40, 'Juego de Tronos', 'Fantasia', 4, 4);

    INSERT INTO PRESTAMOS VALUES
    (1, 10, 100, '2025-02-01', '2025-02-15', '2025-02-10'),
    (2, 20, 101, '2025-02-05', '2025-02-20', NULL),
    (3, 30, 102, '2025-02-10', '2025-02-25', NULL),
    (4, 10, 101, '2025-03-01', '2025-03-15', '2025-03-20');
        
    GO 

    CREATE VIEW LIBROS_PRESTADOS_ACTIVOS AS 
    SELECT
        M.Nombre + '' + M.Apellido AS Socio,
        L.Titulo,
        P.FECHA_PRESTAMO,
        P.FECHA_DEVOLUCION_PACTADA,
        DATEDIFF(day, GETDATE(),P.FECHA_DEVOLUCION_PACTADA) AS DIAS_PARA_VENCIMIENTO

        FROM PRESTAMOS P
        JOIN MIEMBROS M ON P.ID_Miembro = M.ID_Miembro
        JOIN LIBROS L ON P.ID_Libro = L.ID_Libro
        WHERE P.FECHA_DEVOLUCION_REAL IS NULL;
    GO
    --Demostracion que funciona:
    SELECT * FROM LIBROS_PRESTADOS_ACTIVOS
    WHERE DIAS_PARA_VENCIMIENTO < 0;

    GO
    CREATE PROCEDURE DEVOLVERLIBRO
    @ID_Prestamo INT
    AS
    BEGIN 
        IF EXISTS(SELECT 1 FROM PRESTAMOS WHERE ID_Prestamo = @ID_Prestamo AND FECHA_DEVOLUCION_REAL IS NULL)
        BEGIN 
            UPDATE PRESTAMOS 
            SET FECHA_DEVOLUCION_REAL = GETDATE()
            WHERE ID_Prestamo = @ID_Prestamo;

            PRINT 'Libro devuelto correctamente';
        END
        ELSE 
        BEGIN 
            PRINT 'ERROR:El prestamo no existe o el libro ya fue devuelto';
        END
    END;
    GO

    


