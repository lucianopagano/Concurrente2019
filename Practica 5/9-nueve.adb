TASK TYPE Persona IS 
END Persona;

TASK BODY Persona IS
	id int;

	accept reciboId(in int n_id) do
		id = n_id;
	end accept

	LOOP 
		Empresa.reclamo(id)
	END
END Persona;

TASK Empresa IS
	ENTRY reclamo(in int id);
	ENTRY estoyLibre(out int id);
END Empresa;

TASK BODY Empresa IS
	var
		reclamos array of int [1..P] = (0);
	begin
	
	LOOP
		select 
			accept reclamo(in int id):
				reclamos[id] ++;
			end reclamo;
			OR
			--la funcion HayReclamos retorna si hay
			--alguna persona tiene un reclamo
			when HayReclamos(reclamos)
				accept estoyLibre(out int id);
					--obtiene el id que mas reclamos tiene
					int maxId = ObtenerIdConMasReclamos(reclamos);
					reclamos[maxId] = 0;
					id =maxId;
				end estoyLibre; 

		end select;


	END LOOP;

END Empresa;


TASK TYPE Camion IS
END Camion;

TASK BODY Camion IS
	var 
	int id;	
	LOOP
		 Empresa.estoyLibre(out int id);
		 --atiendo el reclamo de la persona 
		 atenderReclamoDe(id);
	END
END Camion;

var
 personas array of Persona[1...P];

begin
	for i : 1.. n
		personas[i].reciboId(i);
end;