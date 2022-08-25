%% image processing algorithms
clear all
close all
clc 
% sobel 
tic ;

Ap = imread('im1.jpg');
A = rgb2gray(Ap);

gx = [-1 0 1; -2 0 2; -1 0 1];
gy = [-1 -2 -1; 0 0 0; 1 2 1];

Gx = conv2(A,gx,'same');
Gy = conv2(A,gy,'same');
B = sqrt(Gx.^2 + Gy.^2);

T = toc ;

figure()
imshow(uint8(B));

%% image processing algorithms
clear all
close all
clc 
Ap = imread('im1.jpg');
A = rgb2gray(Ap);
% kirsch
tic;
g1 = [ 5 5 5 ; -3 0 -3 ; -3 -3 -3 ];
g2 = [ 5 5 -3 ; 5 0 -3 ; -3 -3 -3 ];
g3 = [ 5 -3 -3 ; 5 0 -3 ; 5 -3 -3 ];
g4 = [ -3 -3 -3 ; 5 0 -3 ; 5 5 -3 ];
g5 = [ -3 -3 -3 ; -3 0 -3 ; 5 5 5 ];
g6 = [ -3 -3 -3 ; -3 0 5 ; -3 5 5 ];
g7 = [ -3 -3 5 ; -3 0 5 ; -3 -3 5 ];
g8 = [ -3 5 5 ; -3 0 5 ; -3 -3 -3 ];

G1 = conv2(A,g1,'same');
G2 = conv2(A,g1,'same');
G3 = conv2(A,g2,'same');
G4 = conv2(A,g3,'same');
G5 = conv2(A,g4,'same');
G6 = conv2(A,g5,'same');
G7 = conv2(A,g6,'same');
G8 = conv2(A,g7,'same');

B1 = max ( G1 , G2 );
B2 = max ( B1 , G3 );
B3 = max ( B2 , G4 );
B4 = max ( B3 , G5 );
B5 = max ( B4 , G6 );
B6 = max ( B5 , G7 );
B  = max ( B6 , G8 );

T = toc ;

figure()
imshow(uint8(B));

%% circle ditecting
clear all 
close all
clc

Ap = imread('circles.jpg');
A = rgb2gray(Ap);


gx = [-1 0 1; -2 0 2; -1 0 1];
gy = [-1 -2 -1; 0 0 0; 1 2 1];

Gx = conv2(A,gx,'same');
Gy = conv2(A,gy,'same');
B = sqrt(Gx.^2 + Gy.^2);
B = uint8(B);
B(find(B>180))=255;
B(find(B<70))=0;

tr1 = 1/7 * size(B,1);
tr2 = 1/7 * size(B,2);

B (1 : tr1 , : ) = 0 ;
B (end-tr1 :end , : ) = 0 ;
B (: , 1:tr2 ) = 0 ;
B (: , end-tr2:end) = 0 ;
show = zeros(size(B,1),size(B,2));
center = show;
for i = 25 : size(B,1)-25
    for j = 25 : size(B,2)-25
        for R = 10 : 20
                       
            if (i - R -  1 > 0  &&  j - R -  1 > 0  &&  i + R +  1 < size(B,1) && j + R +  1 < size(B,2))
                center (i,j) = sum(sum(B((i - R -  1 : i - R + 1) , j - R -  1 : j - R + 1))) + sum(sum(B((i + R -  1 : i + R + 1) , j + R -  1 : j + R + 1))) ;
            
                if (center(i,j)/R > 100)
                    show(i,j) = 1;
                end
            end
             
           
        end

    end
end
imshow(show);
k = circle(show);

%% with matlab functions
image = imread('circles.jpg');

im = edge(rgb2gray(image));

[center, rad] = imfindcircles(im,[10 30],'Sensitivity',0.86);
k = size(center,1);


%% denoising
close all
clear all
clc

A = imread('im.jpg');

Ag = imnoise(A,'gaussian');
Ap = imnoise(A,'poisson') ;
Asp = imnoise(A,'salt & pepper');
As = imnoise(A,'speckle');

% figure('Name', ' gaussian before' )
% imshow(Ag);
% figure('Name', ' poisson before' )
% imshow(Ap);
% figure('Name', ' s&p before' )
% imshow(Asp);
% figure('Name', ' speckle before' )
% imshow(As);


% guassian filter 
rg = 0;
rp = 0;
rsp =0;
rs = 0;
for i = 1 : 2 : 11
    for s = 0.1 : 0.1 : 10
        A1 = gaussianfilter(Ag,i,s);
        A2 = gaussianfilter(Ap,i,s);
        A3 = gaussianfilter(Asp,i,s);
        A4 = gaussianfilter(As,i,s);
        if ( (corr2(A(:,:,1),A1(:,:,1) ) + corr2(A(:,:,2),A1(:,:,2) ) + corr2(A(:,:,3),A1(:,:,3) ))/3 > rg )
            rg = (corr2(A(:,:,1),A1(:,:,1) ) + corr2(A(:,:,2),A1(:,:,2) ) + corr2(A(:,:,3),A1(:,:,3) ))/3;
            Bg = A1;
            sigmag = s;
            ng = i; 
        end
        if ( (corr2(A(:,:,1),A2(:,:,1) ) + corr2(A(:,:,2),A2(:,:,2) ) + corr2(A(:,:,3),A2(:,:,3) ))/3 > rp )
            rp = (corr2(A(:,:,1),A2(:,:,1) ) + corr2(A(:,:,2),A2(:,:,2) ) + corr2(A(:,:,3),A2(:,:,3) ))/3;
            Bp = A2;
            sigmap = s;
            np = i; 
        end
        if ( (corr2(A(:,:,1),A3(:,:,1) ) + corr2(A(:,:,2),A3(:,:,2) ) + corr2(A(:,:,3),A3(:,:,3) ))/3 > rsp )
            rsp = (corr2(A(:,:,1),A3(:,:,1) ) + corr2(A(:,:,2),A3(:,:,2) ) + corr2(A(:,:,3),A3(:,:,3) ))/3;
            Bsp = A3;
            sigmasp = s;
            nsp = i; 
        end
        if ( (corr2(A(:,:,1),A4(:,:,1) ) + corr2(A(:,:,2),A4(:,:,2) ) + corr2(A(:,:,3),A4(:,:,3) ))/3 > rs )
            rs = (corr2(A(:,:,1),A4(:,:,1) ) + corr2(A(:,:,2),A4(:,:,2) ) + corr2(A(:,:,3),A4(:,:,3) ))/3;
            Bs = A4;
            sigmas = s;
            ns = i; 
        end
        
    end
end

figure('Name', ' gaussian after G' )
imshow(Bg);

figure('Name', ' poisson after G' )
imshow(Bp);

figure('Name', ' s&p after G' )
imshow(Bsp);

figure('Name', ' speckle after G' )
imshow(Bs);

        
%%

% median filter 
rg = 0;
rp = 0;
rsp =0;
rs = 0;
for i = 1 : 2 : 11
        A1 = medianfilter(Ag,i);
        A2 = medianfilter(Ap,i);
        A3 = medianfilter(Asp,i);
        A4 = medianfilter(As,i);
        if ( (corr2(A(:,:,1),A1(:,:,1) ) + corr2(A(:,:,2),A1(:,:,2) ) + corr2(A(:,:,3),A1(:,:,3) ))/3 > rg )
            rg = (corr2(A(:,:,1),A1(:,:,1) ) + corr2(A(:,:,2),A1(:,:,2) ) + corr2(A(:,:,3),A1(:,:,3) ))/3;
            Bg = A1;
            ng = i; 
        end
        if ( (corr2(A(:,:,1),A2(:,:,1) ) + corr2(A(:,:,2),A2(:,:,2) ) + corr2(A(:,:,3),A2(:,:,3) ))/3 > rp )
            rp = (corr2(A(:,:,1),A2(:,:,1) ) + corr2(A(:,:,2),A2(:,:,2) ) + corr2(A(:,:,3),A2(:,:,3) ))/3;
            Bp = A2;
            np = i; 
        end
        if ( (corr2(A(:,:,1),A3(:,:,1) ) + corr2(A(:,:,2),A3(:,:,2) ) + corr2(A(:,:,3),A3(:,:,3) ))/3 > rsp )
            rsp = (corr2(A(:,:,1),A3(:,:,1) ) + corr2(A(:,:,2),A3(:,:,2) ) + corr2(A(:,:,3),A3(:,:,3) ))/3;
            Bsp = A3;
            nsp = i; 
        end
        if ( (corr2(A(:,:,1),A4(:,:,1) ) + corr2(A(:,:,2),A4(:,:,2) ) + corr2(A(:,:,3),A4(:,:,3) ))/3 > rs )
            rs = (corr2(A(:,:,1),A4(:,:,1) ) + corr2(A(:,:,2),A4(:,:,2) ) + corr2(A(:,:,3),A4(:,:,3) ))/3;
            Bs = A4;
            ns = i; 
        end
        
end

figure('Name', ' gaussian after Median' )
imshow(Bg);

figure('Name', ' poisson after Median' )
imshow(Bp);

figure('Name', ' s&p after Median' )
imshow(Bsp);

figure('Name', ' speckle after Median' )
imshow(Bs);

%% 
% mean filter

rg = 0;
rp = 0;
rsp =0;
rs = 0;
for i = 1 : 2 : 11
        A1 = meanfilter(Ag,i);
        A2 = meanfilter(Ap,i);
        A3 = meanfilter(Asp,i);
        A4 = meanfilter(As,i);
        if ( (corr2(A(:,:,1),A1(:,:,1) ) + corr2(A(:,:,2),A1(:,:,2) ) + corr2(A(:,:,3),A1(:,:,3) ))/3 > rg )
            rg = (corr2(A(:,:,1),A1(:,:,1) ) + corr2(A(:,:,2),A1(:,:,2) ) + corr2(A(:,:,3),A1(:,:,3) ))/3;
            Bg = A1;
            ng = i ;
        end
        if ( (corr2(A(:,:,1),A2(:,:,1) ) + corr2(A(:,:,2),A2(:,:,2) ) + corr2(A(:,:,3),A2(:,:,3) ))/3 > rp )
            rp = (corr2(A(:,:,1),A2(:,:,1) ) + corr2(A(:,:,2),A2(:,:,2) ) + corr2(A(:,:,3),A2(:,:,3) ))/3;
            Bp = A2;
            np = i ;
        end
        if ( (corr2(A(:,:,1),A3(:,:,1) ) + corr2(A(:,:,2),A3(:,:,2) ) + corr2(A(:,:,3),A3(:,:,3) ))/3 > rsp )
            rsp = (corr2(A(:,:,1),A3(:,:,1) ) + corr2(A(:,:,2),A3(:,:,2) ) + corr2(A(:,:,3),A3(:,:,3) ))/3;
            Bsp = A3;
            nsp = i ;
        end
        if ( (corr2(A(:,:,1),A4(:,:,1) ) + corr2(A(:,:,2),A4(:,:,2) ) + corr2(A(:,:,3),A4(:,:,3) ))/3 > rs )
            rs = (corr2(A(:,:,1),A4(:,:,1) ) + corr2(A(:,:,2),A4(:,:,2) ) + corr2(A(:,:,3),A4(:,:,3) ))/3;
            Bs = A4;
            ns = i ;
        end
        
end

figure('Name', ' gaussian after Mean' )
imshow(Bg);

figure('Name', ' poisson after Mean' )
imshow(Bp);

figure('Name', ' s&p after Mean' )
imshow(Bsp);

figure('Name', ' speckle after Mean' )
imshow(Bs);

%% k mean
clear all 
clc
A = imread('img1.jpg');
im =im2double(A);
l = size (im);
Im = reshape(im, l(1,1) * l(1,2),3 );
L = size(Im) ;

c1 =  ceil( rand (1) * L(1,1) ) ;
c2 =  ceil( rand (1) * L(1,1) ) ;

Mu1 = Im(c1,:) ; 
Mu2 = Im(c2,:) ;

distance = zeros( L(1,1) , 2);
g = zeros(L(1,1),2) ; 
M = [1 1 1];
Muprime = [0 0 0];
k = 0;
while (M~=Muprime)
    k = k+1;
    for i = 1 : L(1,1)
        distance(i,1) = ( Im(i,1) - Mu1(1,1) )^2 + ( Im(i,2) - Mu1(1,2) )^2 + ( Im(i,3) - Mu1(1,3) )^2 ;
        distance(i,2) = ( Im(i,1) - Mu2(1,1) )^2 + ( Im(i,2) - Mu2(1,2) )^2 + ( Im(i,3) - Mu2(1,3) )^2 ;
        if (distance(i,2) ~= distance(i,1))
            [row,col] = find(distance(i,:) == min( distance(i,:))) ;
            g(i) = col; 
        elseif (distance(i,2) ~= distance(i,1))
            g(i) = 1 ;
        end

    end
    M = (Mu1(1,1) - Mu2(1,1))^2 + (Mu1(1,2) - Mu2(1,2))^2 + (Mu1(1,3) - Mu2(1,3))^2 ;
    A = find(g == 1);
    Mu1 = mean (Im( A, : ));
    B = find(g == 2);
    Mu2 = mean (Im( B, : ));
    Muprime = (Mu1(1,1) - Mu2(1,1))^2 + (Mu1(1,2) - Mu2(1,2))^2 + (Mu1(1,3) - Mu2(1,3))^2;
end


X = zeros(size(Im));

A = find(g == 1);
l1 = size(A);
Im(A,:) = repmat([1 0 0],l1(1,1),1);

B = find(g == 2);
l2 = size(B);
Im(B,:) = repmat([0 0 0],l2(1,1),1);

im = reshape(Im,l(1,1),l(1,2),3);
imshow(im);

 %% Otsu
clear all
close all
clc
A1 = imread('img2.jpeg');
A = rgb2gray(A1);
h = imhist(A);
N = sum(h); 
Mu00 = 0;
w0 = 0;
m = 0;
t = 0 : 255;
Mu11 = t .* h/N;
for i = 1:256
    w1 = 1 - w0;
    if w0 > 0 && w1 > 0
        Mu1 = Mu11/w1 ;
        Mu0 = Mu00/w0 ;
        sigma = w0 * w1 * (Mu0 - Mu1)^2;
        if ( sigma >= m )
            tr = i;
            m = sigma ;
        end
    end
    w0 = w0 + h(i)/N;
    Mu00 = Mu00 + (i-1) * h(i);
end


A( find (A>=tr))= 0 ;
A( find (A ~=0)) = 255 ;
imshow(A);

%%

clear all
close all
clc
A1 = imread('img2.jpeg');
for j = 1 :3
    A = A1(:,:,j);
    h = imhist(A);
    N = sum(h); 
    Mu00 = 0;
    w0 = 0;
    m = 0;
    t = 0 : 255;
    Mu11 = t .* h/N;
    for i = 1:256
        w1 = 1 - w0;
        if w0 > 0 && w1 > 0
            Mu1 = Mu11/w1 ;
            Mu0 = Mu00/w0 ;
            sigma = w0 * w1 * (Mu0 - Mu1)^2;
            if ( sigma >= m )
                tr = i;
                m = sigma ;
            end
        end
        w0 = w0 + h(i)/N;
        Mu00 = Mu00 + (i-1) * h(i);
    end


A( find (A <tr))= 0 ;
A( find (A ~=0)) = 255 ;
end
imshow(A);
 
 
 
 
 
 

