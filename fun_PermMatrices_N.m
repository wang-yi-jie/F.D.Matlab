function PermMats = fun_PermMatrices_N(N, ROW_AVAIL)

% Return all the permutation matrices of N elements, with M elements have
% been fixed. 
% eg. N=3, M=1: 
%      [0  0  1;
%      (1) 0  0;
%       0 (1) 0] ...
% Input: N - N elements in total. 
%        M - positions of M elements have been fixed. 
% Output: PermMats - a cell of all the N! permutation matrices. 

if N == 0
    PermMats = {};
    return
end

ROW_AVAIL_pos = find(ROW_AVAIL == true);
N_left = length(ROW_AVAIL_pos);

if N_left == 0
    PermMats = {sparse(N, N)};
    return
end

PermMats = {};

for ROW_idx = 1:N_left
    ROW_pos = ROW_AVAIL_pos(ROW_idx, 1);
    PermMatAdd = sparse(ROW_pos, N_left, 1, N, N);
    ROW_AVAIL_2 = ROW_AVAIL;
    ROW_AVAIL_2(ROW_pos, 1) = false;
    PermMats_2 = fun_PermMatrices_N(N, ROW_AVAIL_2);
    for jj = 1:length(PermMats_2)
        PermMats{1, end+1} = PermMats_2{1, jj} + PermMatAdd;
    end
end
end

