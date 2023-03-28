


select *
from inRecibo

select re_fecha_timbrado, to_char(re_fecha_timbrado, 'MON') , re_uuid
from inRecibo
where re_uuid is not null
order by 1



select to_char(re_fecha_timbrado, 'MM') , re_uuid
from inRecibo
where re_uuid is not null and re_fecha_timbrado >= '01-may-20'
order by 1


select to_char(re_fecha_pago, 'MM') as MES , count( unique re_uuid)
from inRecibo
where re_uuid is not null and re_fecha_pago >= '01-apr-20'
group by to_char(re_fecha_pago, 'MM')
order by 1;



select  re_uuid, nvl(re_folio_remanentes, re_folio), re_serie, count(*) cantidad_lineas
from inRecibo
where re_uuid is not null and re_fecha_pago >= trunc(sysdate,'YEAR') and  to_number(to_char(re_fecha_pago,'MM')) = :numeroMes 
group by  re_uuid, nvl(re_folio_remanentes, re_folio), re_serie
order by 1,2;