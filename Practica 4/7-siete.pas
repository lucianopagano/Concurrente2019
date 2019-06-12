PROGRAM SIETE
BEGIN 

	chan[N] arrancarTimer();
	chan[N] terminoTimer();

	chan[N] esperar(string estado);

	chan llegoCamion(int idCamion): 
	
	chan[N] calcularEstado();
	chan[N] empezarAatender(string estado);


	chan realizarDescarga(string tiempo,int camion);
	chan[n] descargaRealizada();

	process Camion [c=1 to N]
	BEGIN
		send arrancarTimer[c]();
		//falta send a Encargado
		string estado;
		recive(esperar[c](estado));

		if(estado == "TO")
           			//irse 
		ELSE
			string tiempoDescarga = Descarga();

			send realizarDescarga(tiempoDescarga,c);
			recive(descargaRealizada[c]());
		END
	END

	process Acopiadora()
	BEGIN
		//poner en un while 
		string tiempo;
		int camion;
		recive(realizarDescarga(tiempo,camion))
		delay(tiempo);

		send descargaRealizada[camion]();
	END

	process Timer [t=1 to N]
	BEGIN
		recive (arrancarTimer[t]());
		delay("2h");
		//falta enviar estado
	END

	process Estado [e=1 to N]
	BEGIN
		string estado="e";
		while(true)
		DO
			if(!EMPTY(terminoTimer[e]))
			THEN
				if(estado =="e")
				THEN
					estado ="TO";
					send esperar[e](estado);
				END
			[] (!EMPTY(calcularEstado[e]) && EMPTY(terminoTimer[e]))
			THEN
				recive(calcularEstado[e]);
				//listo para antender = lpa
				if(estado =="e")
				THEN
					estado ="lpa";
				END
				send empezarAatender(estado);
			END
		BEGIN
	END

	process Encargado [0]
	BEGIN
		while(true)
		DO
			int camion;
			receive llegoCamion(camion);
			send calcularEstado[camion]();
			string estado;
			recive (empezarAatender(estado))
			if(estado== "lpa")
			THEN
				send esperar[camion](estado);

				//falta esperar a ue termine la descarga por que sino vamos a activar muchos camiones 	
			END
		END
	END


END