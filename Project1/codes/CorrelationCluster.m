function out = CorrelationCluster (InputCorrMat, DistanceMeasure )
    l = size (InputCorrMat);
    distance1 = ones(l(1,2),l(1,2)) - abs(InputCorrMat) ;
    distance2 = triu(distance1,1) + tril (ones(l(1,2),l(1,2)));
    cluster = cell(1,l(1,2));  
    for j = 1 : l(1,2)
        cluster{1,j} = [j];
    end
        for i = 1 : l(1,2)
            m =    min(min(distance2));
            
            if( m > DistanceMeasure)
                break
            end
            [ row , col] =  find(distance2 == m );

            cluster{1,row} = [ cluster{1,row}, cluster{1,col} ,col];
            cluster{1,col} = {};

            for j =1:l(1,2)
                if (distance2 (row ,j)~=1 &&  j ~= col)
                    distance2 (row , j) = (distance2 (row , j) + distance2 (j,col))/2 ;
                    distance2 (j , row) = (distance2 (j , row) + distance2 (col,j))/2 ;
                end
            end
            distance2 (col , :) = 1 ;
            distance2 (: , col) = 1 ;

        end

for i = 1 : l(1,2)
     cluster{1,i} = unique(cluster{1,i});
end

out = cluster ;








end