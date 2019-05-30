//En un laboratorio de genética veterinaria hay 3 empleados. El primero de ellos se encarga
//de preparar las muestras de ADN lo más rápido posible; el segundo toma cada muestra de
//ADN preparada y arma el set de análisis que se deben realizar con ella y espera el resultado
//para archivarlo y continuar trabajando; el tercer empleado se encarga de realizar el análisis
//y devolverle el resultado al segundo empleado. 

PROGRAM DOCE
BEGIN

	process Empleado1[0]
	BEGIN
		while(true)
		DO
			string muestra = PreparaMuestra();
			Coordinador!enviarMuestra(muestra);
		END
	END

	process Empleado2[0]
	BEGIN
		queue archivo;
		while(true)
		DO
			Coordinador!estoyLibre();
			string muestra;
			Coordinador?mandarAPreparar(muestra);
			string analisis = PrepararAnalisis(muestra);
			Empleado3!enviarAAnalisis(analisis);

			string resultados;
			Empleado3?esperarResultados(resultados);

			archivo.push(resultados);
		END
	END

	process Empleado3[0]
	BEGIN
		while(true)
		DO
			string analisis;

			Empleado2?enviarAAnalisis(analisis);

			string resultados = RealizarAnalisis(analisis);

			Empleado2!esperarResultados(resultados);
		END
	END

	process Coordinador[0]
	BEGIN
		queue muestras;

		while(true)
		DO
			string muestra;
			if(true); Empleado1?enviarMuestra(muestra)-> muestras.pop(muestra);

			[](!EMPTY(muestras))?Empleado2?estoyLibre()-> 
			Empleado2!mandarAPreparar(muestra);

		END
	END

END