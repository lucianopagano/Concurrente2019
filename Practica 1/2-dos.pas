// Dado un numero N verifique cuantas veces aparece ese número en un arreglo de longitud
// M. Realice el algoritmo en forma concurrente utilizando <> y <await B; S>. Escriba las
// condiciones que considere necesarias.

int cantidad = 0;
arreglo array [1...M] of int;
int N;

PROGRAM DOS
BEGIN
	process Contar[c=0 to 3 ]
	var
		int cant = 0;
		int posInicial;
		int posFinal;
	BEGIN
		posInicial = calcularIndice();
		posFinal = calcularPosFinal;
		for ( int i = posInicial; i++; i <= posFinal )DO
			if(arreglo[i] == N) THEN
				cant ++;
			END
		END

		<cantidad += cant;>
	END
END