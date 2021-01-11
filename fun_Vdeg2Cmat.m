function [Cmats] = fun_Vdeg2Cmat(Vdeg, C_ISLAND, V_PERM_BROKEN, V_DEG_ORI)

% Enumerate CONNECTED F.D. of a real scalar field theory: 
% L = {Free Field} + \sum_{n=3,4,...} (g_n / n!) * phi^n
% by RECURSION. 

% Input: Vdeg     - a list of un-used degrees (or 'ports') of each vertex. 
%                   [degree of vertex #1; degree of vertex #2; ...]
%        C_ISLAND - a list of bool values, indicating which vertices have
%                   already been connected together. 
%        V_PERM_BROKEN  - a list of bool values, indicating which vertices
%                         has already been 'identified' so that the
%                         permutation symmetry has been broken. These are
%                         also vertices recommended to use in the next step, 
%                         in order to prevent counting redundancy. 
%        V_DEG_ORI- a list of original degrees of each vertex. 
% Output: Cmats     - a cell of topologically different C-matrices 
%                     between vertices. 
%         SymFactor - a cell of symmetry factors of each diagram. 


numV = length(Vdeg);

if ~any(Vdeg)
    Cmats = {sparse(numV, numV)};
    return
end

if isempty(Vdeg(C_ISLAND))  % The 1st edge is still to be connected. 
    i0_pos = 1;
    V_PERM_BROKEN_2 = V_PERM_BROKEN;
    V_PERM_BROKEN_2(V_DEG_ORI == 1, 1) = true;
    for n = 3:V_DEG_ORI(end)
        Vnlist = find(V_DEG_ORI == n);
        if isempty(Vnlist)
            continue
        end
        V_PERM_BROKEN_2(Vnlist(1, 1), 1) = true;
    end
else                        % The 1st edge has been specified, and so is the connected island. 
    if ~any(Vdeg(C_ISLAND))     % If the connected island has run out of its 'ports'. 
        Cmats = {};
        return
    end                         % If there are still available 'ports', start there. 
    temp_i0_pos = (Vdeg > 0) & C_ISLAND;
    temp_i0_pos = find(temp_i0_pos == 1);
    i0_pos = temp_i0_pos(1, 1);
    V_PERM_BROKEN_2 = V_PERM_BROKEN;
end

Cmats = {};

Vdeg2 = Vdeg;
Vdeg2(i0_pos, 1) = Vdeg2(i0_pos, 1) - 1;
V_avail_pos = find((Vdeg2 > 0) & V_PERM_BROKEN_2);

for jj = 1:length(V_avail_pos)   
    jj_pos = V_avail_pos(jj);
    Vdeg3 = Vdeg2;
    Vdeg3(jj_pos, 1) = Vdeg3(jj_pos) - 1;
    C_ISLAND_2 = C_ISLAND;
    C_ISLAND_2(i0_pos, 1) = true;
    C_ISLAND_2(jj_pos, 1) = true;
    if jj_pos ~= numV && V_DEG_ORI(jj_pos+1, 1) == V_DEG_ORI(jj_pos, 1)
        V_PERM_BROKEN_2(jj_pos+1, 1) = true;
    end
    Cmats2 = fun_Vdeg2Cmat(Vdeg3, C_ISLAND_2, V_PERM_BROKEN_2, V_DEG_ORI);
    if jj_pos == i0_pos
        Cmat_add = sparse(i0_pos, i0_pos, 2, numV, numV);
    else
        Cmat_add = sparse([i0_pos, jj_pos], [jj_pos, i0_pos], [1, 1], numV, numV);
    end
    for kk = 1:length(Cmats2)
        Cmats{1, end+1} =  Cmat_add + Cmats2{1, kk};
    end
end
end

