PROGRAM 8
BEGIN
	var
	sem barrera;
	sem sem_tarea
	int tarea;

	sem semCantOperarios =1:
	int cantOperarios= 0;

	sem[T] semElementos = (1);
	int[T] elementos= (0);

	process Operario [o= 1 to M]
	BEGIN

		p(semCantOperarios)
		cantOperarios++;

		if(cantOperarios == 5)
		THEN
			tarea++:
			cantOperarios= 0;
			v(semCantOperarios);
			for(int i = 1; i<=5; i++)
				v(barrera);
		END
		else
		BEGIN
			v(semCantOperarios);
			p(barrera);

		END
		int t = tarea;

		//realizar tarea
		P(semElementos[t])
		while(elementos[t] <= X)
		DO
			elementos[t]--;
			v(semElementos[t]);
			P(semElementos[t])
		END

		//retirarse

	END

END