% test case
users(4).
roles(5).
perms(6).

ur(1, 1, 1).
ur(2, 1, 2).
ur(3, 1, 5).
ur(4, 2, 2).
ur(5, 3, 3).
ur(6, 4, 5).
urs(6).

rp(1, 1, 1).
rp(2, 1, 2).
rp(3, 3, 3).
rp(4, 3, 4).
rp(5, 4, 5).
rp(6, 4, 6).
rp(7, 5, 6).
rps(7).

rh(1, 2, 1).
rh(2, 2, 3).
rh(3, 2, 5).
rh(4, 5, 4).
rhs(4).

% Number of Users and Perms should be 16.
