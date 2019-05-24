//sentencia de entrada ?
// ""        "" salida !
PROGRAM DIEZ
BEGIN
	process Empleado [e=1 to 3]
	BEGIN
		while (true)
		DO
			int cliente;
			Buffer?enviarCliente(cliente);
			Cliente[cliente]!esperar();
		END
	END

	process Buffer[0]
	BEGIN
		var
		Queue colaCliente;
		while(true)
		DO
			int e;
			if(true); Cliente[*]?llegue(c)-> cola.push(c);
			[] not Empty(colaCliente); Empleado[*]?listo(e)-> Empleado[e]!enviarCliente(colaCliente.pop);
		END
	END

	process Cliente [c=1 to C]
	BEGIN
		Buffer!llegue(c);

		Empleado[*]esperar?();	
	END
END