﻿601,100
602,"zCTI.Template.Carga.Cubo.Mapa.Para.Dimensao.Desbalanceada"
562,"SUBSET"
586,"MAP.D.020.Conta_Contabil"
585,"MAP.D.020.Conta_Contabil"
564,
565,"biaHS[V;bdykb0V;3NyjwbBZpw]^T_]BTKJ:tKZ>0bqJ[gYM[tVadV_M=3ZdI?2ou]wtOsnBMOv0n\aj2sEpSo=E@FClIxKK4\@A<S0b:zpuYMGwd41ufi@xr7zI@712I@I2]agwWAkTy2;]4ZhJr`HbhxlBvIBQMSXCHPz4>cJDBF?k5FGm2=B3wR[Vs@2Qa_xCmnpA"
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
570,zViewAll
571,All
569,1
592,0
599,1000
560,0
561,0
590,0
637,0
577,1
vElement
578,1
2
579,1
1
580,1
0
581,1
0
582,1
VarType=32ColType=827
603,0
572,130

#****Begin: Generated Statements***
#****End: Generated Statements****


# ===============================================================================================================
#GENERALCOMMENT             Descrição:          	Atualiza dimensão ACO.D.Conta_Contabil
#GENERALCOMMENT             Responsável:   	Rodrigo Mendonça
#GENERALCOMMENT             Data Criação:    	Fevereito/2020
#
#LASTCHANGE                 Alterações:
#LASTCHANGE                 Responsavel Alterações:
# ===============================================================================================================

# ===============================================================================================================
#PROLOGCOMMENT               Descrição:            		Atualiza dimensão de hierarquia desbalanceada ACO.D.Conta_Contabil através 
#PROLOGCOMMENT               	            		do mapa MAP.020.Conta_Contabil.
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
# cDimensao			- Armazena o nome da dimensão
# cCuboMapa			- Armazena o nome do cubo de origem
# cTotalizador			- Armazena o nome do totalizador da dimensão
#
#
# Variáveis que não precisam ser alteradas
# cCuboParametro 			- Armazena o nome do cubo de parâmetro utilizado
# cHorarioInicio			- Armazena o horário de inicio do processo
# cMensagemRegistro		- Armazena a mensagem de erro/log do registro
# cMensagemProcesso		- Armazena a mensagem de erro do processo
# cProcesso			- Armazena o nome do processo
# cUsuario			- Armazena o nome do usuário ou chore que executou o processo

# =================================================================================
# Variáveis do padrão CTI que devem ser alteradas
# =================================================================================


# Informações da dimensão e cubo mapa
# ========================================
cDimensao		= 'ACO.D.Conta_Contabil';
cCuboMapa		= 'MAP.020.Conta_Contabil';

cTotalizador		= 'Total Contas Contábeis';


# =================================================================================
# Variáveis do padrão CTI não devem ser alteradas
# =================================================================================

# Recupera o usuário que executou o processo
# ========================================
cUsuario = IF( DimIx( '}Clients' , TM1User() ) = 0, 'Executed by Chore' , ATTRS('}Clients', TM1User(), '}TM1_DefaultDisplayValue') );
  

  
# Variáveis de controle do processo
# ========================================
cCuboParametro			= 'SYS.150.Controle_Cargas';
cHorarioInicio			= Now();
cProcesso			= GetProcessName();
cMensagemProcesso 		= '';
cContadorRegistro 			= 0;



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
# Limpa todos consolidadores da dimensão
# =================================================================================
#** Busca a Qtde de Elementos na dimensão
      vElemento = DimSiz(cDimensao);
      vCount = vElemento;
#** Checa todos os elementos da dimensão e recria somente elementos dos níveis maiores
      WHILE(vCount <> 0);
      vElementoN = DimNm(cDimensao, vCount);
                             IF(DTYPE(cDimensao, vElementoN) @= 'C');
                                 DimensionElementDelete(cDimensao, vElementoN);
                             ENDIF;
      vCount = vCount - 1;
      END;



# =================================================================================
# Insere Totalizador na Dimensão 
# =================================================================================
DimensionElementInsert ( cDimensao, '', cTotalizador, 'C' );




# =================================================================================
# Define a Ordem da Dimensão 
# =================================================================================
DimensionSortOrder ( cDimensao, 'ByName', 'Ascending', 'ByHierarchy' , 'Ascending' );



573,232

#****Begin: Generated Statements***
#****End: Generated Statements****


# ===============================================================================================================
#METADATACOMMENT        Descrição:  Atualiza estrutura da dimensão desbalanceada considerando os niveis existentes no cubo mapa.
# ===============================================================================================================



# =================================================================================
# Busca Variáveis do Cubo Mapa
# =================================================================================
sNivel1 	= CellGetS ( cCuboMapa, vElement, 'Cód Nível 1' );
sNivel2 	= CellGetS ( cCuboMapa, vElement, 'Cód Nível 2' );
sNivel3 	= '';
sNivel4 	= '';
sNivel5 	= '';
sNivel6 	= '';
sNivel7 	= '';
sNivel8 	= '';
sNivel9 	= '';
sNivel10 	= '';




# =================================================================================
# Atualiza hierarquia da dimensão 
# =================================================================================

sElm = vElement;
sDim = cDimensao;
sTot = cTotalizador;


# Nivel Total
# ==========================
If ( sNivel1 @<> '' );
    DimensionElementComponentAdd ( sDim, sTot, sNivel1, 1 );
ElseIf ( sNivel2 @<> '' );
    DimensionElementComponentAdd ( sDim, sTot, sNivel2, 1 );
ElseIf ( sNivel3 @<> ''  );
    DimensionElementComponentAdd ( sDim, sTot, sNivel3, 1 );
ElseIf ( sNivel4 @<> ''  );
    DimensionElementComponentAdd ( sDim, sTot, sNivel4, 1 );
ElseIf ( sNivel5 @<> ''  );
    DimensionElementComponentAdd ( sDim, sTot, sNivel5, 1 );
ElseIf ( sNivel6 @<> ''  );
    DimensionElementComponentAdd ( sDim, sTot, sNivel6, 1 );
ElseIf ( sNivel7 @<> ''  );
    DimensionElementComponentAdd ( sDim, sTot, sNivel7, 1 );
ElseIf ( sNivel8 @<> ''  );
    DimensionElementComponentAdd ( sDim, sTot, sNivel8, 1 );
ElseIf ( sNivel9 @<> ''  );
    DimensionElementComponentAdd ( sDim, sTot, sNivel9, 1 );
ElseIf ( sNivel10 @<> ''  );
    DimensionElementComponentAdd ( sDim, sTot, sNivel10, 1 );
Else;
    DimensionElementComponentAdd ( sDim, sTot, sElm, 1 );
EndIf;



# Nivel 1
# ==========================
If ( sNivel2 @<> '' & sNivel1 @<> ''  );
    DimensionElementComponentAdd ( sDim, sNivel1, sNivel2, 1 );
ElseIf ( sNivel3 @<> '' & sNivel1 @<> ''  );
    DimensionElementComponentAdd ( sDim, sNivel1, sNivel3, 1 );
ElseIf ( sNivel4 @<> ''  & sNivel1 @<> ''  );
    DimensionElementComponentAdd ( sDim, sNivel1, sNivel4, 1 );
ElseIf ( sNivel5 @<> ''  & sNivel1 @<> ''  );
    DimensionElementComponentAdd ( sDim, sNivel1, sNivel5, 1 );
ElseIf ( sNivel6 @<> ''  & sNivel1 @<> ''  );
    DimensionElementComponentAdd ( sDim, sNivel1, sNivel6, 1 );
ElseIf ( sNivel7 @<> ''  & sNivel1 @<> ''  );
    DimensionElementComponentAdd ( sDim, sNivel1, sNivel7, 1 );
ElseIf ( sNivel8 @<> ''  & sNivel1 @<> ''  );
    DimensionElementComponentAdd ( sDim, sNivel1, sNivel8, 1 );
ElseIf ( sNivel9 @<> ''  & sNivel1 @<> ''  );
    DimensionElementComponentAdd ( sDim, sNivel1, sNivel9, 1 );
ElseIf ( sNivel10 @<> ''  & sNivel1 @<> ''  );
    DimensionElementComponentAdd ( sDim, sNivel1, sNivel10, 1 );
ElseIf ( sNivel1 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel1, sElm, 1 );
EndIf;



# Nivel 2
# ==========================
If ( sNivel3 @<> '' & sNivel2 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel2, sNivel3, 1 );
ElseIf ( sNivel4 @<> '' & sNivel2 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel2, sNivel4, 1 );
ElseIf ( sNivel5 @<> '' & sNivel2 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel2, sNivel5, 1 );
ElseIf ( sNivel6 @<> '' & sNivel2 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel2, sNivel6, 1 );
ElseIf ( sNivel7 @<> '' & sNivel2 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel2, sNivel7, 1 );
ElseIf ( sNivel8 @<> '' & sNivel2 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel2, sNivel8, 1 );
ElseIf ( sNivel9 @<> '' & sNivel2 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel2, sNivel9, 1 );
ElseIf ( sNivel10 @<> '' & sNivel2 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel2, sNivel10, 1 );
ElseIf ( sNivel2 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel2, sElm, 1 );
EndIf;



# Nivel 3
# ==========================
If ( sNivel4 @<> '' & sNivel3 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel3, sNivel4, 1 );
ElseIf ( sNivel5 @<> '' & sNivel3 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel3, sNivel5, 1 );
ElseIf ( sNivel6 @<> '' & sNivel3 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel3, sNivel6, 1 );
ElseIf ( sNivel7 @<> '' & sNivel3 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel3, sNivel7, 1 );
ElseIf ( sNivel8 @<> '' & sNivel3 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel3, sNivel8, 1 );
ElseIf ( sNivel9 @<> '' & sNivel3 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel3, sNivel9, 1 );
ElseIf ( sNivel10 @<> '' & sNivel3 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel3, sNivel10, 1 );
ElseIf ( sNivel3 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel3, sElm, 1 );
EndIf;



# Nivel 4
# ==========================
If ( sNivel5 @<> '' & sNivel4 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel4, sNivel5, 1 );
ElseIf ( sNivel6 @<> '' & sNivel4 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel4, sNivel6, 1 );
ElseIf ( sNivel7 @<> '' & sNivel4 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel4, sNivel7, 1 );
ElseIf ( sNivel8 @<> '' & sNivel4 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel4, sNivel8, 1 );
ElseIf ( sNivel9 @<> '' & sNivel4 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel4, sNivel9, 1 );
ElseIf ( sNivel10 @<> '' & sNivel4 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel4, sNivel10, 1 );
ElseIf ( sNivel4 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel4, sElm, 1 );
EndIf;



# Nivel 5
# ==========================
If ( sNivel6 @<> '' & sNivel5 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel5, sNivel6, 1 );
ElseIf ( sNivel7 @<> '' & sNivel5 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel5, sNivel7, 1 );
ElseIf ( sNivel8 @<> '' & sNivel5 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel5, sNivel8, 1 );
ElseIf ( sNivel9 @<> '' & sNivel5 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel5, sNivel9, 1 );
ElseIf ( sNivel10 @<> '' & sNivel5 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel5, sNivel10, 1 );
ElseIf ( sNivel5 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel5, sElm, 1 );
EndIf;



# Nivel 6
# ==========================
If ( sNivel7 @<> '' & sNivel6 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel6, sNivel7, 1 );
ElseIf ( sNivel8 @<> '' & sNivel6 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel6, sNivel8, 1 );
ElseIf ( sNivel9 @<> '' & sNivel6 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel6, sNivel9, 1 );
ElseIf ( sNivel10 @<> '' & sNivel6 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel6, sNivel10, 1 );
ElseIf ( sNivel6 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel6, sElm, 1 );
EndIf;



# Nivel 7
# ==========================
If ( sNivel8 @<> '' & sNivel7 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel7, sNivel8, 1 );
ElseIf ( sNivel9 @<> '' & sNivel7 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel7, sNivel9, 1 );
ElseIf ( sNivel10 @<> '' & sNivel7 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel7, sNivel10, 1 );
ElseIf ( sNivel7 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel7, sElm, 1 );
EndIf;



# Nivel 8
# ==========================
If ( sNivel9 @<> '' & sNivel8 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel8, sNivel9, 1 );
ElseIf ( sNivel10 @<> '' & sNivel8 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel8, sNivel10, 1 );
ElseIf ( sNivel8 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel8, sElm, 1 );
EndIf;



# Nivel 9
# ==========================
If ( sNivel10 @<> '' & sNivel9 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel9, sNivel10, 1 );
ElseIf ( sNivel9 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel9, sElm, 1 );
EndIf;



# Nivel 10
# ==========================
If ( sNivel10 @<> '' );
    DimensionElementComponentAdd ( sDim, sNivel10, sElm, 1 );
EndIf;
574,201

#****Begin: Generated Statements***
#****End: Generated Statements****


# ===============================================================================================================
#DATACOMMENT        Descrição:  Atualiza alias e atributos da dimensão.
# ===============================================================================================================



# ===================================================================================
# Gera contador para quantidade total de registros processados
# ===================================================================================
cContadorRegistro = cContadorRegistro + 1;
sContadorRegistro = NumberToString( cContadorRegistro );


# =================================================================================
# Busca Variáveis do Cubo Mapa
# =================================================================================

# Busca código dos elementos
#==========================================
sNivel1 		= CellGetS ( cCuboMapa, vElement, 'Cód Nível 1' );
sNivel2 		= CellGetS ( cCuboMapa, vElement, 'Cód Nível 2' );
sNivel3 		= '';
sNivel4 		= '';
sNivel5 		= '';
sNivel6 		= '';
sNivel7 		= '';
sNivel8 		= '';
sNivel9 		= '';
sNivel10 		= '';


# Busca descrição dos elementos
#==========================================
sDescElement	= CellGetS ( cCuboMapa, vElement, 'Descrição' );
sDescNivel1 	= CellGetS ( cCuboMapa, vElement, 'Desc Nível 1' );
sDescNivel2 	= CellGetS ( cCuboMapa, vElement, 'Desc Nível 2' );
sDescNivel3 	= '';
sDescNivel4 	= '';
sDescNivel5 	= '';
sDescNivel6 	= '';
sDescNivel7 	= '';
sDescNivel8 	= '';
sDescNivel9 	= '';
sDescNivel10 	= '';



# =================================================================================
# Adiciona Atributos 
# =================================================================================
sDim = cDimensao;
AttrPutS( sNivel1, sDim, vElement, 'Nível 1' );
AttrPutS( sNivel2, sDim, vElement, 'Nível 2' );



# =================================================================================
# Adiciona Alias com codigo e descrição
# =================================================================================

# Adiciona Alias Cod+Desc
#==========================================
sAlias       = 'Código e Descrição';


#Element
#===========
sCod   = vElement;
sDesc = sDescElement;

If  (  sCod @<>'' & sDesc @<> '' );
    AttrPutS( sCod | ' - ' | sDesc, cDimensao, sCod, sAlias );
EndIf;



#Nivel 1
#===========
sCod   = sNivel1;
sDesc = sDescNivel1;

If  (  sCod @<>'' & sDesc @<> '' );
    AttrPutS( sCod | ' - ' | sDesc, cDimensao, sCod, sAlias );
EndIf;




#Nivel 2
#===========
sCod   = sNivel2;
sDesc = sDescNivel2;

If  (  sCod @<>'' & sDesc @<> '' );
    AttrPutS( sCod | ' - ' | sDesc, cDimensao, sCod, sAlias );
EndIf;




#Nivel 3
#===========
sCod   = sNivel3;
sDesc = sDescNivel3;

If  (  sCod @<>'' & sDesc @<> '' );
    AttrPutS( sCod | ' - ' | sDesc, cDimensao, sCod, sAlias );
EndIf;




#Nivel 4
#===========
sCod   = sNivel4;
sDesc = sDescNivel4;

If  (  sCod @<>'' & sDesc @<> '' );
    AttrPutS( sCod | ' - ' | sDesc, cDimensao, sCod, sAlias );
EndIf;




#Nivel 5
#===========
sCod   = sNivel5;
sDesc = sDescNivel5;

If  (  sCod @<>'' & sDesc @<> '' );
    AttrPutS( sCod | ' - ' | sDesc, cDimensao, sCod, sAlias );
EndIf;




#Nivel 6
#===========
sCod   = sNivel6;
sDesc = sDescNivel6;

If  (  sCod @<>'' & sDesc @<> '' );
    AttrPutS( sCod | ' - ' | sDesc, cDimensao, sCod, sAlias );
EndIf;




#Nivel 7
#===========
sCod   = sNivel7;
sDesc = sDescNivel7;

If  (  sCod @<>'' & sDesc @<> '' );
    AttrPutS( sCod | ' - ' | sDesc, cDimensao, sCod, sAlias );
EndIf;




#Nivel 8
#===========
sCod   = sNivel8;
sDesc = sDescNivel8;

If  (  sCod @<>'' & sDesc @<> '' );
    AttrPutS( sCod | ' - ' | sDesc, cDimensao, sCod, sAlias );
EndIf;




#Nivel 9
#===========
sCod   = sNivel9;
sDesc = sDescNivel9;

If  (  sCod @<>'' & sDesc @<> '' );
    AttrPutS( sCod | ' - ' | sDesc, cDimensao, sCod, sAlias );
EndIf;




#Nivel 10
#===========
sCod   = sNivel10;
sDesc = sDescNivel10;

If  (  sCod @<>'' & sDesc @<> '' );
    AttrPutS( sCod | ' - ' | sDesc, cDimensao, sCod, sAlias );
EndIf;




575,41

#****Begin: Generated Statements***
#****End: Generated Statements****


# ===============================================================================================================
#EPILOGCOMMENT        Descrição:  Habilita log do cubo de destino, realiza CubeSaveData e registra log de status do processo.
# ===============================================================================================================



# =================================================================================
# Registra o Log de Erro ou Sucesso no Cubo de Controle
# =================================================================================
cMensagemProcesso  = ' Processo concluído com sucesso';


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



# =================================================================================
# Executa processo que consolida elementos orfaos
# =================================================================================
ExecuteProcess
  ( 'zCTI.Dim.Hierarchy.Consolidate.Orphans'
  , 'pDim'			, cDimensao
  , 'pTotalizador'		, 'Total Histórico'
  , 'pTotalizadorFilho'	, ''
   );

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
