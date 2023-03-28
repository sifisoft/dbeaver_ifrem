
DROP TABLE inComercio_pagos CASCADE CONSTRAINTS PURGE;

DROP TABLE inComercio_impuestos CASCADE CONSTRAINTS PURGE;

DROP TABLE inComercio_giros CASCADE CONSTRAINTS PURGE;

DROP TABLE inComercio_protecivil CASCADE CONSTRAINTS PURGE;

DROP TABLE inComercio_cobro_movil CASCADE CONSTRAINTS PURGE;

DROP TABLE inComercio_movimientos CASCADE CONSTRAINTS PURGE;

DROP TABLE inComercio_anuncios CASCADE CONSTRAINTS PURGE;

DROP TABLE inComercios CASCADE CONSTRAINTS PURGE;


CREATE TABLE inComercio_anuncios
(
    ca_empresa           NUMBER(4) NOT NULL ,
    ca_tipo              VARCHAR2(4) NOT NULL ,
    ca_control           NUMBER(8) NOT NULL ,
    ca_anuncio           VARCHAR2(4) NOT NULL ,
    ca_secuencia         NUMBER(4) NOT NULL ,
    ca_largo             NUMBER(12,2) NULL ,
    ca_ancho             NUMBER(12,2) NULL ,
    ca_area              NUMBER(15,2) NULL 
)
    TABLESPACE Ingresos
    STORAGE ( 
        INITIAL 1M
        NEXT 640K
        PCTINCREASE 20
     );



CREATE UNIQUE INDEX XPKinComercio_anuncios ON inComercio_anuncios
(ca_empresa   ASC,ca_tipo   ASC,ca_control   ASC,ca_anuncio   ASC,ca_secuencia   ASC);



ALTER TABLE inComercio_anuncios
    ADD CONSTRAINT  XPKinComercio_anuncios PRIMARY KEY (ca_empresa,ca_tipo,ca_control,ca_anuncio,ca_secuencia);



CREATE TABLE inComercio_cobro_movil
(
    cac_empresa          NUMBER(4) NOT NULL ,
    cac_tipo             VARCHAR2(4) NOT NULL ,
    cac_control          NUMBER(8) NOT NULL ,
    cac_numero_pago      NUMBER(12) NOT NULL ,
    cac_total            NUMBER(14,2) NULL ,
    cac_fecha_pago       DATE NULL ,
    cac_agente           VARCHAR2(18) NULL ,
    cac_notas            VARCHAR2(500) NULL 
)
    TABLESPACE Ingresos
    STORAGE ( 
        INITIAL 8M
        NEXT 1M
        PCTINCREASE 30
     );



CREATE UNIQUE INDEX XPKinComercio_cobro_movil ON inComercio_cobro_movil
(cac_empresa   ASC,cac_tipo   ASC,cac_control   ASC,cac_numero_pago   ASC);



ALTER TABLE inComercio_cobro_movil
    ADD CONSTRAINT  XPKinComercio_cobro_movil PRIMARY KEY (cac_empresa,cac_tipo,cac_control,cac_numero_pago);



CREATE TABLE inComercio_giros
(
    cg_empresa           NUMBER(4) NOT NULL ,
    cg_tipo              VARCHAR2(4) NOT NULL ,
    cg_control           NUMBER(8) NOT NULL ,
    cg_giro              VARCHAR2(4) NOT NULL 
)
    TABLESPACE Ingresos
    STORAGE ( 
        INITIAL 1M
        NEXT 640K
        PCTINCREASE 20
     );



CREATE UNIQUE INDEX XPKinComercio_giros ON inComercio_giros
(cg_empresa   ASC,cg_tipo   ASC,cg_control   ASC,cg_giro   ASC);



ALTER TABLE inComercio_giros
    ADD CONSTRAINT  XPKinComercio_giros PRIMARY KEY (cg_empresa,cg_tipo,cg_control,cg_giro);



CREATE TABLE inComercio_impuestos
(
    ci_empresa           NUMBER(4) NOT NULL ,
    ci_tipo              VARCHAR2(4) NOT NULL ,
    ci_control           NUMBER(8) NOT NULL ,
    ci_servicio          VARCHAR2(8) NOT NULL ,
    ci_total             NUMBER(15,2) NULL ,
    ci_fecha_alta        DATE NULL ,
    ci_notas             VARCHAR2(500) NULL ,
    ci_usuario           VARCHAR2(18) NULL 
)
    TABLESPACE Ingresos
    STORAGE ( 
        INITIAL 5M
        NEXT 640K
        PCTINCREASE 20
     );



CREATE UNIQUE INDEX XPKinComercio_impuestos ON inComercio_impuestos
(ci_empresa   ASC,ci_tipo   ASC,ci_control   ASC,ci_servicio   ASC);



ALTER TABLE inComercio_impuestos
    ADD CONSTRAINT  XPKinComercio_impuestos PRIMARY KEY (ci_empresa,ci_tipo,ci_control,ci_servicio);



CREATE TABLE inComercio_movimientos
(
    cm_empresa           NUMBER(4) NOT NULL ,
    cm_tipo              VARCHAR2(4) NOT NULL ,
    cm_control           NUMBER(8) NOT NULL ,
    cm_movimiento        VARCHAR2(5) NOT NULL ,
    cm_fecha_movimiento  DATE NOT NULL ,
    cm_valor_anterior    VARCHAR2(500) NULL ,
    cm_valor_nuevo       VARCHAR2(500) NULL ,
    cm_usuario           VARCHAR2(18) NULL ,
    cm_notas             VARCHAR2(500) NULL 
)
    TABLESPACE Ingresos
    STORAGE ( 
        INITIAL 2M
        NEXT 640K
        PCTINCREASE 20
     );



CREATE UNIQUE INDEX XPKinComercio_movimientos ON inComercio_movimientos
(cm_empresa   ASC,cm_tipo   ASC,cm_control   ASC,cm_movimiento   ASC,cm_fecha_movimiento   ASC);



ALTER TABLE inComercio_movimientos
    ADD CONSTRAINT  XPKinComercio_movimientos PRIMARY KEY (cm_empresa,cm_tipo,cm_control,cm_movimiento,cm_fecha_movimiento);



CREATE TABLE inComercio_pagos
(
    cp_empresa           NUMBER(4) NOT NULL ,
    cp_tipo              VARCHAR2(4) NOT NULL ,
    cp_control           NUMBER(8) NOT NULL ,
    cp_servicio          VARCHAR2(8) NOT NULL ,
    cp_ejercicio         NUMBER(4) NOT NULL ,
    cp_total             NUMBER(15,2) NULL ,
    cp_pagado            VARCHAR2(1) NULL ,
    cp_recibo            VARCHAR2(25) NULL ,
    cp_fecha_pago        DATE NULL ,
    cp_usuario           VARCHAR2(18) NULL 
)
    TABLESPACE Ingresos
    STORAGE ( 
        INITIAL 3M
        NEXT 640K
        PCTINCREASE 20
     );



CREATE UNIQUE INDEX XPKinComercio_pagos ON inComercio_pagos
(cp_empresa   ASC,cp_tipo   ASC,cp_control   ASC,cp_servicio   ASC,cp_ejercicio   ASC);



ALTER TABLE inComercio_pagos
    ADD CONSTRAINT  XPKinComercio_pagos PRIMARY KEY (cp_empresa,cp_tipo,cp_control,cp_servicio,cp_ejercicio);



CREATE TABLE inComercio_protecivil
(
    pc_empresa           NUMBER(4) NOT NULL ,
    pc_tipo              VARCHAR2(4) NOT NULL ,
    pc_control           NUMBER(8) NOT NULL ,
    pc_ejercicio         NUMBER(6) NOT NULL ,
    pc_certificado       VARCHAR2(1) NULL ,
    pc_fecha_alta        DATE NULL ,
    pc_usuario           VARCHAR2(18) NULL ,
    pc_notas             VARCHAR2(500) NULL 
);



CREATE UNIQUE INDEX XPKinComercio_protecivil ON inComercio_protecivil
(pc_empresa   ASC,pc_tipo   ASC,pc_control   ASC,pc_ejercicio   ASC);



ALTER TABLE inComercio_protecivil
    ADD CONSTRAINT  XPKinComercio_protecivil PRIMARY KEY (pc_empresa,pc_tipo,pc_control,pc_ejercicio);



CREATE TABLE inComercios
(
    com_empresa          NUMBER(4) NOT NULL ,
    com_tipo             VARCHAR2(4) NOT NULL ,
    com_control          NUMBER(8) NOT NULL ,
    com_contribuyente    NUMBER(7) NOT NULL ,
    com_denominacion     VARCHAR2(300) NULL ,
    com_nombre_propietario VARCHAR2(500) NULL ,
    com_ocupante         VARCHAR2(250) NULL ,
    com_frente           NUMBER(10,2) NULL ,
    com_fondo            NUMBER(10,2) NULL ,
    com_local            VARCHAR2(1) NULL ,
    com_ruta             VARCHAR2(20) NULL ,
    com_domicilio        VARCHAR2(60) NULL ,
    com_colonia          VARCHAR2(60) NULL ,
    com_cp               VARCHAR2(10) NULL ,
    com_telefono         VARCHAR2(25) NULL ,
    com_email            VARCHAR2(200) NULL ,
    com_domicilio_notificaciones VARCHAR2(500) NULL ,
    com_fecha_ingreso    DATE NULL ,
    com_fecha_baja       DATE NULL ,
    com_ult_eje          NUMBER(4) NULL ,
    com_horario          VARCHAR2(250) NULL ,
    com_notas            VARCHAR2(500) NULL ,
    com_status           VARCHAR2(2) NULL ,
    com_usuario          VARCHAR2(18) NULL 
)
    TABLESPACE Ingresos
    STORAGE ( 
        INITIAL 10M
        NEXT 1M
        PCTINCREASE 20
     );



CREATE UNIQUE INDEX XPKinComercios ON inComercios
(com_empresa   ASC,com_tipo   ASC,com_control   ASC);



ALTER TABLE inComercios
    ADD CONSTRAINT  XPKinComercios PRIMARY KEY (com_empresa,com_tipo,com_control);



ALTER TABLE inComercio_anuncios
    ADD (CONSTRAINT R_95 FOREIGN KEY (ca_empresa, ca_tipo, ca_control) REFERENCES inComercios (com_empresa, com_tipo, com_control));



ALTER TABLE inComercio_cobro_movil
    ADD (CONSTRAINT R_103 FOREIGN KEY (cac_empresa, cac_tipo, cac_control) REFERENCES inComercios (com_empresa, com_tipo, com_control));



ALTER TABLE inComercio_giros
    ADD (CONSTRAINT R_94 FOREIGN KEY (cg_empresa, cg_tipo, cg_control) REFERENCES inComercios (com_empresa, com_tipo, com_control));



ALTER TABLE inComercio_impuestos
    ADD (CONSTRAINT R_91 FOREIGN KEY (ci_empresa, ci_tipo, ci_control) REFERENCES inComercios (com_empresa, com_tipo, com_control));



ALTER TABLE inComercio_movimientos
    ADD (CONSTRAINT R_93 FOREIGN KEY (cm_empresa, cm_tipo, cm_control) REFERENCES inComercios (com_empresa, com_tipo, com_control));



ALTER TABLE inComercio_pagos
    ADD (CONSTRAINT R_92 FOREIGN KEY (cp_empresa, cp_tipo, cp_control) REFERENCES inComercios (com_empresa, com_tipo, com_control));



ALTER TABLE inComercio_protecivil
    ADD (CONSTRAINT R_98 FOREIGN KEY (pc_empresa, pc_tipo, pc_control) REFERENCES inComercios (com_empresa, com_tipo, com_control));



ALTER TABLE inComercios
    ADD (CONSTRAINT R_89 FOREIGN KEY (com_empresa, com_contribuyente) REFERENCES inContribuyentes (co_empresa, co_id));


    
/* DROPS */
/* Nuevas Tablas */

insert into inComercios
(com_empresa, com_tipo, com_control, com_contribuyente, com_denominacion, com_nombre_propietario, com_ocupante, com_frente, com_fondo, com_local, com_ruta, 
     com_domicilio, com_colonia, com_cp, com_telefono, com_email, com_domicilio_notificaciones, com_fecha_ingreso, com_fecha_baja, com_ult_eje, com_horario, com_notas, com_status, com_usuario)
select com_empresa, com_tipo, com_control, com_contribuyente, com_denominacion, com_nombre_propietario, com_ocupante, com_frente, com_fondo, com_local, com_ruta, 
     com_domicilio, com_colonia, com_cp, com_telefono, com_email, com_domicilio_notificaciones, com_fecha_ingreso, com_fecha_baja, com_ult_eje, com_horario, com_notas, com_status, com_usuario
from inComercios2;


insert into inComercio_impuestos
(ci_empresa, ci_tipo, ci_control, ci_servicio, ci_total, ci_fecha_alta, ci_notas, ci_usuario)
select ci_empresa, ci_tipo, ci_control, ci_servicio, ci_total, ci_fecha_alta, ci_notas, ci_usuario 
from inComercio_impuestos2;


insert into inComercio_pagos
(cp_empresa, cp_tipo, cp_control, cp_servicio, cp_ejercicio, cp_total, cp_pagado, cp_recibo, cp_fecha_pago, cp_usuario)
select cp_empresa, cp_tipo, cp_control, cp_servicio, cp_ejercicio, cp_total, cp_pagado, cp_recibo, cp_fecha_pago, cp_usuario 
from inComercio_pagos2;


insert into inComercio_giros
(cg_empresa, cg_tipo, cg_control, cg_giro)
select cg_empresa, cg_tipo, cg_control, cg_giro
from inComercio_giros2;


insert into inComercio_anuncios
(ca_empresa, ca_tipo, ca_control, ca_anuncio, ca_secuencia, ca_largo, ca_ancho, ca_area)
select ca_empresa, ca_tipo, ca_control, ca_anuncio, ca_secuencia, ca_largo, ca_ancho, ca_area
from inComercio_anuncios2;


insert into inComercio_protecivil
(pc_empresa, pc_tipo, pc_control, pc_ejercicio, pc_certificado, pc_fecha_alta, pc_usuario, pc_notas)
select pc_empresa, pc_tipo, pc_control, pc_ejercicio, pc_certificado, pc_fecha_alta, pc_usuario, pc_notas
from inComercio_proteCivil2;


insert into inComercio_movimientos
(cm_empresa, cm_control, cm_movimiento, cm_fecha_movimiento, cm_tipo, cm_valor_anterior, cm_valor_nuevo, cm_usuario, cm_notas)
select cm_empresa, cm_control, cm_movimiento, cm_fecha_movimiento, cm_tipo, cm_valor_anterior, cm_valor_nuevo, cm_usuario, cm_notas
from inComercio_movimientos2;


insert into inComercio_cobro_movil
(cac_empresa, cac_tipo, cac_control, cac_numero_pago, cac_total, cac_fecha_pago, cac_agente, cac_notas)
select cac_empresa, cac_tipo, cac_control, cac_numero_pago, cac_total, cac_fecha_pago, cac_agente, cac_notas
from inComercio_cobro_movil2;


    
    