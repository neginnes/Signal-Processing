function out = kmean(pic)

l = size(pic);

l1 = l(1,1);
l2 = l(1,2);

c1 = [ceil((rand(1) *  l1/2  + l1/4)) , ceil((rand(1) *  l2/2  + l2/4))];
x1 = rand(1);
x2 = rand(1);
if x1 > 0.5
    c2 = [ceil((rand(1)-1/2 *  l1/4  + 3*l1/4)) , 0];
else
    c2 = [ceil(rand(1) *  l1/4  ) , 0];
end
if x2 > 0.5
    c2 = c2 + [0,ceil((rand(1)*  l2/4  + 3*l2/4))];
else
    c2 = c2 + [0,ceil(rand(1) *  l2/4 ) ];
end

% c1 , c2 are the two centers
c1 
c2
out = pic ;
Mu1 = [pic(c1(1,1),c1(1,2),1) , pic(c1(1,1),c1(1,2),2) , pic(c1(1,1),c1(1,2),3) , c1(1,1)/l1 * 256 , c1(1,2) /l2 * 256 ];
Mu2 = [pic(c2(1,1),c2(1,2),1) , pic(c2(1,1),c2(1,2),2) , pic(c2(1,1),c2(1,2),3) , c2(1,1)/l1 * 256 , c2(1,2) /l2 * 256 ];
k1 = 1;
k2 = 1;
for w = 1 : 100
    for i = 1 : l1
        for j = 1 :l2

            distance1 = (pic( i , j , 1) - Mu1(1,1))^2 + (pic( i , j , 2) - Mu1(1,2))^2 + (pic( i , j , 3) - Mu1(1,3))^2 + ( i/l1 * 256 - Mu1(1,4))^2  + ( j/l2 * 256 - Mu1(1,5))^2 ;
            distance2 = (pic( i , j , 1) - Mu2(1,1))^2 + (pic( i , j , 2) - Mu2(1,2))^2 + (pic( i , j , 3) - Mu2(1,3))^2 + ( i/l1 * 256 - Mu2(1,4))^2  + ( j/l2 * 256 - Mu2(1,5))^2 ;

            if distance1 < distance2 
                out(i,j,:) = [1 0 0] ; 
                Mu1 = (k1* Mu1 + [ pic(i, j ,1) , pic(i,j,2) , pic(i,j,3), i/l1 * 256 , j/l2 *256] )/ (k1+1);
                k1 = k1 + 1;

            else
                out(i,j,:) = [1 1 1] ;
                Mu1 = (k2* Mu2 + [ pic(i, j ,1) , pic(i,j,2) , pic(i,j,3), i/l1 * 256 , j/l2 *256] )/ (k2+1);
                k2 = k2 + 1;

            end


        end

    end
    
    
end
k2
k1
out = uint8(out);



end