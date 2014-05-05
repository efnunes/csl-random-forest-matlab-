function [ memcnt ] = determine_membercount( content, labelset,labels )
%% Determines the member labels at a particular node
% Input:
% content : memeber of the node 
% labelset : An array of all the categories used for training
% labels : Training dataset labels

% Output:
% memcnt : returns the count for each label at the node

memcnt = zeros(length(labelset),1);
 l = labels(content);
for i = 1:length(labelset)
   
   memcnt(i) = numel(find(l == labelset(i)));
    
end

% clear l;


end

