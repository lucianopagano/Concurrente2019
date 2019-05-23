//Para una obra de teatro hay un Empleado y P personas que intentan asistir 
//a la misma. Cada persona cuando llega espera a lo sumo 10 minutos a que
//el empleado lo atienda (pasado ese tiempo se reitra sin entrar a la obra),
//le paga la entrada, y lo acompana hasta su asiento. El empleado atiende 
//a las personas de acuerdo al orden de llegada.
//Nota: suponga que hay suficiente lugar en la obra para todas las personas.


PROGRAM Parcial 2018
BEGIN
	Monitor Cola 
	BEGIN
		queue personas;
		cond colaEspera;
		cond empleado;
		int cantPersonas= 0;

		procedure llege(int idPersona)
		BEGIN
			cantPersonas++;
			personas.push(idPersona);
			if(!colaVacia)
			BEGIN
				signal(empleado);
				wait(colaEspera);
			END
			ELSE
				colaVacia = true;
		END

		procedure obtenerPersona(var int personaId)
		BEGIN
			if(colaVacia)
			//preguntar por que!!! si hay muchos empleados deberia ser un while?
				wait(empleado);	
			
			personaId = persona.pop();
		END

		procedure atenderPersona()
		BEGIN

			if(cantPersonas > 0 )
			BEGIN
				colaVacia = false;
				signal(colaEspera);
			END
			ELSE
				colaVacia= true;
		END

	END

	Monitor EstadoPersona [ep = 1 to n]
	BEGIN
		string Estado= "no llego";
		int cantidad=0;
		cond cola;

		procedure Llegar()
		BEGIN
			cantidad ++;
			//hago esto para sincronizar
			// la persona con l timer
			if(cantidad < 2)
			THEN
				wait(cola);
			END
			ELSE
			THEN
				estado = "esperando";
				signal(cola);
			END
		END

		procedure ModificarEstado(var string e)
		BEGIN
			if(estado == "esperando")
			BEGIN
				Estado = e;
				e= Estado;
			END
			ELSE
				e = Estado;
		END
	END

	Process Timer[t = 1 to n]
	BEGIN
		
		EstadoPersona[t].Llegar();
		delay("10m");
		
		EstadoPersona[persona].ModificarEstado("se fue");
		if(estado == "se fue")
		THEN
			// como hacer que se vaya?
		END

	END
	

	Process Persona [p=1 to n]
	BEGIN
		EstadoPersona[p].llegoPersona();
		Cola.llegue(p);
	END

	Process Empleado [0]
	BEGIN
		while (true)
		BEGIN
			int persona = Cola.obtenerPersona();
			string estado;
			EstadoPersona[persona].ModificarEstado(estado);
			if(estado == "atendiendo")
			BEGIN
				Cola.atenderPersona();
				//ubicar a la persona
			END
			
		END
	END


END