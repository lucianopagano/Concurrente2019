En una casa viven una abuela y sus N nietos. 
Además la abuela compró caramelos que quiere convidar entre sus nietos.
Inicialmente la abuela deposita en una fuente X caramelos, luego cada nieto intenta comer caramelos de la siguiente manera: 
si la fuente tiene caramelos el nieto agarra uno de ellos, en el caso de que la fuente esté vacía entonces
se le avisa a la abuela quien repone nuevamente X caramelos.
Luego se debe permitir que el nieto que no pudo comer sea el primero en hacerlo,
es decir, el primer nieto que puede comer nuevamente es el primero que encontró la fuente vacía. 
NOTA: siempre existen caramelos para reponer.
Cada nieto tarda t minutos en comer un caramelo (t no es igual para cada nieto). Puede haber varios nietos comiendo al mismo tiempo.


PROGRAM SIETE
BEGIN

	Monitor Fuente
	BEGIN
		var
		int cantidadCaramelos= 0;
		cond colaAbuela;
		cond colaNieto;
		cond colaNietoEsperando;
		bool primero=true;

		procedure obtenerCaramelo()
		BEGIN
			bool ok = false;

			while(ok == false)
			DO
				if(cantidadCaramelos > 0)
				THEN
					cantidadCaramelos --;
					ok= true;
				END
				ELSE IF(primero)
				THEN
					primero = false;
					wait(colaNieto);

					ok= true;
					cantidadCaramelos --;
					singalAll(colaNietoEsperando);
				END;
				ELSE
				THEN
					// no soy el primero
					wait(colaNietoEsperando);
				END;

			END;
		END;

		procedure reponer(int x)
		BEGIN

			//si la cantidad de caramelos
			//es disntinto de 0
			//espero a que un nieto pida que la abuela reponga
			if(cantidadCaramelos != 0)
			BEGIN
				wait(colaAbuela);
			END

			signal(colaNieto);
			//re pongo caramelos
			cantidadCaramelos = x;

		END;

	END;

	Process Abuela[1]
	BEGIN
		while(true)
		BEGIN
			Fuente.reponer();
		END;

	END;

	Process Nieto [n=1 to N]
	BEGIN

		while (true)
		BEGIN
			Fuente.obtenerCaramelo();
			//comer caramelo

		END;

	END;

END;