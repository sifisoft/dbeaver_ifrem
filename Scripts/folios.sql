
select t.*, t.rowid
from inEmpresas t;

select em_id, em_cfdi_contratados, em_seq_cfdi, t.rowid
from inEmpresas t;


select * 
from inVencimientos
order by ven_empresa, ven_periodicidad, ven_periodo

select *
from inHistoricoLecturas