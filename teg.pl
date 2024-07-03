continente(americaDelSur).
continente(americaDelNorte).
continente(asia).
continente(oceania).

estaEn(americaDelSur, argentina).
estaEn(americaDelSur, brasil).
estaEn(americaDelSur, chile).
estaEn(americaDelSur, uruguay).
estaEn(americaDelNorte, alaska).
estaEn(americaDelNorte, yukon).
estaEn(americaDelNorte, canada).
estaEn(americaDelNorte, oregon).
estaEn(asia, kamtchatka).
estaEn(asia, china).
estaEn(asia, siberia).
estaEn(asia, japon).
estaEn(oceania,australia).
estaEn(oceania,sumatra).
estaEn(oceania,java).
estaEn(oceania,borneo).

jugador(amarillo).
jugador(magenta).
jugador(negro).
jugador(blanco).

aliados(X,Y):- alianza(X,Y).
aliados(X,Y):- alianza(Y,X).
alianza(amarillo,magenta).

%el numero son los ejercitos
ocupa(argentina, magenta, 5).
ocupa(chile, negro, 3).
ocupa(brasil, amarillo, 8).
ocupa(uruguay, magenta, 5).
ocupa(alaska, amarillo, 7).
ocupa(yukon, amarillo, 1).
ocupa(canada, amarillo, 10).
ocupa(oregon, amarillo, 5).
ocupa(kamtchatka, negro, 6).
ocupa(china, amarillo, 2).
ocupa(siberia, amarillo, 5).
ocupa(japon, amarillo, 7).
ocupa(australia, negro, 8).
ocupa(sumatra, negro, 3).
ocupa(java, negro, 4).
ocupa(borneo, negro, 1).

% Usar este para saber si son limitrofes ya que es una relacion simetrica
sonLimitrofes(X, Y) :- limitrofes(X, Y).
sonLimitrofes(X, Y) :- limitrofes(Y, X).

limitrofes(argentina,brasil).
limitrofes(argentina,chile).
limitrofes(argentina,uruguay).
limitrofes(uruguay,brasil).
limitrofes(alaska,kamtchatka).
limitrofes(alaska,yukon).
limitrofes(canada,yukon).
limitrofes(alaska,oregon).
limitrofes(canada,oregon).
limitrofes(siberia,kamtchatka).
limitrofes(siberia,china).
limitrofes(china,kamtchatka).
limitrofes(japon,china).
limitrofes(japon,kamtchatka).
limitrofes(australia,sumatra).
limitrofes(australia,java).
limitrofes(australia,borneo).
limitrofes(australia,chile).

objetivo(amarillo, ocuparContinente(asia)).
objetivo(amarillo,ocuparPaises(2, americaDelSur)). 
objetivo(blanco, destruirJugador(negro)). 
objetivo(magenta, destruirJugador(blanco)). 
objetivo(negro, ocuparContinente(oceania)).
objetivo(negro,ocuparContinente(americaDelSur)). 

% Relaciona jugador, continente y cantidad de paises.
/* Este predicado NO DEBERIA estar hecho con hechos, deberia deducirse de los anteriores. Pero para hacerlo correctamente todavía no tenemos los conceptos (mas adelante se veran), asi que por ahora los dejamos asi */
cuantosPaisesOcupaEn(amarillo, americaDelSur, 1).
cuantosPaisesOcupaEn(amarillo, americaDelNorte, 4).
cuantosPaisesOcupaEn(amarillo, asia, 3).
cuantosPaisesOcupaEn(amarillo, oceania, 0).
cuantosPaisesOcupaEn(magenta, americaDelSur, 2).
cuantosPaisesOcupaEn(magenta, americaDelNorte, 0).
cuantosPaisesOcupaEn(magenta, asia, 0).
cuantosPaisesOcupaEn(magenta, oceania, 0).
cuantosPaisesOcupaEn(negro, americaDelSur, 1).
cuantosPaisesOcupaEn(negro, americaDelNorte, 0).
cuantosPaisesOcupaEn(negro, asia, 1).
cuantosPaisesOcupaEn(negro, oceania, 4)


loliquidaron(Jugador):- jugador(Jugador), not(ocupa(_, Jugador, _)).

ocupaContinente(Jugador, Continente):- jugador(Jugador), continente(Continente), 
       forall(estaEn(Continente, Pais), ocupa(Pais, Jugador, _)).


elQueTieneMasEjercitos(Jugador, Pais):-ocupa(Pais, Jugador, Ejercitos), 
    forall(ocupa(_, OtroJugador, CantEjercitos), CantEjercitos =< Ejercitos).


%elQueTieneMasEjercitos(Jugador, Pais).
%Jugador = amarillo,
%Pais = canada ;

cumpleObjetivos(Jugador):- jugador(Jugador), 
    forall(objetivos(Jugador, Objetivo), objetivoRealizado(Objetivo, Jugador)).

objetivoRealizado(ocuparContinente(Continente), Jugador):- ocupaContinente(Jugador, Continente).
objetivoRealizado(ocuparPaises(Cant, Continente), Jugador):-cantidadDePaises(Jugador, Continente, Cantidad), Cantidad >= Cant.
objetivoRealizado(destruirJugador(JugadorObjetivo), _):- loliquidaron(JugadorObjetivo).

cantidadDePaises(Jugador, Continente, Cantidad):- 
    findall(Pais, esOcupadoPor(Pais, Continente, Jugador), Lista), length(Lista, Cantidad).

esOcupadoPor(Pais, Continente, Jugador):- estaEn(Continente, Pais), ocupa(Pais, Jugador,_).


