function h = BPF(L,lowF,higF,FS,plot)
    %{
        Inputs:
            L: Filter order
            lowF: Low frequency
            higF: High frequency
            FS: Sampling frequency
            plot: To plot or not
            if nothing is entered for "plot" then BPF will not plot
        Outut:
            h: Impulse response of the filter
    %}
    beta = 3;
    h = fir1(L-1,[2*lowF/FS,2*higF/FS], kaiser(L,beta));
    h = h(:);
    if nargin==5
    figure
    freqz(h)
    end
end


