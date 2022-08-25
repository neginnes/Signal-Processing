function out  = meanfilter(pic,n)
    A = ones(n);
    A = ( 1 / n ^2 ) * A ; 
    out = pic;
    out(:,:,1) = conv2(pic(:,:,1),A,'same');
    out(:,:,2) = conv2(pic(:,:,2),A,'same');
    out(:,:,3) = conv2(pic(:,:,3),A,'same');
    out = uint8(out);
end
    