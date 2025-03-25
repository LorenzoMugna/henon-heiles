%% Definizione dati
syms qx qy px py;

T = px^2 + py^2;
U = 1/2*(qx^2 + qy^2) + qx^2 * qy - 1/3*qy^3;
U_func = matlabFunction(U, 'vars', {[qx; qy]});

Hamiltonian = T + U;
Jinv = [zeros(2), eye(2); -eye(2), zeros(2)];
NablaH = gradient(Hamiltonian, [qx, qy, px, py]);
F = Jinv * NablaH;
F = F(3:4);
f = matlabFunction(F, 'vars', {[qx; qy]});
% Creazione grafico
figure(1)
fsurf(@(qx, qy) U_func([qx;qy]), [-3, 3, -3, 3])
colorbar
title('Potenziale di Hénon-Heiles')
xlabel('q_x')
ylabel('q_y')
zlabel('U(q_x, q_y)')
view(50,40)
% saveas(gcf, 'img/potenziale_henon_heiles.png')
% matlab2tikz('latex/potenziale_henon_heiles.tex')
figure(2)
hold on
x = linspace(-1.1, 1.1, 500); 
y = linspace(-1.1, 1.1, 500); 
[X, Y] = meshgrid(x, y); 
Z = U_func([X(:)'; Y(:)']); 
Z = reshape(Z, size(X)); 


contourf(X, Y, Z, [0:30]/40, 'LineColor', 'k') % Filled contour plot with 20 levels
colorbar
title('Curve di livello del potenziale di Hénon-Heiles')
xlabel('q_x')
ylabel('q_y')
contour(X, Y, Z, [1/6,1/6], 'LineColor', 'r')
plot(0,0, 'r.')

%% animazione simulazione sul grafico appena disegnato
H = 1/8;
qx=0;
qy=1/2;
py=0.2;
px=sqrt(2*(H-U_func([qx;qy]))-py^2);
p = [px; py];
q = [qx; qy];
p_handle = plot(q(1), q(2), 'o', 'MarkerSize', 5, 'MarkerFaceColor', 'r')
while true
	for i = 1:20
		[p, q] = stormerverlet(p,q, 0.01, f);
	end
	set(p_handle, 'XData', qfrom(1), 'YData', q(2))
	drawnow
	if qx < 0
		break
	end
end