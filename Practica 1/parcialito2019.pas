Program Parcialito
var
	int cantidad = 0;
	Queue buffer;
	int tam= N;

BEGIN
	process Productor()
	BEGIN
		while(true)do
			elemento = generarElemento();
			<await (cantidad < tam);
			buffer.push(elemento);
			cantidad ++;>
		end
	END

	process Consumidor()
	var 
		object elemento;
	BEGIN
		
		while(true)do
			
			<await (cantidad > 0);
			elemento = buffer.pop();
			cantidad--;
			>

		end


		
	END
END