//Suponga que N personas llegan a la cola de un banco. Una vez que la persona se agrega
//en la cola no espera más de 15 minutos para su atención, si pasado ese tiempo no fue
//atendida se retira. Para atender a las personas existen 2 empleados que van atendiendo de
//a una y por orden de llegada a las personas. 


PROGRAM CINCO
BEGIN

	chan[N] iniciarTimer();

	chan[N] terminoTiempo();
	chan[N] consultarEstadoEmpleado();
	chan[N] enviarEstadoCliente(string estado);

	chan[2] enviarEstadoAEmpleado(string estado);

	chan encolarCliente(int clienteId);

	process Cliente [c=1 to N]
	BEGIN
		send iniciarTimer[c]();
		send encolarCliente(c)
		string estado;
		recive enviarEstadoCliente[c](estado);

		if(estado == "atendido")
		THEN
			//hacer cosas en el banco
		ELSE
			//irse
		END
	END


	process Estado[e= 1 to N]
	BEGIN
		string estado = "e";
		bool clienteEsperando;
		while(true)
		DO
			if(!EMPTY(terminoTiempo[e]))
			THEN
				recive(terminoTiempo[e]());

				if(estado == "e")
				THEN
					estado = "timeOut";
					send(enviarEstadoCliente[e](estado))
				END
			[](!EMPTY(consultarEstadoEmpleado[e]) && empty(terminoTiempo))
			THEN
				var empleadoId;
				recive(consultarEstadoEmpleado[e](empleadoId))
				if(estado == "e")
				THEN
					estado = "atendiendo";
				END

				send enviarEstadoAEmpleado[empleadoId](estado);
			END

		END

	END

	process Timer[t=1 to N]
	BEGIN
		recive(iniciarTimer[t]());
		delay("15m");
		send(terminoTiempo[e]);
	END

	process Empleado[e = 1 to 2]
	BEGIN
		while(true)
		DO
			int clienteId;
			recive(encolarCliente(clienteId));

			send(consultarEstadoEmpleado[clienteId](e));
			recive (enviarEstadoAEmpleado[e](estado));

			if(estado == "atendiendo")
			THEN
				//atender persona
				enviarEstadoCliente[clienteId]("atendido");
			END
		END
		
	END


END