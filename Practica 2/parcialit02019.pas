// Hay N personas que deben usar UN cajero automático de acuerdo al orden de llegada.
// Solo pueden usar el cajero de una persona a la vez; el usuo de cajero por parte 
// de una persona se simula llamando a la funcion UsarCajero()

PROGRAM Parcialito
var
	sem sem_libre = 1;
	bool libre=false;

	sem[N] sem_turnos =(0);
	
	sem sem_cola=1;
	Queue cola;

	sem mutex_cajero= 1;
BEGIN
	process Persona [p=1 to N]
	var
		int siguiente;
	BEGIN
		p(mutex);
		if(libre) then
			libre = false;
			
		else
			p(sem_cola);
			cola.push(p);
			p(sem_turnos[p]);
		end
		v(mutex);

		p(mutex_cajero);
		UsarCajero();
		v(mutex_cajero);

		p(mutex);
		if(NOT EMPTY (cola))then
			siguiente = cola.pop();
			v(sem_turnos[siguiente]);
			v(sem_cola);
		else
			v(sem_cola);
			p(sem_libre)
			libre=true;
			v(sem_libre);
		end
		v(mutex)

	END
END