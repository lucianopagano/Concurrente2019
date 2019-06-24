PROGRAM Panaderia
begin

	process Empleado1[0]
	begin
		
		while(true)do
			string muestra = prepararMuestra();	
			Coordinador!enviarMuestra(muestra);
		end

	end

	process Empleado2[0]
	begin
		while(true)do 
			Coordinador!estoyLibreE2()
			Coordinador?esperarMuestra(string muestra);
			string setA= ArmarSet(muestra);
			Empleado3!enviarset(setA);
			Empleado3?evniarResultado(string resultado);
			Archivar(resultado);
		end

	end

	process Empleado3[0]
	begin
		while(true)do 
			Empleado2?enviarset(string a);
			resultado = ObtenerResultados(a);
			Empleado2!evniarResultado(resultado);
		end
	end

	process Coordinador[0]
	begin
		queue cola;
		
		while(true)do
			if(true) Empleado1?enviarMuestra(string muestra)->
				cola.push(muestra);
			[]IS NOT EMPTY(cola) Empleado2?estoyLibreE2()->
					Empleado2!esperarMuestra(cola.pop());
		end
	end


end