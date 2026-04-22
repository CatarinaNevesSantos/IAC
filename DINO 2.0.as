TERM_READ       EQU     FFFFH
TERM_WRITE      EQU     FFFEH
TERM_STATUS     EQU     FFFDH
TERM_CURSOR     EQU     FFFCH
TERM_COLOR      EQU     FFFBH
MASK            EQU     FFFAH
TIMER_STATUS    EQU     FFF7H
TIMER_VALUE     EQU     FFF6H
DISP3           EQU     FFF3H
DISP2           EQU     FFF2H
DISP1           EQU     FFF1H
DISP0           EQU     FFF0H
DISP5           EQU     FFEFH
DISP4           EQU     FFEEH
; CONSTANTES DE INTERAÇÃO COM OS EXTERNOS.

DIM_TERR        EQU     80
; TAMANHO DO TERRENO DE JOGO, SERÁ 80 POIS É O NÚMERO DE COLUNAS NO TERMINAL
; MAS PODERIA SER ALTERADO SE QUISESSEMOS.

CACTO_MAX       EQU     8
; ALTURA MÁXIMA DOS CATOS NO TERRENO,  (LIVREMENTE ALTERÁVEL, MAS DEVE SER UMA 
; POTÊNCIA DE 2, COMO DESCRITO NO ENUNCIADO DA 1ª PARTE DO PROJETO).

SEED_INICIAL    EQU     F9A5H
; PRIMEIRO VALOR ATRIBUÍDO À SEED QUE DEFINE A SEQUÊNCIA DE CACTOS QUE APARECE
; NO TERRENO DE JOGO  (LIVREMENTE ALTERÁVEL).

NIVEL_CHAO      EQU     20
; LINHA EM QUE VAMOS ESCREVER O CHÃO DO TERRENO (LIVREMENTE ALTERÁVEL).

POS_DINO        EQU     8
; COLUNA (FIXA) EM QUE O DINO ESTÁ NO DECORRER DO JOGO (LIVREMENTE ALTERÁVEL).

SALTO_MAX       EQU     10
; ALTURA MÁXIMA QUE O DINO ALCANÇA QUANDO SALTA (LIVREMENTE ALTERÁVEL).

DINO_MAX        EQU     6
; TAMANHO MÁXIMO DO DINO  (LIVREMENTE ALTERÁVEL, MAS DEVEMOS TER O CUIDADO DE
; GARANTIR QUE QUANDO O DINO SALTA, NÃO "METE A CABEÇA FORA DO ECRÃ", OU SEJA,
; DINO_MAX <= NIVEL_CHAO - SALTO_MAX).

TIMER_SPEED     EQU     3
; VELOCIDADE DE ATUALIZAÇÃO DO TERRENO, EM DEC. SEGUNDO (LIVREMENTE ALTERÁVEL).

CHAO            EQU     '-'
; CARACTÉR USADO PARA ESCREVER O CHÃO (LIVREMENTE ALTERÁVEL).

COR_CHAO        EQU     00F8H
; COR DO CHÃO (LIVREMENTE ALTERÁVEL).

COR_CACTO       EQU     001CH
; COR DOS CACTOS (LIVREMENTE ALTERÁVEL).

COR_DINO        EQU     00F0H
; COR DO DINO (LIVREMENTE ALTERÁVEL).

COR_GO          EQU     00E0H
; COR DA MENSAGEM "GAME OVER" (LIVREMENTE ALTERÁVEL).

STACK_BASE      EQU     8000H
; POSIÇÃO DE MEMÓRIA ONDE A STACK É INICIADA (LIVREMENTE ALTERÁVEL, DESDE QUE 
; NÃO SE SOBREPONHA A OUTRAS POSIÇÕES EM MEMÓRIA).

SEED            WORD    SEED_INICIAL
; VARIÁVEL QUE ARMAZENA O VALOR DA SEED USADA EM GERACACTO EM TODOS OS MOMENTOS 
; DO JOGO. INICIADA COM O VALOR DA CONSTANTE SEED_INICIAL.

NIVEL_DINO      WORD    0
; VARIÁVEL QUE ARMAZENA A ALTURA RELATIVA AO CHÃO EM QUE O DINO SE ENCONTRA,
; OU SEJA, O DINO "TEM OS PÉS" NA POSIÇÃO NIVEL_CHAO - NIVEL_DINO - 1.
; INICIADA COM 0 (O DINO COMEÇA O JOGO NO CHÃO).

GAME_STATUS     WORD    0
; VARIÁVEL QUE INDICA SE O JOGO ESTÁ A DECORRER (GAME_STATUS = 1) OU NÃO 
; (GAME_STATUS = 0). INICIADA COM O VALOR 0 (O JOGO SÓ COMEÇA QUANDO 
; CLICAMOS NO BUTÃO 0).

SALTO           WORD    0
; VARIÁVEL QUE INDICA SE O DINO ESTÁ EM MOVIMENTO (SALTO = 1) OU NÃO (SALTO = 0)
; INICIADA A 0, POIS O DINO COMEÇA O JOGO PARADO.

ATUALIZA        WORD    0
; VARIÁVEL QUE INDICA SE O TERMINAL ESTÁ A MEIO DE UMA ATUALIZAÇÃO 
; (ATUALIZA = 1) OU SE NÃO HÁ ATUALIZAÇÕES POR EFETUAR (ATUALIZA = 0). 
; INICIADA COM 0 (O TERMINAL SÓ É ATUALIZADO DEPOIS DO JOGO COMEÇAR).

NADA            STR     '        ', 0
; STRING QUE NOS PERMITE LIMPAR UMA COLUNA NO ECRÃ (O TAMANHO DESTA STRING
; DEVERÁ SER MAIOR OU IGUAL A CACTO_MAX, SENDO OS VALORES EM POSIÇÕES
; SUPERIORES A CACTO_MAX IRRELEVANTES).

CACTO           STR     '********', 0
; STRING QUE REPRESENTA UM CACTO (LIVREMENTE ALTERÁVEL, O TAMANHO DESTA STRING 
; DEVERÁ SER MAIOR OU IGUAL A CACTO_MAX, SENDO OS VALORES EM POSIÇÕES SUPERIORES
; A CACTO_MAX IRRELEVANTES).

DINO            STR     'AI', 1, 0
; STRING QUE REPRESENTA O DINO QUANDO ELE ESTÁ ASSENTE NO CHÃO (LIVREMENTE 
; ALTERÁVEL, SENDO OS VALORES EM POSIÇÕES SUPERIORES A DINO_MAX IRRELEVANTES).

DINO_UP         STR     ' CAI', 0
; STRING QUE REPRESENTA O DINO QUANDO ELE ESTÁ EM SUBIDA NO CHÃO (LIVREMENTE 
; ALTERÁVEL, SENDO OS VALORES EM POSIÇÕES SUPERIORES A DINO_MAX IRRELEVANTES).

DINO_DOWN       STR     'IAC ', 0
; STRING QUE REPRESENTA O DINO QUANDO ELE ESTÁ EM DESCIDA NO CHÃO (LIVREMENTE 
; ALTERÁVEL, SENDO OS VALORES EM POSIÇÕES SUPERIORES A DINO_MAX IRRELEVANTES).

GAMEOVER        STR     'G A M E  O V E R', 0
; MENSAGEM DE GAME OVER (INTRODUZIDA COM O VALOR SUGERIDO NO ENUNCIADO).
; ESTA MENSAGEM PODE SER ALTERADA, DESDE QUE TENHA APENAS UMA LINHA.

DISPLAYS        STR     DISP0, DISP1, DISP2, DISP3, DISP4, DISP5, 0
; STRING QUE CONTÉM AS POSIÇÕES DOS DIFERENTES DISPLAYS, POR ORDEM.
                
                ORIG    4000H
TERR            TAB     DIM_TERR
; TABELA EM MEMÓRIA QUE ARMAZENA A INFORMAÇÃO SOBRE O TERRENO DE JOGO.
; TEM DIMENSÃO IGUAL A DIM_TERR (E COMEÇA COM 0 EM TODAS AS POSIÇÕES).

PONTOS          TAB     6
; TABELA QUE GUARDA OS DÍGITOS DA PONTUAÇÃO (UNIDADES, DEZENAS, ..., 
; CENTENAS DE MILHARES). INICIA COM OS 6 DÍGITOS A 0.

; ============================================================================ ;

                ORIG    0000H
; INICIAR A STACK
                MVI     R6, STACK_BASE
                
; ATIVA O BOTÃO 0
GET_READY:      MVI     R1, 0001H
                JAL     SET_MASK
                ENI
                
; AGUARDA QUE O BUTÃO 0 SEJA PRESSIONADO
WAIT_FOR_START: MVI     R1, GAME_STATUS
                LOAD    R1, M[R1]
                CMP     R1, R0
                BR.Z    WAIT_FOR_START

; PREPARA O ECRÃ DE JOGO COM O CHÃO E O DINOSSAURO
; DESATIVA AS TINTERRUPÇÕES DO KEY0 E PREPARA AS INTERRUPÇÕES DA KEYUP
; E DO TEMPORIZADOR
START:          ; LIMPA O ECRÃ
                MVI     R1, TERM_CURSOR
                MVI     R2, FFFFH
                STOR    M[R1], R2
                
                ; ESCREVE O CHÃO E O DINO
                MVI     R1, CHAO ; ---------> PARÂMETRO CARACTER
                MVI     R2, NIVEL_CHAO ; ---> PARÂMETRO LINHA
                JAL     ESCREVE_CHAO ; -----> CHAMADA DA ESCREVE_CHAO
                
                MVI     R1, NIVEL_CHAO
                DEC     R1 ; ---------------> PARÂMETRO LINHA
                MVI     R2, DINO ; ---------> PARÂMETRO STRING
                JAL     ESCREVE_DINO ; -----> CHAMADA DA ESCREVE_DINO
                
                MVI     R1, 8088H
                JAL     SET_MASK
                
; ESPERA POR UMA INTERRUPÇÃO DO TIMER PARA ATUALIZAR O TERRENO DE JOGO
                JAL     SET_TIMER
WAIT_FOR_TIMER: MVI     R1, ATUALIZA
                LOAD    R1, M[R1]
                CMP     R1, R0
                BR.Z    WAIT_FOR_TIMER

                MVI     R1, TERR ; ------> PARAMETRO TERRENO
                MVI     R2, DIM_TERR ; --> PARAMETRO TAMANHO DO TERRENO
                JAL     ATUALIZA_JOGO
                
                JAL     SET_TIMER
                BR      WAIT_FOR_TIMER
; DEPOIS DE ATUALIZAR O TERRENO, ATIVAMOS O TEMPORIZADOR E ESPERAMOS
; POR MAIS UM CICLO DE ATUALIZAÇÃO

; ============================================================================ ;
; ATUALIZA A MEMÓRIA E O TERRENO DE JOGO, RECEBENDO COMO PARÂMETROS A
; TABELA EM MEMÓRIA QUE ARMAZENA O TERRENO (R1) E A SUA DIMENSÃO (R2)

ATUALIZA_JOGO:  DEC     R6
                STOR    M[R6], R4
                DEC     R6
                STOR    M[R6], R5
                DEC     R6
                STOR    M[R6], R7
                
; NOTA:  AO LONGO DESTA FUNÇÃO, O VALOR CORRESPONDENTE A R2 É DIM_TERR-1
                DEC     R2
                
; PUSH DOS PARÂMETROS ANTES DO .LOOP, PARA PODEREM SER USADOS MAIS TARDE
                DEC     R6
                STOR    M[R6], R1
                DEC     R6
                STOR    M[R6], R2
                
; SE FOR PRECISO, LIMPA O CACTO NA PRIMEIRA POSIÇÃO
                LOAD    R5, M[R1]
                CMP     R5, R0
                BR.Z    .LOOP
                
                MVI     R1, NADA
                DEC     R6
                STOR    M[R6], R1 ; ------> PARAMETRO STRING
                MVI     R1, CACTO_MAX
                DEC     R6
                STOR    M[R6], R1 ; ------> PARAMETRO ALTURA MAXIMA
                MVI     R1, NIVEL_CHAO
                DEC     R1 ; -------------> PARAMETRO LINHA
                MOV     R2, R0 ; ---------> PARAMETRO COLUNA
                JAL     ESCREVE ; --------> CAHAMADA DE ESCREVE
; FIM DA LIMPEZA DO CACTO
                
; CASO TENHA SIDO LIMPADO UM CACTO, RECUPERAMOS OS PARÂMETROS PARA USAR NO 
; .LOOP, MAS MANTEMO-NOS NA POSIÇÃO DA PILHA A BAIXO DOS DOIS PARÂMETROS,
; POIS SERÃO NECESSÁRIOS DEPOIS DO .LOOP.
                LOAD    R2, M[R6]
                INC     R6
                LOAD    R1, M[R6]
                INC     R6
                DEC     R6
                DEC     R6
; NÃO FAZEMOS O STOR DE R1 E R2 POIS É REDUNDANTE

.LOOP:          
; ATUALIZA O VALOR EM MEMÓRIA
                MOV     R4, R1
                INC     R4
                LOAD    R5, M[R4]
                STOR    M[R1], R5

; VERIFICA SE É PRECISO ATUALIZAR UM CACTO NO TERMINAL
                CMP     R5, R0
                BR.Z    .NEXT
                
; GUARDA OS PARÂMETROS PARA NÃO PERDEMOS A INFORMAÇÃO DE ONDE ESTAMOS NO .LOOP
                DEC     R6
                STOR    M[R6], R1
                DEC     R6
                STOR    M[R6], R2
                
                MOV     R2, R1 ; ---------> PARÂMETRO COLUNA
                MOV     R1, R5 ; ---------> PARÂMETRO ALTURA
                JAL     ATUALIZA_CACTO ; -> CHAMADA DE ATUALIZA_CACTO
                
; RECUPERA OS PARÂMETROS PARA A LABEL .NEXT
                LOAD    R2, M[R6]
                INC     R6
                LOAD    R1, M[R6]
                INC     R6

; PASSA À PRÓXIMA POSIÇÃO NO CICLO
.NEXT:          INC     R1
                DEC     R2
                BR.P    .LOOP
; FIM DO CICLO
                
; PROCESSAMENTO DO ÚLTIMO CACTO DO TERRENO
.ULTIMO_CACTO:  MVI     R1, CACTO_MAX ; -> PARAMETRO ALTURA MAXIMA
                JAL     GERA_CACTO ; ----> CHAMADA DE GERA_CACTO
; GERACACTO COLOCOU O SEU RESULTADO EM R3

; RECUPERAMOS OS PARÂMETROS DA PILHA
                LOAD    R2, M[R6]
                INC     R6
                LOAD    R1, M[R6]
                INC     R6
                
; ATUALIZA A ULTIMA POSICAO COM O RESULTADO DA GERACACTO
                ADD     R4, R1, R2
                STOR    M[R4], R3
                
; VOLTAMOS A METER R1 NA PILHA
                DEC     R6
                STOR    M[R6], R1
                
; VERIFICA SE HÁ UM CATO NA ÚLTIMA POSIÇÃO
                CMP     R3, R0
                BR.Z    .VER_DINO
; ESCREVE O CACTO               
                MVI     R1, CACTO
                DEC     R6
                STOR    M[R6], R1 ; -------> PARAMETRO STRING
                DEC     R6
                STOR    M[R6], R3 ; -------> PARAMETRO ALTURA MAXIMA
                MVI     R1, NIVEL_CHAO
                DEC     R1 ; --------------> PRAMETRO LINHA
                ; -------------------------> PARAMETRO COLUNA (DIM_TERR-1)
                MVI     R4, TERM_COLOR
                MVI     R5, COR_CACTO
                STOR    M[R4], R5 ; -------> DEFINIÇÃO DA COR
                JAL     ESCREVE ; ---------> CHAMADA DE ESCREVE
; FIM DO TRATAMENTO DA ÚLTIMA POSIÇÃO DO TERRENO
                
; VERIFICA SE O DINOSSAURO ESTÁ EM MOVIMENTO
.VER_DINO:      MVI     R4, SALTO
                LOAD    R4, M[R4]
                CMP     R4, R0
                BR.Z    .VER_GAMEOVER
                JAL     MUDA_DINO
                
; VERIFICA SE HOUVE UMA COLISÃO
.VER_GAMEOVER:  
; RECUPERAMOS OS PARÂMETROS PELA ÚLTIMA VEZ, JÁ QUE ESTES SÓ SÃO NECESSÁRIOS
; MAIS UMA VEZ NO MÁXIMO, DENTRO DA ATUALIZA_JOGO
                LOAD    R1, M[R6]
                INC     R6
                
                MVI     R4, POS_DINO
                ADD     R4, R4, R1
                LOAD    R4, M[R4]       ; ALTURA DO CACTO EM POS_DINO (X)
                MVI     R5, NIVEL_DINO
                LOAD    R5, M[R5]
                CMP     R4, R5          ; SE X > NIVEL_DINO HOUVE COLISÃO   
                JMP.P   GAME_OVER
                
; SE O JOGO NÃO TIVER ACABADO, ATUALIZA A PONTUAÇÃO
.PONTOS:        MOV     R1, R4 ; ----------> PARÂMETRO ALTURA 
                ; (ALTURA DO CACTO EM POS_DINO JÁ ESTÁ EM R4)
                JAL     ATUALIZA_PONTOS ; -> CHAMADA DA ATUALIZA_PONTOS
                
; FIM DA ATUALIZA_JOGO (JOGO ATUALIZADO => ATUALIZA = 0)
.EXIT:          MVI     R1, ATUALIZA
                STOR    M[R1], R0

                LOAD    R7, M[R6]
                INC     R6
                LOAD    R5, M[R6]
                INC     R6
                LOAD    R4, M[R6]
                INC     R6
                
                JMP     R7
                
; ============================================================================ ;
; GERA ALEATÓRIAMENTE UM VALOR PARA A ALTURA DO ÚLTIMO CACTO DO TERRENO, 
; ENTRE 0 E CACTO_MAX (PARÂMETRO EM R1).
           
GERA_CACTO:     DEC     R6
                STOR    M[R6], R4
                DEC     R6
                STOR    M[R6], R5
                
                MVI     R2, SEED
                LOAD    R2, M[R2]
                
                MVI     R4, 1
                AND     R4, R2, R4
                SHR     R2
                
                CMP     R4, R0
                BR.Z    .SKIP
                MVI     R5, B400H
                XOR     R2, R2, R5

.SKIP:          MVI     R5, 3278
                ADD     R0, R2, R5
                BR.C    .CACTO
                
                MOV     R3, R0
                BR      .EXIT
   
.CACTO:         DEC     R1
                AND     R3, R2, R1
                INC     R3
                BR      .EXIT
                
.EXIT:          MVI     R4, SEED
                STOR    M[R4], R2

                LOAD    R5, M[R6]
                INC     R6
                LOAD    R4, M[R6]
                INC     R6
                
                JMP     R7
                
; ============================================================================ ;
; ESCREVE O CHAO COM CARACTERES C (PARAMETRO EM R1), NA LINHA NIVEL_CHAO
; (PARÂMETRO EM R2).

ESCREVE_CHAO:   NOP
; COLOCA O CURSOR
.CURSOR:        MVI     R3, 8
.SHIFT:         SHLA    R2
                DEC     R3
                BR.P    .SHIFT
                MVI     R3, TERM_CURSOR
                STOR    M[R3], R2

; DEFINE A COR COM QUE O CHÃO É ESCRITO
                MVI     R2, TERM_COLOR
                MVI     R3, COR_CHAO
                STOR    M[R2], R3

; ESCREVE O CHÃO
                MVI     R2, DIM_TERR
                MVI     R3, TERM_WRITE
.WRITE:         STOR    M[R3], R1
                DEC     R2
                BR.P    .WRITE

                JMP     R7

; ============================================================================ ;
; ESCREVE A PARTIR DA LINHA L (PARAMETRO EM R1) E COLUNA C 
; (PARAMETRO EM R2) A STRING S (1º PARAMETRO NA PILHA) NUM MAXIMO DE K
; CARACTERES (2º PARAMETRO NA PILHA) DE BAIXO PARA CIMA
                
ESCREVE:        NOP
; COLOCA O CURSOR
.CURSOR:        MVI     R4, 8
.SHIFT:         SHLA    R1
                DEC     R4
                BR.P    .SHIFT
                ADD     R1, R1, R2
                MVI     R3, TERM_CURSOR
                STOR    M[R3], R1
                
; COMEÇA O PROCESSO DE ESCRITA
                LOAD    R3, M[R6]       ; R1 = POS_CURSOR
                INC     R6              ; R2 = POS_STRING
                LOAD    R2, M[R6]
                INC     R6              ; R3 = MAXIMO_CARACTERES
                
.WRITE:         LOAD    R5, M[R2]       ; R4 E R5 = VARIAVEIS LIVRES
                CMP     R5, R0
                BR.Z    .EXIT
                
                MVI     R4, TERM_WRITE
                STOR    M[R4], R5
                
                MVI     R4, 0100H
                SUB     R1, R1, R4
                MVI     R4, TERM_CURSOR
                STOR    M[R4], R1
                
                INC     R2
                DEC     R3
                BR.P    .WRITE
                
.EXIT:          JMP     R7

; ============================================================================ ;
; ESCREVE UM CACTO DE ALTURA H (PARÂMETRO EM R1) NA COLUNA C (PARÂMETRO EM R2)

ATUALIZA_CACTO: DEC     R6
                STOR    M[R6], R7
                DEC     R6
                STOR    M[R6], R4
                DEC     R6
                STOR    M[R6], R5
; GUARDAMOS R2 ANTES DE ESCREVERMOS O CACTO NA POSIÇÃO DESIGNADA
                DEC     R6
                STOR    M[R6], R2
                
                MVI     R4, CACTO
                DEC     R6
                STOR    M[R6], R4 ; ---------> PARÂMETRO STRING
                DEC     R6
                STOR    M[R6], R1 ; ---------> PARÂMETRO ALTURA MÁXIMA
                ; ---------------------------> PARÂMETRO COLUNA (JÁ ESTÁ EM R2)
                MVI     R1, NIVEL_CHAO
                DEC     R1 ; ----------------> PARÂMETRO LINHA
                MVI     R4, TERM_COLOR
                MVI     R5, COR_CACTO
                STOR    M[R4], R5 ; ---------> DEFINIÇÃO DA COR
                JAL     ESCREVE ; -----------> CHAMADA DA ESCREVE
; FIM DA ESCRITA DO CACTO
                
; RECUPERAMOS R2 PARA LIMPARMOS O CACTO DA SUA "POSIÇÃO DE PARTIDA"
                LOAD    R2, M[R6]
                INC     R6
                
                MVI     R4, NADA
                DEC     R6
                STOR    M[R6], R4 ; ---------> PARÂMETRO STRING
                MVI     R4, CACTO_MAX
                DEC     R6
                STOR    M[R6], R4 ; ---------> PARÂMETRO ALTURA MÁXIMA
                INC     R2 ; ----------------> PARÂMETRO COLUNA
                MVI     R1, NIVEL_CHAO
                DEC     R1 ; ----------------> PARÂMETRO LINHA
                JAL     ESCREVE ; -----------> CHAMADA DA ESCREVE
; FIM DA LIMPEZA DO CACTO
                
                LOAD    R5, M[R6]
                INC     R6
                LOAD    R4, M[R6]
                INC     R6
                LOAD    R7, M[R6]
                INC     R6
                
                JMP     R7

; ============================================================================ ;
; ESCREVE O DINOSSAURO CORRESPONDENTE À STRING S (PARÂMETRO EM R2) NA LINHA L
; (PARÂMETRO EM R1)

ESCREVE_DINO:   DEC     R6
                STOR    M[R6], R7
                DEC     R6
                STOR    M[R6], R5
                DEC     R6
                STOR    M[R6], R4
                
                DEC     R6
                STOR    M[R6], R2 ; --------> PARÂMETRO STRING
                MVI     R2, DINO_MAX
                DEC     R6
                STOR    M[R6], R2 ; --------> PARÂMETRO ALTURA MÁXIMA
                ; --------------------------> PARÂMETRO LINHA (JÁ ESTÁ EM R1)
                MVI     R2, POS_DINO ; -----> PARÂMETRO COLUNA
                MVI     R4, TERM_COLOR
                MVI     R5, COR_DINO
                STOR    M[R4], R5 ; --------> DEFINIÇÃO DA COR
                JAL     ESCREVE ; ----------> CHAMADA DE ESCREVE
                
                LOAD    R4, M[R6]
                INC     R6
                LOAD    R5, M[R6]
                INC     R6
                LOAD    R7, M[R6]
                INC     R6
                
                JMP     R7
                
; ============================================================================ ;
; ALTERA O DINO PARA REFLETIR A SUA MOVIMENTAÇÃO

MUDA_DINO:      DEC     R6
                STOR    M[R6], R7
                
; VERIFICA SE O DINO ESTÁ A SUBIR OU A DESCER
                MVI     R1, SALTO
                LOAD    R1, M[R1]
                MVI     R2, -1
                CMP     R2, R1
                BR.Z    .DOWN

; CASO O DINOSSAURO ESTEJA A SUBIR, ESCREVE-O NA POSIÇÃO APROPRIADA
.UP:            MVI     R1, NIVEL_CHAO
                DEC     R1
                MVI     R2, NIVEL_DINO
                LOAD    R3, M[R2]
                SUB     R1, R1, R3 ; -----> PARÂMETRO LINHA 
                ; (NIVEL_CHAO - 1 - NIVEL_DINO)
                
; (SO AUMENTAMOS R3 DEPOIS DE DEFINIR R1 DEVIDO AO ESPAÇO QUE INICIA DINO_UP)
                INC     R3
                STOR    M[R2], R3         ; ATUALIZA NIVEL_DINO
                
                MVI     R2, DINO_UP ; ----> PARÂMETRO STRING
                JAL     ESCREVE_DINO ; ---> CHAMADA DE ESCREVE
                BR      .VER_MAX

; CASO O DINOSSAURO ESTEJA A DESCER, ESCREVE-O NA POSIÇÃO APROPRIADA
.DOWN:          MVI     R1, NIVEL_CHAO
                DEC     R1
                MVI     R2, NIVEL_DINO
                LOAD    R3, M[R2]
                DEC     R3
                SUB     R1, R1, R3 ; -----> PARÂMETRO LINHA 
                ; (NIVEL_CHAO - 1 - NIVEL_DINO)
                STOR    M[R2], R3         ; ATUALIZA NIVEL_DINO
                
                MVI     R2, DINO_DOWN ; --> PARÂMETRO STRING
                JAL     ESCREVE_DINO ; ---> CHAMADA DE ESCREVE

; VERIFICA SE O DINOSSAURO JÁ ATINGIU A ALTURA MÁXIMA
.VER_MAX:       MVI     R2, NIVEL_DINO
                LOAD    R2, M[R2]
                MVI     R1, SALTO_MAX
                CMP     R1, R2
                BR.P    .VER_CHAO
                
; METE O DINOSSAURO A DESCER
                MVI     R1, -1
                MVI     R2, SALTO
                STOR    M[R2], R1
                BR      .EXIT
                
; VERIFICA SE O DINOSSAURO JÁ ATERROU
.VER_CHAO:      CMP     R2, R0 ; R2 TEM O VAOR DE NIVEL_DINO
                BR.P    .EXIT
                
; ESCREVE O DINO COM A SUA APARÊNCIA DE QUANDO ESTÁ NO CHÃO
                MVI     R1, NIVEL_CHAO
                DEC     R1 ; ----------------> PARÂMETRO LINHA
                MVI     R2, DINO ; ----------> PARÂMETRO STRING
                JAL     ESCREVE_DINO ; ------> CHAMADA DE ESCREVE
; PREPARA O JOGO PARA RECEBER MAIS SALTOS
                MVI     R2, SALTO
                STOR    M[R2], R0
                MVI     R1, 8088H
                JAL     SET_MASK
                
.EXIT:          LOAD    R7, M[R6]
                INC     R6
                JMP     R7

; ============================================================================ ;
; ATUALIZA A PONTUAÇÃO ATUAL DE ACORDO COM A ALTURA DO CACTO QUE FOI 
; ULTRAPASSADO: H (PARÂMETRO EM R1)

ATUALIZA_PONTOS:DEC     R6
                STOR    M[R6], R4
                DEC     R6
                STOR    M[R6], R5
                
; CALCULAR INCREMENTO DA PONTUAÇÃO: H/2 + 1 (PODE SER INTERPRETADO COMO O 
; CARRY DAS UNIDADES)
                SHRA    R1
                INC     R1
                
                MVI     R2, PONTOS   ; R2 = TABELA DA PONTUAÇÃO
                MVI     R3, DISPLAYS ; R3 = TABELA DOS ENDEREÇOS DOS DISPLAYS
.LOOP:          LOAD    R5, M[R2]    ; R5 = DÍGITO ATUAL
                ADD     R5, R1, R5   ; R1 = CARRY => R1+R5 = DÍGITO ATUALIZADO
                MOV     R1, R0
                
; CÁLCULO DO RESTO DA DIVISÃO POR 10 E DO CARRY
                MVI     R4, AH
.GERA_CARRY:    CMP     R5, R4
                BR.N    .SAVE
                SUB     R5, R5, R4
                INC     R1
                BR      .GERA_CARRY
                
; ATUALIZAÇÃO DA MEMÓRIA E DOS DISPLAYS 
.SAVE:          STOR    M[R2], R5
                LOAD    R4, M[R3]
                STOR    M[R4], R5
                INC     R2
                INC     R3
                LOAD    R4, M[R3]
                CMP     R4, R0
                BR.NZ   .LOOP
                
                LOAD    R5, M[R6]
                INC     R6
                LOAD    R4, M[R6]
                INC     R6
                
                JMP     R7

; ============================================================================ ;
; FUNÇÃO RESPONSÁVEL POR PROCESSAR O TÉRMINO DO JOGO.

GAME_OVER:      
; POSICIONA O CURSOR
                MVI     R1, 22
                MVI     R2, 30
                MVI     R4, 8
.SHIFT:         SHLA    R1
                DEC     R4
                BR.P    .SHIFT
                ADD     R1, R1, R2
                MVI     R3, TERM_CURSOR
                STOR    M[R3], R1
                
; DEFINE A COR DO GAME OVER
                MVI     R2, TERM_COLOR
                MVI     R3, COR_GO
                STOR    M[R2], R3
                
; ESCREVE "G A M E  O V E R"
                MVI     R2, GAMEOVER
.WRITE:         LOAD    R1, M[R2]
                MVI     R3, TERM_WRITE
                STOR    M[R3], R1
                INC     R2
                CMP     R1, R0
                BR.NZ   .WRITE
                
; RECUPERA O ESTADO INCIAL DO JOGO (OU SEJA, REINICIA AS VARIÁVEIS)
.RESET_MEMORY:  
; COLOCA A MEMÓRIA DAS POSIÇÕES DO TERRENO E DA PONTUAÇÃO A 0
                MVI     R1, 6
                MVI     R2, DIM_TERR
                ADD     R2, R2, R1
                MVI     R1, TERR
.NEXT:          STOR    M[R1], R0
                INC     R1
                DEC     R2
                BR.P    .NEXT
                
; DEVOLVE AS VARIÁVEIS DE ESTADO DE JOGO A 0
                MVI     R1, ATUALIZA
                STOR    M[R1], R0
                MVI     R1, GAME_STATUS
                STOR    M[R1], R0
                MVI     R1, SALTO
                STOR    M[R1], R0
                MVI     R1, NIVEL_DINO
                STOR    M[R1], R0
; (NOTA: NÃO É NECESSÁRIO REINICIAR A VARIÁVEL SEED, PARA NÃO GERARMOS SEMPRE A 
; MESMA SEQUÊNCIA DE CACTOS)
                
                JMP     GET_READY

; ============================================================================ ;
; INICIA O TIMER COM O VALOR TIMER_SPEED

SET_TIMER:      MVI     R1, TIMER_SPEED
                MVI     R2, TIMER_VALUE
                STOR    M[R2], R1
                MVI     R1, 1
                MVI     R2, TIMER_STATUS
                STOR    M[R2], R1
                
                JMP     R7

; ============================================================================ ;
; INICIA A MASCARA COM O VALOR PASSADO EM R1 COMO PARAMETRO

SET_MASK:       MVI     R2, MASK
                STOR    M[R2], R1
                JMP     R7

; ============================================================================ ;

; PROCESSAR O BUTÃO 0
                ORIG    7F00H
                
                DEC     R6
                STOR    M[R6], R1
                DEC     R6
                STOR    M[R6], R2
                
                MVI     R1, GAME_STATUS
                MVI     R2, 1
                STOR    M[R1], R2
                
                LOAD    R2, M[R6]
                INC     R6
                LOAD    R1, M[R6]
                INC     R6
                
                RTI
                
; PROCESSAR O BOTÃO KEYUP
                ORIG    7F30H
                
                DEC     R6
                STOR    M[R6], R1
                DEC     R6
                STOR    M[R6], R2
                
                ; O DINOSSAURO COMEÇA O SALTO
                MVI     R1, SALTO
                MVI     R2, 1
                STOR    M[R1], R2
                
                MVI     R1, 8000H
                MVI     R2, MASK
                STOR    M[R2], R1
                
                LOAD    R2, M[R6]
                INC     R6
                LOAD    R1, M[R6]
                INC     R6
                
                RTI
                
; PROCESSAR O TECLADO
                ORIG    7F70H
                
                DEC     R6
                STOR    M[R6], R1
                DEC     R6
                STOR    M[R6], R2
                
                ; O DINOSSAURO COMEÇA O SALTO
                MVI     R1, SALTO
                MVI     R2, 1
                STOR    M[R1], R2
                
                MVI     R1, 8000H
                MVI     R2, MASK
                STOR    M[R2], R1
                
                LOAD    R2, M[R6]
                INC     R6
                LOAD    R1, M[R6]
                INC     R6
                
                RTI
                
; PROCESSAR INTERRUPÇÃO DO TEMPORIZADOR
                ORIG    7FF0H
                
                DEC     R6
                STOR    M[R6], R1
                DEC     R6
                STOR    M[R6], R2
                
                MVI     R1, ATUALIZA
                MVI     R2, 1
                STOR    M[R1], R2
                
                LOAD    R2, M[R6]
                INC     R6
                LOAD    R1, M[R6]
                INC     R6
                
                RTI