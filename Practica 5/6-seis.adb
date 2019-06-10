-- Hay un sistema web para reservas de pasajes de micro donde existen N Clientes que
-- solicitan un pasaje para un cierto destino; espera hasta que el servidor le indique el
-- número de asiento reservado (-1 si no hubiese disponibles); y luego (si había asiento
-- disponible) el cliente imprime su pasaje. El servidor atiende los pedidos de acuerdo al
-- orden de llegada, cuando un cliente le solicita un pasaje a un cierto destino, busca un
-- asiento disponible para ese destino y luego le indica a ese cliente el asiento reservado (o
-- -1 si no hubiese ninguno disponible).

TASK TYPE Cliente IS
	END Cliente;
TASK BODY Cliente IS
	string destino = ObtenerDestino();
	int asiento;-- = obtenerAsiento();
	Servidor.solicitarPasaje(destino, out asiento);
	if(asiento != -1)THEN
		ImprimirPasaje();
	END
	END Cliente;

TASK Servidor IS
	ENTRY solicitarPasaje(string destino, out int asiento);
	END Servidor;

TASK BODY Servidor IS
	--este diccionario tiene en la clave el destino
	--y en el valor la cantidad de pasajes  disponibles
	Dictionary<string,int> destinos;
	LOOP
		accept solicitarPasaje(string destino, out int asiento) do
			if(destinos[destino].value > 0) THEN
				asiento = destinos[destino].value;
				destinos[destino].value --;
			else
				asiento = -1;
			END
		end solicitarPasaje;
	END LOOP;

	END Servidor;

var
	array of Cliente [1...N];  