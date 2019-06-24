// Hay N personas que deben usar UN cajero automático de acuerdo al orden de llegada.
// Solo pueden usar el cajero de una persona a la vez; el usuo de cajero por parte 
// de una persona se simula llamando a la funcion UsarCajero()


Program Parcialito
var 
	sem sem_cola;
	queue cola;

	int cantidad = 0;
	sem sem_cantidad;

	sem[N] sem_personas;
	sem sem_usarCajero;
BEGIN

	process Persona [p= 1 to N]
	var
		int pId;
	BEGIN

		p(sem_cantidad);
		cantidad++;
		if(cantidad > 1) then 
			
			p(sem_cola);
				cola.push(p);
			v(sem_cola);
			v(sem_cantidad);
			p(sem_personas[p]);
		
		else
			v(sem_cantidad);
		end


		p(sem_usarCajero);
			UsarCajero();
		v(sem_usarCajero);

		p(sem_cola);
		if(NOT EMPTY(cola)) then
			pId = cola.pop();
			v(sem_personas[p]);

			v(sem_cola);
		else

			p(sem_cantidad);
			cantidad --;
			v(sem_cantidad);

			v(sem_cola);
		end
	END

END