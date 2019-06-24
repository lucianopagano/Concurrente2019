PROGRAM repaso
var
	chan estoyLibre(int porteroId);
	chan enviarReclamo(int personaId, string reclamo);
	chan[1..3] darReclamo(int personaId,string reclamo);
begin 

	process Portero [p=1 to 3]
	begin
		int personaId; string reclamo;
		while(true) do
			send estoyLibre(p);
			recive(darReclamo[p](personaId, reclamo));
			if(personaId == -1)then
				
				delay("10m");
			else
				Atender(reclamo);

			end

		end

	end

	process Coordinardor[0]
	var
		int personaId; string reclamo; int porteroId;
	begin


		while (true) do
			recive(estoyLibre(porteroId));
			if(EMPTY(enviarReclamo)) then
				send darReclamo[porteroId](-1,null);
			else
				recive(enviarReclamo(personaId,reclamo));
				send darReclamo[porteroId](personaId,reclamo)
			end
		end;
	end

	process Persona [per=1 to P]
	var
		string reclamo;
	begin
		reclamo = GenerarReclamo();

		send enviarReclamo(per, reclamo);
	end

end