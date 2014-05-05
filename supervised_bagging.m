function [ bagged_points ] = supervised_bagging(labels, bf )
%% Bagging data into random samples for each tree 
% Input:
% labels : Training labels
% bf (bagging fraction): the feaction of the total training data used to
%                       train individual trees 

% Output :
% bagged_points : a array of randomly selected data points from the
%                Training dataset(almost equal representation of each
%                category)


label_set = unique(labels);
bagged_points = [];

for i = 1:length(label_set)
    
    idx = find(labels==label_set(i));
    idx = idx(randperm(length(idx)));
    n = ceil(bf * length(idx));
    bagged_points = [bagged_points; idx(1:n)];
    
end

end

