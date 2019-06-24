// Se tiene un curso con 40 alumnos, la maestra entrega una tarea distinta a cada alumno,
// luego cada alumno realiza su tarea y se la entrega a la maestra para que la corrija, esta
// revisa la tarea y si está bien le avisa al alumno que puede irse, si la tarea está mal le indica
// los errores, el alumno corregirá esos errores y volverá a entregarle la tarea a la maestra
// para que realice la corrección nuevamente, esto se repite hasta que la tarea no tenga
// errores.

PROGRAM CUATRO
var
	bool [40] notas = (false);

	

	sem sem_profesora = 0;
	sem[40] esperarNota = (0);
	
	sem sem_cola= 1;
	Queue cola;
BEGIN

	process Alumno[a=1 to 40]
	var
		bool nota = false;
		string tarea;
	BEGIN
		while(nota == false)do
			tarea = RealizarTarea();
			p(sem_cola);
			cola.push(a,tarea);
			v(sem_profesora);
			p(esperarNota[a]);
			nota = notas[a];
		end
	END

	process Profesor[0]
	var
		string tarea;
		int aId;
		bool nota;
	BEGIN
		while(true)do
			p(sem_profesora);
			p(sem_cola);
			cola.pop(aId,tarea);
			nota = CorregirTarea(tarea); 
			notas[aId] = nota;
			v(esperarNota[aId]);
		end
	END

END