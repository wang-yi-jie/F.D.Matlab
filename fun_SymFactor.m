function SymFactors = fun_SymFactor(Cmats, PermMats)

% Return a cell of symmetry-factors of corresponding C-matrices.

SymFactors = cell(1, length(Cmats));
for ii = 1:length(Cmats)
    Cmat = Cmats{1, ii};
    SF1 = 0;
    for jj = 1:length(PermMats)
        if ~any(any(PermMats{1, jj}' * Cmat * PermMats{1, jj} - Cmat))
            SF1 = SF1 + 1;
        end
    end
    SF2 = 1;
    SF3 = 1;
    for jj = 1:size(Cmat, 1)
        if Cmat(jj, jj) > 1
            SF2 = SF2 * factorial(Cmat(jj, jj) / 2) * 2^(Cmat(jj, jj) / 2);
        end
        for kk = jj+1:size(Cmat, 1)
            SF3 = SF3 * factorial(Cmat(jj, kk));
        end
    end
    SymFactors{1, ii} = SF1 * SF2 * SF3;
end 
end

