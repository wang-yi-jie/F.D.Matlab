function EdgeList = fun_Cmat2CFD(Cmats)

% Convert C-matrices to list of edges. 
% Input: Cmats      - a cell of C-matrices to be dealt with. 
% Output: EdgeList  - a cell of edges. 
%                    [Node 1 of Edge 1, Node 1 of Edge 2, ... ;
%                     Node 2 of Edge 1, Node 2 of Edge 2, ... ]

EdgeList = cell(1, length(Cmats));
numV = size(Cmats{1, 1}, 1);

for ii = 1:length(Cmats)
    Cmat = Cmats{1, ii};
    EdgeEnds = zeros(2, (sum(sum(Cmat)))/2);
    label_1 = 1;
    for jj = 1:numV
        if Cmat(jj, jj) ~= 0
            Edge = [jj; jj];
            numEdge = Cmat(jj, jj) / 2;
            label_2 = label_1 + numEdge;
            EdgeEnds(:, label_1:label_2-1) = Edge(:, ones(numEdge, 1));
            label_1 = label_2;
        end
        for kk = jj+1:numV
            Edge = [jj; kk];
            numEdge = Cmat(jj, kk);
            label_2 = label_1 + numEdge;
            EdgeEnds(:, label_1:label_2-1) = Edge(:, ones(numEdge, 1));
            label_1 = label_2;
        end
    end
    EdgeList{1, ii} = EdgeEnds;
end

end

