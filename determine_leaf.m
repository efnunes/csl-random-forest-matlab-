function [ flag] = determine_leaf( obj, ID )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
if ID < 1 || ID > numel(obj.Parent)
    error('MATLAB:tree:isleaf', ...
                    'No node with ID %d.', ID)
end
           
parent = obj.Parent;
flag = ~any( parent == ID );



end

