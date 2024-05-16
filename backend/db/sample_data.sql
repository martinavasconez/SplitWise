-- Inserting Users
INSERT INTO Usuarios (nombre, correo, password) VALUES ('Gaby', 'gaby@example.com', 'pass');
INSERT INTO Usuarios (nombre, correo, password) VALUES ('Martina', 'martina@example.com', 'pass');

-- Assuming the above inserts result in Gaby having ID 1 and Martina having ID 2

-- Creating Group
INSERT INTO Grupos (nombre, detalles, total) VALUES ('Salida Zens', 'Nos encontramos en la U a las 8 pm y salimos juntos al Zens', 90.00);

-- Assuming the above insert results in the group having ID 1000

-- Associating Users with the Group
INSERT INTO Usuario_Grupo (usuario_id, grupo_id) VALUES (1, 1000); -- Gaby joins the group
INSERT INTO Usuario_Grupo (usuario_id, grupo_id) VALUES (2, 1000); -- Martina joins the group

-- Inserting Articles
-- Assuming Gaby buys 2 items and Martina buys 1 item
INSERT INTO Articulos (grupo_id, usuario_id, nombre_articulo, costo) VALUES (1000, 1, 'Botella', 30.00);
INSERT INTO Articulos (grupo_id, usuario_id, nombre_articulo, costo) VALUES (1000, 1, 'Uber', 10.00);
INSERT INTO Articulos (grupo_id, usuario_id, nombre_articulo, costo) VALUES (1000, 2, 'Entradas', 50.00);