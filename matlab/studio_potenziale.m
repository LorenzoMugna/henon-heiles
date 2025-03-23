syms q_x q_y p_x p_y

U = 1/2*(q_x^2 + q_y^2) + q_x^2 * q_y - 1/3*q_y^3;

nablaU = gradient(U, [q_x, q_y])
HU = jacobian(nablaU, [q_x, q_y])

punti_equilibrio = solve(nablaU==[0,0], [q_x,q_y], 'ReturnConditions', true);

[punti_equilibrio.q_x, punti_equilibrio.q_y]

HU_f = matlabFunction(HU, 'vars', {q_x, q_y});
for i = 1:size(punti_equilibrio.q_x,1)
	Hu_i = HU_f(punti_equilibrio.q_x(i), punti_equilibrio.q_y(i))
	lambda = eig(Hu_i);
	if all(lambda > 0)
		disp('>0')
	elseif all(lambda < 0)
		disp('<0')
	end
end