%DRLvoltunpack
%
%This program will unpack DRL voltammetry (after cutting, chemo and stack
%and store data in a usable/analyzable format in matlab.m file
%
%written by Abigail G. Schindler 1.17.17 with lots of help from Lauren
%Burgeno and her LgAVoltDataUnpack.m, getEventsTimes.m, and UnpackNumber.m
%codes (thanks Lauren!)

%%

close all
clear all

%defining directory for path name where DRL folders/files are located. 
%pathname1 is the directory in which all folders with treatment groups is found
pathname1='F:\Schindler Lab\Data\DRLvolt\';

%defining listing as a structure containing all infromation about files... 
%in the data directory located in pathname1 
%dir fuction creates a nfolder x 1 size structure.
%Structure contains 5 variables, one of which is the filename (group).
listing1=dir(pathname1);

%BEWARE that there are usually hidden folders with names like '..' or '.' 
%that will need to be erased.

%group all filenames for each treatment group into a single variable (i.e.
%an array for each group, containng foldernames for each animal).

%create an empty array to put treatment groups into
group = {}; 

%populate the array with the treatment groups
%errasing '..' or '.' from the list of names
for i=1:length(listing1);
    
    if strmatch('Control', listing1(i).name); %1 if true, 0 if false
        group=[group; listing1(i).name];%if filename starts with...
        %a number add the filename to the list of filenames
        %group; listing1(i).name says horizontal cat
        %(this gets rie of the hidden '..' or '.' files you don't want)
    end 
    
    if strmatch('Ethanol', listing1(i).name); %1 if true, 0 if false
        group=[group; listing1(i).name];%if filename starts with...
        %a number add the filename to the list of filenames
        %(this gets rie of the hidden '..' or '.' files you don't want)
    end
    
end

%Create and populate structure DRL with all treatment groups found within 
%...the path 
for i=1:length(group);
    DRLvolt(i).group = group(i);
end

%Populate the structure DRL with all of the animal ID folders
for i=1:length(group);
    %generate list of sessions for each animal ID
    listing2=dir(char(strcat(pathname1, DRLvolt(i).group, '\')));
    %strcat cocatenates strings (because elements of ratID list are...
    %strings you need to tell it to take all char of a string
    %there are multiple folders within each ratID folder so also...
    %need to direct to correct DRL folder where data is
    
    %pathname1='F:\Schindler Lab\Data\DRL\'
    %F:\Schindler Lab\Data\DRL\24\
    
    %create an empty array to put filenames (sessions) into
    %needs to be cell array b/c all session names...
    %aren't same dimensions
    ratIDlist = {};
    
    for j=1:length(listing2);
        
        if isstrprop(listing2(j).name(1), 'digit'); %1 if true, 0 if false
            %.name(1) is indexing into first value in string only
            ratIDlist=[ratIDlist; listing2(j).name];%if filename starts with...
            %a number add the filename to the list of filenames
            %(this gets rie of the hidden '..' or '.' files you don't want)
        end
    end
    
    %put the info into a structure (i.e. each animal ID into appropriate 
    %...treatment group)
    DRLvolt(i).ratIDlist = ratIDlist;
end

%Create and populate structure Group with each animal ID's sessionlist
%need to be a nested structure because want DRL and Group to each be 
%strucutres 
for i=1:length(DRLvolt);
    for j=1:length(DRLvolt(i).ratIDlist);
        %generate list of sessions for each animal ID
        %need '\' after group(i) to add a forward slash between folders for
        %group and rat number
        listing3=dir(char(strcat(pathname1, group(i), '\', DRLvolt(i).ratIDlist(j))));
        
        %strcat cocatenates strings (because elements of ratID list are...
        %strings you need to tell it to take all char of a string
        %there are multiple folders within each ratID folder so also...
        %need to direct to correct DRL folder where data is
        
        
        sessionlist = {};
        
        %create an empty array to put filenames (sessions) into
        %needs to be cell array b/c all session names...
        %aren't same dimensions
        
        
        for k=1:length(listing3);
            if isstrprop(listing3(k).name(1), 'digit'); %1 if true, 0 if false
                %name(1) tells to just look at first item in name
                sessionlist=[sessionlist; listing3(k).name];%if filename...
                %starts with a number add the filename to the list of filenames
                %this gets ride of the hidden files you don't want
            end
        end
        
        %put the info into a structure (i.e. sessionlist for each animal ID)
        %DRL(i).ratIDlist(j).behavsessionlist=nan(1,1,length(sessionlist));
        Animal(j).behavsessionlist= sessionlist;
        DRLvolt(i).Animal(j).behavsessionlist = Animal(j).behavsessionlist;
    end
   
end

for i=1:length(DRLvolt);
    for j=1:length(DRLvolt(i).Animal(j).behavsessionlist);
        pathname1='F:\Schindler Lab\Data\DRLvolt\';
        pathname2= [group(i), '\', DRLvolt(i).ratIDlist(j)];
        pathname3= [DRLvolt(i).Animal(j).behavsessionlist];
        pathname4= [
        listing4= dir(char(strcat(pathname1, pathname2, pathname3)));
        