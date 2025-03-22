%% Størmer-verlet

function [p, q] = expEuler(pin, qin, h, f)
    q = qin + h*(pin) + h^2/2 *(f(qin));
    p = pin + h * f(qin);
end