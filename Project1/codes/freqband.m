function y = freqband (x, passband1, passband2, Fs)
    l = size (x);
    for i = 1:l(1,3)
        for j = 1:l(1,1)
            a = BPF(10,passband1,passband2 ,Fs);
            y(j,:,i) = (filter(a,1,(x(j,:,i))'))';
        end
    end


end