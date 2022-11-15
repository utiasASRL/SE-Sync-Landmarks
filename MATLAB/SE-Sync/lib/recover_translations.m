function t = recover_translations(R, problem_data)
% function t = recover_translations(R, problem_data)
%
% Given a dense d x dN block matrix R whose (dxd)-block elements are
% rotations comprising an optimal solution to the reduced rotation-only
% maximum-likelihood estimation, this function returns a dense (d x n)
% matrix t whose columns are the oorresponding optimal translations

% Copyright (C) 2016 by David M. Rosen


% We have that vec(t) = -(LWtau^pinv V \otimes I_3) vec(R)  (1)
%
% Using the fact that vec(AB) = (B' \otimes I) vec(A),
% we see that (1) is equivalent to
%
% t = - R * V' * LWtau^pinv
if isfield(problem_data,'Q_bt')
    V_sp = problem_data.V_s(1:problem_data.Np,:);
    V_sp_bar = kron(V_sp, speye(3));
    b = problem_data.V_s*problem_data.Y_s'*V_sp_bar'*R';
    t = lsqminnorm(problem_data.L_s,b)';
else
    t = - (problem_data.LWtau \ (problem_data.V * R'))';
end


end

