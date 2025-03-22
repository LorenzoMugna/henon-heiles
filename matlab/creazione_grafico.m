%% Creazione grafico partendo da matrice di dati
% intersezioni matrice N_INTERSEZIONI × 2*N_QY0
% err_hamiltoniana vettore N_INTERSEZIONI


function creazione_grafico(energia, intersezioni, err_hamiltoniana)
	% Creazione grafico
	figure
	colormap('winter')
	subplot(4,4, 1:12)
	hold on
	title(strcat("Intersezioni per H = ", rats(energia)))
	xlabel('q_y')
	ylabel('p_y')
	axis([-0.3, 0.5, -0.3, 0.3])
	for i = 1:size(intersezioni, 2)/2
		plot(intersezioni(:, 2*i-1), intersezioni(:, 2*i), '.')
	end
	
	hold on
	% Grafico errore Hamiltoniana
	subplot(4,4, 13:16)
	plot(err_hamiltoniana)

	% saveas(gcf, strcat('img/grafico_test.png'))

end