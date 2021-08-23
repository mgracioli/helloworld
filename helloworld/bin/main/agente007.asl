/* agente007 Michel Gracioli */

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

/* Initial beliefs and rules */



/* Initial goals */
!start.


/* Plans */
+!start : true <- .send(sample_agent,tell,ola);	//envia a nova crença "ola" para sample_agent
				  .wait(1000);	//espera 1 segundo
				  .send(sample_agent,achieve,verificaTemperatura);	//solicita a execução de um plano (manda o agente verificar a temperatura)
				  .send(sample_agent,askOne,temperatura(T));
				  !createCounter.	//cria um artefato do tipo Counter

//busca o valor da crença "temperatura()" do sample_agent e cria uma crença "temperatura()" aqui em agente007 com o mesmo valor
+temperatura(T) <- .println("O sample_agent disse que a temperatura atual é de: ",T," graus").

+!createCounter <- makeArtifact("counter","tools.Counter",[0],ID);	//ID é uma propredade observável, [0] é o valor inicial pedido pelo construtor do Counter
				   focus(ID);	//faz com que o agente observe mudanças na propriedade observável ID do agente
				   inc.	//executa a operação "inc" definida no artefato
				   
				   
			   
// uncomment the include below to have an agent compliant with its organisation
//{ include("$moiseJar/asl/org-obedient.asl") }
