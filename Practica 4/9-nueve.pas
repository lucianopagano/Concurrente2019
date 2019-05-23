//En una estación de comunicaciones se cuenta con 10 radares y una unidad de
//procesamiento que se encarga de procesar la información enviada por los radares. Cada
//radar repetidamente detecta señales de radio durante 15 segundos y le envía esos datos a
//la unidad de procesamiento para que los analice. Los radares no deben esperar a ser
//atendidos para continuar trabajando.


//sentencia de entrada ?
// ""        "" salida !
PROGRAM NUEVE
BEGIN

	process Radar [r=1 to 10]
	BEGIN
		while(true)
		DO
			delay("15s");
			señal = detectarSeñal()
			Buffer!enviarSeñal(señal);
		END
	END

	process UnidadProcesamiento [1]
	BEGIN

		while(true)
		DO
			Buffer!enviarLibre();
			Buffer?darSeñal();
			ProcesarSeñal(señal);
		END

	END

	process Buffer[0]
	BEGIN
		queue señales;

		while(true)
		DO
			if(true); Radar[*]?enviarSeñal(señal)-> señales.push(señal);
			
			[] not Empty(señales);UnidadProcesamiento?enviarLibre?()->UnidadProcesamiento!darSeñal(señales.pop()) ;

		END

	END

END