%DRLunpack
%
%This program will unpack DRL behavioral (raw) and voltammetry files
%(following cutting, chemometrics and stacking) and store data in a
%usable/analyzable format in matlab.m file
%
%written by Abigail G. Schindler 1.5.17 with lots of help from Lauren
%Burgeno and her LgAVoltDataUnpack.m, getEventsTimes.m, and UnpackNumber.m
%codes (thanks Lauren!)

%%

%add folders for that pathname to matlabpath

close all
clear all

%defining directory for path name where DRL folders/files are located. 
%pathname1 is the directory in which all folders with animal IDs is found
pathname1='F:\Schindler Lab\Data\DRL\Control\';
pathname2='F:\Schindler Lab\Data\DRL\Ethanol\';

%defining listing as a structure containing all infromation about files... 
%in the data directory located in pathname1 
%dir fuction creates a nfolder x 1 size structure.
%Structure contains 5 variables, one of which is the filename (animal ID).
listing1=dir(pathname1);
listing2=dir(pathname2);

%BEWARE that there are usually hidden folders with names like '..' or '.' 
%that will need to be erased.

%group all filenames for each animal together into a single variable (i.e.
%an array for each animal, containng filenames for each session).
for m=1:2
    %create an empty array to put ratIDs into
    %ratIDlist= (m)
    
    %populate the array with animal IDs
    %errasing '..' or '.' from the list of session names
    
    for i=1:length(listing1);
    %create an empty array to put ratIDs into
    ratIDlist= (m) 
        if isstrprop(listing1(i).name(1), 'digit'); %1 if true, 0 if false
            %.name(1) is indexing into first value in string only
            ratIDlist=[ratIDlist(m); listing1(i).name];%if filename starts with...
            %a number add the filename to the list of filenames
            %(this gets rie of the hidden '..' or '.' files you don't want)
        end
        
    end
 
    for i=1:length(listing2);
     %create an empty array to put ratIDs into
    ratIDlist= (m)   
        if isstrprop(listing2(i).name(1), 'digit'); %1 if true, 0 if false
            %.name(1) is indexing into first value in string only
            ratIDlist(m)=[ratIDlist(m); listing2(i).name];%if filename starts with...
            %a number add the filename to the list of filenames
            %(this gets rie of the hidden '..' or '.' files you don't want)
        
        end
    end
    DRL(m).ratID = ratIDlist(i,:)
end
DRL(m).ratID = ratIDlist(m,:)
end
end

    
%Create and populate the structure with all actual animal ids and...
%filenames(sessions)found within the path 

for i=1:length(ratIDlist);
    %generate list of sessions for each animal ID
    listing3=dir(char(strcat(pathname1, ratIDlist(i), '\Behavior\DRL\')));
    
    %strcat cocatenates strings (because elements of ratID list are...
    %strings you need to tell it to take all char of a string
    %there are multiple folders within each ratID folder so also...
    %need to direct to correct DRL folder where data is
    
    %pathname1='F:\Schindler Lab\Data\DRL\'
    %F:\Schindler Lab\Data\DRL\24\Behavior\DRL
    
    sessionlist = {};
    %create an empty array to put filenames (sessions) into
    %needs to be cell array b/c all session names...
    %aren't same dimensions

    
    for j=1:length(listing3);
        if isstrprop(listing3(j).name(1), 'digit'); %1 if true, 0 if false
            sessionlist=[sessionlist; listing3(j).name];%if filename...
            %starts with a number add the filename to the list of filenames 
            %this gets ride of the hidden files you don't want
        end
    end

%put the info into a structure (i.e. sessionlist for each animal ID)
    DRL(i).ratID = ratIDlist(i,:); 
    DRL(i).behavsessionlist= sessionlist;

end

for i=1:length(ratIDlistethanol);
    %generate list of sessions for each animal ID
    listing4=dir(char(strcat(pathname2, ratIDlistethanol(i), '\Behavior\DRL\')));
    
    %strcat cocatenates strings (because elements of ratID list are...
    %strings you need to tell it to take all char of a string
    %there are multiple folders within each ratID folder so also...
    %need to direct to correct DRL folder where data is
    
    %pathname1='F:\Schindler Lab\Data\DRL\'
    %F:\Schindler Lab\Data\DRL\24\Behavior\DRL
    
    sessionlist = {};
    %create an empty array to put filenames (sessions) into
    %needs to be cell array b/c all session names...
    %aren't same dimensions

    
    for j=1:length(listing4);
        if isstrprop(listing4(j).name(1), 'digit'); %1 if true, 0 if false
            sessionlist=[sessionlist; listing4(j).name];%if filename...
            %starts with a number add the filename to the list of filenames 
            %this gets ride of the hidden files you don't want
        end
    end

%put the info into a structure (i.e. sessionlist for each animal ID)
    DRL(i).ethanol.ratID = ratIDlistethanol(i,:); 
    DRL(i).ethanol.behavsessionlist= sessionlist;

end

%Will use function[eventVector, timeVector] = getEventsTimes(fileName)

%this function will output the event and time vector from MedPC data..
%from DRL file. It uses the unpackNumber function.
%Written by Andy Hart


for i=1:length(DRL);
    disp (num2str(i));
    DRL(i).behavior=nan(3000,2,length(DRL(i).behavsessionlist));
    %DRLsessionlist = {};
    for j=1:length(DRL(i).behavsessionlist); %telling to look at sessionlist
        fileName= DRL(i).behavsessionlist{j}; %filename input will be sessionlist(n=1:lenght(sessionlist))
        [eventVector, timeVector] = getEventsTimes(fileName);
        DRL(i).behavior(1:length(eventVector),:,j)= [double(eventVector) double(timeVector)];
        clear eventVector timeVector
    end
end