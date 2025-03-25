%% Eulero esplicito
function [pnext, qnext] = expEuler(pn, qn, h, f)
    qnext = qn + h*(pn) + h^2/2 *(f(qn));
    pnext = pn + h * f(qn);
end