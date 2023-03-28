
-- Recibo
    select t.re_recibo, t.re_folio, t.re_status, t.re_condiciones_pago,t.re_total, t.re_nombre_servicio, t.re_pago_doble, t.re_fecha_pago,  t.*, t.rowid from inRecibo t where re_linea_captura = :lineaCaptura;
    
    select re_pago_doble, t.*, t.rowid from inRecibo t where re_linea_captura = :lineaCaptura;
    
    
-- Linea pagadas
    select t.*, t.rowid from inLineas_pagadas t where lp_linea_captura = :lineaCaptura;

-- Lineas pagadas y procesadas el día de hoy.    
    select count(*) from inLineas_pagadas where trunc(lp_fecha_carga) = trunc(sysdate);
    
    select unique lp_file_name from inLineas_pagadas where trunc(lp_fecha_carga) = trunc(sysdate);
    
    
-- Lineas generadas
   select t.*, t.rowid from inLineas_generadas t where lg_linea_captura = :lineaCaptura;
   
-- Lineas sin procesar.
    select t.*, t.rowid from inLineas_pagadas t where nvl(lp_procesado,'N') = 'N' and lp_empresa = 6;
    
    
-- Limpiar errores
   select * from inLineas_generadas where lg_error = 'Error, Favor de revisar los campos obligatorios: Linea de Captura, Nombre de Concepto, Cantidad e Importe';
   
   delete from inLineas_generadas where lg_error = 'Error, Favor de revisar los campos obligatorios: Linea de Captura, Nombre de Concepto, Cantidad e Importe';
    
    

 -- REVERTIR PROCESO DE LINEAS PAGADAS
 -- Revertir archivo de líneas Pagadas...    
 
 select * from inRecibo where re_notas = :nombreArchivo;
 
 select * from inRecibo where re_uuid is not null and re_notas = :nombreArchivo order by re_folio, re_uuid;
 
 select * from inLineas_pagadas where lp_file_name = :nombreArchivo;
 
 delete from inRecibo where re_notas = :nombreArchivo;
 
delete from inCxC
where cxc_empresa = 6 and not exists (
select 1
from inRecibo
where   re_empresa = cxc_empresa 
    and cxc_recibo = re_recibo
);

-- ojo actualizar o borrar lineas pagadas, Revisar cual de los dos es lo que se requiere.... 
update inLineas_pagadas set lp_procesado = null, lp_fecha_procesado = null where lp_file_name = :nombreArchivo;

delete from inLineas_pagadas where lp_file_name = :nombreArchivo;




-- Limpiar timbrado

update inRecibo
set re_uuid = null,
    re_sello = null,
    re_sellocfd = null,
    re_numcertifsat = null,
    re_sellosat= null,
    re_cadena_original = null,
    re_timbrado = null,
    re_fecha_timbrado = null,
    re_pac_xml_url = null
where re_empresa = 6 and re_folio_remanentes = 186 and re_serie  = 'R' and re_uuid is not null;


select count(*)
from inREcibo
where re_empresa = 6 and re_folio_remanentes = 186 and re_serie  = 'R' and re_uuid is not null;


















-- PAGOS DOBLES
    -- InLineas_pagadas marcado el "Pago Doble" correctamente?
    -- Checar si se marcaron los pagos dobles en "Lineas Pagadas" correctamente
    select lp_linea_captura, count(*)
    from inLineas_pagadas
    where   lp_pago_doble is null 
        and lp_fecha_pago >= trunc(sysdate-15,'MONTH')
    group by lp_linea_captura
    having count(*) > 1;    
    
    -- "Lineas Pagadas" vs.  "Inrecibo"  respecto a pago doble.
    -- Lineas pagadas marcadas como "pagos dobles" pero que en INRECIBO NO tienen dicha marca ..
    select *
    from inLineas_pagadas 
    where   lp_pago_doble = '1' 
        and not exists ( 
            select 1 from inRecibo where re_linea_captura = lp_linea_captura and re_pago_doble = '1'
        )
        and lp_fecha_pago >= trunc(sysdate-15,'MONTH');

    
-- Lineas generadas
 select * from inLineas_generadas where lg_linea_captura = :lineaCaptura;
 
 -- Lineas pagadas
 select * from inLineas_pagadas where lp_linea_captura = :lineaCaptura;
 
 -- Recibo
 select * from inRecibo where re_linea_captura = :lineaCaptura;
 
 
 



-- dobles pagos
select * from inLineas_pagadas where lp_pago_doble = '1'  order by lp_fecha_pago desc

select * from inLineas_pagadas where lp_pago_doble = '1'  and lp_file_name = 'LINEASPAGADAS_07102021.XLSX';

select * from inLineas_pagadas where lp_file_name = 'LINEASPAGADAS_07102021.XLSX';


select count(*) from inRecibo where re_notas = 'LINEASPAGADAS_07102021.XLSX';

select count(*) from inLineas_pagadas where lp_file_name = 'LINEASPAGADAS_10032021.XLS' and nvl(lp_procesado,'N') = 'N';

select unique lp_file_name from inLineas_pagadas where lp_file_name like '%23082021%'   


select * from inRecibo where re_recibo = 813822


select * from inCxC


select *
from inRecibo
where re_folio = 932773


--**********************  
-- PAGOS DOBLES
-- pagos dobles listar
with duplicados as (
    select re_linea_captura, re_total, re_nombre_servicio
    from inRecibo
    where re_empresa = 6 and re_fecha_pago >= '01-aug-21' and re_pago_doble is null
    group by re_linea_captura, re_total, re_nombre_servicio
    having count(*) > 1
)
select r.rowid as myRowID, r.re_linea_captura, row_number() over ( partition by r.re_linea_captura, r.re_linea_captura, r.re_total, r.re_nombre_servicio order by r.re_linea_captura, r.re_total, r.re_nombre_servicio) as row_number
from inRecibo r, duplicados d
where   r.re_linea_captura = d.re_linea_captura
    and r.re_total = d.re_total
    and r.re_nombre_servicio = d.re_nombre_servicio;

-- marcar como pagos dobles...
update inRecibo
set re_pago_doble = 1
where rowid in 
( 
    with duplicados as (
        select re_linea_captura, re_total, re_nombre_servicio
        from inRecibo
        where re_empresa = 6 and re_fecha_pago >= '01-aug-21' and re_pago_doble is null
        group by re_linea_captura, re_total, re_nombre_servicio
        having count(*) > 1
    )
    ,lineas as (select r.rowid as myRowID, r.re_linea_captura, row_number() over ( partition by r.re_linea_captura, r.re_linea_captura, r.re_total, r.re_nombre_servicio order by r.re_linea_captura, r.re_total, r.re_nombre_servicio) as row_number
    from inRecibo r, duplicados d
    where   r.re_linea_captura = d.re_linea_captura
        and r.re_total = d.re_total
        and r.re_nombre_servicio = d.re_nombre_servicio
    )
    select myRowID
    from lineas
    where row_number > 1
);     


select * from inLineas_pagadas; 


select lp_linea_captura, lp_total, count(*)
from inLineas_pagadas
where lp_fecha_pago >= '01-aug-20' and lp_pago_doble is  null
group by lp_linea_captura, lp_total
having count(*) > 1;



select *
from inLineas_pagadas 
where lp_pago_doble is null 
    and exists ( 
        select 1 from inRecibo where re_linea_captura = lp_linea_captura and re_pago_doble = '1'
    )
    and lp_fecha_pago >= '01-aug-21';















-- ****************************************************************
-- ****************************************************************
-- Limpiar lineas pagadas.. 

select * from inRecibo
where re_descripcion_concepto like '%LINEASPAGADAS_23082021PART.2.XLS%';

delete from inRecibo
where re_descripcion_concepto like '%LINEASPAGADAS_23082021PART.2.XLS%';

delete from inLineas_pagadas
where lp_file_name = 'LINEASPAGADAS_23082021PART.2.XLS';

delete from inCxC
where cxc_empresa = 6 and not exists (
select 1
from inRecibo
where   re_empresa = cxc_empresa 
    and cxc_recibo = re_recibo
)















-- ***********************************************************************************************************
-- ELIMINAR DUPLICADOS DE UN ARCHIVO EXCEL DETERMINADO...

-- PASO 1..  Respaldar PDFs 
-- PASO 2 .. Respaldo DB  
select *
from inRecibo
where re_notas = 'LINEASPAGADAS_2702-02032021.XLS'

select * from inLineas_pagadas t 
where lp_file_name =  'LINEASPAGADAS_2702-02032021.XLS';

select * from inCxC
where cxc_empresa = 6 and not exists (
select 1
from inRecibo
where   re_empresa = cxc_empresa 
    and cxc_recibo = re_recibo
)

-- Paso 3 .. Borrar registros
delete from inRecibo 
where   re_notas = 'LINEASPAGADAS_2702-02032021.XLS';

delete from inLineas_pagadas t 
where lp_file_name =  'LINEASPAGADAS_2702-02032021.XLS'; 
    

delete from inCxC
where cxc_empresa = 6 and not exists (
select 1
from inRecibo
where   re_empresa = cxc_empresa 
    and cxc_recibo = re_recibo
)

-- Paso 4... Carga nuevamente pagadas y reprocesar.. 

---------------------------------------------------------------------------------------------------------



select * from inLineas_pagadas where lp_file_name = 'LINEASPAGADAS_19-22122020.XLS';

delete from inLineas_pagadas where lp_file_name = 'LINEASPAGADAS_19-22122020.XLS';





-- Cierre Back Office
select * from kk where linea = :lineaCaptura;

delete from kk;

select sum(total) from kk;

-- Diferencias
select * from ooo where nvl(timbrado,0) = 0 and nvl(conteo_recibo,0) >= 0;


--select *
update inlineas_pagadas
set lp_procesado = 'N'
where exists (
    select 1
    from kk
    where lp_linea_captura = linea
);

select * from inLIneas_pagadas;

select sum(lp_total) from inLineas_pagadas where lp_procesado = 'N';



-- Lineas sin procesar
select count(*) from inLineas_pagadas where lp_file_name = 'LINEASPAGADAS_29-31092020.XLS';

delete from inLineas_pagadas where lp_file_name = 'LINEASPAGADAS_29-31092020.XLS';


select count(*)
from inLineas_pagadas 
where lp_file_name = 'LINEASGENERADAS_15-17082020.XLS' and exists (
    select 1
    from inLineas_generadas
    where lg_linea_captura = lp_linea_captura
)

delete from inLineas_pagadas where lp_file_name = 'LINEASGENERADAS_15-17082020.XLS'; 



-- Suma de timbradas Global y Portal 
select to_char(trunc(re_fecha_pago,'MONTH'),'MON-YYYY') MES, to_char(sum(re_total),'999,999,999.09') from inRecibo where trunc(re_fecha_pago,'MONTH') = :mes and re_uuid is not null and nvl(re_status,'X') != 'C' group by to_char(trunc(re_fecha_pago,'MONTH'),'MON-YYYY');

-- Suma factura global 
select to_char(sum(re_total),'999,999,999.09') from inRecibo where trunc(re_fecha_pago,'MONTH') = :mes and re_uuid is not null and nvl(re_status,'X') != 'C' and re_serie = 'R';

-- Facturado Portal 
select to_char(sum(re_total),'999,999,999.09') from inRecibo where trunc(re_fecha_pago,'MONTH') = :mes and re_uuid is not null and nvl(re_status,'X') != 'C' and re_serie != 'R';

-- Suma de NO    timbradas 
select to_char(nvl(sum(nvl(re_total,0)),0),'999,999,990.09') from inRecibo where re_fecha_pago between '01-jun-20' and '30-Jun-20' and re_uuid is null and nvl(re_status,'X') != 'C';

-- Suma de no canceladas total 
select to_char(sum(re_total),'999,999,999.09') from inRecibo where re_fecha_pago between '01-jun-20' and '30-Jun-20' and nvl(re_status,'X') != 'C';

--- totales incorrectos... (salió mal con las lineas copiadas manualmente).
select re_linea_captura, re_total, re_cantidad, re_impuesto,  re_fecha_pago, re_total - (re_cantidad * re_impuesto), t.rowid
from  inRecibo t 
where re_total - (re_cantidad * re_impuesto) != 0 




select count(*) from inRecibo where trunc(re_fecha_pago) = '14-aug-20';

select * from inLineas_pagadas where trunc(lp_fecha_pago) = '14-aug-20';


select t.*, t.rowid from ooo t;

select * from inLineas_pagadas;

select max(re_recibo) from inRecibo where re_recibo < 500

select *
from inContribuyentes
where co_rfc = 'GOSL9508063N2';








delete
from inLineas_pagadas
where lp_fecha_pago between '01-JUL-20' and '31-JUL-20' and lp_banco not in ( 'SANTANDER','BANAMEX','SCOTIABANK','HSBC','BANORTE','TELECOM','TELECOMM')
;

select linea 
from kk
group by linea
having count(*) > 1;


select *
from kk;

select re_uuid, re_pago_doble
from inRecibo
where to_number(re_recibo) < 500;

update inRecibo
set re_pago_doble = 1
where to_number(re_recibo) < 500;


select *
from inContribuyentes
where co_id in (
select re_contribuyente
from inRecibo
where re_linea_captura = :lineaCaptura
);



select t.*, t.rowid
from inLineas_pagadas t
where lp_procesado = 'D' and lp_fecha_pago between '01-aug-20' and trunc(sysdate);


update inLineas_pagadas t
set lp_procesado = null, lp_error = null
where lp_procesado = 'D' and lp_fecha_pago between '01-aug-20' and trunc(sysdate);



delete from inRecibo
where re_fecha_pago between '01-aug-20' and '5-aug-20' and re_uuid is null and re_usuario = 'sifi'





select count(*) from kk;


delete from kk;




update inLineas_pagadas t
set lp_procesado = null, lp_error = null
where lp_procesado = 'D' and not exists (select 1 from inRecibo where re_linea_captura = lp_linea_captura) and lp_fecha_pago between '01-aug-20' and trunc(sysdate);




select to_char(sum(decode(re_serie,'R',0,re_total)),'999,999,999.00') Total_portal, to_char(sum(decode(re_serie,'R',re_total,0)),'999,999,999.00') total_remanente, to_char(sum(re_total),'999,999,999.00') Gran_total
from inRecibo
where trunc(re_fecha_pago,'MONTH') = '01-Jun-20' and re_uuid is not null and re_status != 'C'
    

select * from ooo where nvl(timbrado,0) = 0 and nvl(conteo_recibo,0) = 0 and  total = total_generadas;

delete from kk;

select * from kk where linea = :linea

select  * from inRecibo where re_linea_captura = :linea;

drop table oo;

select count(*) from oo;

select * from oo 
where not exists (
    select 1
    from inLineas_pagadas 
    where linea = lp_linea_captura
);

-- Nuevas lineas
create table oo as 
select *
from kk
where not exists (
    select 1
    from inRecibo
    where re_linea_captura = linea
)    

-- Lineas que mandó pero finalmente no son correctas
delete from inRecibo
where re_fecha_pago between '01-sep-20' and '8-sep-20'
and not exists (
    select 1 
    from kk
    where linea = re_linea_captura
) 
    
 


-- Diferencia 1
select linea, sum(total) total
from kk
group by linea
minus
select re_linea_captura, sum(re_total)
from inRecibo
where re_fecha_pago between '01-sep-20' and '10-sep-20'
group by re_linea_captura;



-- Difrencia 2
select re_linea_captura, sum(re_total)
from inRecibo
where re_fecha_pago between  '01-sep-20' and '10-sep-20'
group by re_linea_captura;
minus
select linea, sum(total) total
from kk
group by linea




select * from ooo where linea = :linea;


select * from ooo;


-- Solo para referencia... 
drop table ooo;

create table ooo as
select linea, sum(total) total
from kk
group by linea
minus
select re_linea_captura, sum(re_total)
from inRecibo
where re_fecha_pago between '01-aug-20' and '5-aug-20'
group by re_linea_captura;







alter table ooo add conteo number(2);

alter table ooo add timbrado number(2);

alter table ooo add conteo_recibo number(2);

alter table ooo add total_generadas number(15,2);

alter table ooo add folio varchar2(20);


update ooo
set timbrado = (select count(*) from inRecibo where re_linea_captura = linea and re_uuid is not null)
where exists (
    select 1
    from inRecibo
    where re_linea_captura = linea
)


update ooo
set conteo = (select count(*) from inLineas_pagadas where lp_linea_captura = linea )
where exists (
    select 1
    from inLineas_pagadas
    where lp_linea_captura = linea
)

update ooo
set conteo_recibo = (select count(*) from inRecibo where re_linea_captura = linea )
where exists (
    select 1
    from inRecibo
    where re_linea_captura = linea
)

update ooo
set folio = (select unique re_folio from inRecibo where re_linea_captura = linea and re_uuid is not null )
where exists (
    select 1
    from inRecibo
    where re_linea_captura = linea
    group by re_folio
    having count(*) = 1
)



update ooo
set total_generadas = (select sum(lg_costo_unitario * lg_cantidad) from inlineas_generadas where lg_linea_captura = linea )
where exists (
    select 1
    from inLineas_generadas
    where lg_linea_captura = linea
)



--- ESTE    PLS.....
select * from ooo where nvl(timbrado,0) = 0;

delete from inRecibo
where re_linea_captura in ( select linea from ooo where timbrada = 0);


--- ESTE    PLS..... 
select lp_linea_captura, count(*)
from inLineas_pagadas
where lp_linea_captura in ( select linea from ooo where timbrado = 0)
    and lp_fecha_pago >= '01-aug-20'
    and lp_fecha_procesado is not null
group by lp_linea_captura
having count(*) >= 1;    


select * from inLineas_pagadas

update inLineas_pagadas
set lp_procesado = null, lp_fecha_procesado = null
where lp_linea_captura in ( select linea from ooo where timbrada = 0)
    and lp_fecha_pago >= '01-aug-20'
    and lp_fecha_procesado is not null
;    



alter table ooo add timbrada number(2);

update ooo
set timbrada = (select count(*) from inRecibo where re_linea_captura = linea and re_uuid is not null)
where exists (
    select 1
    from inRecibo
    where re_linea_captura = linea
)



select * 
from inLineas_pagadas 
where lp_linea_captura in ( select linea from ooo)
    and lp_fecha_pago >= '01-aug-20'
order by lp_linea_captura    
;




create table oooo as 
select *
from inLineas_pagadas
where lp_fecha_pago >= '01-aug-20' and exists 
(
select *
from ooo
where not exists ( select 1 from inRecibo where re_linea_captura = linea and re_fecha_pago between '01-aug-20' and '07-aug-20')
      and lp_linea_captura = linea 
)
order by lp_linea_captura;


update  inLineas_pagadas t
set lp_procesado = null,
    lp_fecha_procesado = null
where lp_fecha_pago >= '01-aug-20' and t.lp_linea_captura in ( 
    select b.lp_linea_captura
    from oooo b
    group by lp_linea_captura
    having count(*) = 1
) 




select lp_linea_captura
from oooo
group by lp_linea_captura
having count(*) = 1


select * from inRecibo_pagosDobles_JUL2020;

 
select re_linea_captura, sum(re_total) total
from inRecibo
where re_fecha_pago between '01-jul-20' and '31-jul-20'
group by re_linea_captura
minus
select linea, sum(total)
from kk
group by linea
;


select sum(re_total)
from inRecibo
where re_fecha_pago between '01-jul-20' and '31-jul-20' and re_status != 'C'


select * from kk where linea = 'IQ8Y0757655728104244';

select * from inRecibo_pagosDobles_JUL2020 where linea = 'IQ8Y0757655728104244';

select * from inRecibo_pagosDobles_JUL2020;

select sum(re_total) from inRecibo where re_linea_captura = '123I11H0758465128188284';

select t.*, t.rowid from inRecibo t where re_linea_captura = 'IQ8Y0757655728104244';



create table oo
as select *
from InRecibo
where re_linea_captura != 'IQ8Y0757655728104244' and re_linea_captura in ( select c.linea from inRecibo_pagosDobles_JUL2020 c )


select * from inRecibo where re_recibo between 13 and 76; 

insert into inRecibo 
select oo.*
from oo
--where re_uuid is not null;

update oo
set re_recibo = rownum + 12;

-- limpiar timbrado
update oo
set re_uuid = null,
    re_sello = null,
    re_sellocfd = null,
    re_numcertifsat = null,
    re_sellosat= null,
    re_cadena_original = null,
    re_timbrado = null,
    re_fecha_timbrado = null,
    re_pac_xml_url = null;



select re_linea_captura, count(*)
from inRecibo
where re_linea_captura in ( select linea from inRecibo_pagosDobles_JUL2020 )
group by re_linea_captura
having count(*) > 1;


update inRecibo a
set re_total = re_total/2
where re_linea_captura != 'IQ8Y0757655728104244' and re_linea_captura in ( select c.linea from inRecibo_pagosDobles_JUL2020 c );



update inRecibo a
set re_total = (select total from inRecibo_pagosDobles_JUL2020 b where b.linea = a.re_linea_captura)
where re_linea_captura != 'IQ8Y0757655728104244' and re_linea_captura in ( select c.linea from inRecibo_pagosDobles_JUL2020 c )




select t.*, t.rowid
from inRecibo t
where re_linea_captura = 'IQNY0756695127993273'


select t.*, t.rowid
from kk t;


select linea, sum(total)
from kk
group by linea
having count(*) > 1;


    
    

select *
from inLineas_pagadas
where lp_linea_captura = :lineaCaptura;

select *
from inLineas_generadas
where lg_linea_captura = :lineaCaptura;


select t.*, t.rowid 
from inRecibo t
where re_linea_captura = :lineaCaptura;

select to_char(sum(re_total),'999,999,999.09')
from inRecibo
where re_fecha_pago between '01-jul-20' and '31-Jul-20' --and re_uuid is null;



select count(*) from inLineas_pagadas;    
    
    

select to_char(sum(re_total),'999,999,999.09')
from inRecibo
where trunc(re_fecha_pago,'MONTH') = '01-jul-20'
    and re_status != 'C'
    and re_uuid is not null
    --and re_folio_remanentes is null
    

select sum(re_total) 
from inRecibo
where trunc(re_fecha_pago,'MONTH') = '01-may-20'
    and re_serie != 'R'
    and trunc(re_fecha_timbrado) >= '20-JUL-20'
    and re_uuid is not null
        
    
select * 
from inRecibo
where trunc(re_fecha_pago,'MONTH') = '01-may-20'
    and re_serie != 'R'
    and trunc(re_fecha_timbrado) >= '20-JUL-20'
    and re_uuid is not null
    
select to_char(sum(re_total),'999,999,999.00') 
from inRecibo
where trunc(re_fecha_pago,'MONTH') = '01-may-20' and re_status = 'A'


select nvl(re_folio_remanentes, re_folio), to_char(sum(re_total),'999,999,999.09')
from inRecibo
where re_uuid_relacionado like '106bc760-a9ad%' and re_serie != 'R'
group by  nvl(re_folio_remanentes, re_folio);
order by 1
    
select *
from inRecibo
where re_uuid_relacionado like '106bc760-a9ad%' and re_serie != 'R'
order by re_folio

select sum(re_total)
from inRecibo
where re_uuid_relacionado like '106bc760-a9ad%' and re_serie != 'R'
order by re_folio


  
select to_char(sum(re_total),'999,999,999.09')
from inRecibo
where re_folio_remanentes = 79 



select sum(re_total)
from inRecibo
where re_recibo in 
(
select re_recibo
from inRecibo
where re_folio_remanentes = 79
minus  
select re_recibo
from inRecibo
where re_uuid_relacionado like '106bc760-a9ad%'
)



select *
from inLineas_generadas
where lg_linea_captura = 'IOCE0756950428039222'

select *
from inLineas_pagadas
where lp_linea_captura = 'IQNY0756695127993273';

select *
from inRecibo
where re_linea_captura = '123IWKL0756975128038253';


delete from kk;


create table inRecibo_JUL2020_incorrectas as
select *
from inRecibo
where re_fecha_timbrado is null and exists ( select 1 from kk where recibo = re_linea_captura)


select sum(re_total)
from inRecibo_jul2020_incorrectas


delete from inRecibo
where re_fecha_timbrado is null and exists ( select 1 from kk where recibo = re_linea_captura)




alter table inLineas_pagadas add lp_fecha_carga date;


select *
from inREcibo
where re_linea_captura = '123I4GH075707192804126'


select *
from inREcibo
where re_linea_captura = '123I4GH0757071928041260'


select re_recibo, re_folio, re_linea_captura
from inRecibo
where re_folio = 83840;


select re_linea_captura, sum(re_total)
from inRecibo
where re_fecha_pago >= '01-aug-20';
group by re_linea_captura 
minus
select linea,sum(total)
from kk
group by linea


select 1,sum(total)
from kk
union
select 2,sum(re_total)
from inRecibo
where re_fecha_pago >= '01-aug-20';
 


select re_linea_captura
from inRecibo
where re_fecha_pago between '01-jul-20' and '31-jul-20' and re_serie = 'A' and nvl(re_status,'X') != 'C'
group by re_linea_captura




select *
from inLineas_generadas
where lg_concepto is null;

select re_recibo, re_linea_captura, re_total, re_condiciones_pago re_banco, re_uuid, re_descripcion_concepto, re_uuid
from inRecibo
where exists ( 
    select 1
    from inLineas_pagadas
    where (lp_file_name like '%_0309%' or lp_file_name like '%_0409%') and lp_banco = 'TELECOMM'
        and lp_linea_captura = re_linea_captura
        and trunc(lp_fecha_pago) = trunc(re_fecha_pago)
)
order by re_linea_captura, re_recibo;



select *  from inRecibo where re_notas = 'LINEASPAGADAS_19-22122020.XLS' and re_pago_doble is not null;


XPKINCXC

select count(*)
from inCxC;

select t.*, t.rowid
from inEmpresas t;

473710

delete from inCxC
where cxc_empresa = 6 and not exists (
select 1
from inRecibo
where   re_empresa = cxc_empresa 
    and cxc_recibo = re_recibo
)


select * 
from inLineas_pagadas 
where lp_linea_captura in (
'123I3K60897657434665277','123I3OC0897666534662228','123I4260895771734585281','123I5BG0897678834675256','123I5XC0897529534655239','123IEBD0897614934666208','123IELQ0895559034555261','123IESJ0897652034665245','123IHKM0897705034675252','123IHRR0894756934532223','123ILUS0897616334665295','123IMET0897703634675254','123INRO0895902134585223','123IOPP0897706034676283','123IRCX0897708234676241','123IRDN0897709734676288','123IRPE0897737734675234','123ISUI0895845534585257','123IVBI0897712034676212','123IWB60894885734532282','123IY2L0896737234606229','123IY7K0897705134676287','I12O0897487134658228','I12S0897679734678212','I14W0896153534598243','I16H0897609234665237','I16T0897488034658207','I1730897614134665248','I1750897714634675205','I17G0897667834665286','I18E0897591534665241','I1ER0897591234665261','I1G60897736934678281','I1HH0897292334628203','I1IS0896904234617240','I1J20897713534675234','I1JL0897554734658238','I1KI0897615034665238','I1LJ0897621334665249','I1MH0897712234675252','I1MR0897616734665271','I1NC0897657734665237','I1OB0897613234665210','I1TP0897606134668253','I1W40897673834668293','I1WX0897598434668216','I1WX0897632634665204','I1XS0897673334665251','I1YO0896817134608254','I2250897706634675275','I23W0897567634666293','I26Q0897659634668242','I27C0897640234669218','I2B10897462734621230','I2B50897599034668201','I2D70897631934665217','I2ED0897606534665232','I2HO0897274534628289','I2I70897588634665230','I2KO0897664334669254','I2MG0897396234626201','I2N40897650934668219','I2NP0897592534665284','I2NU0897702534675204','I2O50897491834655231','I2PL0897612034665214','I2PT0897617534665267','I2PT0897623434665205','I2PY0897593134665294','I2QL0897519934658266','I2QQ0897603734668274','I2RQ0897599334668289','I2RV0897595534665236','I2S80897690834678261','I2U70897588234665220','I2VT0897653134665201','I2Y60897712434675289','I2YS0897650734668277','I3220897713734675297','I33K0897585734665218','I3720897570734664242','I38V0897585834665258','I38X0897661734660240','I3C40897604434668215','I3D50897668534667237','I3DC0897703534675297','I3DE0897649634668242','I3DM0897520134653246','I3DV0897626934665250','I3EQ0897606934665292','I3ES0897603834668226','I3FT0897609034665219','I3HK0897678334678235','I3LJ0895725734555263','I3LY0897579734665211','I3NG0897703234675264','I3OO0897579034665204','I3P70897707334675270','I3SH0897700434675229','I3SR0897677734678268','I3TC0896227734597236','I3UN0897607434668203','I3V20897469034620217','I3XP0897701234678291','I3YD0897716634678292','I3YL0897621634665221','I41D0897253234628292','I41K0897382434629251','I41X0897657634665214','I4210897596434665291','I42T0897105134618263','I42Y0897715034678236','I4350897632534665248','I4450897303934628270','I44D0896847034608247','I44I0897544334658280','I45M0897684034672289','I46O0897708834671279','I4780897537134656270','I4B20897698934675259','I4BW0897714934675251','I4CG0896834834607229','I4FX0897608834665217','I4HC0897597134668226','I4JC0897487834651284','I4K50897606234668248','I4LB0895726234555251','I4OG0897706734675210','I4QG0896888834617270','I4S20897404634620270','I4TE0895084334542293','I4UB0897624434665289','I4W40896627334608224','I4W70897668134665240','I5150897621234665261','I52J0897278334628286','I5510897627534665257','I5540897680834675280','I56H0897586234665270','I56T0897589734665271','I5BF0897720534675260','I5BT0897700534675250','I5BX0894783734536270','I5F30897365434624290','I5F50897647734661275','I5FU0896720534604212','I5G40897657234661217','I5G50897533534651230','I5HF0897616434665259','I5JU0897623734665240','I5LC0897658334665232','I5LG0897697934675284','I5LH0897726334671244','I5PP0897568534661241','I5Q60897607134660250','I5RU0897543734658268','I5SF0897699534675232','I5T70897629334665284','I5TB0897737034675252','I5TC0897579534665290','I5UE0897614834665210','I5VQ0897631434665225','I5XD0897304134621212','I5XS0897577634665290','I61E0897657034665213','I6220897586334660243','I6420897704834675272','I67G0897616634665213','I68F0897605834665288','I68Q0897589234665259','I6B40897608734665214','I6FN0896733834605273','I6GC0897613334665225','I6JU0897667734669255','I6L10897619934665218','I6L70897704634675253','I6N50897677634678235','I6Q50897688034670219','I6RE0897648534661215','I6RU0897702934675255','I6U60897521734658297','I6VW0897623834665259','I6XN0897588334665272','I6Y80897702634675297','I7180897635834665230','I77V0897592634665241','I7BX0896858434617231','I7CC0894291434528249','I7DR0897604034660237','I7E70897578134665264','I7ET0897645234668236','I7IG0897658734665274','I7K50897573834664275','I7KM0897721034675289','I7L20897654034665225','I7LH0897632734668227','I7OQ0897628834665220','I7PV0897711134675264','I7QF0897701434675221','I7R20897626034665268','I7R80897553834654269','I7RE0897608234665262','I7RQ0897627334661216','I7SM0897714034675224','I7TW0897622634665207','I7UB0897442534629283','I7V50897684734677216','I7VI0897403034628221','I7VI0897403034628221','I7X80897283334628268','I7YD0897604934660283','I7YG0897600034668271','I8280897634734665224','I84O0897568134661269','I85G0897589134665216','I87Q0897698634675271','I8810897605434665244','I8BC0897597234665283','I8BK0897591334665268','I8CH0894788534530227','I8CX0897578934665262','I8D50896094734588293','I8E80897653734665278','I8EN0897582534665297','I8EX0897620834660289','I8FL0897590334665221','I8GT0897625334665207','I8IV0897654134665289','I8MD0897598934660274','I8N30897537534651269','I8NE0897702334675279','I8OE0897692634673257','I8OO0894976734531246','I8PL0897592234665253','I8Q60897709434675273','I8RC0897701134675234','I8RQ0897606834668233','I8RX0897584234665285','I8T70897663734666265','I8UL0897620134665257','I8VG0897290634628243','I8VI0897679034678212','I8W80897602734668216','I8Y30897591634665202','IB1Q0897587434665219','IB1X0897573934662232','IB2C0897678634673250','IB2I0897524834658259','IB2W0896909534610204','IB450897727134670222','IB6R0897623134665293','IB6S0895135634548293','IB8M0897711634675252','IB8S0897618834665214','IBDC0897630934665205','IBFF0897665134662295','IBH10897614534665278','IBI30897622034665255','IBIE0897666934661219','IBJD0897668834661226','IBJH0897660834661279','IBJN0897703034675232','IBK10897674234665287','IBKG0897618634665237','IBLD0897655434665275','IBME0896834034607258','IBPB0897651334667218','IBPR0897622734665268','IBQI0897704534675289','IBRE0897744034671264','IBRF0894766934538253','IBRI0897677934678261','IBSD0897654534665260','IBUU0897322834620222','IBVP0897369334626219','IBW60897659434661273','IBXY0897662834664224','IBY70897586034665204','IC1I0895445734551245','IC250897426334628269','IC2L0897705234675270','IC370895169234544215','IC4C0897577234665202','IC4E0897282534628220','IC4L0897586434660262','IC530897589934665260','IC5Q0897627834665237','IC7D0897679434678203','IC8M0897662234667214','ICBF0897568634666215','ICD10897288234628288','ICDH0897635334665243','ICEK0897667434665220','ICF80896846934607241','ICFV0897680434675236','ICGO0897720634678244','ICGQ0897546834650272','ICHR0897630234665212','ICJD0897711534675272','ICKE0897713434678269','ICKM0897555234657237','ICKT0897637734665289','ICLQ0897122534612240','ICN80897583734665247','ICQB0896857034613203','ICQN0897557334667293','ICSM0895248434544226','ICUN0897622334665201','ICUN0897678034678221','ICV10897582834665276','ICWS0896875034617237','ID120897582034665261','ID2K0897604634665255','ID2N0897487634651218','ID2S0897536834656248','ID4G0897375734628263','ID4V0896837034607238','ID530895725834555260','ID530897591734665227','ID6S0897507534658239','ID6T0897678434678262','ID810897622134665237','IDDO0897666634668265','IDEB0897602934665293','IDEJ0896847134608202','IDEN0897587734665259','IDFM0897667634665219','IDFU0897669334665214','IDFX0897591834665246','IDH20897590634665207','IDIW0897649534661229','IDJV0897665934669244','IDLF0895442334551205','IDNC0897605534668257','IDNL0897288834628242','IDNW0897605034665222','IDOW0897269934623249','IDP30897710934675266','IDPH0897606034665210','IDRJ0897575934665281','IDRR0897710834675219','IDT30897036534618280','IDTE0897656434665244','IDVB0895251934546217','IDWS0897608434665244','IE2N0897701334675287','IE320896042434583232','IE380897629734665262','IE4O0897593934667287','IE5B0897655134665251','IE6B0897650234661235','IE6Y0897579634661205','IE8P0897547234651238','IEB60897607034668275','IEBE0897629834665292','IEE80897589434665239','IEEY0897708934675295','IEF40897094134613215','IEG80897483834659223','IEG80897599734668261','IEHG0897611534665210','IEI10897668034665232','IEIM0897715734678228','IEIX0897583234665229','IEJG0897704134675250','IEKK0897277034628253','IELY0897576834665296','IEMU0897717434678265','IENV0897705634675233','IEO10897576234665284','IEPU0897578434665230','IEQQ0896862134613217','IETO0897387534628269','IEVT0897594434665252','IEX70897629534665257','IF2Y0897533934656277','IF3L0897708334675287','IF3R0897635134665268','IF4C0897731034675294','IF4X0897605934665280','IF6S0897712834675279','IF8G0897710634675259','IF8K0897464234628237','IFBY0897699334675265','IFCM0897627034665252','IFES0897616134665205','IFG60897628434663288','IFG70897602034665242','IFJ40897668434667207','IFLF0897611334665216','IFLK0897587134665213','IFLR0897610634665210','IFO10897596634665290','IFOX0897714334675266','IFPP0897582234665203','IFQ60896846634607217','IFRM0897610934665297','IFW30896877234617262','IFW70897608134665249','IFXN0897604334668211','IFXW0897594734665201','IFYE0897702134675260','IG1E0897661934665260','IG1V0897396634628265','IG6B0897291534628227','IGBY0897665634668214','IGDY0897624834665227','IGGY0897704034675255','IGH20897658034665251','IGHX0897721634678250','IGI80896837334607246','IGK10897581234665297','IGKE0897584334660291','IGKH0897296234628270','IGKU0895725934555205','IGLC0897680534675222','IGLK0896886934617215','IGMD0897556934667242','IGOI0897678134678206','IGQI0897657534665266','IGQQ0896838934607233','IGR80897654334667203','IGU40897607334664264','IGVC0897667334665282','IGVE0897532934653295','IGVO0897609634665213','IGVY0896385234593217','IGX60897700734675232','IGXK0897702734675271','IH240897684434677231','IH280897468834620280','IH2B0897621534665281','IH3O0897574534665216','IH560897621034665244','IH7N0897620534665291','IHBC0897680234675282','IHC80897592834665208','IHCB0895436834558273','IHCT0897584634665276','IHD10897442634628273','IHDG0897730834678247','IHE50897605134665264','IHG70897662634669221','IHGP0897574734665212','IHHE0897338034624242','IHI20897286234628203','IHL40897631834665202','IHLI0897704934675267','IHMX0897707834675270','IHOD0897736834675263','IHQ40897577334665250','IHSL0897701934675261','IHSN0897677534678215','IHTF0897576134665295','IHTL0897627434665210','IHU50897623034665244','IHUH0897587034665278','IHUK0897639334669290','IHW30897628234665234','II1D0897254634628232','II320897703334675218','II3T0897630034665265','II530897611734668202','II6I0897649134665233','IIDX0897583934665220','IIH40897635934665254','IIHQ0897254234628252','IIID0897555034654230','IIJY0897618034665262','IIKF0897253634628272','IIKL0897616934665241','IIL50897621734665206','IIMB0897649434665283','IIN20897606434668206','IINL0894291534528213','IIUJ0897554534658206','IIVU0897659834660249','IJ1S0897598334668227','IJ3Q0897679634678251','IJ4I0897614334665282','IJ4M0897714734675259','IJ4X0897532234653258','IJ610897517234659267','IJ7C0897545734659218','IJ7T0897577534665248','IJ860897673234665244','IJ880897595634665294','IJ8M0897710734675235','IJBN0897455534621218','IJCM0897709834675230','IJD50897578734665207','IJDI0897612134665222','IJDW0897710334675282','IJE40897624034665255','IJGY0897596234665248','IJNN0897122934618297','IJO30897592034665222','IJTT0897656534665269','IJUS0897711234675291','IJWK0896837534607217','IJXK0896443334599221','IJYL0897660734669222','IK4H0897712634678259','IK670897665434660234','IK6V0897589834665291','IK760897624634665220','IK7V0897616834665238','IK7W0897707934671260','IK8L0897711834675255','IK8M0897588434665221','IKBM0897619134665217','IKCP0894878034534214','IKDH0897293434628202','IKDS0897624534665276','IKEB0896336834591279','IKEG0895726034555239','IKEH0897487434651268','IKF40897603134665237','IKFY0895444034558247','IKK60897620634665291','IKKG0897615534665270','IKKR0897613934665237','IKM40897584134665264','IKMX0897628034665297','IKW20897655834665217','IKWI0897631634665246','IKWV0897701634678273','IKXH0897709534675243','IKYH0897679534678209','IL1Y0897612334666231','IL210897608534665274','IL210897727634678290','IL220897579234665288','IL260897654834665261','IL2H0897556734665208','IL2K0897591934665281','IL2N0897172034618268','IL2T0897588034665287','IL3L0897655534665278','IL3P0896895134617273','IL4D0897703834675262','IL630896892934617267','IL6O0895443234558223','IL6T0897643034667219','IL760894781834538281','IL7J0897598034668257','IL8C0897724134678286','IL8D0897574834665296','ILEM0897515534658246','ILFN0897598634668222','ILG60897679334671242','ILGM0897652834665236','ILJI0897612734661241','ILK60897723234678285','ILKJ0897572134664217','ILKR0897536534658286','ILM30897653534665255','ILNC0897626834665202','ILNJ0897601834668266','ILNL0897555334654221','ILP80897615234665225','ILPC0897629234665294','ILPV0897655034665206','ILPW0897603334668275','ILQR0897614034666229','ILR30897705334675263','ILUQ0897622234665257','ILVL0897649734665278','ILVP0895992734580246','ILVY0897690034671209','ILWK0897430434628271','IM3E0897656634665270','IM440897653434665278','IM4B0897617934665289','IM4L0897729934678250','IM5U0897722134678255','IM6F0897707234678275','IM7Q0897618334665205','IM8H0897623334665247','IMBB0897618734665258','IMBI0897544234658245','IMBX0897273334628229','IME60897521334658230','IMEY0897668334665278','IMJM0897602334665217','IMKG0897617734665259','IMLD0895243634546217','IMLH0897565934661208','IMLT0897702234675243','IMMD0897643934668266','IMPR0897601634668265','IMRJ0897580434665247','IMST0897588934665223','IMT50897565834661223','IMTX0897722534678257','IMTY0897595034665297','IMUS0897096234613278','IMUT0895831734587287','IMW70897679134678235','IMX30897614634661203','IMXV0896860234617252','IMYY0897619634665272','IN250895726134555212','IN370897708734675224','IN3F0895377134545249','IN4B0897614734665225','IN5P0897667534665277','IN6E0897745534678249','IN6G0897612834665244','IN6J0897629934665257','IN810897537234651275','IN8P0897322734628271','INDK0897732234678243','INFK0897619334665280','ININ0897699634675202','INJ30897695434678207','INJG0897607534665216','INKH0897592434665203','INN30897677434678247','INNC0897731834678241','INOC0897656834665296','INPP0897586634665213','INRB0897585134665232','INSG0897719934678217','INTK0897584734665227','INVY0897699234675272','INWS0897709034675262','INXY0897479834655254','INY30896876834616222','INY80897679934675261','IO1F0897585934661204','IO1G0897700234678247','IO240897732034678254','IO6C0897572934664256','IOCP0897625734665281','IOEP0897630734665237','IOFW0897666034669248','IOGS0896040134587268','IOIF0897542934651245','IOMQ0897700034675238','IORM0897650534668263','IOS10897732634678263','IOTX0897636034665226','IOTX0897688834676295','IOU40896836334607263','IOY50897697134678241','IP320897627234665245','IP3S0897575134665270','IP4T0897706534678245','IP6V0897655634665228','IP770897296934628296','IP7I0896835634607252','IP7J0897658134667256','IP8I0897668234665263','IPBE0897536734651278','IPC20897669034667258','IPES0897654234665273','IPFN0897555434657285','IPH20897610334665272','IPHC0897655334665262','IPHK0897618934665292','IPJT0897726934671211','IPLM0897707534675235','IPMR0897652934665286','IPOS0897705534675285','IPP10897700934675240','IPP30895726734555228','IPP40897707134675227','IPS60895726534555216','IPVR0897630334665244','IPWO0897617134665241','IPXX0897627134665294','IQ4J0897706334675244','IQ6H0897617334665229','IQ6X0897537334657230','IQ760897541234658232','IQCN0897746734678201','IQED0897626434665238','IQFJ0897626134665238','IQI70897526834658208','IQJB0897594134660217','IQK50896883234617241','IQKF0897657934665293','IQLO0897612934668279','IQNW0896836834607217','IQO30897664034667242','IQQH0897664934669231','IQSC0897619734665253','IQSD0897652134665252','IQWV0897604734668278','IQXD0897595934665224','IQY10896441634596266','IQYP0897713034675258','IR160897561534661279','IR360897660634666288','IR3E0897603534668215','IR4G0895915434581283','IR4Q0897459034621222','IR550897585334665238','IR6F0897664134667240','IR740897709134675287','IR860897618234665222','IR8N0897380934621292','IRBQ0897613734665279','IRC30895250534546214','IRDT0897401234628284','IRE20897632334665240','IRES0897703734675292','IRGG0897610134665279','IRKR0897706234675212','IRKR0897710034675297','IRMG0897283434629264','IRMT0897721234678282','IRO20897705734675240','IROO0895438134558257','IRPK0897625234668223','IRQ40897648334668285','IRQX0897656934665281','IRUX0897604134665295','IRV30897580134665275','IRW40897606334665211','IRYO0897624234665270','IS260897708434675209','IS2K0897601234665223','IS2S0897651134668247','IS3J0897614234669236','IS6I0897583034665274','IS7U0897709934675203','IS8H0897486734658220','IS8I0897346634628274','IS8P0897737234678254','ISDK0895133834548263','ISDR0897680134675254','ISDY0896279134591225','ISEM0897629434665211','ISF40897621834667261','ISFD0897620434663237','ISGT0897654734665221','ISIK0897586534665262','ISM40897590734665293','ISN10897706434675287','ISNN0897587534665207','ISPP0897732434678281','ISQP0896960834618203','ISRB0897685034678259','ISTF0897678934678240','ISTI0897578534665275','ISWN0897672934665286','ISXJ0897653934665281','ISXP0897624934665282','ISXY0897627934663233','ISYF0897625534665235','ISYO0897490534653291','IT3F0897631134665286','IT3J0897562134666235','IT3J0897592934665286','IT4U0897610534665248','IT6N0897599434665271','IT7X0897402034628225','IT810894783934536295','ITBQ0895444834558223','ITDE0897593334665231','ITDY0897706134675217','ITGE0896900434617271','ITGL0897698334675246','ITJN0897603934665225','ITJW0895726934555205','ITLL0897605734664293','ITLO0897656034665202','ITM70897666834668204','ITN60897600634665202','ITN70895909034582226','ITNJ0897680034675275','ITOK0897664534669245','ITQC0897678234678245','ITRD0897589634665288','ITRM0897584534665287','ITSR0897590134665224','ITTG0897594934665264','ITU20897703434675261','ITVB0897710234675214','ITVV0897706934675263','IU180897667934665295','IU1J0897585034665289','IU250897659134662206','IU2H0897673434668231','IU2T0897297934628224','IU3T0897572834664281','IU3T0897662534665259','IU4G0897575034665247','IU5F0896838534607257','IU7P0897597834665262','IUB60897600134665214','IUBJ0897731134678252','IUFQ0897724634671269','IUHR0897577934665294','IUIN0897533234655252','IULB0897678734671251','IUOG0897571834660240','IUP80897533434653202','IUQB0897534234658228','IURG0897566734666210','IUVM0897581434665289','IUVO0897658534665239','IUW40897626634665223','IUX60897381234629269','IUY50897611934665203','IUYY0897644134668218','IV170896846734607260','IV1P0897593734665225','IV1T0897714234678229','IV220897698734675246','IV230897536934651232','IV3S0897696934675249','IV5K0897616234665205','IV7J0897716134678270','IVDV0897703934675227','IVHS0897696734675278','IVI70897672834668236','IVJB0896902834618261','IVJC0897615334661225','IVJG0897617034665267','IVJM0897588134660273','IVJY0897335434624293','IVLP0896890634617279','IVMC0897397234626262','IVMH0897648734661242','IVNO0897704334675297','IVPG0895913234589211','IVPM0897630434665235','IVQ20897671334668222','IVRB0897605634660297','IVRL0897718434678217','IVVW0897684834675297','IVWV0897601434668246','IVX70897295634628214','IVYL0897653334665202','IVYO0897609334665278','IVYR0897697334675210','IW2X0897697534675234','IW380897585434665259','IW3L0897571534664251','IW4U0897580834665242','IW530897597734668297','IW5O0897625134665202','IW7L0897606634664283','IWBX0897587334665246','IWEV0897607234665285','IWG40897061334618222','IWI40897673534664203','IWMC0896858034611212','IWOR0896860934613204','IWQY0896862434617224','IWSX0897673734664221','IWVM0895441234558268','IWWG0897694634675240','IWWN0896873234617240','IWX80897745434678232','IWYL0897555534657261','IX2Y0897590834665247','IX410894988834539266','IX440897696434675267','IX4S0897656234665296','IX4U0897635434668255','IX5G0897669434665227','IX630897581834665271','IX6F0897576434665257','IX7C0897629634665204','IX860895695734551252','IX8E0897600834660225','IX8E0897618134665257','IXBX0897649034665201','IXC50897666734667270','IXDY0897605234668264','IXEM0897575834665235','IXGW0897665334664229','IXHM0897604534668238','IXI40897583434665212','IXIO0897586934660212','IXJG0897710434675266','IXJI0897644934661216','IXLY0897725534671279','IXNK0897583534665232','IXPB0897284734628296','IXQK0895164434542219','IXQU0895052234531230','IXR60897582134665202','IXS20897584834665255','IXS40897554434658214','IXS60897596934665219','IXV70897705834675234','IXX10897557534668281','IXYC0897594534665227','IXYK0896882334611240','IY1N0897487734656240','IY5K0897613534665232','IY6E0897635234668287','IY6E0897702034675251','IY860897747034678205','IYB50896454434594213','IYC50896401134599201','IYEN0897596834665229','IYHF0897663534666271','IYHS0897621134665295','IYKU0897713334675259','IYMV0894939534530234','IYMY0897733234678243','IYPF0897701734675262','IYQ20897677834678251','IYQX0897646934665249','IYSP0897719734675288','IYSU0897461434625276','IYTJ0897612434665254','IYTN0897664834661281','IYVK0897733134678297','IYWC0897581134665290','IYWX0895439734558265','IYX30897595234665207','IYXN0897712534675249','IYY60897598234665241','IYYK0897579434665251'
);