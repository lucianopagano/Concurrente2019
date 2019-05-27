//sentencia de entrada ?
// ""        "" salida !
PROGRAM ONCE
BEGIN

	process Persona[p=1 to N]
	BEGIN
		Timer[p]!iniciarTimer(p);
		Cola!llegue(p);

		string estado;
		Estado[p]?personaEsperar(estado);
		if(estado== "timeOut")
		THEN
			// irse
		ELSE
			//atencion
		END
		
	END

	process Timer[t=1 to N]
	BEGIN
		var 
		int persona;
		Timer[t]?iniciarTimer(persona);
		delay("10m");
		Estado[persona]!terminoTiempo();
	END

	process Estado[e=1 to N]
	BEGIN
		var estado = "esperando";

		while(true)
		DO
			if(true);Timer[e]?terminoTiempo()->
					if(estado == "esperando")
					THEN
						estado="timeOut";
						Persona[e]!personaEsperar(estado);
					END
			[](true);Empleado?ObtenerEstado()->
					if(estado == "esperando")
					THEN
						estado="atendiendo";
					
						Persona[e]!personaEsperar(estado);
					END

			[](true);Empleado?AvisarPersona()->
					Persona[e]!personaEsperar(estado);

		END
	END

	process Cola[1]
	BEGIN
		queue cola;
		while(true)
		DO
			int persona
			if(true);Persona[*]?llegue(persona)-> cola.pop(persona);
			
			[](!EMPTY(cola))-> 
							Empleado?estoyLibre();
							Empleado!obtenerPersona(persona);
		END
	END

	process Empleado[1]
	BEGIN
		while (true)
		DO
			Cola!estoyLibre();
			int persona;
			Cola?obtenerPersona(persona);
			Estado[persona];
		END
	END
END