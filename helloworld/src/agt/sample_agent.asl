/* sample_agent Michel Gracioli */

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

/* Initial beliefs and rules - cren�as do agente */
chovendo. //o agente entende que est� chovendo
nome(michel). //o nome � Michel
estaEm(michel,casa). //o agente entende que est� em casa
carro("Citroen").
tem(michel,carro("Citroen")). //o agente tem um carro
localNascimento("Rio Claro"). //o local de nascimento do agente
estudaEm("Unesp").
temperatura(10).	//a temperatura � de 10 graus


/* Initial goals - Objetivos do agente*/
!start.	//start � o objetivo do agente, com isso, ele sabe que tem que executar o plano start


/* Plans - a��es que o agente tem que fazer para atingir os objetivos*/
//as vari�veis iniciam com letras mai�sculas (nesse caso, o valor da cren�a "nome" vai ser atribuido � vari�vel X)
+!start : nome(X) & estaEm(X,Y)<- .print("Ol� ",X,". Como est� o tempo a� em ",Y,"?");
				  	 			  //-chovendo;	//remove a cren�a chovendo, o agente deixa de acreditar que est� chovendo
				  	 			  //-+estaEm(michel, "Unesp");	//o agente passa a acreditar que est� na unesp e, n�o mais, em casa
				 				  //+ensolarado;	//o agente entende que est� ensolarado e, n�o mais, chovendo
								  !verificaTempo;	//executa o plano "verificaTempo", como eu mudei a cren�a do agente para ele acreditar que est� ensolarado, ele vai imprimir a mensagem "Usar protetor solar"
								  !verificaTemperatura.
					 
+!verificaTempo : chovendo <- .println("Pegar guarda-chuva");
							  !vaDeCarro.
+!verificaTempo : ensolarado <- .println("Usar protetor solar").

+!verificaTemperatura : temperatura(Y) & Y < 15 <- .println("Temperatura baixa. � melhor levar um casaco").
+!verificaTemperatura : temperatura(Y) & Y > 30 <- .println("Temperatura alta. Dia quente").
-!verificaTemperatura : temperatura(Y) <- .println("Temperatura agrad�vel").	//se nenhuma condi��o for atendida, executa essa linha

+!vaDeCarro : nome(X) & tem(X,carro(Y)) <- println(X,", � melhor voc� ir de carro").
-!vaDeCarro.	//caso o agente n�o tenha um carro, n�o faz nada

//faz o tratamento da cren�a "Ola" enviada pelo agente "agente007"
+ola[source(A)] <- .println("O agente ",A," disse oi");
				   .send(james,tellHow,"+!digaOla <- .println(\"O agente james est� dizendo ol� porque o sample_agent solicitou\").");	//envia o plano digaOla para o agente007
				   .send(james,achieve,digaOla).	//solicita a execu��o do plano digaOla
					

// uncomment the include below to have an agent compliant with its organisation
//{ include("$moiseJar/asl/org-obedient.asl") }





