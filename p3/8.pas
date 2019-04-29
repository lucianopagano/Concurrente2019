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
		procedure llegue()
		BEGIN
			if(cantidadJugares == 5) THEN
				//signalAll(cola);
			END
			cantidadJugares  ++;
		END;

	END;

	Monitor AsignarEquipos
	BEGIN
		int cantidadEquipos= 0;
		procedure ObtenerCancha(var int cancha)
		BEGIN

			if(cantidadEquipos <=2)
				cancha = 1
			ELSE
				cancha = 2
		END

		procedure llegoEquipo()
		BEGIN
			signal(esperarEquipo);
		END
	END;

	Process jugador [j=1 to 20]
	BEGIN
		//obtengo el equipo del jugador
		int equipo = DarEquipo();

		Equipo[equipo].llegue();
	END;

END;
