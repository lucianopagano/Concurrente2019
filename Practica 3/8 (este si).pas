//Suponga que N personas llegan a la cola de un banco.
//Una vez que la persona se agrega a la cola espera mas de 15 
//minutos para su atencion, si pasado ese tiempo no fue 
//atendida se retira. Para atender a las personas existen
//2 empleados que van atendiendo de a una y por orden de llegada 
//de las personas

PROGRAM EsteSi
BEGIN

	process Persona [p=1 to N]
	BEGIN
		CoordinadorTimer[p].despertarTimer();
		ColaBanco.llegaPersona(p);
		Estado[p].llegoPersona();


	END

	process Empleado [e=1 to 2]
	BEGIN
		var 
			int	persona;
		while(true)
		DO
			persona
			ColaBanco.ObtenerPersona(persona);
			//atender persona
			Estado[persona].modificarEstado("atendido");
		END
	END

	process Timer [t=1 to N]
	BEGIN
		var
		string estado;
		CoordinadorTimer[t].dormirTimer();
		if(estado == "esperando")
		BEGIN
			delay("15m");
			Estado[t].modificarEstado("se fue");
		END
	END

	Monitor CoordinadorTimer [tp = 1 to N]
	BEGIN
		var
		bool llegoPersona = false;
		cond persona;

		procedure dormirTimer()
		BEGIN
			if(!llegoPersona)
			THEN
				wait(persona)
			END
		END

		procedure despertarTimer()
		BEGIN
			llegoPersona = true;
			signal(persona);
		END																			
	END

	Monitor Estado[e=1 to N]
	BEGIN

		string estado="no llego";
		cond persona;
		procedure llegoPersona()
		BEGIN
			estado = "esperando";
			wait(persona);
		END

		procedure modificarEstado(e)
		BEGIN
			if(estado == "esperando")
			THEN
				estado = e;
				signal(persona);
			END
		END

	END

	Monitor ColaBanco
	BEGIN
		var 
		cond colaPersona;
		queue personas;

		procedure llegaPersona(int persona)
		BEGIN
			personas.push(p);
			signal(empleado);
		END

		procedure ObtenerPersona(var int persona)
		BEGIN
			if(colaPersona.empty())
				wait(empleado);
			persona = colaPersona.pop();
		END
	END

END