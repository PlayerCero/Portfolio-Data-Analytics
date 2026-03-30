/*******************************************************************************

🚀 CASE STUDY: SISTEMA INTEGRADO DE GESTIÓN "LA TIENDA" & ALMACÉN

Autor: Eric Salinas

Institución: Universidad de Piura (UDEP)

Tecnología: SQL (MySQL / MariaDB)

*******************************************************************************/



/* =============================================================================

   PHASE 1: ARQUITECTURA Y DISEÑO RELACIONAL (DDL)

   -----------------------------------------------------------------------------

   PROBLEMA: La empresa necesita controlar compras y ventas, gestionando 

   proveedores con múltiples representantes y asegurando la integridad de 

   los datos de facturación.

   

   ESTRATEGIA: Aplicación de Tercera Forma Normal (3FN). Se separa la entidad 

   'Teléfono' para permitir múltiples contactos por representante sin redundancia.

   =============================================================================

*/



-- 1. Estructura de Clientes y Ventas

CREATE TABLE Cliente (

    IdCliente INT PRIMARY KEY AUTO_INCREMENT,

    Nombre VARCHAR(100) NOT NULL,

    Celular VARCHAR(15), -- Solo se registra uno según requerimiento

    Activo TINYINT(1) DEFAULT 1, -- Flag para permisos de compra

    DNI VARCHAR(8) UNIQUE NOT NULL,

    Direccion VARCHAR(255)

);



CREATE TABLE FormaPago (

    IdFormPag INT PRIMARY KEY AUTO_INCREMENT,

    Nombre VARCHAR(50) NOT NULL -- Ej: Tarjeta, Contado, Yape, Plin

);



CREATE TABLE Boleta (

    IdBoleta INT PRIMARY KEY AUTO_INCREMENT,

    Fecha DATE NOT NULL,

    IdCliente INT,

    IdFormPag INT,

    FOREIGN KEY (IdCliente) REFERENCES Cliente(IdCliente),

    FOREIGN KEY (IdFormPag) REFERENCES FormaPago(IdFormPag)

);



-- 2. Estructura de Suministros y Proveedores

CREATE TABLE Proveedor (

    IdProveedor INT PRIMARY KEY AUTO_INCREMENT,

    RS VARCHAR(100) NOT NULL, -- Razón Social

    RUC VARCHAR(11) UNIQUE NOT NULL,

    Direccion VARCHAR(255)

);



CREATE TABLE Representante (

    IdRepresentante INT PRIMARY KEY AUTO_INCREMENT,

    Nombre VARCHAR(100) NOT NULL,

    IdProveedor INT,

    FOREIGN KEY (IdProveedor) REFERENCES Proveedor(IdProveedor)

);



-- Tabla para soportar Multivaluacidad de teléfonos (Atributo Multivaluado)

CREATE TABLE Telefono_Representante (

    IdTelefono INT PRIMARY KEY AUTO_INCREMENT,

    Numero VARCHAR(15) NOT NULL,

    IdRepresentante INT,

    FOREIGN KEY (IdRepresentante) REFERENCES Representante(IdRepresentante)

);



CREATE TABLE Factura_Compra (

    IdFactura INT PRIMARY KEY AUTO_INCREMENT,

    Fecha DATE NOT NULL,

    IdRepresentante INT, -- Un solo responsable por factura según el caso

    FOREIGN KEY (IdRepresentante) REFERENCES Representante(IdRepresentante)

);



/* =============================================================================

   PHASE 2: CONSULTAS ANALÍTICAS Y BUSINESS INTELLIGENCE (DQL)

   -----------------------------------------------------------------------------

   PROBLEMA: El área de gerencia y almacén requiere KPIs específicos para la 

   toma de decisiones sobre stock y rendimiento de personal.

   =============================================================================

*/



-- 1. ANÁLISIS DE EFICIENCIA OPERATIVA

-- PROBLEMA: Identificar pedidos atendidos en tiempo real para control de despacho.

-- LÓGICA: Filtrado booleano sobre el estado 'Atendido'.

SELECT IdPedido 

FROM Pedido 

WHERE Fecha = "2023-11-28" AND Atendido = 1;



-- 2. SEGMENTACIÓN DE RECURSOS HUMANOS POR ÁREA

-- PROBLEMA: Listar personal clave de Compras, Ventas y Marketing.

-- LÓGICA: Join implícito con filtro de pertenencia mediante cláusula IN.

SELECT R.Nombre, R.Anexo 

FROM Responsable R, Área A 

WHERE A.IdArea = R.IdArea 

AND A.Nombre IN ("Compras", "Ventas", "Marketing");



-- 3. RANKING DE PRODUCTIVIDAD (TOP PERFORMER)

-- PROBLEMA: Identificar al responsable con mayor volumen de gestión en un periodo.

-- ESTRATEGIA: Agregación COUNT con ordenamiento descendente y límite de registro.

-- IMPACTO: Permite establecer bonos de desempeño basados en datos reales de operación.

SELECT R.Nombre AS Representante, COUNT(P.IdPedido) AS Total_Pedidos

FROM Responsable R, Pedido P 

WHERE R.IdResponsable = P.IdResponsable 

AND P.Fecha >= "2023-11-20" AND P.Fecha <= "2023-11-26" 

GROUP BY R.Nombre 

ORDER BY COUNT(P.IdPedido) DESC 

LIMIT 1;



-- 4. CONTROL DE DEMANDA CRÍTICA (TOP 5 PRODUCTOS)

-- PROBLEMA: Determinar qué productos agotan el stock más rápido durante el mes.

-- ESTRATEGIA: Sumatoria de cantidades por producto con triple Join entre tablas.

SELECT PR.Descripción, SUM(DP.Cantidad) AS Unidades_Vendidas

FROM Producto PR, Detalle_Pedido DP, Pedido PE 

WHERE PR.IdProducto = DP.IdProducto 

AND DP.IdPedido = PE.IdPedido 

AND PE.Fecha >= "2023-11-01" 

GROUP BY PR.Descripción 

ORDER BY SUM(DP.Cantidad) DESC 

LIMIT 5;



-- 5. AUDITORÍA DE CARGA LABORAL POR DEPARTAMENTO

-- PROBLEMA: Detectar áreas con alta demanda operativa (umbral > 50 pedidos anuales).

-- LÓGICA: Filtrado de grupos mediante HAVING aplicado post-agregación.

SELECT A.Nombre, COUNT(P.IdPedido) AS Volumen_Anual

FROM Área A, Responsable R, Pedido P 

WHERE A.IdArea = R.IdArea 

AND R.IdResponsable = P.IdResponsable 

AND P.Fecha >= "2023-01-01" 

GROUP BY A.Nombre 

HAVING COUNT(P.IdPedido) > 50;



-- 6. ANÁLISIS DE INACTIVIDAD (DATA MINING)

-- PROBLEMA: Identificar representantes que no registraron actividad el año anterior.

-- ESTRATEGIA: Subconsulta con operador NOT IN para detectar brechas de productividad.

SELECT R.Nombre, R.Anexo 

FROM Responsable R 

WHERE R.IdResponsable NOT IN (

    SELECT P.IdResponsable 

    FROM Pedido P 

    WHERE P.Fecha < "2023-01-01" AND P.Fecha >= "2022-01-01"

);



/*******************************************************************************

FIN DEL SCRIPT

Resumen técnico: Este modelo asegura la escalabilidad operativa de "La Tienda" 

bajo estándares de normalización y análisis de datos de alta precisión.

*******************************************************************************/
