%DRLanalysis
%
%This program will pull the structure and data that was created with...
%DRLunpack and analyze in order to be put into prism
%
%written by Abigail G. Schindler 1.5.17

%DRL(i).ratID = ratIDlist(i,:); 
%DRL(i).behavsessionlist= sessionlist;
%DRL(i).behavior=nan(3000,2,length(DRL(i).behavsessionlist))

%Event stamps
%1=rt lever press during DRL
%2=lt lever press during DRL
%5=reinforcement delivery
%37=DRL reset

clear all
close all

%loading the .mat strucutre that you created with DRLunpack
load drlstructure.mat 

%ensure that correctly loaded
DRL
%1x2 struct array with fields:
    %group - this is a strucutre also
    %ratIDlist
    %Animal

%uses length, find, and nanmean functions
%%

%DRL resets 5sec     
for i=1:length(DRL);
    disp (num2str(i));
    DRL(i).DRLresets5=nan(1,1,length(DRL(i).behavsessionlist));
    DRL(i).DRLresetsmean5={};
    for k=1:5
            DRL(i).DRLresets5(:,:,k)=length(find(DRL(i).behavior(:,1,k)==37));
            DRL(i).DRLresetsmean5=nanmean(DRL(i).DRLresets5(:,:,1:5));
        end
    end


%%

%DRL resets 10sec     
for i=1:length(DRL);
    disp (num2str(i));
    DRL(i).DRLresets10=nan(1,1,length(DRL(i).behavsessionlist));
    DRL(i).DRLresetsmean10={};
    for k=6:10
            DRL(i).DRLresets10(:,:,k)=length(find(DRL(i).behavior(:,1,k)==37));
            DRL(i).DRLresetsmean10=nanmean(DRL(i).DRLresets10(:,:,6:10));
        end
end

%DRL resets 20sec     
for i=1:length(DRL);
    disp (num2str(i));
    DRL(i).DRLresets20=nan(1,1,length(DRL(i).behavsessionlist));
    DRL(i).DRLresetsmean20={};
    for k=11:15
            DRL(i).DRLresets20(:,:,k)=length(find(DRL(i).behavior(:,1,k)==37));
            DRL(i).DRLresetsmean20=nanmean(DRL(i).DRLresets20(:,:,11:15));
        end
end


%%

%DRL reinforcement delivery 5sec
for i=1:length(DRL);
    disp (num2str(i));
    DRL(i).DRLpellets5=nan(1,1,length(DRL(i).behavsessionlist));
    DRL(i).DRLpelletsmean5={};
    for k=1:5
        DRL(i).DRLpellets5(:,:,k)=length(find(DRL(i).behavior(:,1,k)==5));
        DRL(i).DRLpelletsmean5=nanmean(DRL(i).DRLpellets5(:,:,1:5));
    end
end

%DRL reinforcement delivery 10sec
for i=1:length(DRL);
    disp (num2str(i));
    DRL(i).DRLpellets10=nan(1,1,length(DRL(i).behavsessionlist));
    DRL(i).DRLpelletsmean10={};
    for k=6:10
        DRL(i).DRLpellets10(:,:,k)=length(find(DRL(i).behavior(:,1,k)==5));
        DRL(i).DRLpelletsmean10=nanmean(DRL(i).DRLpellets10(:,:,6:10));
    end
end

%%

%DRL lever presses right 5sec     
for i=1:length(DRL);
    disp (num2str(i));
    DRL(i).DRLpressright5=nan(1,1,length(DRL(i).behavsessionlist));
    DRL(i).DRLpressrightmean5={};
    for k=1:5
            DRL(i).DRLpressright5(:,:,k)=length(find(DRL(i).behavior(:,1,k)==1));
            DRL(i).DRLpressrightmean5=nanmean(DRL(i).DRLpressright5(:,:,1:5));
        end
end

%%

%DRL lever presses left 5sec     
for i=1:length(DRL);
    disp (num2str(i));
    DRL(i).DRLpressleft5=nan(1,1,length(DRL(i).behavsessionlist));
    DRL(i).DRLpressleftmean5={};
    for k=1:5
            DRL(i).DRLpressleft5(:,:,k)=length(find(DRL(i).behavior(:,1,k)==2));
            DRL(i).DRLpressleftmean5=nanmean(DRL(i).DRLpressleft5(:,:,1:5));
        end
end

%%

%DRL effective lever presses left 5sec     
for i=1:length(DRL);
    disp (num2str(i));
    DRL(i).DRLeffectivepressleft5=nan(1,1,length(DRL(i).behavsessionlist));
    DRL(i).DRLeffectivepressleftmean5={};
    for k=1:5
            DRL(i).DRLeffectivepressleft5(:,:,k)=(DRL(i).DRLpellets5(:,:,k)./DRL(i).DRLpressleft5(:,:,k)).*100;
            DRL(i).DRLeffectivepressleftmean5=nanmean(DRL(i).DRLeffectivepressleft5(:,:,1:5));
        end
end

%%

%DRL effective lever presses right 5sec     
for i=1:length(DRL);
    disp (num2str(i));
    DRL(i).DRLeffectivepressright5=nan(1,1,length(DRL(i).behavsessionlist));
    DRL(i).DRLeffectivepressrightmean5={};
    for k=1:5
            DRL(i).DRLeffectivepressright5(:,:,k)=(DRL(i).DRLpellets5(:,:,k)./DRL(i).DRLpressright5(:,:,k)).*100;
            DRL(i).DRLeffectivepressrightmean5=nanmean(DRL(i).DRLeffectivepressright5(:,:,1:5));
        end
end