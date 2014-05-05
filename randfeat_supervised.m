function [ randff_data,ff_points] = randfeat_supervised( data, pts, ff)
%% Random selection of features for clustering
% Input:
% data : Training dataset
% pts : Data points at a particular node
% ff : feature fraction

% Output:
% randff_data: data with selected features only
% ff_points : random features selected to split the data

node_data = data(pts,:);
dim = size(node_data,2);
features = ceil(ff * dim);
points = randperm(dim);
ff_points = points(1:features);
randff_data = node_data(:, ff_points);



end

