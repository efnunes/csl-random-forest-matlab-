%% Header
% File: cslforest_script.
% Author: Eric Nunes, brain engineering laboratory, Dartmouth
% Description: File contains routine calls for the core components in the algorithm

% clear;
% Include the data path where the files are stored.
DATA_PATH = 'C:\Users\Eric\Documents\GitHub\StillImageProcessing\cslForest\csl-matlab\csl_supervised\loot_data\';

load (strcat(DATA_PATH, 'TrainLabels'));
load (strcat(DATA_PATH, 'TrainDMapIndices'));
load (strcat(DATA_PATH, 'TestDMapIndices'));
load (strcat(DATA_PATH, 'TestLabels'));
load (strcat(DATA_PATH, 'Labels'));
load (strcat(DATA_PATH, 'H'));


%% ******************************************
warning off;
%user settings
K = 39;
bf = 0.6;        %Bagging fraction
ff = 0.2;        %Feature fraction
ntrees = 1;    %Number of trees


minSize = 5; %nodes with less than this number of data points in them will never spawn children (default = 5);

%% ******************************************



% preallocating memory to the cells
node_centroids{10, ntrees} = {};
feature_space{10, ntrees} = {};
root{10, ntrees} = {};
centroid_tree{10, ntrees} = {}; 
bagged_points{10, ntrees} = {};
% forest{10,ntrees} = {};


time{10} = {};
test{10} = {};
Acc{10} = {};
CF{10} = {};


for run = 1:1
    fprintf('BEGIN: Run %d\n', run); 
    
    TrainH = H(TrainDMapIndices{run}, :);
    TestH = H(TestDMapIndices{run}, :);
    
    

    tic;
    parfor i = 1:ntrees
        %Supervised bagging
        [bagged_points{run, i}] = supervised_bagging(TrainLabels{run}, bf);
    end
    
    
    for maxk = 2; %Greater than or equal to number of classes
        
        for j = 1:ntrees
            %Supervised batchTrain
            [ root{run, j},node_centroids{run, j},feature_space{run , j} ] = batchTrain_supervised(TrainH, TrainLabels{run}, bagged_points{run , j}, ff, node_centroids{run, j}, feature_space{run, j}, maxk, minSize);
        end
        
    end
    time{run} = toc;
    fprintf('TrainTime = %f   \n',time{run});
    
    % Creating a structure for the forest
    [ forest ] = Node2Struct(root(run,:), node_centroids(run,:), feature_space(run,:), ntrees);

%     matlabpool('close');
    test_points = size(TestH,1);
    
    tic;
    parfor i = 1:test_points
        
        % Supervised classification
        [ predict_label{run ,i} ] = label_posterior(forest, TestH(i,:), TrainLabels{run}, ntrees, i);
        
    end
    
    test{run} = toc;
    fprintf('TestTime = %f   ',test{run});
    
    CF{run} = confusionmat(TestLabels{run}, cell2mat(predict_label(run,:)));
    diag  = trace(CF{run});
    Acc{run} = (diag/numel(TestLabels{run})) * 100;
    fprintf(' Accuracy = %f%%\n',Acc{run});
    
end