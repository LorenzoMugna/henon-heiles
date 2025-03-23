function [p, q] = implEuler(pin, qin, h, f)
    % Implicit Euler method using fixed-point iteration
    % pin: initial momentum
    % qin: initial position
    % h: time step
    % f: function handle for the force (gradient of the potential)

    % Initialize q and p
    q = qin;
    p = pin;

    % Tolerance and maximum iterations for convergence
    tol = 1e-8;
    max_iter = 100;

    % Fixed-point iteration
    for iter = 1:max_iter
        % Store the previous values for convergence check
        q_prev = q;
        p_prev = p;

        % Update q and p using the implicit Euler equations
        q = qin + h * p;
        p = pin + h * f(q);

        % Check for convergence
        if norm(q - q_prev, 2) < tol && norm(p - p_prev, 2) < tol
            break;
        end
    end

    % Check if the iteration converged
    if iter == max_iter
        warning('Implicit Euler did not converge within the maximum number of iterations.');
    end
end