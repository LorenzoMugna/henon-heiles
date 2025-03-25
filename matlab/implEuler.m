function [p, q] = implEuler(pin, qin, h, f)
    q = qin;
    p = pin;

    tol = 1e-10;
    max_iter = 100;

    for iter = 1:max_iter
        q_prev = q;
        p_prev = p;

        q = qin + h * p + h^2/2 * f(q);
        p = pin + h * f(q);

        if norm(q - q_prev, 2) < tol && norm(p - p_prev, 2) < tol
            break;
        end
    end

    if iter == max_iter
        warning('Eulero implicito non ha converso nel numero massimo di iterazioni');
    end
end