%% Inizializzazione

% Calcoli simbolici
syms qx qy px py;

T = (px^2 + py^2)/2;
U = 1/2*(qx^2 + qy^2) + qx^2 * qy - 1/3*qy^3;
H = T + U;

Jinv = [zeros(2), eye(2); -eye(2), zeros(2)];
NablaH = gradient(H, [qx, qy, px, py]);

F = Jinv * NablaH;
F = F(3:4);
f = matlabFunction(F, 'vars', {[qx; qy]});
% Parametri simulazione
N_INTERSEZIONI = 400;
TIMEOUT = 5000;
h = 0.01;
livelli_energetici = [1/12, 1/10, 1/8, 1/6, 1/4];
QY0 = [0.1, 0.2, 0.3, 0.4, 0.5,0.1, 0.2, 0.3, 0.4, 0.5];
PY0 = [0,0,0,0,0,0,-0.09, 0.2, 0.1, 0.06, 0.04];

%% Simulazione
for energia = livelli_energetici
	intersezioni_totali = [];
	err_hamiltoniana = [];
	parfor posizione_indice = 1:size(QY0,2)
		posizione = QY0(posizione_indice);
		u = matlabFunction(U, 'vars', {[qx; qy]});
		% Condizioni iniziali
		qx0 = 0;
		qy0 = posizione;
		py0 = PY0(posizione_indice);
		px0 = sqrt(2*(energia - u([qx0; qy0])-1/2*py0^2));

		% Størmer-Verlet
		q = [qx0; qy0];
		p = [px0; py0];
		intersezioni = 0;
		test_timeout = 0;
		local_points = [];
		while intersezioni < N_INTERSEZIONI
			[pn, qn] = stormerverlet(p, q, h, f);

			if sign(q(1)) ~= sign(qn(1)) | qn(1) == 0
				intersezioni = intersezioni + 1;
				local_points = [local_points; qn(2), pn(2)];
				% calcolo energia (solo primo worker)
				if posizione == QY0(1)
					ham = matlabFunction(H, 'vars', {[qx, qy, px, py]});
					err_hamiltoniana = [err_hamiltoniana; ham([qn(1), qn(2), pn(1), pn(2)])];
				end
				test_timeout = 0;
			end

			[q, p] = deal(qn, pn);

			test_timeout = test_timeout + 1;
			if test_timeout > TIMEOUT
				disp('Timeout, il punto non ha raggiunto il piano di Poincaré');
				break;
			end
		end
		intersezioni_totali = [intersezioni_totali, local_points]
	end

	%Creazione grafico
	creazione_grafico(energia, intersezioni_totali, err_hamiltoniana);
end
