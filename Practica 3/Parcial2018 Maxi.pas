//En un evento culinario hay N personas que van a comer y un empleado que los atiende de acuerdo
//al orden de llegada. La persona le indica al empleado que plato quiere y este se lo entrega.
//Nota: maximizar la concurrencia.


PROGRAM Parcial Maxi
BEGIN


	Monitor Cola
	BEGIN

		cond colaPersona;
		cond colaEmpleado:
		
		queue personas;
		int cantidadPersonas =0;
		bool hayPersonas;

		procedure pedirPlato(int personaId)
		BEGIN
			if(hayPersonas)
			BEGIN
				personas.push(personaId);
				signal(colaEmpleado);
				wait(colaPersona);
					
			END ELSE
			THEN
				hayPersonas =true:
				personas.push(personaId)
				signal(colaEmpleado);
				wait(colaPersona);
			END
		END

		procedure entregarPlato()
		BEGIN
			if(empty(personas))
			THEN
				hayPersonas = false;
			END
			signal(colaPersona);

		END

		procedure obtenerPersona(var int personaId)
		BEGIN
			
			if(empty(personas))
			THEN
				wait(colaEmpleado);
			END

			personaId = personas.pop();
		END

	END

	process Empleado [0]
	BEGIN
		while(true) DO
			int personaId
			Cola.obtenerPersona(personaId);
			//obtener plato
			Cola.entregarPlato();

		END
	END

	process Persona [p=1 to N]
	BEGIN
		Cola.pedirPlato(p);
	END
END