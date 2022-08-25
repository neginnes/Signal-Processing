function out = epoching_per_channel (InputSignal, BackwardSamples, ForwardSamples, StimuliOnset)

    [row,col]= find (StimuliOnset~=0);
    s = size(col); 
    channel =zeros(1, BackwardSamples + ForwardSamples + 1) ;
    for i = 1 : s(1,2)
        if(i == 1 )
         channel = [channel ; InputSignal(col(i) - BackwardSamples : col(i) + ForwardSamples )];    
        elseif (i~=1  && col(i) - col(i-1)~= 1)
         channel = [channel ; InputSignal(col(i) - BackwardSamples : col(i) + ForwardSamples )];   
        end      
    end

    channel(1,:) = [] ;
    
    
    out = channel;
    
    
    

end