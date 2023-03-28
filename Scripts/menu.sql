

select * from inEmpresas order by em_id;



select t.*, t.rowid
from inMenu t
where me_empresa = 6
order by me_empresa, me_id;

select t.*, t.rowid
from inUsuario_opciones t;

insert into inMenu
select em_id,328,300, '/SifiReceptoria/municipio/inventario.htm','Inventario',50
from inEmpresas;

insert into inUsuario_opciones select em_id,693,'sifi' from inEmpresas;


insert into inUsuario_opciones select em_id,693,'AmparoGlzS' from inEmpresas;



select *
from inMenu
where me_id = 335;

select * from inUsuarios;

COMMIT;


UPDATE inmenu
SET me_desc ='Productos/Servicios'
WHERE me_id = 325;

-- inserta opciones faltantes de menu tomando como referencia empresa 1
insert into inMenu
select em_id, me_id, me_parent_id, me_url, me_desc, me_menu_icon
from inMenu a, inEmpresas
where me_empresa = 1
    and not exists (    
        select 1
        from inMenu b
        where B.ME_EMPRESA = em_id
            and b.me_id = a.me_id 
)





insert into inTarifasConMed_AD
select em_id, tm_ejercicio, tm_agua_o_drenaje, tm_es_domestico, tm_periodo, tm_rango_inf, tm_rango_sup, tm_cuota_minima_sm, tm_cuota_excedente_sm, tm_usuario, tm_upd_date
from inEmpresas, inTarifasConMed_ad
where tm_empresa = 1 and em_id != 1


select * from inMenu
;



     
select t.*, t.rowid from inEmpresas WHERE co_id = :compa 


select * from inEmpresas;

select co_id, co_nombre, co_cfdi_contratados, co_seq_cfdi
from nmCompany
where co_id = :company;

COMMIT;

update nmCompany
set co_cfdi_contratados = nvl(co_cfdi_contratados,0) + :comprados,
    co_seq_cfdi  = nvl(co_seq_cfdi,0),
    co_version_timbrado = 2
where co_id = :company;
