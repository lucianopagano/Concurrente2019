// Una empresa de 40 empleados que forman 4 equipos de trabajo
// (cada empleado conoce a priori el equipo al que pertence). La empresa
// tiene 4 combis para trasnladar cada equipo a la planta de trabajo
// que le corresponda .
// Cada empleado al llegar sube a la combi que le corresponde a su equipo,
// cuando las 4 combis estan completas cada una de ellas parte a la planta
// correspondiente. El transalado dura un tiempo aleatoreo entre 5 y 20 
// minutos. Al llegar a un sector cada empleado realiza su trabajo y luego
// se retira de la planta (cada empleado se retira independientemente del resto).
// Nota: por simplicidad los empleados no se deben esperar para retirarse.

PROGRAM Parcialito
begin

	process Empleados [e=1 to 40]
	var
		int combi;
	begin
		combi = CalcularCombi(e);
		CoordinadorCombiEmpleado[combi].llegue();
		//trabajar
		//retuirarse
	end

	Monitor CoordinadorCombiEmpleado[c= 1 to 4]
	var
		int cantEmpleados= 1;
		cond esperarEmpleado;
		cond esperarCombi;
	begin
		procedure llegue()
		begin
			if(cantEmpleados < 10)
			then
				cantEmpleados++;
				wait(esperarEmpleado);
			else
				signal(esperarCombi);
				wait(esperarEmpleado);
			end
		end

		procedure llegoCombi()
		begin
			if(cantEmpleados < 10)
			then
				wait(esperarCombi);
			end
		end

		procedure terminoViaje()
		begin
			signalAll(esperarEmpleado);
		end
	end

	Monitor CoordinadorCombis[0]
	var
		cond esperar;
		int cantCombis =1
	begin
		procedure CombiLista()
		begin
			if(cantCombis < 4)
			then
				cantCombis ++;
				wait(esperar);
			else
				signalAll(esperar);
			end
		end
	end

	process Combi [c=1 to 4]
	var
		int tiempo;
	begin
		CoordinadorCombiEmpleado[c].llegoCombi();
		CoordinadorCombis.CombiLista();
		tiempo = CalcularTiempoDeViaje();
		delay(tiempo);
		CoordinadorCombiEmpleado[c].terminoViaje();
	end

end