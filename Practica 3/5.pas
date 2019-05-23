PROGRAM BANCO
BEGIN
	Monitor Cola 
	BEGIN
		var
			queue cola;
			cond empleado;
		
		procedure llegue (int cliente)
		BEGIN
			cola.push(cliente);
			signal(empleado);
		END;

		procedure atender(var int cliente)
		BEGIN
			while (cola.empty())
			BEGIN
				wait();
			END;
			cliente = cola.pop();
		END;
	END; //monitor


	Monitor Coordinado_Timer [ct = 1 to N]
	BEGIN

		var
		cond cola;
		Bool llegoPersona = false

		procedure llegue()
		BEGIN
			llegoPersona = true;
			signal(cola);
		END;

		procedure iniciarTimer()
		BEGIN
			if(!llegoPersona)
			BEGIN
				wait(cola);
			END;
		END;
	END;

	Monitor ESTADO [e= 1 to N]
	BEGIN
		var
		cond cola;
		// estados posibles
		// e:esperando
		// a: atendido
		// sf: el cliente se fue por que pasaron los 15 minutos
		string estado = "e";

		procedure esperar(var string estadoActual)
		BEGIN
			if(estado == "e")
			BEGIN
				wait(cola);
			END;

			// me va a retornar el estado actual de la persona
			estadoActual = e;
		END;

		procedure cambiarEstadoTimer(string nuevo_estado)
		BEGIN
			//si el estado es esperando lo atiendo
			if(estado == "e")
			BEGIN
				estado = nuevo_estado;
				signal(cola);
			END;
		END;

		procedure QuiereAtender(var string estado_actual)
		BEGIN
			if(estado == "e")
			BEGIN
				estado = "a";
				
			END;
			estado_actual = estado;
			signal(cola);

		END;
	END;


	Process Timer_Cliente[t =1 to N]
	BEGIN

		Timer_Cliente[t].IniciarTimer();
		//espero 15 minutos
		delay("15m");
		ESTADO[t].cambiarEstadoTimer("sf");

	END;

	Process cliente[ c= 1 to N]
	BEGIN
		//indico que el cliente llego
		Cola.llegue(c);

		//inicio el timer
		Coordinado_Timer[c].llegue();

		ESTADO[c].esperar();

	END;

	Process Empleado [e= 1 to 2]
	BEGIN

		while(true)
		BEGIN
			int cliente;
			
			Cola.atender(cliente);

			string estadoActual;
			ESTADO[e].QuiereAtender(estadoActual);
			if(estadoActual == 'a')
			BEGIN
				// atender a la persona
			END;
		END;
	END;

END;