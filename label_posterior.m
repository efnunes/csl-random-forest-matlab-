function [ predict_label,forest ] = label_posterior ( forest, test_data, labels, ntrees, test_point)

    %UNTITLED Summary of this function goes here
    %   Detailed explanation goes here

    predict_node = zeros(1,ntrees);
    content{ntrees} = {};
    memcnt{ntrees} = {};
    prob{ntrees} = {};
    
    classes = numel(unique(labels));
    for i = 1:ntrees
        [predict_node(i),forest{i}] = ClassifyData(forest{i}, test_data, test_point);
    end
   

    for i = 1:ntrees

        %Gets the content at that leaf node
        content{i} = forest{i}.Node{predict_node(i),1};
        

        lset = (1:1:classes);

        [memcnt{i}] = determine_membercount(content{i}, lset, labels);
        prob{i} = memcnt{i}/numel(content{i});
    end
    
    forest_count = zeros(1,classes)';
    if ntrees == 1
        forest_count = prob{1};
    else
        for i = 1:ntrees

            forest_count = forest_count + prob{i};
        end
    end
    
    predict_labels = find(forest_count == max(forest_count));
    predict_label = predict_labels(1,1);
end

