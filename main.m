clear

numE = 2;
numV3 = 0;
numV4 = 5;
numVn = [numV3, numV4];
[Cmats, SymFactor] = fun_EnumerateCFD(numE, numVn);

EdgeList = fun_Cmat2CFD(Cmats);

% for ii = 1:length(EdgeList)
%     G = graph(EdgeList{1,ii}(1,:), EdgeList{1,ii}(2,:));
%     figure(floor((ii-1)/20) + 1);
%     subplot(4,5,mod(ii-1, 20)+1)
%     plot(G, 'ko-', 'linewidth', 1.5, 'markersize', 4)
%     title(['S=', num2str(SymFactor{1, ii})], 'fontsize', 12)
%     
%     if mod(ii, 20) == 0 || ii == length(EdgeList)
%         set(gcf, 'position', [50 50 600 1200])
%         saveas(gcf, ['E=', num2str(numE), ',V3=', num2str(numV3), ...
%             ',V4=', num2str(numV4), ',', num2str(ceil(ii/20)), '.jpg'])
%         saveas(gcf, ['E=', num2str(numE), ',V3=', num2str(numV3), ...
%             ',V4=', num2str(numV4), ',', num2str(ceil(ii/20)), '.fig'])
%     end
% end

