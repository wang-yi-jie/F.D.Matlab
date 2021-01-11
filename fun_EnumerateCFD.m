function [Cmats, SymFactor] = fun_EnumerateCFD(Num_E, Num_Vn)

% Enumerate CONNECTED and NOT-TADPOLE F.D. of a real scalar field theory: 
% L = {Free Field} + \sum_{n=3,4,...} (g_n / n!) * phi^n

% Input: Num_E  - # of external vertices
%        Num_Vn - [# of V3 vertices, # of V4 vertices, ...]
% Output: Cmats       - a cell of topologically different C-matrices 
%                       between vertices. 
%         SymFactor   - a cell of symmetry factors of each diagram. 


% Prepare some variables.
nlist = 3:length(Num_Vn)+2;
dimC = Num_E + sum(Num_Vn);

% If {# of lines} * 2 ~= {# of vertices}
if mod(Num_E + sum(Num_Vn.*nlist), 2) ~= 0
    error('Invalid input: no F.D. of this order.')
end


% Prepare some variables.
Vdeg = [ones(Num_E, 1); zeros(dimC - Num_E, 1)];
cnt = Num_E;
for ii = 1:length(Num_Vn)
    Vdeg(cnt+1:cnt+Num_Vn(1,ii), 1) = nlist(1, ii) * ones(Num_Vn(1,ii), 1);
    cnt = cnt + Num_Vn(1,ii);
end

% Construct the C-matrices. 
Cmats_raw = fun_Vdeg2Cmat(Vdeg, false(dimC, 1), false(dimC, 1), Vdeg);

% Initialize returning values.
Cmats = {};
SymFactor = {};

% CHECK THE TADPOLEs. delete the TOPOLOGICALLY IDENTICAL graphs.
PermMats = fun_PermMatrices(Vdeg);
for ii = 1:length(Cmats_raw)
    if fun_isTadPole(Cmats_raw{1, ii}, Num_E)
        continue
    end
    
    hasTopoEquiv = false;
    jj = 0;
    
    while jj < length(Cmats) && hasTopoEquiv == false
        jj = jj + 1;
        hasTopoEquiv = hasTopoEquiv + fun_isTopoEquiv(Cmats{1, jj}, Cmats_raw{1, ii}, PermMats);
    end
    
    switch hasTopoEquiv
        case true
            continue
        case false
            Cmats{1, end+1} = Cmats_raw{1, ii};
    end
end

SymFactor = fun_SymFactor(Cmats, PermMats);

end

