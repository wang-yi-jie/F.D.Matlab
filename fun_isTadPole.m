function isTadPole = fun_isTadPole(Cmat, NumE)

% Check whether the C-matrix is a TADPOLE. 

isTadPole = false;

dimC = size(Cmat, 1);
for ii = NumE+1:dimC
    for jj = ii+1:dimC
        if Cmat(ii, jj) == 1
            Cmat_2 = Cmat;
            Cmat_2(ii, jj) = 0;
            Cmat_2(jj, ii) = 0;
            ConnComp_2 = conncomp(graph(Cmat_2));
            if max(ConnComp_2) > 1 && ~any(ConnComp_2(1:NumE) - ConnComp_2(1))
                isTadPole = true;
                break
            end
        end
    end
end

end

