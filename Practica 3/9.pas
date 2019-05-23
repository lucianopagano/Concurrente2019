//Suponga una comisión con 50 alumnos. Cuando los alumnos llegan forman
//una fila, una vez que están los 50 en la fila el jefe de trabajos prácticos les
//entrega el número de grupo (número aleatorio del 1 al 25) de tal manera
//que dos alumnos tendrán el mismo número de grupo (suponga que el jefe
//posee una función DarNumero() que devuelve en forma aleatoria un número
//del 1 al 25, el jefe de trabajos prácticos no guarda el número que le asigna a
//cada alumno). Cuando un alumno ha recibido su número de grupo
//comienza a realizar la práctica. Al terminar de trabajar, el alumno le avisa
//al jefe de trabajos prácticos y espera la nota. El jefe de trabajos prácticos,
//cuando han llegado los dos alumnos de un grupo les devuelve a ambos la
//nota del GRUPO (el primer grupo en terminar tendrá como nota 25, el
//segundo 24, y así sucesivamente hasta el último que tendrá nota 1).


PROGRAM 9
BEGIN

	process Alumno [a = 1 to 50]
	BEGIN
		var
		int grupoAsignado;
		int nota;
		
		JTP.llegue(grupoAsignado);
		
		//realizar examen

		JTP.Corregir(grupoAsignado, nota);

		if(nota == 25)
			writeln('soy el mejor!!');
	END

	Monitor JTP
	BEGIN
		var
		cond colaAlumno;
		// no sabia que se podia hacer
		cond alumnosGrupos[25];
		int cantidadAlumnos=0;
		int[25] grupos = 0;
		int nota=25;
		int[25] notas;

		procedure llegue(var int grupoAsignado)
		BEGIN

			cantidadAlumnos ++;

			if(cantidadAlumnos < 50)
			THEN
				wait(colaAlumno);
			END
			ELSE
			THEN
				signalAll(colaAlumno);
			END
			grupoAsignado = DarNumero();
		END

		procedure Corregir(int grupo, var notaAlumno)
		BEGIN

			var
			grupos[grupo]++;
			if(grupos[grupo] < 2)
			THEN
				wait(alumnosGrupos[grupo]);
			END
			ELSE
				nota--;
				notas[grupo] = nota;
				signal(alumnosGrupos[grupo]);
			END

			notaAlumno = notas[grupo];
		END


	END
END