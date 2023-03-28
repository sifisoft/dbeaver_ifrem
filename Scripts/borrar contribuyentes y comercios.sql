

/* borrar comercio */

select * from inComercios where com_empresa = :empresa and com_tipo = 'S';

select * from inEmpresas;

select count(*) from inComercios where com_empresa = :empresa and com_tipo = 'S';


delete from inComercio_impuestos where ci_empresa = :empresa and ci_tipo = 'S';

delete from inComercio_pagos where cp_empresa = :empresa and cp_tipo = 'S';

delete from inComercio_anuncios where ca_empresa = :empresa and ca_tipo = 'S';

delete from inComercio_movimientos where cm_empresa = :empresa and cm_tipo = 'S';

delete from inComercio_cobro_movil where cac_empresa = :empresa and cac_tipo = 'S';

delete from inComercios where com_empresa = :empresa and com_tipo = 'S';

delete from inComercio_giros where cg_empresa = :empresa and cg_tipo = 'S';

delete from inComercio_imgs where ci_empresa = :empresa and ci_tipo = 'S';

delete from inComercio_protecivil where pc_empresa = :empresa and pc_tipo = 'S';

select * from inComercios where com_empresa = :empresa and com_control = :control;

select * from inComercios where com_empresa = :empresa and com_tipo = 'S';







delete from inComercio_impuestos where ci_empresa = :empresa and ci_tipo = :tipo and  ci_control = :control;

delete from inComercio_pagos where cp_empresa = :empresa and cp_tipo = :tipo and cp_control = :control;

delete from inComercio_anuncios where ca_empresa = :empresa and ca_tipo = :tipo and ca_control = :control;

delete from inComercio_protecivil where pc_empresa = :empresa and pc_tipo = :tipo and pc_control = :control;

delete from inComercio_movimientos where cm_empresa = :empresa and cm_tipo = :tipo and cm_control = :control ;

delete from inComercio_imgs where ci_empresa = :empresa and ci_tipo = :tipo and ci_control = :control;

delete from inComercio_cobro_movil where cac_empresa = :empresa and cac_tipo  = :tipo and cac_control = :control;

delete from inComercio_giros where cg_empresa  = :empresa and cg_tipo = :tipo and cg_control = :control;

delete from inComercios where com_empresa = :empresa and com_tipo = :tipo and com_control = :control;


select * from all_constraints where constraint_name = 'R_104';


select *
from inMetaCampos
where mc_empresa = 12 and mc_tabla = 55

delete from inMetaCampos
where mc_empresa = 12 and mc_tabla = 55 and mc_campo <> 'AJ'

select t.*, t.rowid 
from inAgentesRutas t
where ar_empresa = 12

select t.*, t.rowid
from inAgentesmoviles t
where am_empresa = 12

select t.*, t.rowid
from inComercio_cobro_movil t
where cac_empresa = 12


select *
from inComercios t
where com_empresa = 12

delete from inComercio_impuestos where ci_empresa = 12

delete from inComercio_pagos where cp_empresa = 12

delete from inComercio_anuncios where ca_empresa = 12

delete from inComercio_protecivil where pc_empresa = 12


delete from inComercio_movimientos where cm_empresa = 12


delete from inComercio_imgs where ci_empresa = 12

delete from inComercio_cobro_movil where cac_empresa = 12

delete from inComercio_giros where cg_empresa  = 12

delete from inComercios where com_empresa = 12

delete from inContribuyentes where co_empresa = 12 and co_id <> 0
