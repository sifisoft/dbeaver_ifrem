



-- OJO Cancelar antes el CFDI de la linea unica.... 

select * from inRecibo where re_linea_captura = 'IH4E0915081735445216';         -- linea destino

select re_folio_remanentes, t.* from inRecibo t where re_linea_captura = :lineaOrigen;


-- QUITAR TIMBRADO Global
-- OJO Cancelar antes el CFDI de la linea unica....
update inREcibo
set re_uuid = (select re_uuid from inRecibo where re_linea_captura = :lineaOrigen)
    , re_sellocfd  = (select re_sellocfd from inRecibo where re_linea_captura = :lineaOrigen)
    , re_cadena_original= (select re_cadena_original from inRecibo where re_linea_captura = :lineaOrigen)
    , re_timbrado = (select re_timbrado from inRecibo where re_linea_captura = :lineaOrigen)
    , re_fecha_timbrado = (select re_fecha_timbrado from inRecibo where re_linea_captura = :lineaOrigen)
    , re_pac_xml_url = (select re_pac_xml_url from inRecibo where re_linea_captura = :lineaOrigen)
    , re_folio_remanentes = (select re_folio_remanentes from inRecibo where re_linea_captura = :lineaOrigen)
where re_linea_captura = 'IH4E0915081735445216';  -- linea destino