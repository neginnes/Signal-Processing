function out  = SemiBandFFT_omittingDC (InputSignal, Fs, f)
    D = size(InputSignal);
    d = D(1,2);
    Y = fft(InputSignal);
    if f < pi % pi is mapped on Fs/2 in Hz
        W = Fs*(0:d*(f/(2*pi)))/d;  
    else
        W = Fs*(0:d/2)/d;       
    end
    Z = abs(Y/d);
    h = size(W);
    A = Z(1:h(1,2));
    A(1) = 0;
    
    figure()
    stem(W ,A);
    title(" |y[k]| ");
    xlabel("F(Hz)");
    grid on;
    out = A;
    
end
