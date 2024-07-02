progenitor(mona, homero).
progenitor(jaqueline, marge).
progenitor(marge, maggie).
progenitor(marge, bart).
progenitor(marge, lisa).
progenitor(abraham, herbert).
progenitor(abraham, homero).
progenitor(clancy, jaqueline).
progenitor(homero, maggie).
progenitor(homero, bart).
progenitor(homero, lisa).

ancestro(Ancestro, Descendiente):- progenitor(Ancestro, Descendiente).
ancestro(Ancestro,Descendiente):- progenitor(Progenitor, Descendiente),
                ancestro(Ancestro, Progenitor).


encolar(Elem, [], [Elem]).
encolar(Elem, [Cab|Cola], [Cab|OtraCola]):- encolar(Elem, Cola, OtraCola).


maximo(Lista, Max):- member(Max, Lista), 
                    forall(member(Otro, Lista), Otro =< Max).

interseccion(Lista, OtraLista, Interseccion):- 
findall(Elem, (member(Elem, Lista), member(Elem, OtraLista)),  Interseccion).


esCreciente([_]).
esCreciente([Cab, OtraCab | Cola]):- Cab < OtraCab, esCreciente([OtraCab| Cola]).


sublistaMayoresA([], _ , []).
sublistaMayoresA([Cab| Cola], Elem, [Cab|OtraCola]):- Cab > Elem,
        sublistaMayoresA(Cola, Elem, OtraCola).
sublistaMayoresA([_|Cola], Elem, Lista):- sublistaMayoresA(Cola, Elem, Lista).


%1] 15 ?- sublistaMayoresA([3, 8, 9, 1, 4], 3 ,Lista).
%Lista = [8, 9, 4] ;
%Lista = [8, 9] ;
%Lista = [8, 4] ;
%Lista = [8] ;
%Lista = [9, 4] ;
%Lista = [9] ;
%Lista = [4] ;
%Lista = [].


generogenero(titanic,drama).
genero(gilbertGrape,drama).
genero(atrapameSiPuedes,comedia).
genero(ironMan,accion).
genero(rapidoYFurioso,accion).
genero(elProfesional,drama).

gusta(belen,titanic).
gusta(belen,gilbertGrape).
gusta(belen,elProfesional).
gusta(juan, ironMan).
gusta(pedro, atrapameSiPuedes).
gusta(pedro, rapidoYFurioso).

%1
soloLeGustaPeliculaDeGenero(Persona, Genero):-persona(Persona), generoPelicula(Genero),
        forall(gusta(Persona, Pelicula), genero(Pelicula, Genero)).


persona(Persona):-gusta(Persona, _).
generoPelicula(Genero):- genero(_, Genero).

%2
peliculasQueLeGustaPorGenero(Persona, Genero, Peliculas):- persona(Persona), 
    generoPelicula(Genero), 
    findall(Pelicula, (gusta(Persona, Pelicula), genero(Pelicula, Genero)), Peliculas).



    madre(mona, homero).
madre(jaqueline, marge).
madre(marge, maggie).
madre(marge, bart).
madre(marge, lisa).
padre(abraham, herbert).
padre(abraham, homero).
padre(clancy, jaqueline).
padre(homero, maggie).
padre(homero, bart).
padre(homero, lisa).

hermano(UnHermano, OtroHermano):- mismaMadre(UnHermano, OtroHermano), 
    mismoPadre(UnHermano, OtroHermano).

mismaMadre(UnHermano, OtroHermano):- madre(Madre, UnHermano), madre(Madre, OtroHermano), 
            UnHermano \= OtroHermano.
mismoPadre(UnHermano, OtroHermano):- padre(Padre, UnHermano),padre(Padre, OtroHermano),
            UnHermano \= OtroHermano.

tio(Tio, Sobrino):-hijoDe(Sobrino, Progenitor), esHermanoOMedioHermano(Progenitor, Tio).

esHermanoOMedioHermano(Progenitor, Tio):- hermano(Progenitor, Tio).
esHermanoOMedioHermano(Progenitor, Tio):- medioHermano(Progenitor, Tio).

medioHermano(Persona, OtraPersona):-mismaMadre(Persona, OtraPersona), not(mismoPadre(Persona, OtraPersona)).
medioHermano(Persona, OtraPersona):-mismoPadre(Persona, OtraPersona), not(mismaMadre(Persona, OtraPersona)).


hijoDe(Persona, Madre):- madre(Madre, Persona).
hijoDe(Persona, Padre):- padre(Padre,Persona).