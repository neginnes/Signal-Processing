function out = circle(A)

for n = 1:2
    for i = 3 : size(A,1)-3
        for j = 3 : size(A,2)-3
            
            if ( A(i,j)+ A(i-1,j-1)+ A(i-1,j) + A(i,j-1) + A(i+1,j) + A(i,j+1) + A(i+1,j+1)+A(i+1,j-1)+ A(i-1,j+1) >5)
                 if(A(i+1,j)+ A(i,j-1)+ A(i-1,j) + A(i+1,j-1) + A(i+2,j) + A(i+1,j+1) + A(i+2,j+1)+A(i+2,j-1)+ A(i,j+1) >5)
                     A(i+1,j) = 1 ;
                     A(i,j-1)=0;
                     A(i,j) =0;
                     A(i+1,j-1)=0;
                     A(i+2,j) =0;
                     A(i+1,j+1) =0;
                     A(i+2,j+1)=0;
                     A(i+2,j-1)=0;
                     A(i,j+1)=0;
                 end
                 if( A(i-1,j)+ A(i-2,j-1)+ A(i-2,j) + A(i-1,j-1) + A(i,j) + A(i-1,j+1) + A(i,j+1)+A(i,j-1)+ A(i-2,j+1) >5)
                     A(i-1,j) = 1 ;
                     A(i-2,j-1)=0;
                     A(i-2,j) =0;
                     A(i-1,j-1)=0;
                     A(i,j) =0;
                     A(i-1,j+1) =0;
                     A(i,j+1)=0;
                     A(i,j-1)=0;
                     A(i-2,j+1)=0;
                 end
                 if ( A(i,j-1)+ A(i-1,j-2)+ A(i-1,j-1) + A(i,j-2) + A(i+1,j-1) + A(i,j) + A(i+1,j)+A(i+1,j-2)+ A(i-1,j) >5)
                     A(i,j-1) = 1 ;
                     A(i-1,j-2)=0;
                     A(i-1,j-1) =0;
                     A(i,j-2)=0;
                     A(i+1,j-1) =0;
                     A(i,j) =0;
                     A(i+1,j)=0;
                     A(i+1,j-2)=0;
                     A(i-1,j)=0;
                 end
                 if ( A(i,j+1)+ A(i-1,j)+ A(i-1,j+1) + A(i,j) + A(i+1,j+1) + A(i,j+2) + A(i+1,j+2)+A(i+1,j)+ A(i-1,j+2) >5)
                     A(i,j+1) = 1 ;
                     A(i-1,j)=0;
                     A(i-1,j+1) =0;
                     A(i,j)=0;
                     A(i+1,j+1) =0;
                     A(i,j+2) =0;
                     A(i+1,j+2)=0;
                     A(i+1,j)=0;
                     A(i-1,j+2)=0;
                 end
                     
                 A(i,j) = 1 ;
                 A(i-1,j-1)=0;
                 A(i-1,j) =0;
                 A(i,j-1)=0;
                 A(i+1,j) =0;
                 A(i,j+1) =0;
                 A(i+1,j+1)=0;
                 A(i+1,j-1)=0;
                 A(i-1,j+1)=0;
            end
            
            



        end
    end
    
end

%out =  A;
out= size(find(A==1),1);

end
