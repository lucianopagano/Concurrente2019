//Resolver la administración de las impresoras de una oficina. Hay 3 impresoras, N usuarios
//y 1 director. Los usuarios y el director están continuamente trabajando y cada tanto envían
//documentos a imprimir. Cada impresora, cuando está libre, toma un documento y lo
//imprime, de acuerdo al orden de llegada, pero siempre dando prioridad a los pedidos del
//director. Nota: los usuarios y el director no deben esperar a que se imprima el documento.



//este escript se debe hacer con un administrador que contenga
//dos queues y luego envia a las impresoras que continuamente envian que estan libres


PROGRAM Ocho
BEGIN

	chan enviarUsuario(int usuario);
	chan enviarDirector(int director);
	chan impresoraLibre(int impresora);
	chan enviarAImprimir();
	
	process Usuario [u=1 to N]
	BEGIN
		while(true)
		DO
			//realizar trabajo
			send enviarUsuario(u);
		END
	END

	process Director()
	BEGIN
		while(true)
		DO
			//realizar trabajo
			send enviarUsuario(1);
		END
	END


	process Coordinador()
	BEGIN
		queue colaUsuario;
		queue colaDirector;
		while(true)
		DO
			if(!EMPTY(enviarDirector))
			THEN
				int director;
				recive(enviarDirector(director));
				colaDirector.push(director);
			
			[](!EMPTY(enviarUsuario) && EMPTY(enviarDirector))
			THEN
				int usuario;
				recive(enviarUsuario(usuario));
				colaDirector.push(director);
			END


			int impresora;
			if(!EMPTY(colaDirector))
			THEN
				recive(impresoraLibre(impresora));

			END

			IF(!EMPTY(colaUsuario) && EMPTY(colaDirector))
			THEN
				recive(impresoraLibre(impresora));

			END
		END
	END

	process Impresora[i=1 to 3]
	BEGIN

		while(true)
		DO
			send impresoraLibre(i);
			recive ( )
		END

	END
END