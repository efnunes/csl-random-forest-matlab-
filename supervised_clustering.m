function [clusters, node_centroids, root, feature_space] = supervised_clustering (data, root, idx, node_centroids, ff_points, feature_space, centroids, points)
%% Kmeans clustering and creation of nodes
% Input:
% data : histogram of randomly selected features
% root : training  tree
% idx : ID of the parent to which the new nodes are to be added
% node_centroids : empty cell which returns the learned centroids at each
%                 node in the tree
% ff_points : random features selected to split the node
% feature_space : empty cell which returns the feature points considered to
%                 split the data at a node
% points : data points to split at each node

% Output:
% clusters : returns the clusters formed at the node after kmeans
% node_centroids : cluster centroids corresponding to the clusters
% root : returns the training tree with new nodes added

  

    
    opts = statset('MaxIter', 30);
    [C, cluster_centroids] = kmeans(data,[],'start',centroids,'options',opts,'emptyaction','drop');%, 'onlinephase','on');
   
    cluster_number = unique(C);
    for i = 1:length(cluster_number)
        clusters{i} = points(C==cluster_number(i));
        [root, ID] = root.addnode(idx, clusters{i});
        node_centroids = q_fifo(node_centroids, 'push', cluster_centroids(i,:));
        feature_space = q_fifo(feature_space,'push', ff_points);
    end

end

