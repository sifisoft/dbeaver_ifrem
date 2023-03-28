


select * from inRecibo where re_linea_captura = 'IDL30802632630497281';

select * from inRecibo where re_linea_captura = :lineaCaptura;

select t.*, t.rowid from inRecibo t where re_recibo = :recibo;


-- Reactivar recibo
update inRecibo
set re_status = 'A', 
    re_cxl_user = null,
    re_cxl_date = null,
    re_cxl_notas = null,
    re_cancelado = null,
    re_cancelado_fecha = null,
    re_cancelado_usuario = null
where re_recibo = :recibo;    
