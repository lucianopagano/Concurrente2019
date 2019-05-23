//Para una obra de teatro hay un Empleado y N personas que intentan asistir 
//a la misma. Cada persona cuando llega espera a lo sumo 10 minutos a que
//el empleado lo atienda (pasado ese tiempo se reitra sin entrar a la obra),
//le paga la entrada, y lo acompana hasta su asiento. El empleado atiende 
//a las personas de acuerdo al orden de llegada.
//Nota: suponga que hay suficiente lugar en la obra para todas las personas.

PROGRAM ParcialObraTeatro
BEGIN


	process Empleado [0]
	BEGIN
		while (true)
		BEGIN
			int persona;
			Cola.obtenerPersona(persona);
			//atender persona
			Estado[persona].cambiarEstado("atendido");

		END
	END

	process Personas [p=1 to N]
	BEGIN
		CordinadorTimer.despertarTimer();
		Estado[p].llegaPersona();

		string estado;
		Estado[p].obtenerEstado(estado);

		if(estado== "timeOut")
		THEN
			//irse a la recalcada concha de la lora
		END
		else if (estado== "atendido");
		THEN
			//mirar obra
		END
	END

	process Timer [t=1 to N]
	BEGIN
		CordinadorTimer[t].dormirTimer();
		delay("10m");
		Estado[t].cambiarEstado("timeOut")
	END

	Monitor Estado [1 to N]
	BEGIN
		string estado = "no llego"
		cond colaPersona;

		procedure llegaPersona()
		BEGIN
			estado = "esperando"
			wait(colaPersona);
		END

		procedure cambiarEstado(string newEstado)
		BEGIN
			if(estado == "esperando")
			THEN
				estado = newEstado;
				signal(colaPersona);
			END
		END

		procedure obtenerEstado(var string e)
		BEGIN
			e = estado;
		END
	END



	Monitor Cola
	BEGIN
		queue personas;
		cond empleado;

		procedure llegoPersona(int persona)
		BEGIN
			personas.push(persona);
			signal(persona);
		END

		procedure obtenerPersona(var int persona)
		BEGIN
			if(personas.empty())
				wait(empleado);
			persona = personas.pop();
		END
	END

	Monitor CordinadorTimer[1 to N]
	BEGIN

		bool llegoPersona= false;
		cond cola;

		procedure dormirTimer()
		BEGIN
			if(!llegoPersona)
			THEN
				wait(cola);
			END
		END
		procedure despertarTimer()
		BEGIN
			llegoPersona := true;
			signal(cola);
		END
	END

END