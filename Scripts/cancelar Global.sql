


select to_char(sum(re_total),'999,999,999.09')
from inRecibo
where re_fecha_pago between '01-mar-22' and '31-mar-22' and re_uuid is null and re_status = 'A';


-- Actualizar solo un recibo para poder cancelar la factura global por fuera
update inRecibo
set re_uuid = '2d865b82-cea8-4bf7-be33-a2944966bd12',
    re_folio_remanentes = '245',
    re_serie = 'R',
    re_fecha_timbrado = to_date('2022-09-14 18:39:50','yyyy-mm-dd hh24:mi:ss'),
    re_timbrado = '1'
where re_recibo = '1199734';    


-- Actualizar todos los recibos para una Global
update inRecibo
set re_uuid = 'daed9f1c-6c3f-4e3c-91b9-20962da941f4',
    re_folio_remanentes = '245',
    re_serie = 'R',
    re_fecha_timbrado = to_date('2022-09-14 18:54:59','yyyy-mm-dd hh24:mi:ss'),
    re_timbrado = '1'
where re_fecha_pago between '01-mar-22' and '31-mar-22' and re_uuid is null and re_status = 'A';    


