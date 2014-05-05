function [ root, node_centroids, feature_space ] = batchTrain_supervised( data, Labels, bagged_points, ff, node_centroids, feature_space, maxk, minSize)
    %% Trains a tree for given bagged dataset
    % Input:
    % data : Training dataset
    % Labels : Training labels
    % bagged_points : randomly sampled data points to be considered for
    %                training (every category is almost equally represented)
    % ff (feature fraction) : fraction of the total features to be considered
    %                        to split the data at the node
    % node_centroids : empty cell which returns the learned centroids at each
    %                 node in the tree
    % feature_space : empty cell which returns the feature points considered to
    %                 split the data at a node
    % maxk : maximum branching factor allowed at a node

    % Output:
    % root : Leaned tree with all the nodes and their data points and the
    %       hierarchical representation of the tree


    Q = {};
    idx = {};
    Q = q_fifo(Q,'push',bagged_points);
    
    root = tree(bagged_points);

    while (~isempty(Q))

        for i = 1:length(root.Node)
            if (isequal(Q{1},root.get(i)))
                idx = i;
            end
        end
        
        % Random selection of features for clustering
        [randff_data,ff_points] = randfeat_supervised(data, Q{1}, ff);

        % Centroid initilization for supervised classification
        [centroids] = init_centroids_supervised(randff_data, Labels, Q{1}, maxk);

        % Supervised clustering
        [clusters, node_centroids, root, feature_space] = supervised_clustering(randff_data, root, idx, node_centroids, ff_points, feature_space, centroids, Q{1});

        % Check for the splitting criteria
        for j = 1:length(clusters)

            [lset] = labelset(clusters{j}, Labels);
            if (length(lset) > 1 && length(clusters{j}) > minSize) % && tN->nodeLvl < maxNodeLevel
                Q = q_fifo(Q,'push', clusters{j});
                
    
            end
        end

       % First in first out 

       Q = Q(2:end);
       

    end
 

end






