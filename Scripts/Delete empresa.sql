

delete from inMetaCampos where mc_empresa = :empresa;

delete from inMetaTablas where mt_empresa = :empresa;

delete from inTablasAguaFijo where cf_empresa = :empresa;

delete from inServicioCuentas where sc_empresa = :empresa;

delete from inServicios where sr_empresa = :empresa;

delete from inDependencias where de_empresa = :empresa;

delete from inVencimientos where ven_empresa = :empresa;

delete from inContribuyentes where co_empresa = :empresa;

delete from inUsuario_empresas where ue_empresa = :empresa;

delete from inUsuario_opciones where uo_empresa = :empresa;

delete from inMenu where me_empresa = :empresa;

delete from inCuentasContables where ct_empresa = :empresa;

delete from inActualizacionEjercicio where ae_empresa = :empresa;

delete from inRecargoEjercicio where re_empresa = :empresa;

delete from inSalariosMinimos where sm_empresa = :empresa;

delete from inCobrosMinimos where cm_empresa = :empresa;

delete from inTablasTrasladoDominio where td_empresa = :empresa;

delete from inTablasPredial where tp_empresa = :empresa;

delete from inEmpresas where em_id = :empresa;


select * 
from inUsuario_opciones
where uo_empresa = 10 
order by uo_opcion


delete from inMenu where me_empresa = 10