TASK Type Auto
	end Auto;
TASK Body Auto is
	Puente.entrarAuto();
	--pasar por el puente
	Puente.pasoAuto();
	end Auto;

TASK Type Camioneta
	end Camioneta;
TASK Body Camioneta is
	Puente.entrarCamioneta();
	--pasar por el puente
	Puente.pasoCamioneta();
	end Camioneta;

TASK Type Camion
	end Camion;
TASK Body Camion is
	Puente.entrarCamion();
	--pasar por el puente
	Puente.pasoCamion();
	end Camion;

TASK Puente
	entrarAuto();
	entrarCamioneta();
	entrarCamion();
	pasoAuto();
	pasoCamioneta();
	pasoCamion();
	end Puente;

TASK Body Puente is
	int peso=0; 
	loop
		select
			when peso + 1 <= 5 
			=> accept entrarAuto
				peso++;
				end entrarAuto;
			or 
			when peso + 2 <= 5 
			=> accept entrarCamioneta
				peso+=2;
				end entrarCamioneta;
			or
			when peso + 3 <= 5
			=> accept entrarCamion
				peso+= 3;
				end	entrarCamion;
			or  
			=> accept pasoAuto
				peso--;
				end pasoAuto;
			or
			=> accept pasoCamioneta
				peso -=2;
				end pasoCamioneta;
			or
			=> accept pasoCamion
				peso -=3;
				end pasoCamion;
	end loop;
end Puente;