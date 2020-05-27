%TO DO: METER PARAGENS A MOSTRAR GID, CARREIRA E OUTRA COISA SE NECESSARIO

:- style_check(-singleton).
:- set_prolog_flag(toplevel_print_options,
    [quoted(true), portrayed(true), max_depth(0)]).
:- consult('base_de_conhecimento.pl').

%aresta(paragem(183,-103678.36,-96590.26,'bom','fechado dos lados','yes','vimeca',1,286,'rua aquilino ribeiro','carnaxide e queijas'),paragem(791,-103705.46,-96673.6,'bom','aberto dos lados','yes','vimeca',1,286,'rua aquilino ribeiro','carnaxide e queijas')).
%aresta(paragem(791,-103705.46,-96673.6,'bom','aberto dos lados','yes','vimeca',1,286,'rua aquilino ribeiro','carnaxide e queijas'),paragem(595,-103725.69,-95975.2,'bom','fechado dos lados','yes','vimeca',1,354,'rua manuel teixeira gomes','carnaxide e queijas')).
%aresta(paragem(595,-103725.69,-95975.2,'bom','fechado dos lados','yes','vimeca',1,354,'rua manuel teixeira gomes','carnaxide e queijas'),paragem(182,-103746.76,-96396.66,'bom','fechado dos lados','yes','scotturb',1,286,'rua aquilino ribeiro','carnaxide e queijas')).
%aresta(paragem(182,-103746.76,-96396.66,'bom','fechado dos lados','yes','scotturb',1,286,'rua aquilino ribeiro','carnaxide e queijas'),paragem(499,-103758.44,-94393.36,'bom','fechado dos lados','yes','vimeca',1,300,'avenida dos cavaleiros','carnaxide e queijas')).
%aresta(paragem(183,-103678.36,-96590.26,'bom','fechado dos lados','yes','vimeca',2,286,'rua aquilino ribeiro','carnaxide e queijas'),paragem(499,-103758.44,-94393.36,'bom','fechado dos lados','yes','vimeca',1,300,'avenida dos cavaleiros','carnaxide e queijas')).
%paragem(594,-103879.91,-95751.23,'bom','fechado dos lados','no','vimeca',1,1116,'avenida professor dr. reinaldo dos santos','carnaxide e queijas').
:- multifile (-)/1.

%Trajeto entre dois pontos
trajeto(Origem, Destino, Caminho) :-
    profundidade(Origem, Destino, [Origem], Caminho).

profundidade(Destino, Destino, H, D) :- inverso(H,D).

profundidade(Origem, Destino, H, D) :-
    aresta(paragem(Origem,_,_,_,_,_,_,_,_,_,_), paragem(Prox,_,_,_,_,_,_,_,_,_,_)),
    \+ member(Prox, H),
    profundidade(Prox, Destino, [Prox|H], D).

%Selecionar apenas algumas das operadoras de transporte para um determinado percurso
percursoComOperadora(paragem(Origem,_,_,_,_,_,Operadora,_,_,_,_), paragem(Destino,_,_,_,_,_,Operadora2,_,_,_,_), L, C) :-
    member(Operadora, L),
    member(Operadora2, L),
    profundidadeComOperadora(paragem(Origem,_,_,_,_,_,Operadora,_,_,_,_), paragem(Destino,_,_,_,_,_,Operadora2,_,_,_,_), [Origem], L, C).

profundidadeComOperadora(paragem(Destino,_,_,_,_,_,Operadora,_,_,_,_), paragem(Destino,_,_,_,_,_,Operadora,_,_,_,_), H, L, C) :- inverso(H,C).

profundidadeComOperadora(paragem(Origem,_,_,_,_,_,Operadora,_,_,_,_), paragem(Destino,_,_,_,_,_,Operadora2,_,_,_,_), H, L, C) :-
    aresta(paragem(Origem,_,_,_,_,_,Operadora,_,_,_,_), paragem(Prox,_,_,_,_,_,OperadoraProx,_,_,_,_)),
    member(OperadoraProx, L),
    \+ member(Prox, H),
    profundidadeComOperadora(paragem(Prox,_,_,_,_,_,OperadoraProx,_,_,_,_), paragem(Destino,_,_,_,_,_,Operadora2,_,_,_,_), [Prox|H], L, C).

%Excluir um ou mais operadores de transporte para o percurso TESTAR COM ORIGEM E DESTINO SÓ
percursoExcluiOperadora(paragem(Origem,_,_,_,_,_,Operadora,_,_,_,_), paragem(Destino,_,_,_,_,_,Operadora2,_,_,_,_), L, C) :-
    \+ member(Operadora, L),
    \+ member(Operadora2, L),
    profundidadeExcluiOperadora(paragem(Origem,_,_,_,_,_,Operadora,_,_,_,_), paragem(Destino,_,_,_,_,_,Operadora2,_,_,_,_), [Origem], L, C).

profundidadeExcluiOperadora(paragem(Destino,_,_,_,_,_,Operadora,_,_,_,_), paragem(Destino,_,_,_,_,_,Operadora,_,_,_,_), H, L, C) :- inverso(H,C).

profundidadeExcluiOperadora(paragem(Origem,_,_,_,_,_,Operadora,_,_,_,_), paragem(Destino,_,_,_,_,_,Operadora2,_,_,_,_), H, L, C) :-
    aresta(paragem(Origem,_,_,_,_,_,Operadora,_,_,_,_), paragem(Prox,_,_,_,_,_,OperadoraProx,_,_,_,_)),
    \+ member(OperadoraProx, L),
    \+ member(Prox, H),
    profundidadeExcluiOperadora(paragem(Prox,_,_,_,_,_,OperadoraProx,_,_,_,_), paragem(Destino,_,_,_,_,_,Operadora2,_,_,_,_), [Prox|H], L, C).

%Identificar quais as paragens com o maior número de carreiras num determinado percurso
maiorNumeroParagens(paragem(Origem,_,_,_,_,_,_,_,_,_,_), paragem(Destino,_,_,_,_,_,_,_,_,_,_), Lista, Res) :-
    contaParagens(Origem, N),
    profundidadeConta(paragem(Origem,_,_,_,_,_,_,_,_,_,_), paragem(Destino,_,_,_,_,_,_,_,_,_,_), [p(Origem,N)], Lista),
    calculaMaior(Lista, 0, Max),
    getMaiores(Lista, Max, Res).

profundidadeConta(paragem(Destino,_,_,_,_,_,_,_,_,_,_), paragem(Destino,_,_,_,_,_,_,_,_,_,_), H, Lista) :-
    inverso(H, Lista).
    
profundidadeConta(paragem(Origem,_,_,_,_,_,_,_,_,_,_), paragem(Destino,_,_,_,_,_,_,_,_,_,_), H, Lista) :-
    aresta(paragem(Origem,_,_,_,_,_,_,_,_,_,_), paragem(Prox,_,_,_,_,_,_,_,_,_,_)),
    contaParagens(Prox, N),
    \+ member(p(Prox,N), H),
    profundidadeConta(paragem(Prox,_,_,_,_,_,_,_,_,_,_), paragem(Destino,_,_,_,_,_,_,_,_,_,_), [p(Prox,N)|H], Lista).

%Escolher o percurso que passe apenas por abrigos com publicidade
percursoComPublicidade(paragem(Origem,_,_,_,_,Publicidade,_,_,_,_,_), paragem(Destino,_,_,_,_,Publicidade2,_,_,_,_,_), C) :-
    member(Publicidade,['yes']),
    member(Publicidade2,['yes']),
    profundidadeComPublicidade(paragem(Origem,_,_,_,_,Publicidade,_,_,_,_,_), paragem(Destino,_,_,_,_,Publicidade2,_,_,_,_,_), [Origem], C).

profundidadeComPublicidade(paragem(Destino,_,_,_,_,Publicidade,_,_,_,_,_), paragem(Destino,_,_,_,_,Publicidade,_,_,_,_,_), H, C) :- inverso(H,C).

profundidadeComPublicidade(paragem(Origem,_,_,_,_,Publicidade,_,_,_,_,_), paragem(Destino,_,_,_,_,Publicidade2,_,_,_,_,_), H, C) :-
    aresta(paragem(Origem,_,_,_,_,Publicidade,_,_,_,_,_), paragem(Prox,_,_,_,_,PublicidadeProx,_,_,_,_,_)),
    member(PublicidadeProx, ['yes']),
    \+ member(Prox, H),
    profundidadeComPublicidade(paragem(Prox,_,_,_,_,PublicidadeProx,_,_,_,_,_), paragem(Destino,_,_,_,_,Publicidade2,_,_,_,_,_), [Prox|H], C).

%Escolher o percurso que passe apenas por paragens abrigadas
percursoComAbrigo(paragem(Origem,_,_,_,Abrigo,_,_,_,_,_,_), paragem(Destino,_,_,_,Abrigo2,_,_,_,_,_,_), C) :-
    \+ member(Abrigo,['sem abrigo']),
    \+ member(Abrigo2,['sem abrigo']),
    profundidadeComAbrigo(paragem(Origem,_,_,_,_,Publicidade,_,_,_,_,_), paragem(Destino,_,_,_,_,Publicidade2,_,_,_,_,_), [Origem], C).

profundidadeComAbrigo(paragem(Destino,_,_,_,Abrigo,_,_,_,_,_,_), paragem(Destino,_,_,_,Abrigo,_,_,_,_,_,_), H, C) :- inverso(H,C).

profundidadeComAbrigo(paragem(Origem,_,_,_,Abrigo,_,_,_,_,_,_), paragem(Destino,_,_,_,Abrigo2,_,_,_,_,_,_), H, C) :-
    aresta(paragem(Origem,_,_,_,Abrigo,_,_,_,_,_,_), paragem(Prox,_,_,_,AbrigoProx,_,_,_,_,_,_)),
    \+ member(AbrigoProx, ['sem abrigo']),
    \+ member(Prox, H),
    profundidadeComAbrigo(paragem(Prox,_,_,_,AbrigoProx,_,_,_,_,_,_), paragem(Destino,_,_,_,Abrigo2,_,_,_,_,_,_), [Prox|H], C).

getMaiores([], M, []).
getMaiores([p(X,N)|T], M, [p(X,N)|NewT]) :-
    N == M,
    getMaiores(T, M, NewT).
getMaiores([p(X,N)|T], M, NewT) :-
    N \= M,
    getMaiores(T, M, NewT).

calculaMaior([], R, R). 
calculaMaior([p(N,X)|Xs], WK, R):- X >  WK, calculaMaior(Xs, X, R). 
calculaMaior([p(N,X)|Xs], WK, R):- X =< WK, calculaMaior(Xs, WK, R).
calculaMaior([p(N,X)|Xs], R):- calculaMaior(Xs, X, R). 

contaParagens(Gid, N) :-
    findall(Gid, paragem(Gid,_,_,_,_,_,_,_,_,_,_), L),
    length(L, N).
    
inverso(Xs, Ys):-
	inverso(Xs, [], Ys).

inverso([], Xs, Xs).
inverso([X|Xs],Ys, Zs):-
	inverso(Xs, [X|Ys], Zs).