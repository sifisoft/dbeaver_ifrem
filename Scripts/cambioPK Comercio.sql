
alter table inCxC add cxc_tipo_comercio varchar2(2);

alter table inRecibo add re_tipo_comercio varchar2(2);

create table inComercios2 as select * from inComercios;

create table inComercio_impuestos2 as select * from inComercio_impuestos;

create table inComercio_pagos2 as select * from inComercio_pagos;

create table inComercio_giros2 as select * from inComercio_giros;

create table inComercio_anuncios2 as select * from inComercio_anuncios;

create table inComercio_protecivil2 as select * from inComercio_protecivil;

create table inComercio_movimientos2 as select * from inComercio_movimientos;

create table inComercio_cobro_movil2 as select * from inComercio_cobro_movil;

alter table inComercio_impuestos2 add ci_tipo varchar2(2);

alter table inComercio_pagos2 add cp_tipo varchar2(2);

alter table inComercio_giros2 add cg_tipo varchar2(2);

alter table inComercio_anuncios2 add ca_tipo varchar2(2);

alter table inComercio_protecivil2 add pc_tipo varchar2(2);

alter table inComercio_movimientos2 add cm_tipo varchar2(2);

alter table inComercio_cobro_movil2 add cac_tipo varchar2(2);


update inComercio_impuestos2
set ci_tipo = ( select com_tipo from inComercios where com_empresa = ci_empresa and com_contribuyente = ci_contribuyente and com_control = ci_control);

update inComercio_pagos2
set cp_tipo = ( select com_tipo from inComercios where com_empresa = cp_empresa and com_contribuyente = cp_contribuyente and com_control = cp_control);

update inComercio_giros2
set cg_tipo = ( select com_tipo from inComercios where com_empresa = cg_empresa and com_contribuyente = cg_contribuyente and com_control = cg_control);

update inComercio_anuncios2
set ca_tipo = ( select com_tipo from inComercios where com_empresa = ca_empresa and com_contribuyente = ca_contribuyente and com_control = ca_control);

update inComercio_protecivil2
set pc_tipo = ( select com_tipo from inComercios where com_empresa = pc_empresa and com_contribuyente = pc_contribuyente and com_control = pc_control);

update inComercio_movimientos2
set cm_tipo = ( select com_tipo from inComercios where com_empresa = cm_empresa and com_contribuyente = cm_contribuyente and com_control = cm_control);

update inComercio_cobro_movil2
set cac_tipo = ( select com_tipo from inComercios where com_empresa = cac_empresa and com_contribuyente = cac_contribuyente and com_control = cac_control);



 


