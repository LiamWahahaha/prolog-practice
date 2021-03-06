% Legal moves

% Grasp banana
move(state(middle, onbox, middle, hasnot),
     grasp,
     state(middle, onbox, middle, has)).

% Climb box
move(state(P, onfloor, P, H),
     climb,
     state(P, onbox, P, H)).

% Push box
move(state(P1, onfloor, P1, H),
     push(P1, P2),
     state(P2, onfloor, P2, H)).

% Walk around
move(state(P1, onfloor, B, H),
     walk(P1, P2),
     state(P2, onfloor, B, H)).

% canget(State): monkey can get banana in State
canget(state(_, _, _, has)).
canget(State1) :-
    move(State1, _, State2),
    canget(State2).

% get plan
canget(state(_, _, _, has), []).
canget(State, [Action|Actions]) :-
    move(State, Action, New_State),
    canget(New_State, Actions).
