PROGRAM DOS
BEGIN

	chan enviarPedido(int personaId);
	chan porteroLibre(int porteroId);
	chan dejarReclamo(int reclamoId);

	chan[3] enviarReclamo(int reclamoId);

	process Portero [p=1 to 3]
	BEGIN
		bool[P] pedidosRealidados =(false)

		while(true)
		DO
			
			send(porteroLibre(p));
			recive(enviarReclamo[p](Id));
			if(Id != null)
			THEN
				int reclamoId:
				
				//atender reclamo
			
			ELSE
			
				delay("10m");
			END
		BEGIN
	END

	process Persona [p=1 to P]
	BEGIN
		send(dejarReclamo(p));
	END	

	process Coordinador[0]
	BEGIN
		while(true)
		DO
			int porteroLibre;
			recive(porteroLibre(porteroLibre));

			if( EMPTY(dejarReclamo))
			THEN
				send(enviarReclamo[porteroLibre](null));
			ELSE
				int personaId;
				recive(dejarReclamo(personaId);
				send(enviarReclamo[porteroLibre].(reclamoId));
			END
		END
	END


END