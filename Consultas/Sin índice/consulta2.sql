--consulta 2
--seleccionar el esquema en el que se quiere hacer la consulta
SET search_path = millon_datos;
SET search_path = cienmil_datos;
SET search_path = diezmil_datos;
SET search_path = mil_datos;

--deshabilitar las indexaciones automáticas de PostgreSQL
SET enable_mergejoin TO off;
SET enable_hashjoin TO off;
SET enable_bitmapscan TO off;
SET enable_sort TO off;

--eliminar índices
DROP INDEX index_m_mat;
DROP INDEX index_fe_mat;

--liberar la basura antes de la consulta
vacuum;

explain analyze 
select count(dni) as matriculados, (
	case 
		when ma.fecha > '2019-01-01' and ma.fecha < '2019-06-30' 
			then 'primer semestre'
		when ma.fecha > '2019-07-01' and ma.fecha < '2019-12-31'
			then 'segundo semestre'
	end
) as semestre
from matricula ma 
join estudiante e
on e.m_codigo = ma.codigo
where ma.fecha > '2019-01-01' and ma.fecha < '2019-12-31'
group by 
	case 
		when ma.fecha > '2019-01-01' and ma.fecha < '2019-06-30' 
			then 'primer semestre'
		when ma.fecha > '2019-07-01' and ma.fecha < '2019-12-31'
			then 'segundo semestre'
	end;
	