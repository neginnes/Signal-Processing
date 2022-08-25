function out = epoching (InputSignal, BackwardSamples, ForwardSamples, StimuliOnset)
    l = size(InputSignal);
    for i = 1:l(1,1)
        
            out(:,:,i)  =  epoching_per_channel(InputSignal(i,:),BackwardSamples,ForwardSamples, StimuliOnset);
        end
        
end

