/* sample_agent Michel Gracioli */

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

/* Initial beliefs and rules - crenças do agente */
chovendo. //o agente entende que está chovendo
nome(michel). //o nome é Michel
estaEm(michel,casa). //o agente entende que está em casa
carro("Citroen").
tem(michel,carro("Citroen")). //o agente tem um carro
localNascimento("Rio Claro"). //o local de nascimento do agente
estudaEm("Unesp").
temperatura(10).	//a temperatura é de 10 graus


/* Initial goals - Objetivos do agente*/
!start.	//start é o objetivo do agente, com isso, ele sabe que tem que executar o plano start


/* Plans - ações que o agente tem que fazer para atingir os objetivos*/
//as variáveis iniciam com letras maiúsculas (nesse caso, o valor da crença "nome" vai ser atribuido à variável X)
+!start : nome(X) & estaEm(X,Y)<- .print("Olá ",X,". Como está o tempo aí em ",Y,"?");
				  	 			  //-chovendo;	//remove a crença chovendo, o agente deixa de acreditar que está chovendo
				  	 			  //-+estaEm(michel, "Unesp");	//o agente passa a acreditar que está na unesp e, não mais, em casa
				 				  //+ensolarado;	//o agente entende que está ensolarado e, não mais, chovendo
								  !verificaTempo;	//executa o plano "verificaTempo", como eu mudei a crença do agente para ele acreditar que está ensolarado, ele vai imprimir a mensagem "Usar protetor solar"
								  !verificaTemperatura.
					 
+!verificaTempo : chovendo <- .println("Pegar guarda-chuva");
							  !vaDeCarro.
+!verificaTempo : ensolarado <- .println("Usar protetor solar").

+!verificaTemperatura : temperatura(Y) & Y < 15 <- .println("Temperatura baixa. É melhor levar um casaco").
+!verificaTemperatura : temperatura(Y) & Y > 30 <- .println("Temperatura alta. Dia quente").
-!verificaTemperatura : temperatura(Y) <- .println("Temperatura agradável").	//se nenhuma condição for atendida, executa essa linha

+!vaDeCarro : nome(X) & tem(X,carro(Y)) <- println(X,", é melhor você ir de carro").
-!vaDeCarro.	//caso o agente não tenha um carro, não faz nada

//faz o tratamento da crença "Ola" enviada pelo agente "agente007"
+ola[source(A)] <- .println("O agente ",A," disse oi");
				   .send(james,tellHow,"+!digaOla <- .println(\"O agente james está dizendo olá porque o sample_agent solicitou\").");	//envia o plano digaOla para o agente007
				   .send(james,achieve,digaOla).	//solicita a execução do plano digaOla
					

// uncomment the include below to have an agent compliant with its organisation
//{ include("$moiseJar/asl/org-obedient.asl") }





