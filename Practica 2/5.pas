PROGRAM 5
BEGIN
	var
	sem barrera= 0;
	sem semCantAlumnos= 1;
	int cantAlumnos= 0; 
	int[10] notas;
	sem semColaTarea=1;
	queue colaTarea();
	sem[10] sem-alu-tarea = 0;
	sem profesor =0;
	procedure Alumno [a= 1 to 50]
	BEGIN

		P(semCantAlumnos)
		cantAlumnos++;
		var int tarea = elegirTarea();
		if(cantAlumnos == 50)
		THEN
			V(semCantAlumnos);
			
			for(int i = 1 to 50)
				V(barrera);
		END
		ELSE
			V(semCantAlumnos);
			P(barrera);
		END
		//realizar tarea
		p(semColaTarea)
		colaTarea.push(tarea);
		v(semColaTarea);
		v(profesor);
		p(sem-alu-tarea[tarea]);
	END


	procedure Profesor [0]
	BEGIN
		int alumnos = 1;
		notas = 10;
		while(alumnos <= 50)
		do
			p(profesor);

			p(semColaTarea);
			int tarea = colaTarea.pop();
			v(semColaTarea);

			tareas[tarea]++;
			if(tareas[tarea] == 5)
			THEN
				notas[tarea] = notas;
				notas --;
				for(i=1, i<=5, i++) 
					v(sem-alu-tarea[tarea]);
			END
			alumnos--;
		end
	END
END