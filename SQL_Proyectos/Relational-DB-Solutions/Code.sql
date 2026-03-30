/* ***************************************************************************
** BASE DE DATOS: DISEÑO Y CONSULTAS SQL (SOLUCIONARIO PC4)
** Autor: Eric Bekim Salinas Cajaleón
** Institución: Universidad de Piura (UDEP)
** Fecha: 30 de marzo de 2026
***************************************************************************
*/

/* ===========================================================================
1. DISEÑO DEL MODELO RELACIONAL (CASO: PROMOCIÓN DE COLEGIOS)

DESCRIPCIÓN: Sistema para gestionar eventos de captación de alumnos mediante 
visitas guiadas de colegios. Se registran datos de instituciones, 
programas académicos y la asignación de expositores universitarios.
===========================================================================
*/

-- Tabla de clasificación de colegios
CREATE TABLE Tipo (
    idTipo INT PRIMARY KEY,
    Nombre VARCHAR(45) -- Mujeres, Hombres o Mixto
);

-- Información de los colegios invitados
CREATE TABLE Colegio (
    idColegio INT PRIMARY KEY,
    Nombre VARCHAR(45),
    Direccion VARCHAR(45),
    Telefono VARCHAR(45),
    idTipo INT,
    FOREIGN KEY (idTipo) REFERENCES Tipo(idTipo)
);

-- Gestión de Programas y Facultades
CREATE TABLE Facultad (
    idFacultad INT PRIMARY KEY,
    Nombre VARCHAR(45)
);

CREATE TABLE Programa (
    idPrograma INT PRIMARY KEY,
    Nombre VARCHAR(45),
    idFacultad INT,
    FOREIGN KEY (idFacultad) REFERENCES Facultad(idFacultad)
);

-- Personal académico expositor
CREATE TABLE Expositor (
    idExpositor INT PRIMARY KEY,
    Nombre VARCHAR(45),
    Correo VARCHAR(45),
    Anexo VARCHAR(45),
    idPrograma INT,
    FOREIGN KEY (idPrograma) REFERENCES Programa(idPrograma)
);

-- Registro de visitas guiadas
CREATE TABLE Visita (
    idVisita INT PRIMARY KEY,
    Fecha DATE,
    CantAlum INT,
    HoraIni TIME,
    HoraFin TIME,
    idColegio INT,
    FOREIGN KEY (idColegio) REFERENCES Colegio(idColegio)
);

-- Relación muchos a muchos (Visita e Investigador/Lugar)
CREATE TABLE Visita_has_Expositor (
    idVisita INT,
    idExpositor INT,
    Lugar VARCHAR(45),
    PRIMARY KEY (idVisita, idExpositor),
    FOREIGN KEY (idVisita) REFERENCES Visita(idVisita),
    FOREIGN KEY (idExpositor) REFERENCES Expositor(idExpositor)
);

/* ===========================================================================
2. CONSULTAS SQL (CASO: TIENDA DE ROPA)

CONTEXTO: Análisis de datos para una tienda que gestiona boletas, pedidos, 
inventario de ropa y facturas de proveedores.
===========================================================================
*/

/* a. Invitaciones para clientes de la década de los 80:
   ESTRATEGIA: Filtrado por rango de fechas mediante operadores relacionales. */
SELECT nombre, dirección 
FROM Cliente 
WHERE FecNac >= '1980-01-01' AND FecNac <= '1990-01-01';

/* b. Conteo de pedidos (etiqueta "Ventas") de la semana pasada:
   ESTRATEGIA: Uso de la función COUNT con filtro temporal de lunes a viernes. */
SELECT Count(IdPedido) Venta 
FROM Pedido 
WHERE Fecha >= '2024-10-21' AND Fecha <= '2024-10-25';

/* c. Pedidos pendientes (incluso sin boleta):
   ESTRATEGIA: Aplicación de LEFT JOIN para incluir pedidos que no tienen boleta. */
Select p.IdPedido, p.fecha 
FROM Pedido p 
LEFT JOIN Boleta b ON p.IdBoleta = b.IdBoleta 
WHERE p.fecha >= '2024-10-21' AND p.fecha <= '2024-10-27';

/* d. Proveedores de 'Polo' con compras en el mes actual:
   ESTRATEGIA: Unión de 5 tablas y ordenamiento alfabético ascendente. */
Select DISTINCT p.RazonSocial, p.Celular 
FROM Proveedor p, Factura F, DetalleF D, Ropa R, Tipo T 
WHERE p.IdProveedor = f.IdProveedor 
  AND f.IdFactura = d.IdFactura 
  AND d.IdRopa = r.IdRopa 
  AND r.IdTipo = t.IdTipo 
  AND t.Tipo = 'Polo' 
  AND f.Fecha >= '2024-10-01' 
ORDER BY p.RazonSocial ASC;

/* e. Fecha con menor volumen de pedidos (Semana pasada):
   ESTRATEGIA: Agrupación por fecha, conteo, ordenamiento ascendente y LIMIT 1. */
Select p.Fecha, Count(IdPedido) 
FROM Pedido p, Boleta b 
WHERE p.IdBoleta = b.IdBoleta 
  AND p.fecha >= '2024-10-21' AND p.Fecha <= '2024-10-27' 
GROUP BY p.Fecha 
ORDER BY Count(IdPedido) ASC 
LIMIT 1;

/* f. Top 5 proveedores con más facturas este año:
   ESTRATEGIA: Agrupación por razón social y ordenamiento descendente. */
Select p.RazonSocial, Count(f.IdFactura) 
FROM Proveedor p, Factura f 
WHERE p.IdProveedor = f.IdProveedor 
  AND f.Fecha >= '2024-01-01' 
GROUP BY p.RazonSocial 
ORDER BY Count(f.IdFactura) DESC 
LIMIT 5;

/* g. Clientes VIP (Pedidos > S/. 10,000 en el año):
   ESTRATEGIA: Uso de HAVING para filtrar resultados agregados (SUM). */
Select c.Nombre, SUM(d.Cantidad * d.PrecioVta) 
FROM Cliente c, Pedido p, DetalleP d 
WHERE c.IdCliente = p.IdCliente 
  AND p.IdPedido = d.IdPedido 
  AND p.Fecha >= '2024-01-01' 
GROUP BY c.Nombre 
HAVING SUM(d.Cantidad * d.PrecioVta) > 10000;

/* h. Proveedores sin actividad el mes pasado:
   ESTRATEGIA: Subconsulta con el operador NOT IN. */
Select RazonSocial 
FROM Proveedor 
WHERE IdProveedor NOT IN (
    Select IdProveedor 
    FROM Factura 
    WHERE Fecha >= '2024-09-01' AND Fecha < '2024-10-01'
);

/* i. Análisis de eliminación selectiva:
   ACCIÓN: Borrar pedidos del año actual de clientes cuyo nombre inicia con "A" 
   y que no son de la década de los 90. */
DELETE FROM Pedido 
WHERE Fecha > '2023-12-31' 
  AND IdCliente IN (
      Select IdCliente FROM Cliente 
      WHERE nombre like 'A%' 
        AND (FecNac >= '2000-01-01' OR FecNac < '1990-01-01')
  );

/* ***************************************************************************
NOTAS FINALES: Este modelo y las consultas han sido extraídos del 
solucionario oficial. Se recomienda verificar la integridad 
referencial al ejecutar los comandos DELETE para evitar errores de 
restricción de clave foránea.
***************************************************************************
*/