//sentencia de entrada ?
// ""        "" salida !
PROGRAM ONCE
BEGIN

	process Persona[p=1 to N]
	BEGIN
		Timer[p]!iniciarTimer(p);

		if(true);
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
					END
			[](true);
		END

	END
END