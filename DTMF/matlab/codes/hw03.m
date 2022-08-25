%% Q1
clear all 
close all
clc
A = imread('pic1.png');
B = imread('pic2.png');

Y1 = fft2(A);
absY1 = abs(Y1);
angY1 = angle(Y1);


Y2 = fft2(B);
absY2 = abs(Y2);
angY2 = angle(Y2);

Z1 = ifft2(absY2 .* exp(i*angY1));
Z2 = ifft2(absY1 .* exp(i*angY2));

figure()
imshow(uint8(Z1));
figure()
imshow(uint8(Z2));

%% Q2
clear all
close all
clc

A = load('fmri.mat');
B = A.image;

imshowpair(B(:,:,1),B(:,:,2),'montage')
Im = B(:,:,2);
im = Im;
theta = 0;
X = 0 ;
Y = 0;
view = imref2d(size(Im));
corr = 0 ;

for x = -20 : -5
    percent = (x+20)/15 * 100
    for y = 0 : 20    
        for t = 0 : 360
            tr1 = affine2d([cosd(t) sind(t) 0 ; -sind(t) cosd(t) 0 ; 0 0 1]*[ 1 0 0 ; 0 1 0 ; x y 1]);
            im = imwarp(Im,tr1,'OutputView',view);

            if ( corr2(im,B(:,:,1)) > corr) 
                pic = im;
                corr = corr2(im,B(:,:,1)) ;
                theta = t ;
                X = x;
                Y = y;
            end
        end
    end
end

%% Q2 - for first degree accuracy
theta2 = theta;
X2 = X ;
Y2 = Y;
for x = X - 1 : 0.1 : X + 1
    percent = 100*(x - X + 1 )/2
    for y = Y-1 : 0.1 : Y + 1
        for t = theta - 1 : 0.1 : theta + 1
            
            tr1 = affine2d([cosd(t) sind(t) 0 ; -sind(t) cosd(t) 0 ; 0 0 1]*[ 1 0 0 ; 0 1 0 ; x y 1]);
            im = imwarp(Im,tr1,'OutputView',view);

            if ( corr2(im,B(:,:,1)) > corr)                
                corr = corr2(im,B(:,:,1)) ;
                pic = im ; 
                theta2 = t ;
                X2 = x;
                Y2 = y;
            end
        end
    end
end        
        
%% Q2 - for Second degree accuracy
thetaf = theta2;
Xf = X2 ;
Yf = Y2;
for x = X2 - 0.1 : 0.01 : X2 + 0.1
    percent = 100*(x - X2 +0.1 )/0.2
    for y = Y2-0.1 : 0.01 : Y2 + 0.1       
        for t = theta2 - 0.1 : 0.01 : theta2 + 0.1
            
            tr1 = affine2d([cosd(t) sind(t) 0 ; -sind(t) cosd(t) 0 ; 0 0 1]*[ 1 0 0 ; 0 1 0 ; x y 1]);
            im = imwarp(Im,tr1,'OutputView',view);

            if ( corr2(im,B(:,:,1)) > corr)                
                corr = corr2(im,B(:,:,1)) ;
                pic = im;
                thetaf = t ;
                Xf = x;
                Yf = y;
            end
        end
    end
end    
%% Q2 - for third degree accuracy
thetafinal = thetaf;
Xfinal = Xf ;
Yfinal = Yf;
for x = Xf - 0.01 : 0.001 : Xf + 0.01
    percent = 100*(x - Xf +0.01 )/0.02
    for y = Yf-0.01 : 0.001 : Yf + 0.01      
        for t = thetaf - 0.01 : 0.001 : thetaf + 0.01
            
            tr1 = affine2d([cosd(t) sind(t) 0 ; -sind(t) cosd(t) 0 ; 0 0 1]*[ 1 0 0 ; 0 1 0 ; x y 1]);
            im = imwarp(Im,tr1,'OutputView',view);

            if ( corr2(im,B(:,:,1)) > corr)                
                corr = corr2(im,B(:,:,1)) ;
                pic = im;
                thetafinal = t ;
                Xfinal = x;
                Yfinal = y;
            end
        end
    end
end 
%% Q2 - for plotting
close all
figure('Name','before aligning')
imshowpair(B(:,:,1),B(:,:,2),'montage')
figure('Name','after aligning')
imshowpair(B(:,:,1),pic,'montage')

figure('Name','fixed')
imshow(B(:,:,1))
figure('Name','moved')
imshow(pic)

%save('fmri_after_aligning','pic');

%% Q3

clear all
close all
clc

load('filter_697.mat');
load('filter_770.mat');
load('filter_852.mat');
load('filter_941.mat');
load('filter_1209.mat');
load('filter_1336.mat');
load('filter_1477.mat');
load('filter_1633.mat');



Fs = 8192 ;

[h1,w1] =  freqz( filter_697 );
[h2,w2] =  freqz( filter_770 );
[h3,w3] =  freqz( filter_852 );
[h4,w4] =  freqz( filter_941 );
[h5,w5] =  freqz( filter_1209 );
[h6,w6] =  freqz( filter_1336 );
[h7,w7] =  freqz( filter_1477);
[h8,w8] =  freqz( filter_1633 );

f1 = (Fs / (2*pi)) * w1 ;
f2 = (Fs / (2*pi)) * w2 ;
f3 = (Fs / (2*pi)) * w3 ;
f4 = (Fs / (2*pi)) * w4 ;
f5 = (Fs / (2*pi)) * w5 ;
f6 = (Fs / (2*pi)) * w6 ;
f7 = (Fs / (2*pi)) * w7 ;
f8 = (Fs / (2*pi)) * w8 ;


figure('Name','filters')
subplot(4,2,1)
semilogy(f1,abs(h1))
a1 = abs(h1);
m1 = f1( a1 == max(a1) );
title('filter 697')

subplot(4,2,2)
semilogy(f2,abs(h2))
a2 = abs(h2);
m2 = f2( a2 == max(a2) );
title('filter 770')

subplot(4,2,3)
semilogy(f3,abs(h3))
a3 = abs(h3);
m3 = f3( a3 == max(a3) );
title('filter 852')

subplot(4,2,4)
semilogy(f4,abs(h4))
a4 = abs(h4);
m4 = f4( a4 == max(a4) );
title('filter 941')


subplot(4,2,5)
semilogy(f5,abs(h5))
a5 = abs(h5);
m5 = f5( a5 == max(a5) );
title('filter 1209')

subplot(4,2,6)
semilogy(f6,abs(h6))
a6 = abs(h6);
m6 = f6( a6 == max(a6) );
title('filter 1336')

subplot(4,2,7)
semilogy(f7,abs(h7))
a7 = abs(h7);
m7 = f7( a7 == max(a7) );
title('filter 1478')

subplot(4,2,8)
semilogy(f8,abs(h8))
a8 = abs(h8);
m8 = f8( a8 == max(a8) );
title('filter 1633')


y1 = audioread('DialedSequence_SNR30dB.wav');
y2 = audioread('DialedSequence_SNR20dB.wav');
y3 = audioread('DialedSequence_SNR10dB.wav');
y4 = audioread('DialedSequence_SNR00dB.wav');
y5 = audioread('DialedSequence_NoNoise.wav');

l1 = size(y1);
l2 = size(y2);
l3 = size(y3);
l4 = size(y4);
l5 = size(y5);

n1 = 0 : 1/Fs : 1/Fs * (l1(1,1)-1) ; 
n2 = 0 : 1/Fs : 1/Fs * (l2(1,1)-1) ;
n3 = 0 : 1/Fs : 1/Fs * (l3(1,1)-1) ;
n4 = 0 : 1/Fs : 1/Fs * (l4(1,1)-1) ;
n5 = 0 : 1/Fs : 1/Fs * (l5(1,1)-1) ;

figure('Name','waves')

subplot(3,2,1)
plot(n1,y1);
title('wave1')
xlabel('t')

subplot(3,2,2)
plot(n2,y2);
title('wave2')
xlabel('t')

subplot(3,2,3)
plot(n3,y3);
title('wave3')
xlabel('t')

subplot(3,2,4)
plot(n4,y4);
title('wave4')
xlabel('t')

subplot(3,2,5)
plot(n5,y5);
title('wave5')
xlabel('t')

% denoising waves

y1_denoised = filter(filter_770,1,y1) + filter(filter_852,1,y1) + filter(filter_941,1,y1) + filter(filter_1209,1,y1) + filter(filter_1336,1,y1) + filter(filter_1477,1,y1) + filter(filter_1633,1,y1) + filter(filter_697,1,y1);
y2_denoised = filter(filter_770,1,y2) + filter(filter_852,1,y2) + filter(filter_941,1,y2) + filter(filter_1209,1,y2) + filter(filter_1336,1,y2) + filter(filter_1477,1,y2) + filter(filter_1633,1,y2) + filter(filter_697,1,y2);
y3_denoised = filter(filter_770,1,y3) + filter(filter_852,1,y3) + filter(filter_941,1,y3) + filter(filter_1209,1,y3) + filter(filter_1336,1,y3) + filter(filter_1477,1,y3) + filter(filter_1633,1,y3) + filter(filter_697,1,y3);
y4_denoised = filter(filter_770,1,y4) + filter(filter_852,1,y4) + filter(filter_941,1,y4) + filter(filter_1209,1,y4) + filter(filter_1336,1,y4) + filter(filter_1477,1,y4) + filter(filter_1633,1,y4) + filter(filter_697,1,y4);
y5_denoised = filter(filter_770,1,y5) + filter(filter_852,1,y5) + filter(filter_941,1,y5) + filter(filter_1209,1,y5) + filter(filter_1336,1,y5) + filter(filter_1477,1,y5) + filter(filter_1633,1,y5) + filter(filter_697,1,y5);
figure('Name','denoised waves')

subplot(3,2,1)
plot(n1,y1_denoised );
title('wave1')
xlabel('t')

subplot(3,2,2)
plot(n2,y2_denoised );
title('wave2')
xlabel('t')

subplot(3,2,3)
plot(n3,y3_denoised );
title('wave3')
xlabel('t')

subplot(3,2,4)
plot(n4,y4_denoised );
title('wave4')
xlabel('t')

subplot(3,2,5)
plot(n5,y5_denoised );
title('wave5')
xlabel('t')
%%
figure()
f1 = filter(filter_697,1,y1_denoised);
subplot(4,2,1)
plot(n1,f1 );
f2 = filter(filter_770,1,y1_denoised);
subplot(4,2,2)
plot(n1,f2 );
f3 = filter(filter_852,1,y1_denoised);
subplot(4,2,3)
plot(n1,f3 );
f4 = filter(filter_941,1,y1_denoised);
subplot(4,2,4)
plot(n1,f4 );
f5 = filter(filter_1209,1,y1_denoised);
subplot(4,2,5)
plot(n1,f5 );
f6 = filter(filter_1336,1,y1_denoised);
subplot(4,2,6)
plot(n1,f6 );
f7 = filter(filter_1477,1,y1_denoised);
subplot(4,2,7)
plot(n1,f7 );
f8 = filter(filter_1633,1,y1_denoised);
subplot(4,2,8)
plot(n1,f8 );


%%
% decodding y1

close all
clc

out = mute(y1_denoised,Fs);
% SemiBandFFT (y1_denoised(out(1):out(2)), Fs);
d = size (out);
for i = 1 : d(1,1)
    if(i~=1)
        SemiBandFFT (y1_denoised(out(i-1):out(i)), Fs);
    else
        SemiBandFFT (y1_denoised(1:out(i)), Fs);
    end
end
%%
% decodding y2

close all
clc

out = mute(y2_denoised,Fs);
d = size (out);
for i = 1 : d(1,1)
    if(i~=1)
        SemiBandFFT (y2_denoised(out(i-1):out(i)), Fs);
    else
        SemiBandFFT (y2_denoised(1:out(i)), Fs);
    end
end
%%
% decodding y3

close all
clc

out = mute(y3_denoised,Fs);
d = size (out);
for i = 1 : d(1,1)
    if(i~=1)
        SemiBandFFT (y3_denoised(out(i-1):out(i)), Fs);
    else
        SemiBandFFT (y3_denoised(1:out(i)), Fs);
    end
end

%%
% decodding y4

close all
clc

out = mute(y4_denoised,Fs);
d = size (out);
for i = 1 : d(1,1)
    if(i~=1)
        SemiBandFFT (y4_denoised(out(i-1):out(i)), Fs);
    else
        SemiBandFFT (y4_denoised(1:out(i)), Fs);
    end
end
%%
% decodding y5

close all
clc

out = mute(y5_denoised,Fs);
d = size (out);
for i = 1 : d(1,1)
    if(i~=1)
        SemiBandFFT (y5_denoised(out(i-1):out(i)), Fs);
    else
        SemiBandFFT (y5_denoised(1:out(i)), Fs);
    end
end

