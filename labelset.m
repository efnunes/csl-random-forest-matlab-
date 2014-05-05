function [ lset ] = labelset( cluster, labels )
%% Determines the labels present in a particular cluster
% Input:
% cluster : a cluster of data points
% labels : all labels

% Output:
% lset : returns the labels of the cluster points
clear lset;
lset = unique(labels(cluster));

end

