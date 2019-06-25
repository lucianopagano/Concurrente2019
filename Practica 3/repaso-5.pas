// Suponga que N personas llegan a la cola de un banco. Una vez que la persona se agrega
// en la cola no espera más de 15 minutos para su atención, si pasado ese tiempo no fue
// atendida se retira. Para atender a las personas existen 2 empleados que van atendiendo
// de a una y por orden de llegada a las personas.

PROGRAM Banco
BEGIN

	process Pesona [p=1 to N]
	BEGIN
		Estado[p].llegoPersona();


	END

	process Timer[t=1 to N]
	BEGIN

	END

	Monitor Estado [e=1 to N]
	var
		string estado = "llegue"; 
	BEGIN

		procedure llegoPersona()
		BEGIN
			estado = "esperenado";
		END

	END
END