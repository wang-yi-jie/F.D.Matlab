function PermMats = fun_PermMatrices(V_DEG_ORI)

% Return all the transformation matrices acting on the C-matrix, 
% corresponding to permuting vertices. 

PermMats_raw = cell(1, V_DEG_ORI(end, 1)-2);
numV = length(V_DEG_ORI);

E_num = length(find(V_DEG_ORI == 1));
Vn_num_list = zeros(1, V_DEG_ORI(end, 1) - 2);
for degV = 3:V_DEG_ORI(end, 1)
    Vn_num_list(1, degV-2) = length(find(V_DEG_ORI == degV));
end


for degV = 3:V_DEG_ORI(end, 1)
    Vn_pos = find(V_DEG_ORI == degV);
    Vn_num = Vn_num_list(1, degV-2);
    
    Vn_PermMats = fun_PermMatrices_N(Vn_num, true(Vn_num, 1));
    if isempty(Vn_PermMats)
        PermMats_raw{1, degV-2} = {speye(numV, numV)};
        continue
    end
    Vn_PermMats_Full = cell(1, length(Vn_PermMats));
    for ii = 1:length(Vn_PermMats)
        temp = sparse(numV, numV);
        temp(Vn_pos, Vn_pos) = Vn_PermMats{1, ii} - speye(length(Vn_pos));
        Vn_PermMats_Full{1, ii} = speye(numV, numV) + temp;
    end
    PermMats_raw{1, degV-2} = Vn_PermMats_Full;
end

PermMats = {speye(numV)};
for degV = 3:V_DEG_ORI(end, 1)
    Vn_PermMats_Full = PermMats_raw{1, degV-2};
    PermMats_2 = {};
    label = 0;
    for ii = 1:length(Vn_PermMats_Full)
        for jj = 1:length(PermMats)
            label = label + 1;
            PermMats_2{1, label} = Vn_PermMats_Full{1, ii} * PermMats{jj};
        end
    end
    PermMats = PermMats_2;
end
end