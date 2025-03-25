run('funzioni_comuni.m');
nablaU = gradient(U, [qx, qy])
HU = jacobian(nablaU, [qx, qy])

punti_equilibrio = solve(nablaU==[0,0], [qx,qy], 'ReturnConditions', true);

[punti_equilibrio.qx, punti_equilibrio.qy]

HU_f = matlabFunction(HU, 'vars', {qx, qy});
for i = 1:size(punti_equilibrio.qx,1)
	Hu_i = HU_f(punti_equilibrio.qx(i), punti_equilibrio.qy(i))
	lambda = eig(Hu_i);
	if all(lambda > 0)
		disp('>0')
	elseif all(lambda < 0)
		disp('<0')
	end
end