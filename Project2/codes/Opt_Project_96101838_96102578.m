%% Ford-Fulkerson Queue class implementation
clear; clc;

%set(0, 'RecursionLimit', 100000);
img1 = imread('img1.jpg');
img1 = imresize(img1, 0.2);
g = g_graph(img1);

%%

tic;
subplot(1, 3, 1);
imagesc(g(:, :, 1) + g(:, :, 2) + g(:, :, 3) + g(:, :, 4));
k = segmentation(g, 228);
subplot(1, 3, 2);
imagesc(k);
subplot(1, 3, 3);
image(img1);
toc;

%% K-Means
clear; clc

% Load Image
im1 = im2double(imread('img2.jpg'));                    
T = reshape(im1,size(im1,1)*size(im1,2),3);

% number of clusters
k = 2;
% random centers
c = T( ceil(rand(k,1)*size(T,1) ) ,:); 
% 1:k = distance from i'th cluster, k+1 = label, k+2 = distance
d_l   = zeros(size(T,1),k+2);                         
N_iteration   = 5; 

for n = 1:N_iteration 
    for i = 1:size(T,1)       
        % finding distance from i'th cluster for all nodes (i)
        for j = 1:k  
            d_l(i,j) = norm(T(i,:) - c(j,:));      
        end

        % find label and minimum distance
        [D, C] = min(d_l(i,1:k));
        d_l(i,k+1) = C;   
        d_l(i,k+2) = D;     
    end
   
    for i = 1:k
        % update centers
        tmp = find(d_l(:,k+1) == i);
        c(i,:) = mean(T(tmp,:));

        tmp = find(isnan(c(:,1)) == 1);
        for Ind = 1:size(tmp,1)
         c(tmp(Ind),:) = T(randi(size(T,1)),:);
        end
    end  
end

X = zeros(size(T));
for i = 1:k
    idx = find(d_l(:,k+1) == i);
    X(idx,:) = repmat(c(i,:),size(idx,1),1); 
end
T = reshape(X,size(im1,1),size(im1,2),3);

% Plotting
subplot(1,2,1);
imshow(im1); 
title('Orginal Photo');

subplot(1,2,2);
imshow(T); 
title('Segmented Photo')

%% Other Methods

%% Super pixel
clear; clc
im1 = double(importdata('img2.jpeg'));
[L,NumLabels] = superpixels(im1,4);

figure(1)
subplot(1,2,1);
imshow(uint8(im1)); 
title('Orginal Photo');

subplot(1,2,2);
imshow(label2rgb(L)); 
title('Segmented Photo')

%% Threshold method :)
clear; clc
im = double(importdata('img2.jpeg'));
im1 = im(:,:,3);
for T = 140:10:230
    im2 = im(:,:,3);
    im2(find(im1<=T)) = 0;
    im2(find(im1>T)) = 256;

    figure(1)
    subplot(1,2,1);
    imshow(uint8(im)); 
    title('Orginal Photo');

    subplot(1,2,2);
    imshow(uint8(im2));
    title(['Segmented Photo (T = ',num2str(T),')'])
    
    hold on
    pause(1)
end

%% Neural Net Clustering GUI
% clear; clc
% x = simplecluster_dataset;
% inputs = simplecluster_dataset;
% net = competlayer(6);
% net = train(net,inputs);
% view(net)
% outputs = net(inputs);
% classes = vec2ind(outputs);
% 
% nctool



