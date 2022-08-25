function out  = SemiBandFFT (InputSignal, Fs)
    D = size(InputSignal);
    d = D(1,1);
    Y = fft(InputSignal);
        W = Fs*(0:d/2)/d;       
    %fhz = Fs*W/(pi*2);
    Z = abs(Y/d);
    h = size(W);
   % E = Z(1:h(1,2))
    figure()
    plot(W ,Z(1:h(1,2)));
    title(" |y[k]| ");
    xlabel("F(Hz)");
    xlim([0 1800])
    grid on;
    
    out = Z(1:h(1,2));
end
