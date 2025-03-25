%% Definizioni delle funzioni del problema
syms qx qy px py;

T = (px^2 + py^2)/2;
U = 1/2*(qx^2 + qy^2) + qx^2 * qy - 1/3*qy^3;
H = T + U;
U_func = matlabFunction(U, 'vars', {[qx; qy]});

Jinv = [zeros(2), eye(2); -eye(2), zeros(2)];
NablaH = gradient(H, [qx, qy, px, py]);

F = Jinv * NablaH;
F = F(3:4);
f = matlabFunction(F, 'vars', {[qx; qy]});
