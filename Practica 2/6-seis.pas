// A una empresa llegan E empleados y por día hay T tareas para hacer (T>E),
// una vez que todos los empleados llegaron empezaran a trabajar.
// Mientras haya tareas para hacer los empleados tomaran una y la realizarán.
// Cada empleado puede tardar distinto tiempo en realizar  cada  tarea.
// Al finalizar el día se le da un premio al empleado que más tareas realizó.

Program Seis
var
	int tareasRealidas[E];
	sem barrera= 0;
	
	cantEmpleados=0;
	sem sem_cantidadEmpleados =1;

	Queue Tareas;
	sem sem_Tareas=1;

	sem premio = 0;

	sem sem_cantPremio=1;
	int cantPremio=0:
	sem barreraPremio;
BEGIN

	process Empleado [e=1 to E]
	var
		int tId;
	BEGIN

		p(sem_cantidadEmpleados);

		if(cantEmpleados != E)then
			cantEmpleados ++;
			v(sem_cantidadEmpleados);
			p(barrera);
		else
			for (1 to E) do
				v(barrera);
			end
			v(sem_cantidadEmpleados);
		end

		p(sem_Tareas)
		while(NOT EMPTY(Tareas))
		do
			tId = Tareas.pop();
			v(sem_Tareas);
			//metodo que realiza la tarea 
			RealizarTarea(tId);
			tareasRealidas[e] ++;
			p(sem_Tareas);
		end

		v(sem_Tareas);

		p(sem_cantPremio);
		if(cantPremio != E) then
			cantPremio++;
			v(sem_cantPremio);
			p(barreraPremio);
		else
			v(premio);
			p(barreraPremio);
		end

	END

	process Premio [0]
	var
		int max;
	BEGIN
		v(premio);
		//calculo el que mas tareas tiene
		max= CalcularMaximo(tareasRealidas);
		//le entrego el premio al ganador
		EntregarPremio(max);

		for (1 to E)do
			v(barreraPremio);
		end

	END

END