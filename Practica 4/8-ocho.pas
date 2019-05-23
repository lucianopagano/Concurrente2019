//Resolver la administración de las impresoras de una oficina. Hay 3 impresoras, N usuarios
//y 1 director. Los usuarios y el director están continuamente trabajando y cada tanto envían
//documentos a imprimir. Cada impresora, cuando está libre, toma un documento y lo
//imprime, de acuerdo al orden de llegada, pero siempre dando prioridad a los pedidos del
//director. Nota: los usuarios y el director no deben esperar a que se imprima el documento.

PROGRAM Ocho
BEGIN

	chan enviarUsuario();
	chan enviarDirector();
	process Usuario [u=1 to N]
	BEGIN
		while(true)
		DO
			//realizar trabajo
			send enviarUsuario();
		END
	END

	process Director()
	BEGIN
		while(true)
		DO
			//realizar trabajo
			send enviarUsuario();
		END
	END

	process Impresora[i=1 to 3]
	BEGIN

		while(true)
		DO
			if(!EMPTY(enviarDirector))
			THEN
				recive(enviarDirector())
				delay("1m");
			
			[](!EMPTY(enviarUsuario) && EMPTY(enviarDirector))
			THEN
				recive(enviarUsuario());
				delay("1m");
			END
		END

	END
END