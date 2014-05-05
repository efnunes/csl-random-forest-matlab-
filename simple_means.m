function [centroids] = simple_means (data, dataByLabels, maxk)
% % return maxk centroids with an even number, if possible, in each class

    centroids = [];
    d = size(data,1); % number of data points
    c = size(dataByLabels,1); % number of categories
    if maxk >= d
        centroids = data;
    else
        meansPerClass = zeros(1, c);
        meansPerClass(:) = floor(maxk/c);
    
        if sum(meansPerClass) < maxk
            %get correct number of centroids overall
            numNeeded = maxk - sum(meansPerClass);
            bonusClusters = randsample(1:c,numNeeded,0); %WITHOUT replacement
            for i = 1:numel(bonusClusters)
                meansPerClass(bonusClusters(i)) = meansPerClass(bonusClusters(i)) + 1;
            end
        end

    
        for idx = 1:c
            classData = dataByLabels{idx,2};
            if size(classData,1) > meansPerClass(idx) % don't try to make centroids without min amount of data
                [~, ctrs] = kmeans(classData, meansPerClass(idx), 'emptyaction', 'drop');
            else
                ctrs = classData;
            end
            centroids = vertcat(centroids, ctrs);
        end
    
        % if we don't have enough centroids by contribution from each class
        if size(centroids,1) < maxk
        	rem_k = maxk - size(centroids,1);
            pts = randperm(d);
            ctrs = data(pts(1:rem_k),:);
            centroids = vertcat(centroids, ctrs);
        end
    end
    
end

