--En una empresa hay 5 controladores de temperatura y una Central. Cada controlador
--toma la temperatura del ambiente cada 10 minutos y se la envía a una central para que
--analice el dato y le indique que hacer. Cuando la central recibe una temperatura que es
--mayor de 40 grados, detiene a ese controlador durante 1 hora.

TASK TYPE Controlador IS
END Controlador;

TASK BODY Controlador IS
	
VAR
	double temperatura;
	boolean detener = false;
BEGIN
	LOOP
		delay("10m");
		temperatura = CalcularTemperatura();
		Central.monitorearTemperatura(temperatura,detener);

		IF (detener) THEN
			delay("1h");
		END
	END LOOP;
END Controlador;

TASK Central IS
	Entry monitorearTemperatura(in double temperatura, out boolean detener)
END Central;

TASK BODY Central IS
VAR
	double temperatura;
	boolean detener = false;
BEGIN
	LOOP 
		ACCEPT monitorearTemperatura(in double temperatura,out boolean detener);
				detener = temperatura > 40.00;
		END monitorearTemperatura;
	END LOOP;
END Central;
var
array of Controlador [1...5];