PROGRAM SEIS
BEGIN
	chan clienteHabitual(int clienteId);
	chan clienteEsporadico(int clienteId);
	chan[N] esperar();
	process Cliente[c=1 to N]
	BEGIN
		string tipoCliente = DarCategoria();

		if(tipoCliente == "habitual")
		THEN
			send clienteHabitual(c);
		ELSE
			send clienteEsporadico(c);
		END

		recive (esperar[c]());
	END

	process Caja [0]
	BEGIN
		while(true)
		DO
			int clienteId;
			if(!EMPTY(clienteHabitual))
			THEN
				recive(clienteHabitual(clienteId))
				//atender a cliente habitual
				send esperar[clienteId]();
			[](EMPTY(clienteEsporadico) && EMPTY(clienteHabitual))
			THEN
				recive(clienteEsporadico(clienteId))
				//atender a cliente habitual
				send esperar[clienteId]();
			END
		END
	END

END