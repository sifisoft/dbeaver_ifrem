

-- RESPALDO
select * 
from inRecibo
where re_folio_remanentes = :folioRemanentes;

-- CONTEO
select count(*) 
from inRecibo
where re_folio_remanentes = :folioRemanentes;

-- TOTAL
select to_char(sum(re_total),'999,999,999.09') 
from inRecibo
where re_folio_remanentes = :folioRemanentes;

-- FECHA DE PAGO
select unique to_char(re_fecha_pago,'MONTH') 
from inRecibo
where re_folio_remanentes = :folioRemanentes;

-- Quitar timbrado folio regular.
select * 
from inRecibo
where re_empresa = 8 and re_folio = '104403' ;

update inREcibo
set re_uuid = null
    , re_sellocfd  =null
    , re_cadena_original= null
    , re_timbrado = null
    , re_fecha_timbrado = null
    , re_pac_xml_url = null
    , re_folio_remanentes = null
where re_empresa = 8 and re_folio = '104403'
;



-- QUITAR TIMBRADO Global
update inREcibo
set re_uuid = null
    , re_sellocfd  =null
    , re_cadena_original= null
    , re_timbrado = null
    , re_fecha_timbrado = null
    , re_pac_xml_url = null
    , re_folio_remanentes = null
where re_folio_remanentes = :folioRemanentes;
;

select t.*, t.rowid
from inRecibo t
where re_folio_remanentes = :folioRemanentes;


select t.*, t.rowid
from inRecibo t
where re_linea_captura = '123IH3O0922364635790274';



-- Quitar timbrado folio regular.

select * 
from inRecibo
where re_empresa = 8 and re_folio = '104403' ;

update inREcibo
set re_uuid = null
    , re_sellocfd  =null
    , re_cadena_original= null
    , re_timbrado = null
    , re_fecha_timbrado = null
    , re_pac_xml_url = null
    , re_folio_remanentes = null
where re_empresa = 8 and re_folio = '104403'
;





select *
from inRecibo
where re_linea_captura = '123IHJK0753846527699213';

select unique re_pac_msg
from inRecibo
where re_empresa = 6 and re_fecha_pago between '01-may-20' and '31-may-20' and re_timbrado is null


select *
from inRecibo
where re_empresa = 6 and re_fecha_pago between '01-may-20' and '31-may-20' and re_timbrado is not null


create table folio73 as
select *
from inRecibo
where re_folio_remanentes = 73
order by re_recibo;










select count(*) from folio73;

update inRecibo
set re_folio_remanentes = 76
where re_folio_remanentes = 73;

select t.*, t.rowid
from inHistorico_timbrado t
order by ht_fecha desc;



