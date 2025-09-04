﻿601,100
602,"zCTI.Template.Carga.Arquivo.Para.Cubo.Mapa"
562,"CHARACTERDELIMITED"
586,"C:\TM1_Models\CTI\ArquivosCarga\Mapa_Conta.csv"
585,"C:\TM1_Models\CTI\ArquivosCarga\Mapa_Conta.csv"
564,
565,"kc4DxvHrk_aa<rA[a2TFkh\_K6OWBbB56B002E]NS1hQubl`j^Tf[W3EUOGTz^9TO7?gbGC1MbLQTEvFXPeVa;ZHwSBTop7mdy`[Pri3<kt6eqCKfvsUK;=:z8C304\fr6GH9cIwR9Lldu5n`x0h=xWr:3fw[?j9ndD1A3TB5q7fKW:Q@PHl<lC7OxmTKC>3lGj7nMov"
559,1
928,0
593,
594,
595,
597,
598,
596,
800,
801,
566,0
567,";"
588,","
589,"."
568,""""
570,
571,
569,1
592,0
599,1000
560,0
561,0
590,0
637,0
577,6
vElement
vDesc_Element
vCod_N1
vDesc_N1
vCod_N2
vDesc_N2
578,6
2
2
2
2
2
2
579,6
1
2
3
4
5
6
580,6
0
0
0
0
0
0
581,6
0
0
0
0
0
0
582,6
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
603,0
572,246

#****Begin: Generated Statements***
#****End: Generated Statements****


# ===============================================================================================================
#GENERALCOMMENT             Descrição:          	Carrega dados CSV para o Cubo Mapa MAP.020.Conta_Contabil
#GENERALCOMMENT             Responsável:   	Rodrigo Mendonça
#GENERALCOMMENT             Data Criação:    	Fevereiro/2019
#
#LASTCHANGE                 Alterações:
#LASTCHANGE                 Responsavel Alterações:
# ===============================================================================================================

# ===============================================================================================================
#PROLOGCOMMENT               Descrição:            Define arquivo fonte 
# ===============================================================================================================

# =================================================================================
# 									Glosário 
# =================================================================================
# Prefixos de Variáveis 
#
# v - Variáveis de entrada		- relacionado a origem de dados do turbo
# p - Parâmetros de entrada		- relacionado ao input realizado pelo usuário no momento de disparo do processo
# c - Constantes			- variáveis que receberão um valor fixo (Não serão alteradas durante o processo)
# n - Numerica
# s - String (Texto)
#
# Variáveis que deverão ser alteradas
# cCuboDestino			- Armazena o nome do cubo de destino
#
#
# Variáveis configuradas no cubo de controle 
# cCaminhoArquivoFonte 		- Busca o caminho de origem do processo no cubo de controle
# cCaminhoArquivoRejeitado 		- Busca o caminho de rejeitado do processo no cubo de controle
# cPrefixoArquivoFonte 		- Busca o prefixo do arquivo de origem do processo no cubo de controle
# cUtilizarDebug		 	- Busca no cubo de controle se ao executar o processo, será utilizado o modo Debug (Grava em arquivo texto o que seria gravado no cubo)
# cGravarLogAlteracao		- Busca no cubo de controle se ao executar o processo, serão gravados as alterações no cubo de destino
#
#
# Variáveis que não precisam ser alteradas
# cCuboParametro 			- Armazena o nome do cubo de parâmetro utilizado
# cCuboPropriedade		- Armazena o nome do cubo de sistema onde estão as principais propriedades dos cubos
# cExisteCabecalhoRejeitado		- Variável que irá controlar o cabeçalho do arquivo de rejeitado sejá criado uma única vez
# cExisteRegistroRejeitado 		- Variável que irá controlar se o registro possuí algum erro de integridade ou validação dos dados
# cHorarioInicio			- Armazena o horário de inicio do processo
# cMensagemRegistro		- Armazena a mensagem de erro/log do registro
# cMensagemProcesso		- Armazena a mensagem de erro do processo
# cProcesso			- Armazena o nome do processo
# cQtdRegistroRejeitado		- Contador de registros rejeitados
# cTipoErro			- Controla o tipo de erro (Erro 1 - Prologo / Erro 2 - Dados)
# cUsuario			- Armazena o nome do usuário ou chore que executou o processo

# =================================================================================
# Variáveis do padrão CTI que devem ser alteradas
# =================================================================================


# Informações do cubo de Destino
# ========================================
cCuboDestino		= 'MAP.020.Conta_Contabil';



# =================================================================================
# Variáveis do padrão CTI não devem ser alteradas
# =================================================================================

# Recupera o usuário que executou o processo
# ========================================
cUsuario = IF( DimIx( '}Clients' , TM1User() ) = 0, 'Executed by Chore' , ATTRS('}Clients', TM1User(), '}TM1_DefaultDisplayValue') );
  

  
# Variáveis de controle do processo
# ========================================
cCuboParametro			= 'SYS.150.Controle_Cargas';
cCuboPropriedade			= '}CubeProperties';
cHorarioInicio			= Now();
cProcesso			= GetProcessName();
cMensagemRegistro	 	= '';
cMensagemProcesso 		= '';
cExisteRegistroRejeitado 		= 0;
cExisteCabecalhoRejeitado 		= 0;
cQtdRegistroRejeitado		= 0;
cTipoErro				= 0;
cContadorRegistro 			= 0;



# Variáveis do cubo de controle
# ========================================
cCaminhoArquivoFonte 		= CellGetS( cCuboParametro , cProcesso , 'Caminho do Arquivo Fonte' );
cCaminhoArquivoRejeitado  		= CellGetS( cCuboParametro , cProcesso , 'Caminho do Arquivo de Rejeitado' );
cPrefixoArquivoFonte 		= CellGetS( cCuboParametro , cProcesso , 'Prefixo do Arquivo' );
cUtilizarDebug		 	= CellGetS( cCuboParametro , cProcesso , 'Debug (S/N)' );
cGravarLogAlteracao		= CellGetS( cCuboParametro , cProcesso , 'Gerar Log de Alteração (S/N)' );



# Tratamento para os campos vindos do cubo de controle que recebem (S/N)
# ========================================
cUtilizarDebug		 	= IF( cUtilizarDebug @= 'S' , 'S' , 'N' );
cGravarLogAlteracao		= IF( cGravarLogAlteracao @= 'S' , 'S' , 'N' );




# =================================================================================
# Define variáveis locais de arquivo
# =================================================================================
cDelimitadorArquivo 		= ';';
cSeparadorMilhar			= '.';
cSeparadorDecimal			= ',';

DataSourceASCIIDelimiter 		= cDelimitadorArquivo;
DataSourceASCIIThousandSeparator 	= cSeparadorMilhar;
DataSourceASCIIDecimalSeparator 	= cSeparadorDecimal;
DataSourceQuoteCharacter 		= '';


# =================================================================================
# Define o Log inicial da carga como falha
# Registra esse log logo no inicio para garantir que tenha algum log de falha registrado
# Caso o processo não consiga chegar no próximo registro de log por alguma falha inesperada
# =================================================================================
cMensagemProcesso	= 'Processo com falha, contate o administrador para verificar os logs de erro do sistema' ;
s01			= TimSt( cHorarioInicio , '\Y-\m-\d \hh\im\ss' );
s02 			= cUsuario ;
s03 			= cMensagemProcesso ;
s04 			= '0' ;
s05 			= TimSt( cHorarioInicio - Now, '\Y-\m-\d \hh\im\ss' );

CellPutS( s01 , cCuboParametro, cProcesso, 'DataHora Inicio' );
CellPutS( s01 , cCuboParametro, cProcesso, 'DataHora Fim' );
CellPutS( s02 , cCuboParametro, cProcesso, 'Usuário' );
CellPutS( s03 , cCuboParametro, cProcesso, 'Mensagem de Log' );
CellPutS( s04 , cCuboParametro, cProcesso, 'Registros Processados' );
CellPutS( s05 , cCuboParametro, cProcesso, 'Tempo de Execução' );




# =================================================================================
# Validação do arquivo de origem e pasta
# Teste 1 - Se o caminho do arquivo fonte foi preenchido no cubo de controle
# Teste 2 - Se o caminho do arquivo rejeitado foi preenchido no cubo de controle
# Teste 3 - Se o diretório do arquivo fonte existir
# Teste 4 - Se o diretório do arquivo de rejeitado/debug existir
# Teste 5 - Se o arquivo fonte existe na pasta informada
# =================================================================================


# Define o nome dos arquivos
# ======================================================
sPrefixo			= cPrefixoArquivoFonte;
cSufixoRejeitado		= IF( cUtilizarDebug @= 'S' , 'Debug' , 'Reject' );

cNomeArquivoFonte	=  sPrefixo  | '.csv';
cNomeArquivoRejeitado	=  sPrefixo  | '_' | cSufixoRejeitado | '.csv';



# Aborta o processo se o caminho do arquivo fonte não foi informado
# ======================================================
IF( cCaminhoArquivoFonte @= '' );
   cTipoErro = 1;
   cMensagemProcesso = 'O caminho onde esta o arquivo fonte não foi informado, informe no cubo:   "' | cCuboParametro | '"' ;
   DataSourceType = 'NULL';
   ItemReject( cMensagemProcesso );
ENDIF;



# Aborta o processo se o caminho do arquivo reject não foi informado
# ======================================================
IF( cCaminhoArquivoRejeitado  @= '' );
   cTipoErro = 1;
   cMensagemProcesso = 'O caminho onde deverá ser salvo o arquivo com registros rejeitados não foi informado, informe no cubo:   "' | cCuboParametro | '"' ;
   DataSourceType = 'NULL';
   ItemReject( cMensagemProcesso );
ENDIF;



# Insere o caractere "\" no final do caminho caso ainda não tenha
# ======================================================
cCaminhoArquivoFonte 	= IF( SUBST( cCaminhoArquivoFonte , LONG( cCaminhoArquivoFonte ) , 1 ) @<> '\' , cCaminhoArquivoFonte | '\' , cCaminhoArquivoFonte ); 
cCaminhoArquivoRejeitado  	= IF( SUBST( cCaminhoArquivoRejeitado  , LONG( cCaminhoArquivoRejeitado  ) , 1 ) @<> '\' , cCaminhoArquivoRejeitado  | '\' , cCaminhoArquivoRejeitado  );



# Aborta o processo se o diretorio do arquivo fonte não existir
# ======================================================
IF( FileExists( cCaminhoArquivoFonte ) = 0 );
   cTipoErro = 1;
   cMensagemProcesso = 'O diretório especificado para o arquivo fonte  "' | cCaminhoArquivoFonte | '"   não existe, informe no cubo:   "' | cCuboParametro | '"' ;
   DataSourceType = 'NULL';
   ItemReject( cMensagemProcesso );
ENDIF;



# Aborta o processo se o diretorio dos arquivos rejeitados não existir
# ======================================================
IF( FileExists( cCaminhoArquivoRejeitado) = 0 );
   cTipoErro = 1;
   cMensagemProcesso = 'O diretório especificado para o arquivo com registros rejeitados  "' | cCaminhoArquivoRejeitado | '"   não existe, informe no cubo:   "' | cCuboParametro | '"' ;
   DataSourceType = 'NULL';
   ItemReject( cMensagemProcesso );
ENDIF;



# Monta o caminho completo 
# ======================================================
cNomeArquivoFonteCompleto 	= cCaminhoArquivoFonte | cNomeArquivoFonte;
cNomeArquivoRejeitadoCompleto	= cCaminhoArquivoRejeitado | cNomeArquivoRejeitado;



# Aborta o processo se o arquivo fonte não existir na pasta de origem
# ======================================================
IF( FileExists( cNomeArquivoFonteCompleto ) = 0 );
   cTipoErro = 1;
   cMensagemProcesso = 'O arquivo   "' | cNomeArquivoFonte | '"   não existe no diretorio:   "' | cCaminhoArquivoFonte | '"' ;
   DataSourceType = 'NULL';
   ItemReject( cMensagemProcesso );
ENDIF;



# Apaga o arquivo de reject caso exista
# ======================================================
IF( FileExists( cNomeArquivoRejeitadoCompleto ) = 1 );
   ASCIIDelete( cNomeArquivoRejeitadoCompleto );
ENDIF;



# Define o arquivo fonte como a nova fonte de dados deste processo
# ======================================================
DatasourceNameForServer		= cNomeArquivoFonteCompleto ;
DatasourceNameForClient		= cNomeArquivoFonteCompleto ;



# =================================================================================
# Limpa dados do cubo de destino
# =================================================================================
CubeClearData ( cCuboDestino );

573,19

#****Begin: Generated Statements***
#****End: Generated Statements****


# ===============================================================================================================
#METADATACOMMENT        Descrição:  Adiciona elementos na dimensão principal do cubo mapa
# ===============================================================================================================


# =================================================================================
# Atualiza dimensão do Mapa
# =================================================================================
sElm = vElement;
sDim = 'MAP.D.020.Conta_Contabil';

If( sElm @<> '' & DimIx( sDim, sElm ) = 0 );
    DimensionElementInsert( sDim, '', sElm,  'n' );
EndIf;
574,111

#****Begin: Generated Statements***
#****End: Generated Statements****


# ===============================================================================================================
#DATACOMMENT        Descrição:  Grava dados no cubo acumulando valores.
# ===============================================================================================================

# ===================================================================================
# Gera contador para o arquivo de debug ou registros rejeitados o e quantid. total de registros processados
# ===================================================================================
cContadorRegistro = cContadorRegistro + 1;
sContadorRegistro = NumberToString( cContadorRegistro );


# ===================================================================================
# Retira os espaços em branco
# ===================================================================================
vElement		= Trim( vElement );
vDesc_Element	= Trim( vDesc_Element );
vCod_N1		= Trim( vCod_N1 );
vDesc_N1	= Trim( vDesc_N1 );
vCod_N2		= Trim( vCod_N2 );
vDesc_N2	= Trim( vDesc_N2 );



# ===================================================================================
# Pula o Registro se todas as colunas estiverem vazias
# ===================================================================================
IF( '' @= vElement	 
  & '' @= vDesc_Element 
  & '' @= vCod_N1 
  & '' @= vDesc_N1
  & '' @= vCod_N2 
  & '' @= vDesc_N2
  );
  ItemSkip;
EndIf;



# ===================================================================================
# Marca o registro para rejeitar 
# Verifica se o registro está duplicado no arquivo
# ===================================================================================
If( cExisteRegistroRejeitado = 0 );
  sDuplic = CellGetS( cCuboDestino, vElement, 'Data Atualização' );
   If ( sDuplic @<> '' );
      cExisteRegistroRejeitado = 1;
      cMensagemRegistro = 'Registro duplicado no arquivo fonte.';
   EndIf;
EndIf;



# ===================================================================================
# DEBUG ou REJEIÇÃO
# Registra em arquivo os registros
# ===================================================================================
If( cExisteRegistroRejeitado = 1  %  cUtilizarDebug @= 'S' );


  # Escreve o cabeçalho do arquivo de registros rejeitados
  # =================================================================================
  If( cExisteCabecalhoRejeitado = 0);
    AsciiOutput( cNomeArquivoRejeitadoCompleto , 'Cod. Conta' , 'Desc. Conta' , 'Cod. N1' , 'Desc. N1' , 'Cod N2' , 'Desc. N2' , 'Num. Registro' , 'Mensagem de Erro');
    cExisteCabecalhoRejeitado = 1;
    cTipoErro = 2;
    If( cUtilizarDebug @= 'S'  );
      cMensagemProcesso = ' Processo concluido com registros salvos no arquivo de Debug, verificar o arquivo:    ' | cNomeArquivoRejeitadoCompleto;
    EndIf;
  EndIf;


  # Escreve o registro no arquivo de debug ou rejeitados
  # =================================================================================
  AsciiOutput( cNomeArquivoRejeitadoCompleto , vElement , vDesc_Element , vCod_N1 , vDesc_N1 , vCod_N2 , vDesc_N2 , sContadorRegistro , cMensagemRegistro );


  # Limpa as variaveis e pula o registro
  # ============================
  IF( cExisteRegistroRejeitado = 1 );
     cExisteRegistroRejeitado = 0;
     cMensagemRegistro = '';
     cMensagemProcesso = ' Processo concluido com registros rejeitados, verificar o arquivo:    ' | cNomeArquivoRejeitadoCompleto;
     ItemSkip;
  EndIf;

EndIf;



# ===================================================================================
# Grava os dados no cubo
# ===================================================================================
s01 = vDesc_Element;
s02 = vCod_N1;
s03 = vDesc_N1;
s04 = vCod_N2;
s05 = vDesc_N2;

CellPutS ( s01, cCuboDestino, vElement, 'Descrição' );
CellPutS ( s02, cCuboDestino, vElement, 'Cód Nível 1' );
CellPutS ( s03, cCuboDestino, vElement, 'Desc Nível 1' );
CellPutS ( s04, cCuboDestino, vElement, 'Cód Nível 2' );
CellPutS ( s05, cCuboDestino, vElement, 'Desc Nível 2' );

CellPutS ( TimSt( cHorarioInicio , '\Y-\m-\d \hh\im\ss' ), cCuboDestino, vElement, 'Data Atualização' );

575,41

#****Begin: Generated Statements***
#****End: Generated Statements****


# ===============================================================================================================
#EPILOGCOMMENT        Descrição:  Habilita log do cubo de destino, realiza CubeSaveData e registra log de status do processo.
# ===============================================================================================================

# =================================================================================
# Habilita o Log e salva dados no cubo
# =================================================================================
CellPutS ( 'YES', cCuboPropriedade, cCuboDestino, 'LOGGING' );
CubeSaveData ( cCuboDestino );


# =================================================================================
# Registra o Log de Erro ou Sucesso no Cubo de Controle
# =================================================================================
If( cTipoErro = 0 );
   cMensagemProcesso  = ' Processo concluído com sucesso';
EndIf;


s01	= TimSt( Now , '\Y-\m-\d \hh\im\ss' );
s02 	= cUsuario ;
s03 	= cMensagemProcesso ;
s04 	= sContadorRegistro  ;
s05 	= TimSt( Now - cHorarioInicio, ' \h:\i:\s') ;

CellPutS( s01 , cCuboParametro, cProcesso, 'DataHora Fim' );
CellPutS( s02 , cCuboParametro, cProcesso, 'Usuário' );
CellPutS( s03 , cCuboParametro, cProcesso, 'Mensagem de Log' );
CellPutS( s04 , cCuboParametro, cProcesso, 'Registros Processados' );
CellPutS( s05 , cCuboParametro, cProcesso, 'Tempo de Execução' );


If( cTipoErro = 2 );
  ItemReject( cMensagemProcesso );
EndIf;

576,CubeAction=1511DataAction=1503CubeLogChanges=0
930,0
638,1
804,0
1217,0
900,
901,
902,
938,0
937,
936,
935,
934,
932,0
933,0
903,
906,
929,
907,
908,
904,0
905,0
909,0
911,
912,
913,
914,
915,
916,
917,0
918,1
919,0
920,50000
921,""
922,""
923,0
924,""
925,""
926,""
927,""
