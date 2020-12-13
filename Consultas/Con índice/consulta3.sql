--consulta 3
--seleccionar el esquema donde se realizará la consulta
SET search_path = millon_datos;
SET search_path = cienmil_datos;
SET search_path = diezmil_datos;
SET search_path = mil_datos;

--habilitar la indexación automática de PostgreSQL
SET enable_mergejoin TO on;
SET enable_hashjoin TO on;
SET enable_bitmapscan TO on;
SET enable_sort TO on;

--crear índices para mejorar los tiempos de consulta
CREATE INDEX index_col_nom ON colegio USING btree(nombre);

--liberar la basura
vacuum;

explain analyze 
select count(dni) as num_est, col.nombre as col_nom
from colegio col
inner join estudiante e
on col.codigo = e.col_codigo
group by col.nombre
order by num_est desc
limit 10;