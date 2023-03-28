

-- TOTALES
select to_char(count(*),'999,999,000') recibos, to_char(sum(RE_TOTAL),'999,999,000.00') total
from inREcibo
where re_empresa = 6 and re_fecha_pago between '01-feb-23' and '31-jan-23' and re_status = 'A' and re_uuid is null;


-- APARTAR RECIBO
update inRecibo
set re_timbrado = '1'
    , re_fecha_timbrado = '22-mar-23'
    , re_numcertifsat = ''
    , re_sellocfd = ''
    , re_sellosat = ''
    , re_uuid = '1'
    , re_version = '1.1'
    , re_folio_remanentes = 14
    , re_serie = 'R'
where re_empresa = 6 and re_fecha_pago between '01-feb-23' and '28-feb-23' and re_status = 'A' and re_uuid is null;


COMMIT;

-- ACTUALIZAR EL TIMBRADO CORRECTO
update inRecibo
set re_timbrado = '1'
    , re_fecha_timbrado = '22-mar-23'
    , re_numcertifsat = '00001000000507247013'
    , re_sellocfd = 'JacuivoMo+SyjBj9faWfV9u+p0GABCryFJZfHHI4yzIDAnWkMP3WD1qNEVPtvxhdquDLcqF+XUGkuhB2wHU+b1tuWu+ta/qVK2a0LYIvhtRkvzEh85r3bMM+RBM7ASsdDHcnFxVosNwBepekJuxiNJh9C18e7wLgr+lUzfGyoWnUN8fL5w7ieix3TpLhGCpGOqiKWOdR6PQCCD6wxhzFWHO6SxrTT78xNDwsHVIgEYZOyKdAysejNeaHtEjd3Q+Ae/eGZjlCYwdXd6DvuOM4OHTyKopv6zHm2eZOk8kNvoFVd0g9CNBWV/h1xgidmaIIIA4Rhl4L2U3MX6JOOzmmYw=='
    , re_sellosat = 'ZTIGXaDdju+e7p2IEIUEnNvRDREvXQbROs5urBknG2tqyA/IOn4lDIwYUVbKAWpsMjFjs0DjyAwjAkaLihrJQCRAoYzgCMS3Qif2vg7AjYc3hZ4HElYQX0wruPB1MbHP2pU4LB/cdAKuvlAkKQv3QHQaCK+g7yE3JZ9MdAruDQIlz0YeBeENNaQ6m7zl8gE8do4/tFeML4e256g8Hkfvj/Q6/6SejLvYf2NqBFcTSTrh7dQe0k7srbQ8eXWjpnr6D3QiTX+2trGb9RQgLwC8M6PZHPQ5x7F3viVBwxWgfB96RdRYtUSV1aaezsyI3qj0tgABkvN58iLVqFuk5frU7A=='
    , re_uuid = 'cee0cb9b-cb74-4787-8118-0aa12d45b22a'
    , re_version = '1.1'
where re_empresa = 6 and re_folio_remanentes = 14;


select count(*), sum(RE_TOTAL)
from inREcibo
where re_empresa = 6 and re_folio_remanentes = 14;

---
-- Folios remanentes usados
12 - Feb/2023 
13 - Mar/2023 para GLOBAL Enero
14 - Mar/2023 para GLOBAL Febrero

