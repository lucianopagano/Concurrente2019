//Resolver  con  SENTENCIAS  AWAIT  (<>  y  <await  B;  S>)
//el  problema  de  los  filósofos  evitando deadlock y demora innecesaria
program filosofos
var
	bool estaComiendo[5]=(false);
begin
	process Filosofo [f=1 to 5]
	begin
		while(true)do
		
			<await estaComiendo[f-1] == false && estaComiendo[(f+1)mod 5];
				estaComiendo[f-1] = true;
				estaComiendo[(f+1)mod 5] =true;>
			
			estaComiendo[(f+1)mod 5] = false;
			estaComiendo[(f-1)] = false;
		end
	end
end 