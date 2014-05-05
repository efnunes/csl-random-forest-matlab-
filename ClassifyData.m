function [predict_node,tree] = ClassifyData (tree, test_data, test_point)
    %% Gives the label for the test data 
    % Input:
    % root : Learned random forest
    % test_data: a test data sample whose node is to be predicted
    % node_tree : a replica of the learned tree with each node represented by
    %             its corresponding learned centroid
    % labels : Training labels
    % feature_space : gives the features considered at a particular node to
    %               make a decisison
    % ntrees : Number of trees in the forest

    % Output:
    %predict_label : the predicted label for the test data
    
%     predict_node = zeros(1,ntrees);
%     content{ntrees} = {};
%     memcnt{ntrees} = {};
    
    idx = 1;
    tree.Node{idx,4}(end + 1,1) = test_point; %root
    while (~determine_leaf(tree, idx))
        children = determine_children(tree, idx);
        %children = node_tree.getchildren(idx);
        

        new_test  = test_data(1,tree.Node{children(1),3});
        %new_test = test_data(1, feature_space{children(1) - 1});

        dist = Inf;
        for i = 1:length(children)
            edist = norm(new_test - tree.Node{children(i),2});
            %edist = norm(new_test - node_tree.Node{children(i)}{1});
            if (dist > edist)
                dist = edist;
                idx = children(i);
                predict_node = idx;
            end
        end
        tree.Node{idx,4}(end + 1,1) = test_point;
        
    end
    

%     clear node_tree

end

