//Existen N pacientes que van al consultorio de UN médico el cual los atiende de acuerdo
//al orden de llegada. Cada paciente espera a que el médico le haga la receta con los
//medicamentos y luego se dirige a la Farmacia a comprarlos, espera a que lo terminen de
//atender y se retira. En la Farmacia hay UN empleado que atiende a la gente de acuerdo al
//orden de llegada.

PROGRAM TRECE
BEGIN
	process Persona [p=1 to N]
	BEGIN
		CoordinadorMediciPersonas!llegue(p);
		string receta;
		Medico?esperarReceta(receta);
		CoordinadorFarmaciaPersonas!enviarFarmacia(p,receta);
		string pedido;
		Farmaceutico?esperarPedido(pedido);
	END

	process CoordinadorMedicoPersonas[0]
	BEGIN
		//podria quitarse?
		queue personas;
		while(true)
		DO
			int persona;
			if(true); Persona[*]?llegue(persona)-> personas.pop(persona);

			[](NOT EMPTY(personas)); Medico?medicoLibre()->
									 int p = personas.pop();
									 Medico!AtenderPersona(p);
		END
	END

	process Medico[0]
	BEGIN
		while(true)
		DO
			CoordinadorMedicoPersonas!medicoLibre();
			int persona;
			CoordinadorMedicoPersonas?AtenderPersona(p);
			//atender persona
			//realizar receta
			Persona[p]!esperarReceta(receta) 
		END
	END

	process CoordinadorFarmaciaPersonas[0]
	BEGIN
		queue cola;

		string[] recetas;
		while (true)
		BEGIN
			string receta;
			int p;
			if(true); Persona[*]?enviarFarmacia(p,receta)-> 
								recetas[p] = receta;
								cola.pop(p);
			
			[](NOT EMPTY(cola)); Farmaceutico?farmaceuticoLibre()->
								 			  int persona = cola.pop();
								 			  string receta = recetas[persona];
								 			  Farmaceutico!armarPerdido(persona,receta);


		END
	END

	process Farmaceutico[0]
	BEGIN
		while (true)
		DO
			while(true)
			DO
				CoordinadorFarmaciaPersonas!farmaceuticoLibre();
 			  	int persona;
				string receta;
				CoordinadorFarmaciaPersonas?armarPerdido(persona,receta);
				string pedido = ArmarPedido(receta);
				Persona[persona]!esperarPedido(pedido);
			END
		END
	END
END