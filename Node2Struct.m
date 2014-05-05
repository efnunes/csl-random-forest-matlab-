function [ forest ] = Node2Struct (root, node_centroids, feature_space, ntrees)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    forest{ntrees} = {};
    temp{ntrees} = {};
    for i = 1:ntrees
        forest{i} = struct(root{i});
        temp{i} = struct2cell(forest{i});
        for j = 1:length(node_centroids{i})
            temp{1,i}{1}{j+1,2} = node_centroids{1,i}{1,j};
            temp{1,i}{1}{j+1,3} = feature_space{1,i}{1,j};

            temp{1,i}{1}{j+1,4} = [];

            

        end

       
        forest{i}.Node = temp{1,i}{1};


        


    end

end

