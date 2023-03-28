


select *
from inUsuarios
where us_status = 'A';

update inUsuarios
set us_status = 'B'
where us_id not in ('sifi','scruz','AmparoGlzS','6ClaudiaH')

delete from inUsuarios where us_status = 'B';

delete from inUsuario_permisos where us_id in ( select us_id from inUsuarios where us_status = 'B' );

delete from inUsuario_opciones where uo_usuario in ( select us_id from inUsuarios where us_status = 'B');

delete from inusuario_empresas where ue_usuario in ( select us_id from inUsuarios where us_status = 'B');


insert into inUsuario_opciones
select uo_empresa, uo_opcion, :nuevoUsuario 
from inUsuario_opciones
where uo_usuario = :usuarioBase;

insert into inUsuario_empresas
select ue_empresa, :nuevoUsuario
from inusuario_empresas
where ue_usuario = :usuarioBase;