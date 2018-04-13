close all
clear all
clc
 
%% PCA_Test
[image1,p1,t1]=freadenvinew('C:\Users\Ren\Desktop\变化检测作业\first_matched.img');
[image3,p3,t3] = freadenvinew('C:\Users\Ren\Desktop\变化检测作业\second_cut.img');
image1 = reshape(image1,[608,1676,6]);
image2 = reshape(image3,[608,1676,6]);
% matlab中一行为sample，envi中一列为一个sample，这样需要进行矩阵的转置。
image_temp = zeros(608,1676);
image_temp2 = zeros(608,1676);
first_image= zeros(1676,608,6);
second_image= zeros(1676,608,6);
for i=1:6
    image_temp = image1(:,:,i);
    image_temp2 =image2(:,:,i);
    first_image(:,:,i) = image_temp';
    second_image(:,:,i) = image_temp2';
end
%% 协方差矩阵
[x,y,bands] = size(first_image);
pixels = x*y;
first_image_PCA = reshape(first_image,[pixels bands]);
correlation = (first_image_PCA'*first_image_PCA)/pixels;
%这里不知道要不要减去一

%% 计算特征值
[COEFF,SCORE,latent] = pca(correlation);

% 其中

%% 


% 参考文献http://www.cnblogs.com/leonwen/p/5122811.html
% https://www.cnblogs.com/chaosimple/p/3182157.html