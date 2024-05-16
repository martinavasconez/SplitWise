-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS splitwise;

-- Switch to the spicesync database
USE splitwise;

-- Create table for Usuarios
CREATE TABLE Usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    correo VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);

-- Create table for Grupos
CREATE TABLE Grupos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    detalles TEXT,
    total DECIMAL(10, 2) DEFAULT 0.00
) AUTO_INCREMENT = 1000; -- four digit group IDs

-- Create table for Articulos
CREATE TABLE Articulos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    grupo_id INT,
    usuario_id INT,
    nombre_articulo VARCHAR(255),
    costo DECIMAL(10, 2),
    FOREIGN KEY (grupo_id) REFERENCES Grupos(id),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id)
);

-- Create table for Deudas
CREATE TABLE Deudas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    grupo_id INT,
    usuario_deudor_id INT,
    usuario_creditor_id INT,
    monto DECIMAL(10, 2),
    FOREIGN KEY (grupo_id) REFERENCES Grupos(id),
    FOREIGN KEY (usuario_deudor_id) REFERENCES Usuarios(id),
    FOREIGN KEY (usuario_creditor_id) REFERENCES Usuarios(id)
);

-- Create table for Usuario_Grupo relationship
CREATE TABLE Usuario_Grupo (
    usuario_id INT,
    grupo_id INT,
    PRIMARY KEY (usuario_id, grupo_id),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id),
    FOREIGN KEY (grupo_id) REFERENCES Grupos(id)
);