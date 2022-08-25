function out  = SemiBandFFT (InputSignal, Fs, f)
    D = size(InputSignal);
    d = D(1,2);
    Y = fft(InputSignal);
    if f < pi % pi is mapped on Fs/2 in Hz
        W = Fs*(0:d*(f/(2*pi)))/d;  
    else
        W = Fs*(0:d/2)/d;       
    end
    %fhz = Fs*W/(pi*2);
    Z = abs(Y/d);
    h = size(W);
   % E = Z(1:h(1,2))
    figure()
    stem(W ,Z(1:h(1,2)));
    title(" |y[k]| ");
    xlabel("F(Hz)");
    grid on;
    
    out = Z(1:h(1,2));
end
