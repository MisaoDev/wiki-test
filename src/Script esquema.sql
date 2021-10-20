-- Creación de base de datos
DROP DATABASE IF EXISTS sistema_web;
CREATE DATABASE sistema_web;

-- Creación de tablas
CREATE TABLE usuario (
  id_usuario        INT             PRIMARY KEY AUTO_INCREMENT,
  nombre            VARCHAR(40)     NOT NULL,
  apellido_paterno  VARCHAR(20)     ,
  apellido_materno  VARCHAR(20)     ,
  rut               VARCHAR(10)     ,
  email             VARCHAR(40)     NOT NULL,
  password_hash     BINARY(60)      NOT NULL,
  verificado        BOOLEAN         NOT NULL,
  es_admin          BOOLEAN         NOT NULL
);

CREATE TABLE método_pago (
  id_método_pago    INT             PRIMARY KEY AUTO_INCREMENT,
  nombre            VARCHAR(40)     NOT NULL
);

CREATE TABLE venta (
  id_venta          INT             PRIMARY KEY AUTO_INCREMENT,
  id_usuario        INT             NOT NULL,
  id_método_pago    INT             NOT NULL,
  hora              TIME            NOT NULL,
  fecha             DATE            NOT NULL,
  total             BIGINT          NOT NULL
);

CREATE TABLE categoría (
  id_categoría      INT             PRIMARY KEY AUTO_INCREMENT,
  nombre            VARCHAR(40)     NOT NULL
);

CREATE TABLE producto (
  id_producto       INT             PRIMARY KEY AUTO_INCREMENT,
  id_categoría      INT             NOT NULL,
  nombre            VARCHAR(40)     NOT NULL,
  precio            BIGINT          NOT NULL,
  descuento         INT             ,
  stock             INT             NOT NULL,
  eliminado         BOOLEAN         
);

CREATE TABLE detalle_venta (
  id_producto       INT             NOT NULL,
  id_venta          INT             NOT NULL,
  cantidad          INT             NOT NULL,
  precio            BIGINT          NOT NULL,
  PRIMARY KEY (id_producto, id_venta)
);

-- Definición de Constraints (FKs)
ALTER TABLE venta
  ADD CONSTRAINT fk_venta_usuario
  FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
  ON UPDATE CASCADE ON DELETE RESTRICT
  ,
  ADD CONSTRAINT fk_venta_métodopago
  FOREIGN KEY (id_método_pago) REFERENCES método_pago(id_método_pago)
  ON UPDATE CASCADE ON DELETE RESTRICT
;

ALTER TABLE producto
  ADD CONSTRAINT fk_producto_categoría
  FOREIGN KEY (id_categoría) REFERENCES categoría(id_categoría)
  ON UPDATE CASCADE ON DELETE SET NULL
;

ALTER TABLE detalle_venta
  ADD CONSTRAINT fk_detalle_producto
  FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
  ON UPDATE CASCADE ON DELETE RESTRICT
  ,
  ADD CONSTRAINT fk_detalle_venta
  FOREIGN KEY (id_venta) REFERENCES venta(id_venta)
  ON UPDATE CASCADE ON DELETE CASCADE
;
