TASK Base IS
	empezarEscribir();
	terminarEscribir();
	empezarALeer();
	terminarDeLeer();
	END Base;
TASK Body Base IS
	int cant=0;

	SELECT datos > 0
	when cant == 0
		=> accept empezarEscribir()
			cant++;
			end empezarEscribir;
		or select terminarEscribir()
	 	cant--;
	 	end terminarEscribir;

	when cant == 0 => 
		accept empezarALeer && empezarEscribir'count == 0
			cant ++;
		end empezarALeer;
		
	or
		select terminarDeLeer()
			cant--;
		end terminarDeLeer;
		
	END Base;

TASK TYPE Tipo_Uno IS
	END Tipo_Uno;

TASK Body Tipo_Uno IS
	LOOP
		Boolean esperar5=true;
		SELECT Base.empezarEscribir();
			--empezar a escribir
			Base.terminarEscribir();
			esperar5 =false;
		OR DELAY 2
			DELAY 5;
		END SELECT;
		

	END LOOP
END Tipo_Uno;


TASK TYPE Tipo_Dos IS
	END Tipo_Dos;

TASK Body Tipo_Dos IS
	END Tipo_Dos;

TASK TYPE Tipo_Tres IS
	END Tipo_Tres;

TASK Body Tipo_Tres IS
	END Tipo_Tres;

var
	array of Tipo_Uno[1...A];
	array of Tipo_Dos[1...B];
	array of Tipo_Uno[1...C];