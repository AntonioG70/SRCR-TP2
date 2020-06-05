%TO DO: METER PARAGENS A MOSTRAR GID, CARREIRA E OUTRA COISA SE NECESSARIO em todas as que têm p() também. ordenar lista

:- set_prolog_flag(toplevel_print_options,
    [quoted(true), portrayed(true), max_depth(0)]).
:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- consult('base_de_conhecimento.pl').
/*
aresta(paragem(183,-103678.36,-96590.26,'bom','fechado dos lados','yes','vimeca',1,286,'rua aquilino ribeiro','carnaxide e queijas'),paragem(49,-103705.46,-96673.6,'bom','aberto dos lados','yes','vimeca',1,286,'rua aquilino ribeiro','carnaxide e queijas')).
aresta(paragem(791,-103705.46,-96673.6,'bom','aberto dos lados','yes','vimeca',2,286,'rua aquilino ribeiro','carnaxide e queijas'),paragem(234,-103725.69,-95975.2,'bom','fechado dos lados','yes','vimeca',1,354,'rua manuel teixeira gomes','carnaxide e queijas')).
aresta(paragem(791,-103725.69,-95975.2,'bom','fechado dos lados','yes','vimeca',2,354,'rua manuel teixeira gomes','carnaxide e queijas'),paragem(49,-103746.76,-96396.66,'bom','fechado dos lados','yes','scotturb',2,286,'rua aquilino ribeiro','carnaxide e queijas')).
aresta(paragem(182,-103746.76,-96396.66,'bom','fechado dos lados','yes','scotturb',1,286,'rua aquilino ribeiro','carnaxide e queijas'),paragem(595,-103758.44,-94393.36,'bom','fechado dos lados','yes','vimeca',1,300,'avenida dos cavaleiros','carnaxide e queijas')).
aresta(paragem(49,-103678.36,-96590.26,'bom','fechado dos lados','yes','vimeca',2,286,'rua aquilino ribeiro','carnaxide e queijas'),paragem(791,-103758.44,-94393.36,'bom','fechado dos lados','yes','vimeca',1,300,'avenida dos cavaleiros','carnaxide e queijas')).
aresta(paragem(183,-103678.36,-96590.26,'bom','fechado dos lados','yes','vimeca',1,286,'rua aquilino ribeiro','carnaxide e queijas'),paragem(595,-103705.46,-96673.6,'bom','aberto dos lados','yes','vimeca',1,286,'rua aquilino ribeiro','carnaxide e queijas')).
aresta(paragem(183,-103678.36,-96590.26,'bom','fechado dos lados','yes','vimeca',1,286,'rua aquilino ribeiro','carnaxide e queijas'),paragem(791,-103705.46,-96673.6,'bom','aberto dos lados','yes','vimeca',1,286,'rua aquilino ribeiro','carnaxide e queijas')).
%goal(791).
*/
:- multifile (-)/1.

%Trajeto entre dois pontos
%exemplo 97->1009
trajeto(Origem, Destino, Caminho) :-
    Historico = [Origem],
    pp(Origem, Destino, Historico, Caminho).

pp(Destino, Destino, Historico, D) :- inverso(Historico, D).

pp(Origem, Destino, Historico, D) :-
    aresta(paragem(Origem,_,_,_,_,_,_,_,_,_,_), paragem(Prox,_,_,_,_,_,_,_,_,_,_)),
    \+ member(Prox, Historico),
    pp(Prox, Destino, [Prox|Historico], D).

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

%Excluir um ou mais operadores de transporte para o percurso
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
maiorNumeroParagens(paragem(Origem,_,_,_,_,_,_,_,_,_,_), paragem(Destino,_,_,_,_,_,_,_,_,_,_), Lista, L) :-
    contaParagens(Origem, N),
    profundidadeConta(paragem(Origem,_,_,_,_,_,_,_,_,_,_), paragem(Destino,_,_,_,_,_,_,_,_,_,_), [(Origem,N)], Lista),
    ordena(Lista, Res),
    inverso(Res, L).

profundidadeConta(paragem(Destino,_,_,_,_,_,_,_,_,_,_), paragem(Destino,_,_,_,_,_,_,_,_,_,_), H, Lista) :-
    inverso(H, Lista).
    
profundidadeConta(paragem(Origem,_,_,_,_,_,_,_,_,_,_), paragem(Destino,_,_,_,_,_,_,_,_,_,_), H, Lista) :-
    aresta(paragem(Origem,_,_,_,_,_,_,_,_,_,_), paragem(Prox,_,_,_,_,_,_,_,_,_,_)),
    contaParagens(Prox, N),
    \+ member((Prox,N), H),
    profundidadeConta(paragem(Prox,_,_,_,_,_,_,_,_,_,_), paragem(Destino,_,_,_,_,_,_,_,_,_,_), [(Prox,N)|H], Lista). 

%Escolher o percurso que passe apenas por abrigos com publicidade 183->594
percursoComPublicidade(paragem(Origem,_,_,_,_,Publicidade,_,_,_,_,_), paragem(Destino,_,_,_,_,Publicidade2,_,_,_,_,_), C) :-
    member(Publicidade,['Yes']),
    member(Publicidade2,['Yes']),
    profundidadeComPublicidade(paragem(Origem,_,_,_,_,Publicidade,_,_,_,_,_), paragem(Destino,_,_,_,_,Publicidade2,_,_,_,_,_), [Origem], C).

profundidadeComPublicidade(paragem(Destino,_,_,_,_,Publicidade,_,_,_,_,_), paragem(Destino,_,_,_,_,Publicidade,_,_,_,_,_), H, C) :- inverso(H,C).

profundidadeComPublicidade(paragem(Origem,_,_,_,_,Publicidade,_,_,_,_,_), paragem(Destino,_,_,_,_,Publicidade2,_,_,_,_,_), H, C) :-
    aresta(paragem(Origem,_,_,_,_,Publicidade,_,_,_,_,_), paragem(Prox,_,_,_,_,PublicidadeProx,_,_,_,_,_)),
    member(PublicidadeProx, ['Yes']),
    \+ member(Prox, H),
    profundidadeComPublicidade(paragem(Prox,_,_,_,_,PublicidadeProx,_,_,_,_,_), paragem(Destino,_,_,_,_,Publicidade2,_,_,_,_,_), [Prox|H], C).

%Escolher o percurso que passe apenas por paragens abrigadas
percursoComAbrigo(paragem(Origem,_,_,_,Abrigo,_,_,_,_,_,_), paragem(Destino,_,_,_,Abrigo2,_,_,_,_,_,_), C) :-
    \+ member(Abrigo,['Sem Abrigo']),
    \+ member(Abrigo2,['Sem Abrigo']),
    profundidadeComAbrigo(paragem(Origem,_,_,_,_,Publicidade,_,_,_,_,_), paragem(Destino,_,_,_,_,Publicidade2,_,_,_,_,_), [Origem], C).

profundidadeComAbrigo(paragem(Destino,_,_,_,Abrigo,_,_,_,_,_,_), paragem(Destino,_,_,_,Abrigo,_,_,_,_,_,_), H, C) :- inverso(H,C).

profundidadeComAbrigo(paragem(Origem,_,_,_,Abrigo,_,_,_,_,_,_), paragem(Destino,_,_,_,Abrigo2,_,_,_,_,_,_), H, C) :-
    aresta(paragem(Origem,_,_,_,Abrigo,_,_,_,_,_,_), paragem(Prox,_,_,_,AbrigoProx,_,_,_,_,_,_)),
    \+ member(AbrigoProx, ['Sem Abrigo']),
    \+ member(Prox, H),
    profundidadeComAbrigo(paragem(Prox,_,_,_,AbrigoProx,_,_,_,_,_,_), paragem(Destino,_,_,_,Abrigo2,_,_,_,_,_,_), [Prox|H], C).

%Escolher um ou mais pontos intermédios por onde o percurso deverá passar
percursoComPontos(paragem(Origem,_,_,_,_,_,_,_,_,_,_), paragem(Destino,_,_,_,_,_,_,_,_,_,_), L, C) :-
    profundidadeComPontos(paragem(Origem,_,_,_,_,_,_,_,_,_,_), paragem(Destino,_,_,_,_,_,_,_,_,_,_), [Origem], L, C),
    pertence(L, C).

profundidadeComPontos(paragem(Destino,_,_,_,_,_,_,_,_,_,_), paragem(Destino,_,_,_,_,_,_,_,_,_,_), H, L, C) :- inverso(H,C).

profundidadeComPontos(paragem(Origem,_,_,_,_,_,_,_,_,_,_), paragem(Destino,_,_,_,_,_,_,_,_,_,_), H, L, C) :-
    aresta(paragem(Origem,_,_,_,_,_,_,_,_,_,_), paragem(Prox,_,_,_,_,_,_,_,_,_,_)),
    \+ member(Prox, H),
    profundidadeComPontos(paragem(Prox,_,_,_,_,_,_,_,_,_,_), paragem(Destino,_,_,_,_,_,_,_,_,_,_), [Prox|H], L, C).

%Escolher o percurso mais rápido (usando critério da distância) %183->526
goal(526).

resolve_gulosa_distancia(Nodo,Caminho/Custo) :-   paragem(Nodo,Latitude,Longitude,_,_,_,_,_,_,_,_),
                                        paragem(526,Latitude2,Longitude2,_,_,_,_,_,_,_,_),
                                        estima(Latitude, Longitude, Latitude2, Longitude2, Estima),
									    agulosa([[Nodo]/1/Estima],InvCaminho/Custo/_),
									    inverso(InvCaminho,Caminho).

agulosa(Caminhos,Caminho) :- obtem_melhor_g(Caminhos,Caminho),
							Caminho = [Nodo|_]/_/_,goal(Nodo).

agulosa(Caminhos,SolucaoCaminho) :- obtem_melhor_g(Caminhos,MelhorCaminho),
								   seleciona(MelhorCaminho,Caminhos,OutrosCaminhos),
								   expande_gulosa(MelhorCaminho,ExpCaminhos),
								   append(OutrosCaminhos,ExpCaminhos,NovoCaminhos),
								   agulosa(NovoCaminhos,SolucaoCaminho).
 
obtem_melhor_g([Caminho],Caminho):- !.

obtem_melhor_g([Caminho1/Custo1/Est1,_/Custo2/Est2|Caminhos],MelhorCaminho):- Est1 =< Est2,
																			  !,
																			  obtem_melhor_g([Caminho1/Custo1/Est1|Caminhos],MelhorCaminho).

																			
obtem_melhor_g([_|Caminhos],MelhorCaminho):- obtem_melhor_g(Caminhos,MelhorCaminho).

expande_gulosa(Caminho,ExpCaminhos):- findall(NovoCaminho,adjacente(Caminho,NovoCaminho),ExpCaminhos).


adjacente([Nodo|Caminho]/Custo/_, [ProxNodo,Nodo|Caminho]/NovoCusto/Est) :-
    aresta(paragem(Nodo,_,_,_,_,_,_,_,_,_,_), paragem(ProxNodo,Latitude,Longitude,_,_,_,_,_,_,_,_)),
    paragem(526,Latitude2,Longitude2,_,_,_,_,_,_,_,_),
    \+ member(ProxNodo, Caminho),
	NovoCusto is Custo + 1,
	estima(Latitude,Longitude,Latitude2,Longitude2,Est).

%Escolher o menor percurso (usando critério menor número de paragens)
%exemplo 185->595
%goal(595).

resolve_gulosa_paragens(Nodo,Caminho/Custo) :-  agulosa1([[Nodo]/1],InvCaminho/Custo),
									            inverso(InvCaminho,Caminho).

agulosa1(Caminhos,Caminho) :- obtem_melhor_g1(Caminhos,Caminho),
							Caminho = [Nodo|_]/_,goal(Nodo).

agulosa1(Caminhos,SolucaoCaminho) :- obtem_melhor_g1(Caminhos,MelhorCaminho),
								   seleciona(MelhorCaminho,Caminhos,OutrosCaminhos),
								   expande_gulosa1(MelhorCaminho,ExpCaminhos),
								   append(OutrosCaminhos,ExpCaminhos,NovoCaminhos),
								   agulosa1(NovoCaminhos,SolucaoCaminho).
 
obtem_melhor_g1([Caminho],Caminho):- !.

obtem_melhor_g1([Caminho1/Custo1,_/Custo2|Caminhos],MelhorCaminho):- Custo1 =< Custo2,
																			  !,
																			  obtem_melhor_g1([Caminho1/Custo1|Caminhos],MelhorCaminho).

																			
obtem_melhor_g1([_|Caminhos],MelhorCaminho):- obtem_melhor_g1(Caminhos,MelhorCaminho).

expande_gulosa1(Caminho,ExpCaminhos):- findall(NovoCaminho,adjacente1(Caminho,NovoCaminho),ExpCaminhos).


adjacente1([Nodo|Caminho]/Custo, [ProxNodo,Nodo|Caminho]/NovoCusto) :-
    aresta(paragem(Nodo,_,_,_,_,_,_,_,_,_,_), paragem(ProxNodo,_,_,_,_,_,_,_,_,_,_)),
    \+ member(ProxNodo, Caminho),
	NovoCusto is Custo + 1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Predicados Auxiliares %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ordena(List,Sorted):- b_sort(List,[],Sorted).
b_sort([],Acc,Acc).
b_sort([H|T],Acc,Sorted):- bubble(H,T,NT,Max), b_sort(NT,[Max|Acc],Sorted).
   
bubble((N,X),[],[],(N,X)).
bubble((N,X),[(N1,Y)|T],[(N1,Y)|NT],Max):- X>Y, bubble((N,X),T,NT,Max).
bubble((N,X),[(N1,Y)|T],[(N,X)|NT],Max):- X=<Y, bubble((N1,Y),T,NT,Max).

pertence([],_).
pertence([H|T],L):- pertence(T,L), member(H,L).

estima(Latitude, Longitude, Latitude2, Longitude2, D) :-
    D is sqrt((Latitude2-Latitude)^2 + (Longitude2-Longitude)^2).
    
contaParagens(Gid, N) :-
    findall(Gid, paragem(Gid,_,_,_,_,_,_,_,_,_,_), L),
    length(L, N).
    
inverso(Xs, Ys):-
	inverso(Xs, [], Ys).

inverso([], Xs, Xs).
inverso([X|Xs],Ys, Zs):-
	inverso(Xs, [X|Ys], Zs).

seleciona(E, [E|Xs], Xs).
seleciona(E, [X|Xs], [X|Ys]) :- seleciona(E, Xs, Ys).

%getMaiores([], M, []).
%getMaiores([(X,N)|T], M, [(X,N)|NewT]) :-
%    N == M,
%    getMaiores(T, M, NewT).
%getMaiores([(X,N)|T], M, NewT) :-
%    N \= M,
%    getMaiores(T, M, NewT).

%calculaMaior([], R, R). 
%calculaMaior([(N,X)|Xs], WK, R):- X >  WK, calculaMaior(Xs, X, R). 
%calculaMaior([(N,X)|Xs], WK, R):- X =< WK, calculaMaior(Xs, WK, R).
%calculaMaior([(N,X)|Xs], R):- calculaMaior(Xs, X, R). 