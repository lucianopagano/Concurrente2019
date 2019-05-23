PROGRAM CuatroB
BEGIN
	chan contador(int cantidad);
	chan habilitarPortero();
	chan aperturaPuerta();
	process Corredor[c=1 to C]
	BEGIN
		int cantidad=0;

		recive(contador(cantidad))

		if(cantidad < C)
		THEN
			cantidad++;
			send contador(cantidad);
			recive(barrera());
		ELSE
			send habilitarPortero();
			recive(aperturaPuerta());
			for(i=1 to C)
			DO
				send barrera();
			END
		END
		//arramcar carrera
	END

	process Portero
	BEGIN
		//envio 1 para que empiece el proceso de conteo
		send contador(1);
		recive(habilitarPortero());
		//buscar llaves
		send (aperturaPuerta());
	END

END