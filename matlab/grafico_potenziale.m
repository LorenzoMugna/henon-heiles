%% Definizione dati

N_INTERSEZIONI = 250;

syms qx qy px py;

T = px^2 + py^2;
U = 1/2*(qx^2 + qy^2) + qx^2 * qy - 1/3*qy^3;

% Creazione grafico
figure(1)
fsurf(@(qx, qy) 1/2*(qx.^2 + qy.^2) + qx.^2 .* qy - 1/3*qy.^3, [-3, 3, -3, 3])
colorbar
title('Potenziale di Hénon-Heiles')
xlabel('q_x')
ylabel('q_y')
zlabel('U(q_x, q_y)')
view(50,40)
saveas(gcf, 'img/potenziale_henon_heiles.png')