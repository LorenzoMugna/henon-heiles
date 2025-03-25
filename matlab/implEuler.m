%% Eulero implicito
function [pnext, qnext] = implEuler(pn, qn, h, f)
    qnext = qn;
    pnext = pn;

    tol = 1e-10;
    max_iter = 100;

    for iter = 1:max_iter
        q_prev = qnext;
        p_prev = pnext;

        qnext = qn + h * pnext + h^2/2 * f(qnext);
        pnext = pn + h * f(qnext);

        if norm(qnext - q_prev, 2) < tol && norm(pnext - p_prev, 2) < tol
            break;
        end
    end

    if iter == max_iter
        warning('Eulero implicito non ha converso nel numero massimo di iterazioni');
    end
end