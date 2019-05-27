//Suponga que existe un antivirus distribuido en él hay R procesos robots que
//continuamente están buscando posibles sitios web infectados; cada vez que encuentran
//uno avisan la dirección y continúan buscando. Hay un proceso analizador que se encargue
//de hacer todas las pruebas necesarias con cada uno de los sitios encontrados por los robots
//para determinar si están o no infectados. 

PROGRAM CATORCE
BEGIN

	process Robot[r=1 to R]
	BEGIN
		while(true)
		DO
			string pagina = AnalizarPagina();

		END
	END

	//se puede hacer sin un buffer?
	process Analizador
	DO
		while(true)
		DO
			if(true); 
		END
		
	END

END