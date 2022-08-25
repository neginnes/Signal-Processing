function out = mute(y,Fs)
l = size (y);
out = 0;
n = 1 ;
while(n <  l(1,1))
    if (y(n)^2 <= 0.05)
        cnt = 0 ;
        while(y( n + cnt)^2 <= 0.05)
            cnt = cnt + 1;
            if(n + cnt >= l(1,1))
                break
            end
            
        end
        t = (cnt - 1) / Fs ;
        
        if( t > 0.07 )
            out = [out;n];
        end
        if(cnt>0)
            n = n + cnt-1;
        end
    end
     n = n + 1 ;
end   
out(1:2,:) = [];      
end


