PROGRAM TRES
BEGIN

	chan[C] enviarPlatoACliente(string plato);
	char realizarPedido(string clienteId,string resumenPedido);

	chan vendedorLibre(idVendedor);
	chan[2] enviarPedidoAVendedor(int idCliente,string pedido);

	chan enviarPedidoACocineros(int clienteId, string pedidoConFormato)

	process Cliente [c=0 to C]
	BEGIN
		//con esta sentencia obtengo lo que el cliente quiere comer
		string pedido =self.obtenerPedido();
		send(realizarPedido(c));

		string plato;
		recive(enviarPlatoACliente[c](plato));

		//el cliente se va con el plato

	END

	process CoordinadorClienteVendedor[0]
	BEGIN

		while(true)
		DO

			int idVendedor;
			recive(vendedorLibre(idVendedor));

			if(EMPTY(realizarPedido))
			THEN
				//le mando al vendedor -1 cosa que quiere decir
				//que el puede estar libre
				//manda nulo por que no hay pedido
				send(enviarPedidoAVendedor[idVendedor](-1,null));

			ELSE
				int clienteId;
				string pedido;
				recive(realizarPedido(clienteId,pedido));
				send(enviarPedidoAVendedor[idVendedor](clienteId,pedido);

			END

		END

	END

	process Vendedor [v=1 to 3]
	BEGIN
		while(true)
		DO
			send(vendedorLibre(idVendedor));

			int cliente;
			string pedido;
			recive(enviarPedidoAVendedor[c](cliente,pedido))

			if(cliente == -1)
			THEN
				// repone pack
				delay("3m");
			ELSE
				//elabora el pedido con el formato necesario para el cocinero
				string pedidoConFormato = self.elaborarFormatoPedido(pedido);

			END

		END
	END


	process Cocinero [ c=1 to 2 ]
	BEGIN
		while(true)
		DO
			int clienteId;
			string pedidoConFormato;
			recive(enviarPedidoACocineros(clienteId,pedidoConFormato));

			//el cocinero prepara el plato
			string plato= self.elaborarPlato(pedidoConFormato);

			send enviarPlatoACliente[clienteId](plato);

		END

	END

END