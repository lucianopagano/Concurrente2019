-- En una clínica existe un médico de guardia que recibe continuamente peticiones de
-- atención de las E enfermeras que trabajan en su piso y de las P personas que llegan a la
-- clínica ser atendidos.
-- Cuando una persona necesita que la atiendan espera a lo sumo 5 minutos a que el
-- médico lo haga, si pasado ese tiempo no lo hace, espera 10 minutos y vuelve a requerir
-- la atención del médico. Si no es atendida tres veces, se enoja y se retira de la clínica.
-- Cuando una enfermera requiere la atención del médico, si este no lo atiende
-- inmediatamente le hace una nota y se la deja en el consultorio para que esta resuelva su
-- pedido en el momento que pueda (el pedido puede ser que el médico le firme algún 
-- papel). Cuando la petición ha sido recibida por el médico o la nota ha sido dejada en el
-- escritorio, continúa trabajando y haciendo más peticiones.
-- El médico atiende los pedidos dándoles prioridad a los pacientes que llegan para ser
-- atendidos. Cuando atiende un pedido, recibe la solicitud y la procesa durante un cierto
-- tiempo. Cuando está libre aprovecha a procesar las notas dejadas por las enfermeras

TASK Medico IS
	atenderPaciente();
	atenderEnfermera();

	END Medico;
TASK BODY Medico is 
	END Medico;

TASK ColaNotas IS
		enfermeraNota(in string nota);
		tomarNotaMedico(out string nota);
	END ColaNotas;

TASK BODY ColaNotas IS
	Queue cola;
	string nota;
	LOOP
		SELECT enfermeraNota(nota)
			cola.push(nota);
		OR
			when (not empty (cola))
			=> accept (tomarNotaMedico(nota))
					nota = cola.pop();
		--preguntar
	END LOOP;

	END ColaNotas;

TASK Type Enfermera IS

	LOOP
		SELECT	
			Medico.atenderEnfermera();
		ELSE
			string nota = CrearNota();
			ColaNotas.enfermeraNota(nota);
	END LOOP;		

	END Enfermera;

TASK BODY Enfermera IS

	LOOP
		SELECT Medico.atenderEnfermera();
		ELSE Medico.DejarNota();

	END Enfermera;

TASK Type Persona IS
	END Persona;
TASK BODY Persona IS
	int intentos = 0;
	bool antendio = false;
	while(antendio == false && intentos < 3) DO
		
		SELECT Medico.atenderPaciente()
			antendio = true;
		OR DELAY "5M"
			DELAY "10M"
			--que pasa cuando vuelve a solicitar la atención debo 
			--volver a realizar la entryCall?
			intentos++;	
		END atenderPaciente;
	END
END Persona;

var
	array of Enfermera [1...E];
	array of Persona [1...P];
BEGIN

END
