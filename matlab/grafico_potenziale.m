%% Definizione dati
run('funzioni_comuni.m');
% Creazione grafico
figure(1)
fsurf(@(qx, qy) U_func([qx;qy]), [-3, 3, -3, 3])
colorbar
title('Potenziale di Hénon-Heiles')
xlabel('q_x')
ylabel('q_y')
zlabel('U(q_x, q_y)')
view(50,40)

figure(2)
hold on
x = linspace(-1.1, 1.1, 500); 
y = linspace(-1.1, 1.1, 500); 
[X, Y] = meshgrid(x, y); 
Z = U_func([X(:)'; Y(:)']); 
Z = reshape(Z, size(X)); 


contourf(X, Y, Z, [0:30]/40, 'LineColor', 'k')
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
p_handle = plot(q(1), q(2), 'o', 'MarkerSize', 5, 'MarkerFaceColor', 'r');
while true
	for i = 1:20
		[p, q] = stormerverlet(p,q, 0.01, f);
	end
	set(p_handle, 'XData', q(1), 'YData', q(2))
	drawnow
end