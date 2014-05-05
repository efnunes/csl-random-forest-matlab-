function [ centroids] = init_centroids_supervised( data, labels, points, maxk )
%% Supervised centroid initilization for kmeans
% Input:
% data : data present at the node
% labels : Training labels
% points: Training points corresponding to the data 

% Output:
% centroids: returns initilized centroids for clustering the node

for i = 1:length(points)
    lset(i) = labels(points(i));
end

label_set = unique(lset);


for i = 1:length(label_set)
    dataByLabels{i,1} = find(lset==label_set(i));
end


for i = 1:length(dataByLabels)
    dataByLabels{i,2} = data(dataByLabels{i,1},:);
end


for i = 1:length(dataByLabels)
    class_means(i,:) = sum(dataByLabels{i,2},1)/(size(dataByLabels{i,2},1));
end


if maxk > length(label_set)
	[centroids] = simple_means(data,dataByLabels, maxk);
elseif maxk == length(label_set)
	centroids = class_means;
else
    error('Make branching factor(maxk) equal to ot greater than number of categories');
end

end

