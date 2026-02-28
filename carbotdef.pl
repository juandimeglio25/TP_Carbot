% 1. BASE DE DATOS DINÁMICA
:- dynamic auto/6.

% 2. CHAT
:- dynamic estado_chat/1.
estado_chat(inicio).

% --- NIVEL 0: MENÚ PRINCIPAL ---
transicion(inicio, elegir_ventas, preguntando_tipo).
transicion(inicio, elegir_taller, menu_taller).

% --- RAMA A: VENTAS ---
transicion(preguntando_tipo, recibir_tipo, preguntando_minimo).
transicion(preguntando_minimo, recibir_min, preguntando_maximo).
transicion(preguntando_maximo, recibir_max, recomendando).

% Bucle de retorno
transicion(recomendando, no_convence, preguntando_tipo).

% Negociación
transicion(recomendando, interesar, eligiendo_pago).
transicion(eligiendo_pago, pago_contado, preparando_ruta).
transicion(eligiendo_pago, pago_cuotas, seleccionando_plazo).
transicion(seleccionando_plazo, confirmar_plazo, preparando_ruta).

% Logística
transicion(preparando_ruta, iniciar_viaje, calculando_ruta).
transicion(calculando_ruta, termino_ruta, ofreciendo_info).

% Contacto
transicion(ofreciendo_info, aceptar_info, pedir_contacto).
transicion(ofreciendo_info, rechazar_info, finalizar).

% Cierre
transicion(pedir_contacto, verificar_numero, validando_numero).
transicion(validando_numero, finalizar, inicio).

% --- RAMA B: TALLER ---
transicion(menu_taller, service_oficial, agendando_turno).
transicion(menu_taller, reparacion, agendando_turno).
transicion(agendando_turno, confirmar_turno, finalizar).

% Cierre Global (Para cualquier estado que vaya a finalizar)
transicion(finalizar, cerrar, inicio).

% Regla de Avance
avanzar_estado(Evento) :-
    estado_chat(EstadoActual),
    transicion(EstadoActual, Evento, NuevoEstado),
    retract(estado_chat(EstadoActual)),
    assert(estado_chat(NuevoEstado)).

% 3. SISTEMA EXPERTO (REGLAS DE NEGOCIO)

recomendar_rango(TipoBuscado, Min, Max, ListaResultados) :-
    findall(
        [Marca, Modelo, Version, Anio, Precio],
        (
            auto(Marca, Modelo, TipoReal, Version, Anio, Precio),
            Precio >= Min,
            Precio =< Max,
            sub_atom(TipoReal, _, _, _, TipoBuscado)
        ),
        ListaResultados
    ).

% 4. GRAFO LOGÍSTICO (AMBA y CABA)

% --- NODOS ---
agencia(caba1, 'Kansai (Caballito)').
agencia(caba2, 'Ford Dietrich').
agencia(caba3, 'Volkswagen Alra').
agencia(caba4, 'Espasa VW (Pto Madero)').
agencia(caba5, 'Collins Chevrolet').
agencia(caba6, 'Mapemfi').
agencia(norte1, 'Car One (Tortuguitas)').
agencia(norte2, 'Autodelta (Polvorines)').
agencia(norte3, 'Audi Norden (San Isidro)').
agencia(sur1, 'Strianese Ford (Lomas)').
agencia(sur2, 'Autos del Sur (Quilmes)').
agencia(sur3, 'Del Sur Autos (Lanús)').
agencia(oeste1, 'Del Oeste (San Justo)').
agencia(oeste2, 'Vehículos Del Oeste').
agencia(oeste3, 'LNG Olivieri (Ciudadela)').

% --- ARISTAS (DISTANCIAS REALES KM) ---
ruta(caba1, caba2, 4). ruta(caba1, caba3, 4). ruta(caba1, caba4, 9).
ruta(caba1, caba5, 7). ruta(caba1, caba6, 7). ruta(caba1, norte1, 39).
ruta(caba1, norte2, 34). ruta(caba1, norte3, 23). ruta(caba1, sur1, 20).
ruta(caba1, sur2, 26). ruta(caba1, sur3, 13). ruta(caba1, oeste1, 15).
ruta(caba1, oeste2, 15). ruta(caba1, oeste3, 11).
ruta(caba2, caba3, 3). ruta(caba2, caba4, 6). ruta(caba2, caba5, 9).
ruta(caba2, caba6, 4). ruta(caba2, norte1, 40). ruta(caba2, norte2, 35).
ruta(caba2, norte3, 22). ruta(caba2, sur1, 22). ruta(caba2, sur2, 25).
ruta(caba2, sur3, 15). ruta(caba2, oeste1, 19). ruta(caba2, oeste2, 19).
ruta(caba2, oeste3, 14).
ruta(caba3, caba4, 9). ruta(caba3, caba5, 6). ruta(caba3, caba6, 7).
ruta(caba3, norte1, 37). ruta(caba3, norte2, 32). ruta(caba3, norte3, 19).
ruta(caba3, sur1, 24). ruta(caba3, sur2, 28). ruta(caba3, sur3, 17).
ruta(caba3, oeste1, 18). ruta(caba3, oeste2, 18). ruta(caba3, oeste3, 13).
ruta(caba4, caba5, 15). ruta(caba4, caba6, 2). ruta(caba4, norte1, 46).
ruta(caba4, norte2, 41). ruta(caba4, norte3, 27). ruta(caba4, sur1, 21).
ruta(caba4, sur2, 20). ruta(caba4, sur3, 13). ruta(caba4, oeste1, 24).
ruta(caba4, oeste2, 23). ruta(caba4, oeste3, 20).
ruta(caba5, caba6, 13). ruta(caba5, norte1, 32). ruta(caba5, norte2, 27).
ruta(caba5, norte3, 18). ruta(caba5, sur1, 25). ruta(caba5, sur2, 33).
ruta(caba5, sur3, 19). ruta(caba5, oeste1, 14). ruta(caba5, oeste2, 14).
ruta(caba5, oeste3, 8).
ruta(caba6, norte1, 44). ruta(caba6, norte2, 39). ruta(caba6, norte3, 25).
ruta(caba6, sur1, 21). ruta(caba6, sur2, 21). ruta(caba6, sur3, 13).
ruta(caba6, oeste1, 22). ruta(caba6, oeste2, 21). ruta(caba6, oeste3, 18).
ruta(norte1, norte2, 6). ruta(norte1, norte3, 23). ruta(norte1, sur1, 56).
ruta(norte1, sur2, 65). ruta(norte1, sur3, 51). ruta(norte1, oeste1, 36).
ruta(norte1, oeste2, 36). ruta(norte1, oeste3, 33).
ruta(norte2, norte3, 21). ruta(norte2, sur1, 50). ruta(norte2, sur2, 60).
ruta(norte2, sur3, 46). ruta(norte2, oeste1, 30). ruta(norte2, oeste2, 31).
ruta(norte2, oeste3, 27).
ruta(norte3, sur1, 43). ruta(norte3, sur2, 47). ruta(norte3, sur3, 36).
ruta(norte3, oeste1, 30). ruta(norte3, oeste2, 30). ruta(norte3, oeste3, 24).
ruta(sur1, sur2, 18). ruta(sur1, sur3, 8). ruta(sur1, oeste1, 21).
ruta(sur1, oeste2, 20). ruta(sur1, oeste3, 23).
ruta(sur2, sur3, 16). ruta(sur2, oeste1, 35). ruta(sur2, oeste2, 34).
ruta(sur2, oeste3, 34).
ruta(sur3, oeste1, 20). ruta(sur3, oeste2, 19). ruta(sur3, oeste3, 19).
ruta(oeste1, oeste2, 1). ruta(oeste1, oeste3, 6). ruta(oeste2, oeste3, 6).

% Helper de Navegación
conexion_directa(A,B,D) :- ruta(A,B,D).
conexion_directa(A,B,D) :- ruta(B,A,D).

distancia_real(Inicio, Fin, Distancia) :-
    navegar(Inicio, Fin, [Inicio], Distancia).

navegar(A, B, _, D) :- conexion_directa(A, B, D).
navegar(A, B, Visitados, Total) :-
    conexion_directa(A, X, D1),
    X \== B,
    \+ member(X, Visitados),
    navegar(X, B, [X|Visitados], D2),
    Total is D1 + D2.


% 5. ALGORITMO TSP (LOGÍSTICA - CICLO HAMILTONIANO)

permutacion([], []).
permutacion(L, [H|T]) :- seleccionar(H, L, R), permutacion(R, T).
seleccionar(E, [E|T], T).
seleccionar(E, [H|T], [H|R]) :- seleccionar(E, T, R).

% --- Algoritmo Exacto (Fuerza Bruta con Retorno) ---
ruta_optima(Inicio, Destinos, RutaOptima, CostoMinimo) :-
    findall(pack(R,C), (
        permutacion(Destinos,P),
        append(P, [Inicio], P_Retorno), % CAMBIO 1: Agregamos el Inicio al final de la ruta
        R=[Inicio|P_Retorno],
        calcular_costo_ruta(Inicio,P_Retorno,C)
    ), L),
    (L \= [] -> sort(2, @=<, L, [pack(RutaOptima, CostoMinimo)|_]) ; RutaOptima=[], CostoMinimo=999).

calcular_costo_ruta(_, [], 0).
calcular_costo_ruta(Actual, [Sig|Resto], Total) :-
    (distancia_real(Actual, Sig, D) -> true ; D=999),
    calcular_costo_ruta(Sig, Resto, Sub), Total is D + Sub.

% --- Algoritmo Aproximado (Greedy con Retorno) ---
ruta_aproximada(Inicio, Destinos, RutaFinal, CostoTotal) :-
    % Paso 'Inicio' como un parámetro extra para que no lo olvide en la recursión
    greedy(Inicio, Destinos, Inicio, Ruta, CostoTotal),
    RutaFinal = [Inicio|Ruta].

% Caso base. Si no quedan destinos, la ruta es volver al inicio y el costo es esa distancia.
greedy(Actual, [], InicioOriginal, [InicioOriginal], Total) :-
    (distancia_real(Actual, InicioOriginal, Total) -> true ; Total=999).

greedy(Actual, Restantes, InicioOriginal, [Sig|Resto], Total) :-
    encontrar_mas_cercano_gps(Actual, Restantes, Sig, D),
    select(Sig, Restantes, Nuevos),
    greedy(Sig, Nuevos, InicioOriginal, Resto, Sub), Total is D + Sub.

encontrar_mas_cercano_gps(Actual, Cands, Mejor, MenorD) :-
    findall(pack(D, Dest), (member(Dest, Cands), distancia_real(Actual, Dest, D)), L),
    sort(1, @=<, L, [pack(MenorD, Mejor)|_]).

% 6. MÁQUINA DE TURING (VALIDADOR CELULAR)

es_digito(X) :- member(X, ['0','1','2','3','4','5','6','7','8','9']).

validar_celular(L) :- turing_cel(q0, L, 0).

% q0: Decisión de Zona
turing_cel(q0, ['1'|T], 0) :- turing_cel(q_amba, T, 0).
turing_cel(q0, ['2'|T], 0) :- turing_cel(q_interior, T, 0).

% Rama AMBA (11...)
turing_cel(q_amba, ['1'|T], 0) :- turing_cel(q_contar, T, 0, 8).

% Rama Interior (2...)
turing_cel(q_interior, ['2'|T], 0) :- turing_cel(q_lp, T, 0).    % 22...
turing_cel(q_interior, ['3'|T], 0) :- turing_cel(q_pilar, T, 0). % 23...
turing_cel(q_lp,       ['1'|T], 0) :- turing_cel(q_contar, T, 0, 7). % 221...
turing_cel(q_pilar,    ['0'|T], 0) :- turing_cel(q_contar, T, 0, 7). % 230...

% Contador General
turing_cel(q_contar, [N|T], C, Meta) :-
    es_digito(N), C2 is C + 1, turing_cel(q_contar, T, C2, Meta).
turing_cel(q_contar, [], Meta, Meta).


% 8. GRAMÁTICA DE PATENTES (VALIDACIÓN SEMÁNTICA)

% Valida los dos formatos de patentes argentinas
% Predicado principal para llamar desde Python
validar_patente(Lista) :- phrase(formato_patente, Lista).

% 1. Formato Viejo: 3 Letras + 3 Números (Ej: abc 123)
formato_patente --> letra, letra, letra, numero, numero, numero.

% 2. Formato Mercosur: 2 Letras + 3 Números + 2 Letras
% La primera letra ahora usa 'letra_mercosur_inicio' en vez de 'letra' general.
formato_patente --> letra_mercosur_inicio, letra, numero, numero, numero, letra, letra.

% --- Definiciones de Terminales ---

% Letras válidas (a-z) para formato viejo y resto de las letras
letra --> [L], { member(L, ['a','b','c','d','e','f','g','h','i','j','k','l','m',
                            'n','o','p','q','r','s','t','u','v','w','x','y','z']) }.

% En Argentina, las patentes Mercosur actuales SOLO empiezan con la letra 'a'.
letra_mercosur_inicio --> [L], { member(L, ['a']) }.

% Números válidos (0-9)
numero --> [N], { member(N, ['0','1','2','3','4','5','6','7','8','9']) }.
