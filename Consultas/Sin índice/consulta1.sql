--consulta 1
--Seleccionar el esquema en el que se quiere hacer la consulta
SET search_path = millon_datos;
SET search_path = cienmil_datos;
SET search_path = diezmil_datos;
SET search_path = mil_datos;

--deshabilitar las indexaciones automáticas de PostgreSQL
SET enable_mergejoin TO off;
SET enable_hashjoin TO off;
SET enable_bitmapscan TO off;
SET enable_sort TO off;

--eliminar los índices por si se crearon
DROP INDEX index_col_dni;
DROP INDEX index_col_codigo;
DROP INDEX index_col_ciudad;
DROP INDEX index_val_nota;

--ejecutar antes del código para liberar memoria
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