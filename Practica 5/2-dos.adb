--Se quiere modelar la cola de un banco que atiende un solo empleado,
--los clientes llegan y si esperan más de 10 minutos se retiran. CORREGIDO
TASK Type Persona is
	end Persona;
TASK Body Persona is
	select Banco.llegada();

	OR delay "10m"

	end select;
end Persona;


TASK Banco is
	llegada();
	end Banco;

TASK Body Banco is
	Loop
		accept llegada();
			--atender persona
		end llegada;
	end Loop;

end Banco;

var 
array Persona[1..N];
BEGIN
END 