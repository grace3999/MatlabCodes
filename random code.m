function[] = DRLresets(j,l)

for i=1:length(DRL);
    disp (num2str(i));
    DRL(i).resets=sprintf('DRL(i).DRLresets%g',l);
    DRL(i).resets=nan(1,1,length(DRL(i).behavsessionlist));
    DRL(i).resetsmean=sprintf('DRL(i).DRLresetsmean%g',l);
    DRL(i).resetsmean={};
    for k=j:l
        DRL(i).resets(:,:,k)=length(find(DRL(i).behavior(:,1,k)==37));
        DRL(i).resetsmean=nanmean(DRL(i).resets(:,:,j:l));
    end
    sprintf('DRL(i).DRLresets%g',l)=DRL(i).resets    
end


%%trying to do this is too difficult Lauren said

%%

M=volt(i).Behavior(:,:,sessionnumberShA(d));
            B=volt(i).Behavior(:,:,sessionnumberShA(d)-1);
            Lactive= (M(M(:,1)== activeLNP,2))-presessiontime;
            Ractive= (M(M(:,1)== activeRNP,2))-presessiontime;
            
            TOLactive= (M(M(:,1)== TOLNP,2))-presessiontime;
            TORactive= (M(M(:,1)== TORNP,2))-presessiontime;
            
            Rinactive=(M(M(:,1)== inactiveRNP,2))-presessiontime;
            Linactive=(M(M(:,1)== inactiveLNP,2))-presessiontime;
            
            if isempty(Lactive)
                activeNPtimes= Ractive;
            else
                activeNPtimes=Lactive;
                
            end