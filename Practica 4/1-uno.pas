//Se desea modelar el funcionamiento de un banco en el cual existen 5 cajas para realizar
//pagos. Existen P personas que desean pagar. Para esto cada una selecciona la caja donde
//hay menos personas esperando, una vez seleccionada espera a ser atendido.

PROGRAM UNO
BEGIN
	chan pedirCaja(int p);
	chan[N] obtenerCaja(var int cajaId);
	chan[5] pagarEnCaja(decimal monto);
	chan decrementarCaja(int cajaId);

	Process Caja [c=1 to 5]
	BEGIN
		decimal recaudado=0;
		while (true)
		DO
			recive(pagarEnCaja[c]);
			recaudado += monto;
		END
	END

	Process Persona[p = 1 to N]
	BEGIN
		var 
		send(pedirCaja);
		int caja;
		recive (obtenerCaja[p](caja));
		decimal monto = self.ObtenerMont();
		send(pagarEnCaja[caja](monto))
	END


	Process Administrador [0]
	BEGIN
		int [5] Cajas;
		while(true)
		DO
			if(NOT EMPTY(pedirCaja))
			THEN
				recive(pedirCaja(p));
				
				int min = 999999;
				int pos=0;
				cajaMinima=0;
				for(int c in Cajas)
				DO
					if(c < min)
					THEN
						cajaMinima =pos;
					END
					pos++;
				END
				Cajas[cajaMinima]++;

				// como calcular cola?
				int caja;
				send obtenerCaja[p](cajaMinima)
			END
			[](NOT EMPTY(decrementarCaja)
			THEN
				var int cajaADecrementar;
				recive(decrementarCaja(cajaADecrementar));
				Cajas[cajaMinima]--;
			END
		END

	END

END