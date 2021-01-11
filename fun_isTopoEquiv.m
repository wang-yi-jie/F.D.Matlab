function isTopoEquiv = fun_isTopoEquiv(Cmat_1, Cmat_2, PermMats)

% Check whether Cmat_1 & Cmat_2 are topologically equivalent, under
% specified permutation among vertices. 

% TO BE MODIFIED. 
% G1 = graph(Cmat_1);
% G2 = graph(Cmat_2);
% isTopoEquiv = isisomorphic(G1, G2);

isTopoEquiv = false;

for ii = 1:length(PermMats)
    if ~any(any(PermMats{1, ii}' * Cmat_1 * PermMats{1, ii} - Cmat_2))
        isTopoEquiv = true;
        break
    end
end


end

