-- Hay una empresa de servicios que tiene un Recepcionista, N Clientes que hacen
-- reclamos y E Empleados que los resuelven. Cada vez que un cliente debe hacer un
-- reclamo, espera a que el Recepcionista lo atienda y le dé un Número de Reclamo, y
-- luego continúa trabajando. Los empleados cuando están libres le piden un reclamo para
-- resolver al Recepcionista y lo resuelven. El Recepcionista recibe los reclamos de los
-- clientes y les entrega el Número de Reclamo, o bien atiende los pedidos de más trabajo
-- de los Empleados (cuando hay reclamos sin resolver le entrega uno al empleado para
-- que trabaje); siempre le debe dar prioridad a los pedidos de los Empleados. Nota: los
-- clientes, empleados y recepcionista trabajan infinitamente

TASK Recepcionista IS
	ENTRY entregarReclamo(in string reclamo, out int reclamoId);
	ENTRY darReclamoEmpleado(out string reclamo);
END Recepcionista;

TASK BODY Recepcionista IS
	queue reclamos= new queue();
	int cantReclamos=0;
	LOOP
		select 
			accept entregarReclamo(in string reclamo, out int reclamoId) && darReclamoEmpleado'count == 0;
				cantReclamos++;
				reclamos.push(reclamo);
				reclamoId = cantReclamos;
			OR
				when !EMPTY(reclamos)=> accept darReclamoEmpleado();
					reclamo = reclamos.pop();

		end select;
	END LOOP;

END Recepcionista;


TASK TYPE Cliente IS
END Cliente;

TASK BODY Cliente IS
	LOOP
		int numeroReclamo;
		string reclamo = GenerarReclamo();
		int reclamoId;
		Recepcionista.entregarReclamo(reclamo,reclamoId);
		--guarda el id del reclamo 
	END LOOP;
END Cliente;

TASK TYPE Empleado IS
END Empleado;

TASK BODY Empleado IS

	LOOP
		string reclamo;
		Recepcionista.darReclamoEmpleado(reclamo);
		ResolverReclamo(reclamo);
	END LOOP;

END Empleado;
var

array of cliente[1..N] clientes;
array of empleado[1..E] empleados;
