eEn un entrenamiento de fútbol hay 20 jugadores que forman 4 equipos 
(cada jugador conoce el equipo al cual pertenece llamando a la función DarEquipo()). 
Cuando un equipo está listo (han llegado los 5 jugadores que lo componen),
debe enfrentarse a otro equipo que también esté listo 
(los dos primeros equipos en juntarse juegan en la cancha 1, y los otros dos equipos juegan en la cancha 2).
Una vez que el equipo conoce la cancha en la que juega,sus jugadores se dirigen a ella.
Cuando los 10 jugadores del partido llegaron a la cancha comienza el partido, juegan durante 50 minutos,
y al terminar todos los jugadores del partido se retiran (no es necesario que se esperen para salir).


PROGRAM 8
BEGIN

	Monitor Equipo[p=1 to 4]
	BEGIN

		int cantidadJugares=1
		cond cola;
		// es como un recurso compartido
		// que utilizan todos los procesos
		// pero solo lo modifica el ultimo 
		//y es el valor que le va a dar a todos los otros proceos
		int cancha;
		procedure llegue(var int canchaAsignada)
		BEGIN
			cantidadJugares  ++;
			if(cantidadJugares == 5) THEN
				//
				AsignarEquipos.obtenerCancha(cancha);
				signalAll(cola);
			END
			ELSE
				wait(cola);	

			canchaAsignada= cancha;
			
		END;

	END;

	Monitor AsignarEquipos
	BEGIN
		int cantidadJugadores= 0;
		procedure obtenerCancha(var int cancha)
		BEGIN
			cantidadJugadores ++:
			if(cantidadJugadores <=10)
				cancha = 1;
			ELSE
				cancha = 2;
		END
	END;

	Monitor Partido [p= 1 to 2]
	BEGIN
		int cantidadJugadores= 0;
		cond cola;
		procedure jugarPartido()
		BEGIN
			cantidadJugadores++;
			if(cantidadJugadores < 10)
			THEN
				wait(cola);
			END
			ELSE
			BEGIN
				delay("50m");
				signalAll(cola);
			END
			
		END
	END;

	Process jugador [j=1 to 20]
	BEGIN
		//obtengo el equipo del jugador
		int equipo = DarEquipo();
		int cancha;
		Equipo[equipo].llegue(cancha);
		Partido[cancha].jugarPartido();
	END;

END;
