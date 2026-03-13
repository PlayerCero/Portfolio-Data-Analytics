-- Script de Creación de Base de Datos en SQL Server (Re-dividido Usuarios/Roles)

-- 1. Crear la base de datos (ejecutar esto una vez)
CREATE DATABASE [GasAndinaApp];
GO
USE [GasAndinaApp];
GO

use [LogisticMaster]
go

Drop Database [GasAndinaApp]
GO

-- ##########################################################################
-- ELIMINACIÓN DE TABLAS EXISTENTES (PARA LIMPIEZA EN CASO DE RE-EJECUCIÓN)
-- ##########################################################################

-- Puedes descomentar y ejecutar estas líneas si necesitas limpiar un esquema previo.
-- El orden inverso es crucial para las claves foráneas.
/*
DROP TABLE IF EXISTS DetallesAlmacenDistribucion;
DROP TABLE IF EXISTS ZonasGeograficas;
DROP TABLE IF EXISTS EstacionesDistribucion;
DROP TABLE IF EXISTS Rutas;
DROP TABLE IF EXISTS ReportesIncidente;
DROP TABLE IF EXISTS Incidentes;
DROP TABLE IF EXISTS TiposIncidente;
DROP TABLE IF EXISTS DetallesProductoAlmacen;
DROP TABLE IF EXISTS Almacenes;
DROP TABLE IF EXISTS ClasificacionesLogistica;
DROP TABLE IF EXISTS Turnos;
DROP TABLE IF EXISTS Seguimientos;
DROP TABLE IF EXISTS Cargas;
DROP TABLE IF EXISTS Asignaciones;
DROP TABLE IF EXISTS Pagos;
DROP TABLE IF EXISTS TiposPago;
DROP TABLE IF EXISTS DetallesPedido;
DROP TABLE IF EXISTS Productos;
DROP TABLE IF EXISTS Pedidos;
DROP TABLE IF EXISTS Reclamos;
DROP TABLE IF EXISTS TiposReclamo;
DROP TABLE IF EXISTS Conductor; -- Nueva tabla dividida
DROP TABLE IF EXISTS Operador;  -- Nueva tabla dividida
DROP TABLE IF EXISTS Cliente;   -- Nueva tabla dividida
DROP TABLE IF EXISTS Vehiculos;
DROP TABLE IF EXISTS Usuarios;  -- La nueva tabla base
GO
*/
);

-- Script de Creación de Base de Datos en SQL Server (Versión Final con cambios)

-- 1. Crear la base de datos (ejecutar esto una vez)
-- USE master;
-- GO
-- CREATE DATABASE [NombreDeTuBaseDeDatos];
-- GO
-- USE [NombreDeTuBaseDeDatos];
-- GO

-- Si ya tienes una base de datos, simplemente usa la siguiente línea
USE [NombreDeTuBaseDeDatos]; -- <--- REEMPLAZA ESTO CON EL NOMBRE REAL DE TU DB
GO

-- ##########################################################################
-- ELIMINACIÓN DE TABLAS EXISTENTES (PARA LIMPIEZA EN CASO DE RE-EJECUCIÓN)
-- ##########################################################################

-- Puedes descomentar y ejecutar estas líneas si necesitas limpiar un esquema previo.
-- El orden inverso es crucial para las claves foráneas.
/*
DROP TABLE IF EXISTS DetallesAlmacenDistribucion;
DROP TABLE IF EXISTS ZonasGeograficas;
DROP TABLE IF EXISTS EstacionesDistribucion;
DROP TABLE IF EXISTS Rutas;
-- Hay que eliminar primero las FKs antes de eliminar las tablas de Incidentes/Reportes
ALTER TABLE Incidentes DROP CONSTRAINT FK_Incidentes_ReporteIncidente;
ALTER TABLE ReportesIncidente DROP CONSTRAINT FK_ReportesIncidente_ReportePadre;
DROP TABLE IF EXISTS ReportesIncidente;
DROP TABLE IF EXISTS Incidentes;
DROP TABLE IF EXISTS TiposIncidente;
DROP TABLE IF EXISTS DetallesProductoAlmacen;
DROP TABLE IF EXISTS Almacenes;
DROP TABLE IF EXISTS ClasificacionesLogistica;
DROP TABLE IF EXISTS Turnos;
DROP TABLE IF EXISTS Seguimientos;
DROP TABLE IF EXISTS Cargas;
DROP TABLE IF EXISTS Asignaciones;
DROP TABLE IF EXISTS Pagos;
DROP TABLE IF EXISTS TiposPago;
DROP TABLE IF EXISTS DetallesPedido;
DROP TABLE IF EXISTS Productos;
DROP TABLE IF EXISTS Pedidos;
DROP TABLE IF EXISTS Reclamos;
DROP TABLE IF EXISTS TiposReclamo;
DROP TABLE IF EXISTS Conductor;
DROP TABLE IF EXISTS Operador;
DROP TABLE IF EXISTS Empleado; -- Si existe esta tabla
DROP TABLE IF EXISTS Cliente;
DROP TABLE IF EXISTS Vehiculos;
DROP TABLE IF EXISTS Usuarios;
GO
*/

-- Tabla Usuarios
CREATE TABLE Usuarios (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Sexo VARCHAR(10),
    FechaNacimiento DATE
);

CREATE TABLE Vehiculos (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Tipo VARCHAR(50),
    Modelo VARCHAR(100),
    Capacidad DECIMAL(10, 2),
    Estado VARCHAR(50),
    UbicacionActual VARCHAR(255),
    NumeroVehiculo VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE TiposReclamo (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Descripcion VARCHAR(255) NOT NULL,
    SugerenciaCompensacion VARCHAR(500)
);

CREATE TABLE Productos (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    PesoUnidad DECIMAL(10, 2),
    VolumenUnidad DECIMAL(10, 2)
);

CREATE TABLE TiposPago (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion VARCHAR(255)
);

CREATE TABLE Almacenes (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Ubicacion VARCHAR(500) NOT NULL,
    CapacidadMaxima DECIMAL(10, 2),
    StockProductos INT
);

CREATE TABLE EstacionesDistribucion (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Ubicacion VARCHAR(500) NOT NULL,
    TipoEstacion VARCHAR(100),
    Capacidad DECIMAL(10, 2),
    HorarioAtencion VARCHAR(255)
);

CREATE TABLE TiposIncidente (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Descripcion VARCHAR(255) NOT NULL
);

-- ##########################################################################
-- TABLAS DE ROLES (REFERENCIAN A USUARIOS)
-- ##########################################################################

CREATE TABLE Cliente(
    IdUsuario INT PRIMARY KEY, -- FK a Usuarios
    IdClienteNegocio VARCHAR(50) UNIQUE NOT NULL,
    EmailContacto VARCHAR(255),
    DireccionEntrega VARCHAR(500),
    SecuenciaEntrega VARCHAR(255),
    Estado VARCHAR(50),
    CONSTRAINT FK_Cliente_Usuario FOREIGN KEY (IdUsuario) REFERENCES Usuarios(Id)
);

CREATE TABLE Empleado(
    IdUsuario INT PRIMARY KEY, -- FK a Usuarios
    CONSTRAINT FK_Empleado_Usuario FOREIGN KEY (IdUsuario) REFERENCES Usuarios(Id)
);

CREATE TABLE Conductor (
    IdUsuario INT PRIMARY KEY, -- FK a Empleado
    IdConductorNegocio VARCHAR(50) UNIQUE NOT NULL,
    Licencia VARCHAR(100),
    UbicacionActual VARCHAR(255),
    CapacidadVehiculoConductor VARCHAR(100),
    IdVehiculoAsignado INT NULL, -- FK a Vehiculos.Id (opcional si es su vehículo habitual)
    CONSTRAINT FK_Conductor_Empleado FOREIGN KEY (IdUsuario) REFERENCES Empleado(IdUsuario),
    CONSTRAINT FK_Conductor_VehiculoAsignado FOREIGN KEY (IdVehiculoAsignado) REFERENCES Vehiculos(Id)
);

CREATE TABLE Despachador (
    IdUsuario INT PRIMARY KEY, -- FK a Empleado
    IdOperadorNegocio VARCHAR(50) UNIQUE NOT NULL,
    CONSTRAINT FK_Operador_Empleado FOREIGN KEY (IdUsuario) REFERENCES Empleado(IdUsuario)
);


-- ##########################################################################
-- TABLAS CON DEPENDENCIAS DE PRIMER NIVEL (que usan los roles)
-- ##########################################################################

CREATE TABLE Reclamos (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    IdTipoReclamo INT NOT NULL,
    IdCliente INT NOT NULL, -- FK a la tabla Cliente
    Ubicacion VARCHAR(255),
    FechaHora DATETIME NOT NULL,
    CONSTRAINT FK_Reclamos_TiposReclamo FOREIGN KEY (IdTipoReclamo) REFERENCES TiposReclamo(Id),
    CONSTRAINT FK_Reclamos_Cliente FOREIGN KEY (IdCliente) REFERENCES Cliente(IdUsuario)
);

CREATE TABLE Pedidos (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    IdOperador INT NULL, -- FK a la tabla Operador (quien pudo haber gestionado el pedido)
    FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
    Prioridad VARCHAR(50),
    TiempoEstimadoEntrega DATETIME,
    IdCliente INT NOT NULL, -- FK a la tabla Cliente
    Estado VARCHAR(50),
    CONSTRAINT FK_Pedidos_Operador FOREIGN KEY (IdOperador) REFERENCES Despachador(IdUsuario),
    CONSTRAINT FK_Pedidos_Cliente FOREIGN KEY (IdCliente) REFERENCES Cliente(IdUsuario)
);

CREATE TABLE DetallesPedido (
    IdPedido INT NOT NULL,
    IdProducto INT NOT NULL,
    Cantidad INT NOT NULL,
    PRIMARY KEY (IdPedido, IdProducto),
    CONSTRAINT FK_DetallesPedido_Pedido FOREIGN KEY (IdPedido) REFERENCES Pedidos(Id),
    CONSTRAINT FK_DetallesPedido_Producto FOREIGN KEY (IdProducto) REFERENCES Productos(Id)
);

CREATE TABLE Pagos (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    IdPedido INT NOT NULL,
    IdTipoPago INT NOT NULL,
    Monto DECIMAL(18, 2) NOT NULL,
    FechaHora DATETIME NOT NULL,
    CONSTRAINT FK_Pagos_Pedido FOREIGN KEY (IdPedido) REFERENCES Pedidos(Id),
    CONSTRAINT FK_Pagos_TiposPago FOREIGN KEY (IdTipoPago) REFERENCES TiposPago(Id)
);

CREATE TABLE Asignaciones (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    IdPedido INT NOT NULL,
    IdVehiculo INT NOT NULL,
    IdConductor INT NOT NULL, -- FK a la tabla Conductor
    IdOperador INT NOT NULL, -- --- CAMBIO AQUI: Hacemos IdOperador NOT NULL si siempre un operador es quien asigna ---
    Estado VARCHAR(50),
    FechaHora DATETIME NOT NULL DEFAULT GETDATE(),
    Descripcion VARCHAR(500),
    CONSTRAINT FK_Asignaciones_Pedido FOREIGN KEY (IdPedido) REFERENCES Pedidos(Id),
    CONSTRAINT FK_Asignaciones_Vehiculo FOREIGN KEY (IdVehiculo) REFERENCES Vehiculos(Id),
    CONSTRAINT FK_Asignaciones_Conductor FOREIGN KEY (IdConductor) REFERENCES Conductor(IdUsuario),
    CONSTRAINT FK_Asignaciones_Operador FOREIGN KEY (IdOperador) REFERENCES Despachador(IdUsuario) -- Referencia a IdUsuario de Operador
);

CREATE TABLE Cargas (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    IdVehiculo INT NOT NULL,
    TipoGas VARCHAR(50),
    Cantidad DECIMAL(10, 2),
    Estado VARCHAR(50),
    Excedente DECIMAL(10, 2),
    CONSTRAINT FK_Cargas_Vehiculo FOREIGN KEY (IdVehiculo) REFERENCES Vehiculos(Id)
);

CREATE TABLE Seguimientos (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    IdPedido INT NOT NULL,
    UbicacionActual VARCHAR(255),
    Estado VARCHAR(50),
    Tiempo DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Seguimientos_Pedido FOREIGN KEY (IdPedido) REFERENCES Pedidos(Id)
);

CREATE TABLE Turnos (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    IdConductor INT NOT NULL, -- FK a la tabla Conductor
    TipoTurno VARCHAR(100),
    Observacion VARCHAR(500),
    CONSTRAINT FK_Turnos_Conductor FOREIGN KEY (IdConductor) REFERENCES Conductor(IdUsuario)
);

CREATE TABLE ClasificacionesLogistica (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    IdProducto INT NOT NULL,
    TratamientoAlmacenamiento VARCHAR(500),
    TemperaturaAlmacenamiento DECIMAL(5, 2),
    CONSTRAINT FK_ClasificacionesLogistica_Producto FOREIGN KEY (IdProducto) REFERENCES Productos(Id)
);

CREATE TABLE DetallesProductoAlmacen (
    IdProducto INT NOT NULL,
    IdAlmacen INT NOT NULL,
    CantidadStock INT NOT NULL,
    UbicacionEnAlmacen VARCHAR(255),
    PRIMARY KEY (IdProducto, IdAlmacen),
    CONSTRAINT FK_DetallesProductoAlmacen_Producto FOREIGN KEY (IdProducto) REFERENCES Productos(Id),
    CONSTRAINT FK_DetallesProductoAlmacen_Almacen FOREIGN KEY (IdAlmacen) REFERENCES Almacenes(Id)
);

CREATE TABLE ZonasGeograficas (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Ubicacion VARCHAR(500) NOT NULL,
    Nombre VARCHAR(255),
    Descripcion VARCHAR(1000),
    IdEstacionDistribucion INT NULL,
    CONSTRAINT FK_ZonasGeograficas_EstacionDistribucion FOREIGN KEY (IdEstacionDistribucion) REFERENCES EstacionesDistribucion(Id)
);

CREATE TABLE DetallesAlmacenDistribucion (
    IdAlmacen INT NOT NULL,
    IdEstacionDistribucion INT NOT NULL,
    CantidadDespachada INT,
    FechaHora DATETIME NOT NULL DEFAULT GETDATE(),
    PRIMARY KEY (IdAlmacen, IdEstacionDistribucion),
    CONSTRAINT FK_DetallesAlmacenDistribucion_Almacen FOREIGN KEY (IdAlmacen) REFERENCES Almacenes(Id),
    CONSTRAINT FK_DetallesAlmacenDistribucion_EstacionDistribucion FOREIGN KEY (IdEstacionDistribucion) REFERENCES EstacionesDistribucion(Id)
);

-- ##########################################################################
-- TABLAS CON DEPENDENCIAS DE SEGUNDO NIVEL O RELACIONES CIRCULARES/REFLEXIVAS
-- ##########################################################################

CREATE TABLE Incidentes (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    IdTipoIncidente INT NOT NULL,
    IdVehiculo INT NULL,
    Ubicacion VARCHAR(255),
    FechaHora DATETIME NOT NULL DEFAULT GETDATE(),
    Descripcion VARCHAR(1000),
    NotificacionAExternos BIT,
    IdReporteIncidente INT NULL, -- FK a ReportesIncidente.Id (se añade después)
    CONSTRAINT FK_Incidentes_TiposIncidente FOREIGN KEY (IdTipoIncidente) REFERENCES TiposIncidente(Id),
    CONSTRAINT FK_Incidentes_Vehiculo FOREIGN KEY (IdVehiculo) REFERENCES Vehiculos(Id)
);

CREATE TABLE ReportesIncidente (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    IdIncidente INT UNIQUE NOT NULL,
    IdConductor INT NOT NULL, -- --- CAMBIO AQUI: Asociado a Conductor en lugar de Operador ---
    Descripcion VARCHAR(1000),
    Ubicacion VARCHAR(255),
    FechaHora DATETIME NOT NULL DEFAULT GETDATE(),
    IdReportePadre INT NULL, -- FK reflexiva (se añade después)
    ModificarReporte BIT,
    CONSTRAINT FK_ReportesIncidente_Incidente FOREIGN KEY (IdIncidente) REFERENCES Incidentes(Id),
    CONSTRAINT FK_ReportesIncidente_Conductor FOREIGN KEY (IdConductor) REFERENCES Conductor(IdUsuario) -- Referencia a IdUsuario de Conductor
);

-- Añadir FK reflexiva a ReportesIncidente
ALTER TABLE ReportesIncidente
ADD CONSTRAINT FK_ReportesIncidente_ReportePadre FOREIGN KEY (IdReportePadre) REFERENCES ReportesIncidente(Id);

-- Añadir FK de Incidentes a ReportesIncidente (ahora que ReportesIncidente existe)
ALTER TABLE Incidentes
ADD CONSTRAINT FK_Incidentes_ReporteIncidente FOREIGN KEY (IdReporteIncidente) REFERENCES ReportesIncidente(Id);


CREATE TABLE Rutas (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    PuntoInicio VARCHAR(255) NOT NULL,
    PuntoFin VARCHAR(255) NOT NULL,
    Distancia DECIMAL(10, 2),
    TiempoEstimado INT, -- En minutos, por ejemplo
    Condiciones VARCHAR(500),
    IdPedido INT NOT NULL,
    IdVehiculo INT NULL,
    Observaciones VARCHAR(500),
    FechaHora DATETIME NOT NULL DEFAULT GETDATE(),
    Estado VARCHAR(50),
    IdAsignacion INT NOT NULL, -- FK a Asignaciones.Id
    CONSTRAINT FK_Rutas_Pedido FOREIGN KEY (IdPedido) REFERENCES Pedidos(Id),
    CONSTRAINT FK_Rutas_Vehiculo FOREIGN KEY (IdVehiculo) REFERENCES Vehiculos(Id),
    CONSTRAINT FK_Rutas_Asignacion FOREIGN KEY (IdAsignacion) REFERENCES Asignaciones(Id)
);