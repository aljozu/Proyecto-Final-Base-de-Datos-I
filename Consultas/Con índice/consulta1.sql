--consulta 1
--seleccionar el esquema en el que se quiere hacer la consulta
SET search_path = millon_datos;
SET search_path = cienmil_datos;
SET search_path = diezmil_datos;
SET search_path = mil_datos;

--habilitar las indexaciones automáticas de PostgreSQL
SET enable_mergejoin TO on;
SET enable_hashjoin TO on;
SET enable_bitmapscan TO on;
SET enable_sort TO on;

--Crear índices para mejorar el tiempo de las consultas
CREATE INDEX index_col_dni ON estudiante USING hash(dni);
CREATE INDEX index_col_codigo ON colegio USING hash(codigo);
CREATE INDEX index_col_ciudad ON colegio USING hash(ciudad);
CREATE INDEX index_val_nota ON nota USING btree(valor);

--ejecutar antes de la consulta para liberar la basura
vacuum;

explain analyze 
select e.dni, col.nombre as colegio, e.nombre, 
e.apellido, re.valor as nota, re.curson as curso
from estudiante e
inner join(
	select codigo, nombre 
	from colegio 
	where ciudad = 'Auckland'
) col on e.col_codigo = col.codigo
inner join(
	select es_dni, c_codigo, valor, cu.nombre as curson 
	from nota n
	inner join curso cu
	on n.c_codigo = cu.codigo
	where valor < 10
) re on re.es_dni = e.dni;



