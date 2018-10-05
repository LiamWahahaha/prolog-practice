% helper functions
member(H, [H|_]).
member(H, [Y|T]) :-
    H \= Y,
    member(H, T).

list2set([], []).
list2set([E|Es], Set) :-
    member(E, Es),
    !,
    list2set(Es, Set).
list2set([E|Es], [E|Set]) :-
    list2set(Es, Set).

union([], List, List).
union([H|T], List, Result) :-
    member(H, List),!,
    union(T, List, Result).
union([H|T], List, [H|Result]):-
    union(T, List, Result).

len([], 0).
len([_|T], N) :-
    len(T, N1),
    N is N1 + 1.
same_length(List1, List2) :-
    len(List1, N1),
    len(List2, N2),
    N1 = N2.

% minRoleAssignmentsWithHierarchy(S) :- output the number of users to permissions
minRoleAssignmentsWithHierarchy(S) :-
    users(N),
    count_perms(N, 0, S).

count_perms(0, Users_To_Perms, Users_To_Perms) :-
    !.
count_perms(M, Current_Count, Final_Count) :-
    M > 0,
    user_total_perms(M, Total_Perms),
    len(Total_Perms, Perm_Count),
    write(M), write(','), write(Total_Perms), write(','), write(Perm_Count), nl,
    New_Count is Perm_Count + Current_Count,
    M1 is M - 1,
    count_perms(M1, New_Count, Final_Count).

user_total_roles(N, Total_Roles) :-
    ur_roles(N, Roles),
    ur_hierarchy(Roles, Roles, [], Total_Roles).

user_total_perm_roles(N, Perm_Roles) :-
    ur_roles(N, Roles),
    ur_hierarchy(Roles, Roles, [], Total_Roles),
    roles_with_perms(Total_Roles, Perm_Roles).

user_total_perms(N, Total_Perms) :-
    ur_roles(N, Roles),
    ur_hierarchy(Roles, Roles, [], Total_Roles),
    roles_with_perms(Total_Roles, Perm_Roles),
    user_total_perms_helper(Perm_Roles,[], Total_Perms).

user_total_perms_helper([], Total_Perms, Total_Perms).
user_total_perms_helper([Head_Perm_Role|Tail_Perm_Roles], Before_Acc, After_Acc) :-
    findall(Perm, rp(_, Head_Perm_Role, Perm), Perm_List),
    list2set(Perm_List, Perm_Set),
    union(Perm_Set, Before_Acc, New_Acc),
    user_total_perms_helper(Tail_Perm_Roles, New_Acc, After_Acc).

ur_roles(N, Role_Set) :-
    findall(User_Role, ur(_, N, User_Role), Role_List),
    list2set(Role_List, Role_Set).

ur_hierarchy([], Origin_Rs, New_Rs, Total_Rs) :-
    not(same_length(Origin_Rs, New_Rs)),
    ur_hierarchy(New_Rs, New_Rs, [], Total_Rs).
ur_hierarchy([], Total_Rs, Total_Rs, Total_Rs):- !.
ur_hierarchy([Head_BR|Tail_BRs], BRs, Before_Acc, After_Acc) :-
    findall(Sub_Role, rh(_, Head_BR, Sub_Role), Sub_Role_List),
    list2set(Sub_Role_List, Sub_Role_Set),
    union(Sub_Role_Set, BRs, Partial_Set),
    union(Partial_Set, Before_Acc, Union_Set),
    ur_hierarchy(Tail_BRs, BRs, Union_Set, After_Acc).

roles_with_perms(Total_Roles, Valid_Roles):-
    roles_with_perms(Total_Roles, [], Valid_Roles).
roles_with_perms([], Role_W_Perm, Role_W_Perm).
roles_with_perms([Head_Role|Tail_Roles], Before_Acc, After_Acc) :-
    rp(_, Head_Role, _),
    !,
    roles_with_perms(Tail_Roles, [Head_Role|Before_Acc], After_Acc).
roles_with_perms([_|Tail_Roles], Before_Acc, After_Acc) :-
    roles_with_perms(Tail_Roles, Before_Acc, After_Acc).
