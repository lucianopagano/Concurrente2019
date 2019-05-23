PROGRAM CUATROA
BEGIN
	chan enviarLlegada();
	chan habilitarPortero();

	chan habilitarPista();

	char enviarLlegadaAlPortero();

	process Corredores[c=0 to C]
	BEGIN
		send (enviarLlegada());
		recive(habilitarPista());
	END

	process CoordinadorCorredoresPortero[0]
	BEGIN
		int cantCorredores=0;
		while(cantCorredores != C)
		DO
			recive(enviarLlegada());
			send(enviarLlegadaAlPortero())
			cantCorredores++;
		END
		send(habilitarPortero());

	END

	process Portero [0]
	BEGIN
		recive(habilitarPortero());
		
		while(EMPTY(enviarLlegadaAlPortero))
		DO
			recive(enviarLlegadaAlPortero());
			send(habilitarPista())
		END
	END

END


PROGRAM CUATROB
BEGIN

	chan habilitarPortero;

	chan barrera();

	process Corredor[c=1 to C]
	BEGIN
		//c=1 e el primero en llegar?
		if(c == 1)
		THEN 
			// C-1 por que no debo contarme a mi
			for(i=1, i <= C -1)
			DO
				recive(barrera());
			END
			send(habilitarPortero());
		ELSE
			send (barrera());
		END
		recive(habilitarPista());
	END

	process Portero [0]
	BEGIN
		recive(habilitarPortero());
		
		while(EMPTY(enviarLlegadaAlPortero))
		DO
			recive(enviarLlegadaAlPortero());
			send(habilitarPista())
		END
	END



END