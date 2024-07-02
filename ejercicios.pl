mortal(Persona):-humano(Persona).
humano(socrates).
humano(platon).

habla(juan, espaniol).
habla(juan, ingles).
habla(juan, italiano).
habla(marcela, espaniol).
habla(hernan, aleman).

seComunican(Persona,OtraPersona):- habla(Persona,Idioma), habla(OtraPersona,Idioma), Persona \= OtraPersona.


quiere(juan ,playa).
quiere(juan , wifi).
quiere(juan , teatro).
quiere(ana ,sierra).
quiere(ana, playa).


lugar(mardel, playa).
lugar(mardel , wifi).
lugar(mardel , teatro).
lugar(mardel , casino).
lugar(tandil , sierra).
lugar(tandil , teatro).

tieneTodoParaVeranear(Lugar,Persona):-lugarVeraneo(Lugar), persona(Persona),forall(quiere(Persona, Algo), lugar(Lugar, Algo)).

lugarVeraneo(Lugar):-lugar(Lugar,_).
persona(Persona):-quiere(Persona,_).


contador(roque).
joven(roque).
trabajoEn(roque,acme).
trabajoEn(jose,acme).
trabajoEn(ana,omni).
trabajoEn(lucia,omni).
trabajoEn(julia, fiat).
honesto(roque).
habla(roque,frances).
habla(ana,ingles).
habla(ana,frances).
habla(lucia,ingles).
habla(lucia,frances).
habla(cecilia,frances).
abogado(cecilia).
ingeniero(ana).
ingeniero(julia).
ambicioso(cecilia).
ambicioso(jose).
ambicioso(Persona):-contador(Persona),joven(Persona).
experiencia(Persona):-trabajoEn(Persona, _).
profesional(Persona):-contador(Persona).
profesional(Persona):-abogado(Persona).
profesional(Persona):-ingeniero(Persona).
puedeAndar(comercioExterior, Persona):- ambicioso(Persona).
puedeAndar(contaduria, Persona):- contador(Persona), honesto(Persona).
puedeAndar(ventas, Persona):- ambicioso(Persona), experiencia(Persona).
puedeAndar(ventas, lucia).
puedeAndar(proyectos, Persona):- ingeniero(Persona), experiencia(Persona).
puedeAndar(proyectos, Persona):- abogado(Persona), joven(Persona).
puedeAndar(logistica, Persona):- profesional(Persona), cumpleCondiciones(Persona).
cumpleCondiciones(Persona):- joven(Persona).
cumpleCondiciones(Persona):- trabajoEn(Persona, omni).

