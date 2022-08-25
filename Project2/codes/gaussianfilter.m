function out  = gaussianfilter(pic,n,sigma)
    out = pic;
    A = zeros(n);
    l = ceil(n/2)-1 ;

    for x = -l : l
        for y = -l : l

            F =  1 / ( sqrt(2* pi) * sigma ) * exp( -(x^2 + y^2) / (2*sigma^2) ) ;

            A(x+l+1,y+l+1) =  F ;
        end 
    end
    A = A / A(1,1) ; 
    s = sum ( sum (A) ) ;
    A = A/s ;
    out(:,:,1) = conv2(pic(:,:,1),A,'same');
    out(:,:,2) = conv2(pic(:,:,2),A,'same');
    out(:,:,3) = conv2(pic(:,:,3),A,'same');
    out = uint8(out);
    
end