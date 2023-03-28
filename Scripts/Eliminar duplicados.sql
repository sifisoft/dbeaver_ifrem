



select 
from inLineas_pagadas
where trunc(lp_fecha_pago) = trunc(sysdate-2)
order by lp_empresa, lp_linea_captura, lp_fecha_pago;

select max(lp_fecha_pago)  from inLineas_pagadas;


delete from inLineas_pagadas 
where trunc(lp_fecha_pago) = trunc(sysdate-2) and lp_procesado = 'D';

select *
from inLineas_pagadas
where lp_procesado = 'D'


delete from inLineas_pagadas
where lp_procesado = 'D';


