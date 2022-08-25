%% FFT
clear all
close all
clc
s = load('y.mat');
x = s.y;
t = fft(x);
z = abs(t);
p = angle(t);
l = size(x);
n = 1:l(1,2);
figure('Name','FFT')
subplot(2,1,1);
plot (n,z);
title("|y[n]|");
xlabel("n");
grid on;

subplot(2,1,2);
plot (n,p);
title("phase y[n]");
xlabel("n");
grid on;

% diagnosing whether the fft is mirrored or not
ft = flip(z);
m =  z(1,2:end) - ft(1,1:end-1);
figure()
plot (n(2:end),m);
title(" y[n] - flipped y[n] ");
xlabel("n");
grid on;
% denoising the signal
tprime = fft(real(x));
ftprime = flip(abs(fft(real(x))));
zprime = abs(tprime);
pprime = angle(tprime);
mprime =  zprime(1,2:end) - ftprime(1,1:end-1);

figure('Name','denoised FFT')
subplot(3,1,1);
plot (n,zprime);
title("|y[n]|");
xlabel("n");
grid on;

subplot(3,1,2);
plot (n,pprime);
title("phase y[n]");
xlabel("n");
grid on;
subplot(3,1,3);
plot (n(2:end),mprime);
title(" y[n] - flipped y[n] ");
xlabel("n");
grid on;

%% Sampling
clear all
close all
clc
%aliasing_figure()
%% EEG
clear all
close all
clc
sub = load('subject1.mat');
s = sub.SubjectData;

% not filtered signals
SemiBandFFT(s(2,1:end),256,pi);
SemiBandFFT(s(3,1:end),256,pi);
SemiBandFFT(s(4,1:end),256,pi);
SemiBandFFT(s(5,1:end),256,pi);
SemiBandFFT(s(6,1:end),256,pi);
SemiBandFFT(s(7,1:end),256,pi);
SemiBandFFT(s(8,1:end),256,pi);
SemiBandFFT(s(9,1:end),256,pi);

%% first part of cutoff frequency and energy filtering
close all
clc
sub = load('subject1.mat');
s = sub.SubjectData;

A = SemiBandFFT_omittingDC (s(2,1:end),256,2*pi*40/256);
B = SemiBandFFT_omittingDC (s(3,1:end),256,2*pi*40/256);
C = SemiBandFFT_omittingDC (s(4,1:end),256,2*pi*40/256);
D = SemiBandFFT_omittingDC (s(5,1:end),256,2*pi*40/256);
E = SemiBandFFT_omittingDC (s(6,1:end),256,2*pi*40/256);
F = SemiBandFFT_omittingDC (s(7,1:end),256,2*pi*40/256);
G = SemiBandFFT_omittingDC (s(8,1:end),256,2*pi*40/256);
H = SemiBandFFT_omittingDC (s(9,1:end),256,2*pi*40/256);

close all
%energy in each cut frequency
P1 = ones(1,128);
P2 = ones(1,128);
P3 = ones(1,128);
P4 = ones(1,128);
P5 = ones(1,128);
P6 = ones(1,128);
P7 = ones(1,128);
P8 = ones(1,128);

for i = 0:40
P1(i+1) = (sum((SemiBandFFT_omittingDC (s(2,1:end),256,2*pi*i/256)))./sum(A)).^2;
close all
P2(i+1) = (sum((SemiBandFFT_omittingDC (s(3,1:end),256,2*pi*i/256)))./sum(B)).^2;
close all
P3(i+1) = (sum((SemiBandFFT_omittingDC (s(4,1:end),256,2*pi*i/256)))./sum(C)).^2;
close all
P4(i+1) = (sum((SemiBandFFT_omittingDC (s(5,1:end),256,2*pi*i/256)))./sum(D)).^2;
close all
P5(i+1) = (sum((SemiBandFFT_omittingDC (s(6,1:end),256,2*pi*i/256)))./sum(E)).^2;
close all
P6(i+1) = (sum((SemiBandFFT_omittingDC (s(7,1:end),256,2*pi*i/256)))./sum(F)).^2;
close all
P7(i+1) = (sum((SemiBandFFT_omittingDC (s(8,1:end),256,2*pi*i/256)))./sum(G)).^2;
close all
P8(i+1) = (sum((SemiBandFFT_omittingDC (s(9,1:end),256,2*pi*i/256)))./sum(H)).^2;
close all
end

figure('Name', 'channel 1')
k = 0 : 127 ;
stem (k , P1);
title(" part of whole energy per cutoff fruquency ");
xlabel("cutoff frequency(Hz)");


figure('Name', 'channel 2')
k = 0 : 127 ;
stem (k , P2);
title(" part of whole energy per cutoff fruquency ");
xlabel("cutoff frequency(Hz)");


figure('Name', 'channel 3')
k = 0 : 127 ;
stem (k , P3);
title(" part of whole energy per cutoff fruquency ");
xlabel("cutoff frequency(Hz)");




figure('Name', 'channel 4')
k = 0 : 127 ;
stem (k , P4);
title(" part of whole energy per cutoff fruquency ");
xlabel("cutoff frequency(Hz)");


figure('Name', 'channel 5')
k = 0 : 127 ;
stem (k , P5);
title(" part of whole energy per cutoff fruquency ");
xlabel("cutoff frequency(Hz)");


figure('Name', 'channel 6')
k = 0 : 127 ;
stem (k , P6);
title(" part of whole energy per cutoff fruquency ");
xlabel("cutoff frequency(Hz)");


figure('Name', 'channel 7')
k = 0 : 127 ;
stem (k , P7);
title(" part of whole energy per cutoff fruquency ");
xlabel("cutoff frequency(Hz)");


figure('Name', 'channel 8')
k = 0 : 127 ;
stem (k , P8);
title(" part of whole energy per cutoff fruquency ");
xlabel("cutoff frequency(Hz)");

%% filter 
close all
clc
sub = load('subject1.mat');
s = sub.SubjectData;
h = size(s);
sprime = s(2:9,1:end);
%omitting the mean
mm = mean(sprime');
m = (ones(8,h(1,2)));
for i=1:8
m(i,1:end) = ones(1,h(1,2)) .* mm(i);
end
sprime = sprime - m;
% %filtering

% a = BPF(200,5,35 ,256);
% sprime = (filter(a,1,sprime'))';
sprime = (bandpass(sprime',[1 35],256))';


s(2:9,:) = sprime ; 

A = SemiBandFFT_omittingDC (s(2,1:end),256,2*pi*40/256);
B = SemiBandFFT_omittingDC (s(3,1:end),256,2*pi*40/256);
C = SemiBandFFT_omittingDC (s(4,1:end),256,2*pi*40/256);
D = SemiBandFFT_omittingDC (s(5,1:end),256,2*pi*40/256);
E = SemiBandFFT_omittingDC (s(6,1:end),256,2*pi*40/256);
F = SemiBandFFT_omittingDC (s(7,1:end),256,2*pi*40/256);
G = SemiBandFFT_omittingDC (s(8,1:end),256,2*pi*40/256);
H = SemiBandFFT_omittingDC (s(9,1:end),256,2*pi*40/256);


%% reducing frequency and check it again

close all
clear all
clc
sub = load('subject1.mat');
s = sub.SubjectData;
h = size(s);
sprime = s(2:9,1:end);

%omitting the mean
mm = mean(sprime');
m = (ones(8,h(1,2)));
for i=1:8
m(i,1:end) = ones(1,h(1,2)) .* mm(i);
end
sprime = sprime - m;

%filtering
% a = BPF(200,5,35 ,256);
% sprime = (filter(a,1,sprime'))';
% 
% s(2:9,:) = sprime;

sprime = (bandpass(sprime',[1 35],256))';

s(2:9,:) = sprime ; 

i = 1:3:h(1,2);
reduced_s = s(:,i);

A = SemiBandFFT_omittingDC (reduced_s(2,1:end),256/3,6*pi*40/256);
B = SemiBandFFT_omittingDC (reduced_s(3,1:end),256/3,6*pi*40/256);
C = SemiBandFFT_omittingDC (reduced_s(4,1:end),256/3,6*pi*40/256);
D = SemiBandFFT_omittingDC (reduced_s(5,1:end),256/3,6*pi*40/256);
E = SemiBandFFT_omittingDC (reduced_s(6,1:end),256/3,6*pi*40/256);
F = SemiBandFFT_omittingDC (reduced_s(7,1:end),256/3,6*pi*40/256);
G = SemiBandFFT_omittingDC (reduced_s(8,1:end),256/3,6*pi*40/256);
H = SemiBandFFT_omittingDC (reduced_s(9,1:end),256/3,6*pi*40/256);

save('subject2','reduced_s');



%% comparing epoching after filter or before
clear all
close all
clc
x = 1:1000;
y = sin(20*x) + 0.1*sin(50*x);
a = BPF(100,10,30 ,100);
y1 = (filter(a,1,y'))';
subplot(1,2,1)
plot(x(200:1000), y1(200:1000));
title('filter first')
ylabel('sin(x)')
xlabel('x')
ylim([-2 2])


y2 = y1(200:1000);
a = BPF(100,10,30 ,100);
y2 = (filter(a,1,y2'))';
subplot(1,2,2)
plot(x(200:1000), y2);
title('filter second')
ylabel('sin(x)')
xlabel('x')
ylim([-2 2])

%% epoching

close all
clear all
clc

sub = load('subject2.mat');
s = sub.reduced_s;

BackwardSamples = ceil(200*256/3000);
ForwardSamples  = ceil(800*256/3000);

a = epoching (s(2:9,:), BackwardSamples, ForwardSamples, s(10,:));
save('epochdata','a');
 %A = SemiBandFFT_omittingDC ((a(7,:,1)),256/3,6*pi*40/256);
% B = SemiBandFFT_omittingDC ((a(77,:,1)),256/3,6*pi*40/256);
% C = SemiBandFFT_omittingDC ((a(777,:,1)),256/3,6*pi*40/256);

% through running the above commented code we estimate the pass bands :

y = freqband (a, 1, 10, 256/3);
 %A = SemiBandFFT_omittingDC ((y(7,:,1)),256/3,6*pi*40/256);
l = size (y);
r = zeros(l);
E = zeros(l(1,1),l(1,3));
for i = 1:l(1,3)
    for j = 1:l(1,1)
            r(j,:,i) = y(j,:,i).^2 ;
            E(j,i) = sum(r(j,:,i),2);
    end
end
save('Energy','E');

for k = 1:8
    plot(1:l(1,1),E(:,k));
    title(['channel ',num2str(k)],'Interpreter','latex');
    pause(0.5)
end

%% dinoising and reducing datas

clear all
close all
clc
sub = load('64channeldata.mat');
s = sub.data;


% not filtered data
% in this part I have just checked the plots of only 1 examine
SemiBandFFT_omittingDC(s(1,:,7),600,pi);
% for i = 1 : 63
% 
%     SemiBandFFT(s(i,:,7),600,pi);
%      
% 
% end 

%omitting the mean

 for i=1:1800
        s(:,i,:) = s(:,i,:)-mean (s,2);
 end


i = 1:5:1800;
reduced_s = s(:,i,:);
save('subject3','reduced_s');

%%  rxy matrix

clear all
close all
clc
sub = load('subject3.mat');
s = sub.reduced_s;
A = zeros(63,360*45);

for j = 1 : 63
    for i=1:44
        A(j,1:360*(i+1))=[A(j,1:360*i),s(j,:,i)];
    end
end

A(:,1:360)=[];

% A = concat of all experments signals in each channel

rxy = zeros(63,63);

for i = 1 :63 
    for j = 1:63
        
        rxy(i,j) = sum( (A( i,:)) .* (A(j,:)) ) / sqrt(   sum( A(i,:) .* A(i,:) ) * sum (A(j,:) .* A(j,:))  ) ;
        
    end
end


C = CorrelationCluster (rxy, 0.4);



 distance1 = ones(63,63) - abs(rxy) ; 
% distance2 = triu(distance1,1) + tril (ones(63,63));
% cluster = cell(1,63);  % rows are numbers of cluster and colums are the group inside each cluster
% for j = 1 : 63
%     cluster{1,j} = [j];
% end
%     for i = 1 :62
%         m =    min(min(distance2));
%         [ row , col] =  find(distance2 == m );
%         
%         cluster{1,row} = [ cluster{1,row}, cluster{1,col} ,col];
%         cluster{1,col} = {};
% 
%         for j =1:63
%             if (distance2 (row ,j)~=1 &&  j ~= col)
%                 distance2 (row , j) = (distance2 (row , j) + distance2 (j,col))/2 ;
%                 distance2 (j , row) = (distance2 (j , row) + distance2 (col,j))/2 ;
%             end
%         end
%         distance2 (col , :) = 1 ;
%         distance2 (: , col) = 1 ;
% 
%     end
%     
%     
%  C = {};
%     for i = 1: 62
%         cluster{1,i} = unique(cluster{1,i});
%         x = size(cluster{1,i});
%         if ( x(1,1) ~= 0  )
%                 C = {C,cluster{1,i}} ;
%            
%         end
%     end
%     C{:,1} = {};

% % C = cluster{1,62};
% %     for i = 1 :63
%         A = find(C==i);
%         h = size (A);   
%         if h(1,2)>1
%             for j = 2 : h(1,2)
%                C(A(1,2:h(1,2))) 
%                C(A(:,j)) = [];
%             end
%         end
%     end
%   
%% for our electrodes

clear all
close all
clc
sub = load('epochdata.mat');
s = sub.a;
A = zeros(8,88*2701);
for j = 1 : 8
    for i=1:2700
        A(j,1:88*(i+1))=[A(j,1:88*i),s(i,:,j)];
    end
end

A(:,1:88)=[];

% A = concat of all experments signals in each channel

rxy = zeros(8,8);

for i = 1 :8
    for j = 1:8
        
        rxy(i,j) = sum( (A( i,:)) .* (A(j,:)) ) / sqrt(   sum( A(i,:) .* A(i,:) ) * sum (A(j,:) .* A(j,:))  ) ;
        
    end
end


C = CorrelationCluster (rxy, 0.3);




