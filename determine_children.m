function [ children ] = determine_children( obj, ID)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

parent = obj.Parent;
IDs = find( parent == ID );
children = IDs';


end

