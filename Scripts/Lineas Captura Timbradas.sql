



-- conteo uuid por mes
select  re_uuid, nvl(re_folio_remanentes, re_folio), re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and nvl(re_status,'X') = 'A' and to_char(re_fecha_pago,'MMYYYY')  = 062021   
group by  re_uuid, nvl(re_folio_remanentes, re_folio), re_serie
order by 1,2



select t.*, t.rowid from inRecibo t where re_linea_captura = :lineaCaptura;


select t.*, t.rowid from inRecibo t where re_uuid = :uuid;


select t.re_folio_remanentes,t.re_cantidad,t.re_total,  t.*, t.rowid from inRecibo t where re_linea_captura = :lineaCaptura;


-- Reactivar recibo
select re_empresa, re_recibo, re_status, re_cxl_user, re_cxl_date, re_total, re_cancelado, t.rowid from inRecibo t where re_linea_captura = :lineaCaptura;

-- Fecha pago
select re_empresa, re_recibo, re_fecha_pago, t.rowid from inRecibo t where re_linea_captura = :lineaCaptura;
















select  re_uuid, nvl(re_folio_remanentes, re_folio), re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and nvl(re_status,'X') = 'A' and to_char(re_fecha_pago,'MMYYYY') = :numeroMes 
group by  re_uuid, nvl(re_folio_remanentes, re_folio), re_serie
order by 1,2;


select re_uuid, sum(re_total), sum(re_impuesto*re_cantidad), count(*)
from inRecibo
where re_fecha_pago between '01-feb-21' and '28-feb-31' and re_folio_remanentes is not null
group by re_uuid;

select re_linea_captura
from inRecibo
where re_fecha_pago between '01-feb-21' and '28-feb-31' 
having nd sum(re_total) != sum(re_impuesto*re_cantidad)
group by re_linea_captura;









-- Guardar folios y series 2020
create table cfdi2020 ( folio varchar2(50), serie varchar2(10)); 

insert into cfdi2020
select  nvl(re_folio_remanentes, re_folio) folio, re_serie serie
from inRecibo
where re_uuid is not null and nvl(re_status,'X') = 'A' and to_char(re_fecha_pago,'MM') between 5 and 12   
group by  nvl(re_folio_remanentes, re_folio), re_serie
order by 1,2

-- cfdi cancleados
select folios from xmls2020
minus
select folio||'-'||serie||'.xml'
from cfdi2020;

select folio||'-'||serie||'.xml'
from cfdi2020
where not exists (
    select 1
    from xmls2020
    where folios = folio||'-'||serie||'.xml' 
);










select re_folio, re_uuid, re_fecha_pago, re_linea_captura, re_total from inRecibo where re_uuid = :uuid order by re_fecha_pago


select re_uuid, count(*)
from 
(
select  re_uuid, to_char(re_fecha_pago,'MM')
from inRecibo
where re_uuid is not null and nvl(re_status,'X') = 'A' and to_char(re_fecha_pago,'MM') between 5 and 12   
group by  re_uuid, to_char(re_fecha_pago,'MM')
)
group by re_uuid
having count(*) > 1










--------------------------------------------------------------------------------
select  re_uuid, nvl(re_folio_remanentes, re_folio), re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_pago,'MM') = :numeroMes 
group by  re_uuid, nvl(re_folio_remanentes, re_folio), re_serie
order by 1,2
--------------------------------------------------------------------------------


select  re_uuid, nvl(re_folio_remanentes, re_folio), re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_pago,'MM') = :numeroMes 
group by  re_uuid, nvl(re_folio_remanentes, re_folio), re_serie
order by 1,2;



--------------------------------------------------------------------------------
select  re_uuid, nvl(re_folio_remanentes, re_folio), re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_pago,'MM') = :numeroMes 
group by  re_uuid, nvl(re_folio_remanentes, re_folio), re_serie
order by 1,2
--------------------------------------------------------------------------------
select  re_uuid, nvl(re_folio_remanentes, re_folio), re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_pago,'MM') = :numeroMes 
group by  re_uuid, nvl(re_folio_remanentes, re_folio), re_serie
order by 1,2
--------------------------------------------------------------------------------
select  re_uuid, nvl(re_folio_remanentes, re_folio), re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_pago,'MM') = :numeroMes 
group by  re_uuid, nvl(re_folio_remanentes, re_folio), re_serie
order by 1,2
--------------------------------------------------------------------------------
select  re_uuid, nvl(re_folio_remanentes, re_folio), re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_pago,'MM') = :numeroMes 
group by  re_uuid, nvl(re_folio_remanentes, re_folio), re_serie
order by 1,2
--------------------------------------------------------------------------------
select  re_uuid, nvl(re_folio_remanentes, re_folio), re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_pago,'MM') = :numeroMes 
group by  re_uuid, nvl(re_folio_remanentes, re_folio), re_serie
order by 1,2
--------------------------------------------------------------------------------
select  re_uuid, nvl(re_folio_remanentes, re_folio), re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_pago,'MM') = :numeroMes 
group by  re_uuid, nvl(re_folio_remanentes, re_folio), re_serie
order by 1,2
--------------------------------------------------------------------------------
select  re_uuid, nvl(re_folio_remanentes, re_folio), re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_pago,'MM') = :numeroMes 
group by  re_uuid, nvl(re_folio_remanentes, re_folio), re_serie
order by 1,2
--------------------------------------------------------------------------------
select trunc(re_fecha_pago), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_pago,'MM') = :numeroMes 
group by trunc(re_fecha_pago), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie
order by 1,2
--------------------------------------------------------------------------------
select trunc(re_fecha_pago), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_pago,'MM') = :numeroMes 
group by trunc(re_fecha_pago), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie
order by 1,2
--------------------------------------------------------------------------------
select trunc(re_fecha_pago), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_pago,'MM') = :numeroMes 
group by trunc(re_fecha_pago), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie
order by 1,2
--------------------------------------------------------------------------------
select trunc(re_fecha_pago), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_pago,'MM') = :numeroMes 
group by trunc(re_fecha_pago), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie
order by 1,2
--------------------------------------------------------------------------------
select trunc(re_fecha_pago), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_pago,'MM') = :numeroMes 
group by trunc(re_fecha_pago), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie
order by 1,2
--------------------------------------------------------------------------------
select trunc(re_fecha_pago), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_pago,'MM') = :numeroMes 
group by trunc(re_fecha_pago), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie
order by 1,2
--------------------------------------------------------------------------------
select trunc(re_fecha_pago), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_pago,'MM') = :numeroMes 
group by trunc(re_fecha_pago), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie
order by 1,2
--------------------------------------------------------------------------------
select trunc(re_fecha_pago), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_pago,'MM') = :numeroMes 
group by trunc(re_fecha_pago), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie
order by 1,2
--------------------------------------------------------------------------------
select trunc(re_fecha_pago), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_pago,'MM') = :numeroMes 
group by trunc(re_fecha_pago), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie
order by 1,2
--------------------------------------------------------------------------------
select trunc(re_fecha_pago), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_pago,'MM') = :numeroMes 
group by trunc(re_fecha_pago), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie
order by 1,2
--------------------------------------------------------------------------------
select trunc(re_fecha_pago), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_pago,'MM') = :numeroMes 
group by trunc(re_fecha_pago), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie
order by 1,2
--------------------------------------------------------------------------------
select trunc(re_fecha_pago), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_pago,'MM') = :numeroMes 
group by trunc(re_fecha_pago), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie
order by 1,2
--------------------------------------------------------------------------------
select to_char(re_fecha_pago, 'MM') as MES , count( unique re_uuid)
from inRecibo
where re_uuid is not null and re_fecha_pago >= '01-apr-20'
group by to_char(re_fecha_pago, 'MM')
order by 1
--------------------------------------------------------------------------------
select to_char(re_fecha_pago, 'MM') as MES , count( unique re_uuid)
from inRecibo
where re_uuid is not null and re_fecha_pago >= '01-apr-20'
group by to_char(re_fecha_pago, 'MM')
order by 1
--------------------------------------------------------------------------------
select to_char(re_fecha_timbrado, 'MM') as MES , count( unique re_uuid)
from inRecibo
where re_uuid is not null and re_fecha_timbrado >= '01-may-20'
group by to_char(re_fecha_timbrado, 'MM')
order by 1
--------------------------------------------------------------------------------
select re_fecha_timbrado, to_char(re_fecha_timbrado, 'MON') , re_uuid
from inRecibo
where re_uuid is not null
order by 1
--------------------------------------------------------------------------------
select trunc(re_fecha_timbrado), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_timbrado,'MM') = :numeroMes 
group by trunc(re_fecha_timbrado), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie
order by 1,2
--------------------------------------------------------------------------------
select trunc(re_fecha_timbrado), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_timbrado,'MM') = :numeroMes 
group by trunc(re_fecha_timbrado), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie
order by 1,2
--------------------------------------------------------------------------------
select trunc(re_fecha_timbrado), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_timbrado,'MM') = :numeroMes 
group by trunc(re_fecha_timbrado), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie
order by 1,2
--------------------------------------------------------------------------------
select trunc(re_fecha_timbrado), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_timbrado,'MM') = :numeroMes 
group by trunc(re_fecha_timbrado), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie
order by 1,2
--------------------------------------------------------------------------------
select trunc(re_fecha_timbrado), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_timbrado,'MM') = :numeroMes 
group by trunc(re_fecha_timbrado), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie
order by 1,2
--------------------------------------------------------------------------------
select trunc(re_fecha_timbrado), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_timbrado,'MM') = :numeroMes 
group by trunc(re_fecha_timbrado), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie
order by 1,2
--------------------------------------------------------------------------------
select trunc(re_fecha_timbrado), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_timbrado,'MM') = :numeroMes 
group by trunc(re_fecha_timbrado), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie
order by 1,2
--------------------------------------------------------------------------------
select trunc(re_fecha_timbrado), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_timbrado,'MM') = :numeroMes 
group by trunc(re_fecha_timbrado), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie
order by 1,2
--------------------------------------------------------------------------------
select trunc(re_fecha_timbrado), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_timbrado,'MM') = :numeroMes 
group by trunc(re_fecha_timbrado), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie
order by 1,2
--------------------------------------------------------------------------------
select re_fecha_timbrado, re_uuid, nvl(re_folio_remanentes, re_folio), re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_timbrado,'MM') = :numeroMes 
group by re_fecha_timbrado, re_uuid, nvl(re_folio_remanentes, re_folio), re_serie
order by 1,2
--------------------------------------------------------------------------------
select trunc(re_fecha_timbrado), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_timbrado,'MM') = :numeroMes 
group by trunc(re_fecha_timbrado), re_uuid, nvl(re_folio_remanentes, re_folio), re_serie
order by 1,2
--------------------------------------------------------------------------------
select trunc(re_fecha_timbrado), re_uuid, re_folio_remanentes, re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_timbrado,'MM') = :numeroMes 
group by trunc(re_fecha_timbrado), re_uuid, re_folio_remanentes, re_serie
order by 1,2
--------------------------------------------------------------------------------
select trunc(re_fecha_timbrado), re_uuid, re_folio, re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_timbrado,'MM') = :numeroMes 
group by trunc(re_fecha_timbrado), re_uuid, re_folio, re_serie
order by 1,2
--------------------------------------------------------------------------------
select re_fecha_timbrado, re_uuid, re_folio, re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_timbrado,'MM') = :numeroMes 
group by re_fecha_timbrado, re_uuid, re_folio, re_serie
order by 1,2
--------------------------------------------------------------------------------
select re_fecha_timbrado, re_uuid, re_folio, re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_timbrado,'MM') = :numeroMes 
group by re_fecha_timbrado, re_uuid, re_folio, re_serie
order by 1,2
--------------------------------------------------------------------------------
select re_fecha_timbrado, re_uuid, re_folio, re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_timbrado,'MM') = :numeroMes 
group by re_fecha_timbrado, re_uuid, re_folio, re_serie
order by 1,2
--------------------------------------------------------------------------------
select re_fecha_timbrado, re_uuid, re_folio, re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_timbrado,'MM') = :numeroMes 
group by re_fecha_timbrado, re_uuid, re_folio, re_serie
order by 1,2
--------------------------------------------------------------------------------
select re_fecha_timbrado, re_uuid, re_folio, re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_timbrado,'MM') = :numeroMes 
group by re_fecha_timbrado, re_uuid, re_folio, re_serie
order by 1,2
--------------------------------------------------------------------------------
select re_fecha_timbrado, re_uuid, re_folio, re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_timbrado,'MM') = :numeroMes 
group by re_fecha_timbrado, re_uuid, re_folio, re_serie
order by 1,2
--------------------------------------------------------------------------------
select re_fecha_timbrado, re_uuid, re_folio, re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_timbrado,'MM') = :numeroMes 
group by re_fecha_timbrado, re_uuid, re_folio, re_serie
order by 1,2
--------------------------------------------------------------------------------
select re_fecha_timbrado, re_uuid, re_folio, re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_timbrado,'MM') = :numeroMes 
group by re_fecha_timbrado, re_uuid, re_folio, re_serie
order by 1,2
--------------------------------------------------------------------------------
select re_fecha_timbrado, re_uuid, re_folio, re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_timbrado,'MM') = 6 
group by re_fecha_timbrado, re_uuid, re_folio, re_serie
order by 1,2
--------------------------------------------------------------------------------
select re_fecha_timbrado, re_uuid, re_folio, re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and to_char(re_fecha_timbrado,'MM') = 6 
group by re_fecha_timbrado, re_uuid, re_folio, re_serie
order by 1
--------------------------------------------------------------------------------
select to_char(re_fecha_timbrado, 'MM') as MES , count( unique re_uuid)
from inRecibo
where re_uuid is not null and re_fecha_timbrado >= '01-may-20'
group by to_char(re_fecha_timbrado, 'MM')
order by 1
--------------------------------------------------------------------------------
select to_char(re_fecha_timbrado, 'MM') , count( unique re_uuid)
from inRecibo
where re_uuid is not null and re_fecha_timbrado >= '01-may-20'
group by to_char(re_fecha_timbrado, 'MM')
order by 1
--------------------------------------------------------------------------------
select to_char(re_fecha_timbrado, 'MM') , count(*)
from inRecibo
where re_uuid is not null and re_fecha_timbrado >= '01-may-20'
group by to_char(re_fecha_timbrado, 'MM')
order by 1
--------------------------------------------------------------------------------
select to_char(re_fecha_timbrado, 'MM') , re_uuid
from inRecibo
where re_uuid is not null and re_fecha_timbrado >= '01-may-20'
order by 1
--------------------------------------------------------------------------------
select re_fecha_timbrado, to_char(re_fecha_timbrado, 'MM') , re_uuid
from inRecibo
where re_uuid is not null and re_fecha_timbrado >= '01-may-20'
order by 1
--------------------------------------------------------------------------------
select to_char(re_fecha_timbrado, 'MM') , re_uuid
from inRecibo
where re_uuid is not null and re_fecha_timbrado >= '01-may-20'
order by 1
--------------------------------------------------------------------------------
select to_char(re_fecha_timbrado, 'MON') , re_uuid
from inRecibo
where re_uuid is not null and re_fecha_timbrado >= '01-may-20'
order by 1
--------------------------------------------------------------------------------
select re_fecha_timbrado, to_char(re_fecha_timbrado, 'MON') , re_uuid
from inRecibo
where re_uuid is not null
order by 1
--------------------------------------------------------------------------------
select re_fecha_timbrado, re_uuid
from inRecibo
where re_uuid is not null
order by 1
--------------------------------------------------------------------------------
select re_fecha_timbrado, re_uuid
from inRecibo
where re_uuid is not null
--------------------------------------------------------------------------------
select re_uuid, re_fecha_timbrado
from inRecibo
where re_uuid is not null
--------------------------------------------------------------------------------
select re_uuid, re_fecha_timbrado
from inRecibo
--------------------------------------------------------------------------------
select *
from inRecibo
--------------------------------------------------------------------------------
select unique ma_charter
from rsmaes
where trunc(ma_inp_d) = trunc(sysdate) and ma_inp_u = 'OMNIBEES'
order by 1
--------------------------------------------------------------------------------
select unique ma_charter
from rsmaes
where trunc(ma_inp_d) = trunc(sysdate) and ma_inp_u = 'OMNIBEES'
--------------------------------------------------------------------------------
select to_char(re_fecha_pago,'mm'), count(unique re_folio)
from inRecibo
where re_timbrado = '1'
group by  to_char(re_fecha_pago,'mm')
order by 1
--------------------------------------------------------------------------------
select to_char(re_fecha_pago,'mon'), count(unique re_folio)
from inRecibo
where re_timbrado = '1'
group by  to_char(re_fecha_pago,'mon')
order by 1
--------------------------------------------------------------------------------
select to_char(re_fecha_pago,'mon'), count(*)
from inRecibo
where re_timbrado = '1'
group by  to_char(re_fecha_pago,'mon')
order by 1
--------------------------------------------------------------------------------
select to_char(re_fecha_pago,'mon')
from inRecibo
where re_timbrado = '1'
group by  to_char(re_fecha_pago,'mon')
order by 1
--------------------------------------------------------------------------------
select to_char(re_fecha_timbrado,'mon')
from inRecibo
where re_timbrado = '1'
group by  to_char(re_fecha_timbrado,'mon')
order by 1
--------------------------------------------------------------------------------
select re_folio, to_char(re_fecha_timbrado,'mon')
from inRecibo
where re_timbrado = '1'
group by re_folio, to_char(re_fecha_timbrado,'mon')
order by 2
--------------------------------------------------------------------------------
select re_folio, to_char(re_fecha_timbrado,'mm')
from inRecibo
where re_timbrado = '1'
group by re_folio, to_char(re_fecha_timbrado,'mm')
order by 2
--------------------------------------------------------------------------------
select re_folio, to_char(re_fecha_timbrado,'mm')
from inRecibo
where re_timbrado = '1'
group by re_folio, to_char(re_fecha_timbrado,'mm')
order by 1
--------------------------------------------------------------------------------
select re_folio, to_char(re_fecha_timbrado,'mon')
from inRecibo
where re_timbrado = '1'
group by re_folio, to_char(re_fecha_timbrado,'mon')
order by 1
--------------------------------------------------------------------------------
select re_folio, to_char(re_fecha_timbrado,'mon')
from inRecibo
where re_timbrado = '1'
group by re_folio, to_char(re_fecha_timbrado,'mon')
order by 2
--------------------------------------------------------------------------------
select re_folio, re_fecha_timbrado
from inRecibo
where re_timbrado = '1'
group by re_folio, re_fecha_timbrado
order by 2
--------------------------------------------------------------------------------
select re_folio, re_fecha_timbrado
from inRecibo
where re_timbrado = '1'
group by re_folio, re_fecha_timbrado
order by 1
--------------------------------------------------------------------------------
select re_folio, re_fecha_timbrado
from inRecibo
where re_timbrado = '1'
group by re_folio, re_fecha_timbrado
--------------------------------------------------------------------------------
select to_char(trunc(re_fecha_timbrado,'MONTH'),'MON'), count(*)
from (
select re_folio, re_fecha_timbrado
from inRecibo
where re_timbrado = '1'
group by re_folio, re_fecha_timbrado
)
group by to_char(trunc(re_fecha_timbrado,'MONTH'),'MON')
order by 1
--------------------------------------------------------------------------------
select trunc(re_fecha_timbrado,'MONTH'), count(*)
from (
select re_folio, re_fecha_timbrado
from inRecibo
where re_timbrado = '1'
group by re_folio, re_fecha_timbrado
)
group by trunc(re_fecha_timbrado,'MONTH')
order by 1
--------------------------------------------------------------------------------
select trunc(re_fecha_timbrado,'MONTH'), count(*)
from (
select re_folio, re_fecha_timbrado
from inRecibo
where re_timbrado = '1'
group by re_folio, re_fecha_timbrado
)
group by trunc(re_fecha_timbrado,'MONTH')
--------------------------------------------------------------------------------
select re_folio, re_fecha_timbrado
from inRecibo
where re_timbrado = '1'
group by re_folio, re_fecha_timbrado
order by 2
--------------------------------------------------------------------------------
select re_folio, re_fecha_timbrado
from inRecibo
where re_timbrado = '1'
group by re_folio, re_fecha_timbrado
order by 2
--------------------------------------------------------------------------------
select re_folio, re_fecha_timbrado
from inRecibo
where re_timbrado = '1'
group by re_folio, re_fecha_timbrado
order by 1
--------------------------------------------------------------------------------
select trunc(re_fecha_pago,'MONTH'), count(*)
from inRecibo
where re_timbrado = '1'
group by trunc(re_fecha_pago,'MONTH')
order by 1
--------------------------------------------------------------------------------
select trunc(re_fecha_timbrado,'MONTH'), count(*)
from inRecibo
where re_timbrado = '1'
group by trunc(re_fecha_timbrado,'MONTH')
order by 1
--------------------------------------------------------------------------------
select trunc(re_fecha_timbrado,'MONTH'), count(*)
from inRecibo
where re_timbrado = '1'
group by trunc(re_fecha_timbrado,'MONTH')
--------------------------------------------------------------------------------
select *
from inRecibo