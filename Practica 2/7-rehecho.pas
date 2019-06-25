// Existe una casa de comida rápida que es atendida por 1 empleado.
// Cuando una persona llega se pone en la cola y espera a lo sumo
// 10 minutos a que el empleado lo atienda.
// Pasado ese tiempo se retira sin realizar la compra
PROGRAM CasaComida
begin
	var
		sem arrancarTimer[P] =(0);
		
		sem[P] sem_estados=1;
		string[P] estados;

		sem sem_cola=1;
		Queue cola;

		sem[P] esperar=0;

		sem sem_empleado = 0;

	process Persona [p=1 to P]
	begin
		p(sem_estados[p]);
		estados[p] = 'llegue';
		v(sem_estados[p]);
		p(sem_cola);
		cola.push(p);
		v(sem_cola);

		v(arrancarTimer[p]);
		v(sem_empleado);
		p(esperar[p]);

		p(sem_estados[t]);
		if(estados[t] = 'timeOut')then
			//irse a casa

		else
			//tomar pedido e irse
		end
		v(sem_estados[t]);

	end

	process Timer [t=1 to P]
	begin
		p(arrancarTimer[t]);
		delay "10m";

		p(sem_estados[t]);
		if(estados[t] == 'llegue') then
			estados[t] == 'timeOut';
			v(esperar[p])
		end
		v(sem_estados[t]);
	end

	process Empleado[0]
	var 
		int eId;
	begin
		while(true)do
			p(sem_empleado);
			p(sem_cola);
			eId := cola.pop();
			v(sem_cola);
			p(sem_estados[eId]);
			if(estados[eId] == 'llegue')then
				//atender
				estados[eId] = 'atendiendo';
				v(esperar[eId]);
			end
			v(sem_estados[eId]);

		end
	end
end