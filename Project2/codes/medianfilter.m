function out  = medianfilter(pic,n)
    A = ones(n);
    m = ceil(n/2) - 1 ;
    M = size(pic(:,:,1));
    B1 = zeros(2*m + M(1,1),2*m + M(1,2));
    B2 = B1;
    B3 = B1;
    
    B1(1+m : end-m , 1+m : end-m ) = pic(:,:,1);
    B2(1+m : end-m , 1+m : end-m ) = pic(:,:,2);
    B3(1+m : end-m , 1+m : end-m ) = pic(:,:,3);


	for i= m+1 : m + M(1,1)
		for j= m+1: m + M(1,2)
			C = B1(i-m:i+m,j-m:j+m);
            D = C(1,:);
                for k = 2 : n
                    D = [ D , C(k,:)];
                end
                D = sort(D);
                B1(i,j) = D(ceil(n*n/2));
        end
    end

    for i= m+1 : m + M(1,1)
		for j= m+1: m + M(1,2)
			C = B2(i-m:i+m,j-m:j+m);
            D = C(1,:);
                for k = 2 : n
                    D = [ D , C(k,:)];
                end
                D = sort(D);
                B2(i,j) = D(ceil(n*n/2));
        end
    end
    
    for i= m+1 : m + M(1,1)
		for j= m+1: m + M(1,2)
			C = B3(i-m:i+m,j-m:j+m);
            D = C(1,:);
                for k = 2 : n
                    D = [ D , C(k,:)];
                end
                D = sort(D);
                B3(i,j) = D(ceil(n*n/2));
        end
    end
    out(:,:,1) = B1(1+m : end-m ,1+m : end-m);
    out(:,:,2) = B2(1+m : end-m ,1+m : end-m);
    out(:,:,3) = B3(1+m : end-m ,1+m : end-m);
	out =  uint8(out);	
end
    
