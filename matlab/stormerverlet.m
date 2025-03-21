%% Størmer-verlet

function [p, q] = stormer_verlet(pin, qin, h, f)
    q = qin + h*(pin) + h^2/2 *(f(qin));
    p = pin + h/2 * (f(qin) + f(q));
end