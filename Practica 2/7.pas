PROGRAM 7
BEGIN
	var
	string[N] estados;
	sem[N] coordinadorTimer = (0);
	sem[N] cordinadorEstado= (1);
	sem[N] sem_personas = (0);
	sem empleado =0:
	queue ColaPersonas;
	sem sem_personas =1;
	process Persona[p=1 to N]
	BEGIN
		p(cordinadorEstado[p])
		estados[p] = "esperando";
		
		p(ColaPersonas);
		personas.push(p);
		v(ColaPersonas);

		v(cordinadorEstado[p]);
		v(coordinadorTimer[p]);
		v(empleado);

		p(sem_personas[p]);
	END

	process Timer[t=1 to N]
	BEGIN
		p(coordinadorTimer[t]);
		delay("10m");

		p(cordinadorEstado[personaId])
		if(estados[personaId] == "esperando")
		THEN
			//atender persona
			estados[t] = "timeOut"
			v(sem_personas[t]);
			v(cordinadorEstado[t]);
		END
		else
		THEN
			v(cordinadorEstado[t]);
		END
	END

	process Empleado()
	BEGIN
		while(true)
		BEGIN
			p(empleado);

			p(ColaPersonas);
			int personaId = personas.pop();
			v(ColaPersonas);

			p(cordinadorEstado[personaId])
			if(estados[personaId] == "esperando")
			THEN
				//atender persona
				estados[personaId] = "atendido"
				v(sem_personas[p]);
				v(cordinadorEstado[personaId]);
			END
			ELSE
			THEN
				v(cordinadorEstado[personaId])
			END
		END
	END

END