
-- Apertura ejercicio Receptoria
-- 

select * from inEmpresas;


insert into inServicioCuentas
(
	SC_EMPRESA,
	SC_PLAN,
	SC_EJERCICIO,
	SC_SERVICIO,
	SC_CTA_INGRESOS,
	SC_CTA_PRESUPUESTO,
	SC_CTA_TOTAL,
	SC_CTA_SUB_INGRESOS,
	SC_CTA_SUB_PRESUP,
	SC_CTA_SUB_TOTAL,
	SC_CTA_REC_INGRESOS,
	SC_CTA_REC_PRESUP,
	SC_CTA_REC_TOTAL,
	SC_CTA_REZ_INGRESOS,
	SC_CTA_REZ_PRESUP,
	SC_CTA_REZ_TOTAL
)
select
	SC_EMPRESA,
	SC_PLAN,
	:newEjercicio,
	SC_SERVICIO,
	SC_CTA_INGRESOS,
	SC_CTA_PRESUPUESTO,
	SC_CTA_TOTAL,
	SC_CTA_SUB_INGRESOS,
	SC_CTA_SUB_PRESUP,
	SC_CTA_SUB_TOTAL,
	SC_CTA_REC_INGRESOS,
	SC_CTA_REC_PRESUP,
	SC_CTA_REC_TOTAL,
	SC_CTA_REZ_INGRESOS,
	SC_CTA_REZ_PRESUP,
  SC_CTA_REZ_TOTAL
from inServicioCuentas
where sc_empresa = :company and sc_ejercicio = :oldEjercicio;

insert into inTarifasConMed_AD
(
	TM_EMPRESA,
	TM_EJERCICIO,
	TM_AGUA_O_DRENAJE,
	TM_ES_DOMESTICO,
	TM_PERIODO,
	TM_RANGO_INF,
	TM_RANGO_SUP,
	TM_CUOTA_MINIMA_SM,
	TM_CUOTA_EXCEDENTE_SM,
	TM_USUARIO,
	TM_UPD_DATE
)
select 
	TM_EMPRESA,
	:newEjercicio,
	TM_AGUA_O_DRENAJE,
	TM_ES_DOMESTICO,
	TM_PERIODO,
	TM_RANGO_INF,
	TM_RANGO_SUP,
	TM_CUOTA_MINIMA_SM,
	TM_CUOTA_EXCEDENTE_SM,
	TM_USUARIO,
	TM_UPD_DATE
from inTarifasConMed_AD
where tm_empresa = :company and tm_ejercicio = :oldEjercicio;

insert into inTarifasSinMed_Agua
(
	TN_EMPRESA,
	TN_EJERCICIO,
	TN_TIPO_VIVIENDA,
	TN_DIAMETRO_TOMA,
	TN_PERIODO,
	TN_CUOTA_SM,
	TN_USUARIO,
	TN_UPD_DATE
)
select 
	TN_EMPRESA,
	:newEjercicio,
	TN_TIPO_VIVIENDA,
	TN_DIAMETRO_TOMA,
	TN_PERIODO,
	TN_CUOTA_SM,
	TN_USUARIO,
	TN_UPD_DATE
from inTarifasSinMed_Agua
where tn_empresa = :company and tn_ejercicio = :oldEjercicio;



insert into inCuentasContables
(
	CT_EMPRESA,
	CT_PLAN,
	CT_EJERCICIO,
	CT_CUENTA,
	CT_NOMBRE,
	CT_NIVEL,
	CT_USUARIO,
	CT_ORDEN
)
select 
	CT_EMPRESA,
	CT_PLAN,
	:newEjercicio,
	CT_CUENTA,
	CT_NOMBRE,
	CT_NIVEL,
	CT_USUARIO,
	CT_ORDEN
from inCuentasContables
where ct_empresa = :company and ct_ejercicio = :oldEjercicio;


insert into inTablasPredial
(
	TP_EMPRESA,
	TP_EJERCICIO,
	TP_LIMITE_INFERIOR,
	TP_LIMITE_SUPERIOR,
	TP_CUOTA_FIJA,
	TP_FACTOR
)
select 
	TP_EMPRESA,
	:newEjercicio,
	TP_LIMITE_INFERIOR,
	TP_LIMITE_SUPERIOR,
	TP_CUOTA_FIJA,
	TP_FACTOR
from inTablasPredial
where tp_empresa = :company and tp_ejercicio = :oldEjercicio;


insert into inTablasTrasladoDominio
(
	TD_EJERCICIO,
	TD_LIMITE_INFERIOR,
	TD_LIMITE_SUPERIOR,
	TD_CUOTA_FIJA,
	TD_FACTOR,
	TD_EMPRESA
)
select
	:newEjercicio,
	TD_LIMITE_INFERIOR,
	TD_LIMITE_SUPERIOR,
	TD_CUOTA_FIJA,
	TD_FACTOR,
	TD_EMPRESA
from inTablasTrasladoDominio
where td_ejercicio = :oldEjercicio and td_empresa = :company;


insert into inCobrosMinimos
(
	cm_empresa,
	cm_ejercicio,
	cm_minimo
)
select
	cm_empresa,
	:newEjercicio,
	cm_minimo
from inCobrosMinimos
where cm_empresa = :company and cm_ejercicio = :oldEjercicio;


insert into inSalariosminimos
(sm_empresa, sm_ejercicio, sm_zona, sm_valor)
select 
	sm_empresa, 
	:newEjercicio, 
	sm_zona, 
	102.64
from inSalariosMinimos
where sm_empresa = :company and sm_ejercicio = :oldEjercicio;



insert into inRecargoEjercicio
(re_empresa, re_ejercicio, re_pct_recargo)
select 
	re_empresa, 
	:newEjercicio,
	re_pct_recargo
from inRecargoEjercicio
where re_empresa = :company and re_ejercicio = :oldEjercicio;




insert into inActualizacionEjercicio
(ae_empresa, ae_ejercicio, ae_pct_actualizacion)
select
	ae_empresa,
	:newEjercicio,
	ae_pct_actualizacion
from inActualizacionEjercicio
where ae_empresa = :company and ae_ejercicio = :oldEjercicio;

commit;



update inEmpresas
set em_cfdi_contratados = em_cfdi_contratados + &adquiridos
where em_id = &company
/



select em_cfdi_contratados from inEmpresas where em_id = 19;


commit;



select * from inUsuarios
where us_id = 'sifi';


