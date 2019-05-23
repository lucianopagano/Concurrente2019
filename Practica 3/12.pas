//Resolver el uso de un equipo de videoconferencia que puede ser usado
//por una unica persona a la vez. Hay P personas que utilizan este equipo
//(una unica vez cada uno) para su trabajo de acuerdo a su prioridad.
//La prioridad de cada persona esta dada por un numero entero positivo.
//Ademas existe un administrador que cada 3 horas incrementa en 1 la prioridad
//de todas las personas que estan esperand por usar el equipo


PROGRAM 12
BEGIN
	process Persona [per=1 to P]
	BEGIN

		Equipo.utilizar(per);
		//realizar video conferencia
		Equipo.liberar();
	END

	process Administror[0]
	BEGIN
		while(true)
		DO
			delay('30h');
			Equipo.actualizarPrioridades;
		END
	END

	Monitor Equipo
	BEGIN
		var
		//diccionario de datos
		//primer int corresponde al id de la persona
		//segundo int corresponde a la prioridad
		//inicializo en 1 para qeu todas las personas
		//tengan prioridad 1
		prioridades<int, int>;

		bool libre = true;
		
		//un condicional por persona
		cond[P] colaPersonas;

		procedure utilizar(int persona)
		BEGIN
			if(!libre)
			THEN
				int prioridad = calcularPrioridad();
				prioridades.add(persona,prioridad);
				wait(colaPersonas[persona]);
			END
			ELSE
			THEN
				libre = false;
			END
		END

		procedure liberar()
		BEGIN
			
			if(prioridades.empty())
			THEN
				libre = true;
			END 
			ELSE
			THEN
				int persona;
				int max = -1;
				foreach(p in prioridades)
				DO
					if(max < p.value)
					THEN
						max = p.value;
						persona = p.index:
					END
				END
				//elimina del diccionario de prioridades la prioridad
				prioridades.remove(persona);

				//despierto el proceso
				signal(persona);
			END	
		END

		process actualizarPrioridades()
		BEGIN
			if(!prioridades.empty())
			THEN
				foreach(p in prioridades)
				DO
					p.value ++:
				END
			END
		END
	END
END