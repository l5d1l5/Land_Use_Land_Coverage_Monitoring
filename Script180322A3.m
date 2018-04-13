%% 基于多时相数据的灰度差值法检测
%% 包括了进行PCA之后的差值图像
%% 以及没有进行PCA的差值图像 6个波段
clear all;
close all;
clc
[image1,p1,t1]=freadenvinew('C:\Users\Ren\Desktop\变化检测作业\first_matched.img');
[image3,p3,t3] = freadenvinew('C:\Users\Ren\Desktop\变化检测作业\second_cut.img');
image1 = reshape(image1,[608,1676,6]);
image2 = reshape(image3,[608,1676,6]);
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

ans = max(max(max(first_image(:,:,1))));
ans = min(min(min(first_image(:,:,1))));
%% 提取第一个图像的主成分
[m,n,l] = size(first_image);
pixels =m*n;
first_matrix = zeros(pixels,6);

for i=1:6
    tempimage01A = first_image(:,:,i);
    tempimage01B = zeros(pixels,l);
    first_matrix(:,i) = reshape(tempimage01A,[1019008,1]);
end
[coeff,score,latent,tsquared,explained] = pca(first_matrix);
[PC1,vary1,explained1]=pca(first_matrix);
Y = first_matrix*PC1;
first_image_PCA=zeros(1676,608,6);
for i=1:6
    first_image_PCA(:,:,i) = reshape(Y(:,i),[1676,608,1]);
end
% figure;imshow(first_image_PCA(:,:,1),[]);title('早期图像第一主成分');
% figure;imshow(first_image_PCA(:,:,2),[]);title('早期图像第一主成分');
% figure;imshow(first_image_PCA(:,:,3),[]);title('早期图像第一主成分');
% figure;imshow(first_image_PCA(:,:,4),[]);title('早期图像第一主成分');
% figure;imshow(first_image_PCA(:,:,5),[]);title('早期图像第一主成分');
% figure;imshow(first_image_PCA(:,:,6),[]);title('早期图像第一主成分');


%% 提取第二个图像的主成分

[m,n,l] = size(second_image);
pixels =m*n;
second_matrix = zeros(pixels,6);
for i=1:6
    tempimage01A = second_image(:,:,i);
    tempimage01B = zeros(pixels,l);
    second_matrix(:,i) = reshape(tempimage01A,[1019008,1]);
end
[coeff2,score2,latent2,tsquared2,explained2] = pca(second_matrix);
[PC2,vary2,explained3]=pca(second_matrix);
Y2 = second_matrix*PC2;
second_image_PCA=zeros(1676,608,6);
for i=1:6
    second_image_PCA(:,:,i) = reshape(Y2(:,i),[1676,608,1]);
end

%% 进行第一主成分的差值运算
matrix_sub = first_image_PCA(:,:,1) - second_image_PCA(:,:,1);
figure;histogram(matrix_sub);title('提取第一主成分并进行波段差值运算');

%% 绘制差值图像的一个灰度图

figure;histogram(matrix_sub,10,'BinMethod','sturges');
title('PCA第一主成分差值图像的灰度直方图');
axis([-255 ,255,0,300000]);
axis on;
grid on;
%% 
%% 第一个波段的差值，不进行PCA
figure;title('差值图像的灰度直方图');
matrix_first_sub  = first_image(:,:,1)-second_image(:,:,1);
subplot(2,3,1);histogram(matrix_first_sub,10,'BinMethod','sturges');
title('Band1','FontSize',10);
axis([-255 ,255,0,600000]);axis on;grid on;
% xlabel('灰度差值');ylabel('像元个数');
ans = max(max(max(matrix_first_sub)));
ans = min(min(min(matrix_first_sub)));
%% 第二个波段
matrix_second_sub  = first_image(:,:,2)-second_image(:,:,2);
subplot(2,3,2);histogram(matrix_second_sub,10,'BinMethod','sturges');
title('Band2','FontSize',10);
axis([-255,255,0,600000]);axis on;grid on;
% xlabel('灰度差值');ylabel('像元个数');


%% 第3个波段
matrix_three_sub  = first_image(:,:,3)-second_image(:,:,3);
subplot(2,3,3);histogram(matrix_three_sub,10,'BinMethod','sturges');
title('Band3','FontSize',10);
axis([-255 ,255,0,600000]);axis on;grid on;
% xlabel('灰度差值');ylabel('像元个数');

%% 第4个波段
matrix_four_sub  = first_image(:,:,4)-second_image(:,:,4);
subplot(2,3,4);histogram(matrix_four_sub,10,'BinMethod','sturges');
title('Band4','FontSize',10);
axis([-255,255,0,600000]);axis on;grid on;
% xlabel('灰度差值');ylabel('像元个数');

%% 第5个波段
matrix_five_sub  = first_image(:,:,5)-second_image(:,:,5);
subplot(2,3,5);histogram(matrix_five_sub,10,'BinMethod','sturges');
title('Band5','FontSize',10);
axis([-255,255,0,600000]);axis on;grid on;
% xlabel('灰度差值');ylabel('像元个数');

%% 第6个波段
matrix_six_sub  = first_image(:,:,6)-second_image(:,:,6);
subplot(2,3,6);histogram(matrix_six_sub,10,'BinMethod','sturges');
title('Band7','FontSize',10);
axis([-255,255,0,600000]);axis on;grid on;
% xlabel('灰度差值');ylabel('像元个数');
%% 计算平移之前的数据

A1 =max(max(matrix_first_sub));
A2 =max(max(matrix_second_sub));
A3 =max(max(matrix_three_sub));
A4 =max(max(matrix_four_sub));
A5 =max(max(matrix_five_sub));
A6 =max(max(matrix_six_sub));
B1 =min(min(matrix_first_sub));
B2 =min(min(matrix_second_sub));
B3 =min(min(matrix_three_sub));
B4 =min(min(matrix_four_sub));
B5 =min(min(matrix_five_sub));
B6 =min(min(matrix_six_sub));
C1 = mean(mean(matrix_first_sub(1:1676,1:608)));
C2 = mean(mean((matrix_second_sub(1:1676,1:608))));
C3 = mean(mean((matrix_three_sub(1:1676,1:608))));
C4 = mean(mean((matrix_four_sub(1:1676,1:608))));
C5 = mean(mean((matrix_five_sub(1:1676,1:608))));
C6 = mean(mean((matrix_six_sub(1:1676,1:608))));
D1 = std2(matrix_first_sub);
D2 = std2(matrix_second_sub);
D3 = std2(matrix_three_sub);
D4 = std2(matrix_four_sub);
D5 = std2(matrix_five_sub);
D6 = std2(matrix_six_sub);


%% 


%% 平移灰度直方图
%% 第一个波段的差值，平移
figure;
matrix_first_sub  = first_image(:,:,1)-second_image(:,:,1)+125;
subplot(2,3,1);histogram(matrix_first_sub,10,'BinMethod','sturges');
title('Band1','FontSize',10);
axis([0,255,0,600000]);axis on;grid on;
% xlabel('灰度差值');ylabel('像元个数');
%% 第二个波段
matrix_second_sub  = first_image(:,:,2)-second_image(:,:,2)+125;
subplot(2,3,2);histogram(matrix_second_sub,10,'BinMethod','sturges');
title('Band2','FontSize',10);
axis([0,255,0,600000]);axis on;grid on;
% xlabel('灰度差值');ylabel('像元个数');


%% 第3个波段
matrix_three_sub  = first_image(:,:,3)-second_image(:,:,3)+125;
subplot(2,3,3);histogram(matrix_three_sub,10,'BinMethod','sturges');
title('Band3','FontSize',10);
axis([0 ,255,0,600000]);axis on;grid on;
% xlabel('灰度差值');ylabel('像元个数');

%% 第4个波段
matrix_four_sub  = first_image(:,:,4)-second_image(:,:,4)+125;
subplot(2,3,4);histogram(matrix_four_sub,10,'BinMethod','sturges');
title('Band4','FontSize',10);
axis([0 ,255,0,600000]);axis on;grid on;
% xlabel('灰度差值');ylabel('像元个数');

%% 第5个波段
matrix_five_sub  = first_image(:,:,5)-second_image(:,:,5)+125;
subplot(2,3,5);histogram(matrix_five_sub,10,'BinMethod','sturges');
title('Band5','FontSize',10);
axis([0,255,0,600000]);axis on;grid on;
% xlabel('灰度差值');ylabel('像元个数');

%% 第6个波段
matrix_six_sub  = first_image(:,:,6)-second_image(:,:,6)+125;
subplot(2,3,6);histogram(matrix_six_sub,10,'BinMethod','sturges');
title('Band7','FontSize',10);
axis([ 0,255,0,600000]);axis on;grid on;

% xlabel('灰度差值');ylabel('像元个数');
%% 平移后的图像
figure;imshow(matrix_first_sub,[]);title('直方图平移之后的差值图像 BAND1','FontSize',14);
figure;imshow(matrix_second_sub,[]);title('直方图平移之后的差值图像 BAND2','FontSize',14);
figure;imshow(matrix_three_sub,[]);title('直方图平移之后的差值图像 BAND3','FontSize',14);
figure;imshow(matrix_four_sub,[]);title('直方图平移之后的差值图像 BAND4','FontSize',14);
figure;imshow(matrix_five_sub,[]);title('直方图平移之后的差值图像 BAND5','FontSize',14);
figure;imshow(matrix_six_sub,[]);title('直方图平移之后的差值图像 BAND6','FontSize',14);
%% 计算均值和方差
A1 =max(max(matrix_first_sub));
A2 =max(max(matrix_second_sub));
A3 =max(max(matrix_three_sub));
A4 =max(max(matrix_four_sub));
A5 =max(max(matrix_five_sub));
A6 =max(max(matrix_six_sub));
B1 =min(min(matrix_first_sub));
B2 =min(min(matrix_second_sub));
B3 =min(min(matrix_three_sub));
B4 =min(min(matrix_four_sub));
B5 =min(min(matrix_five_sub));
B6 =min(min(matrix_six_sub));
C1 = mean(mean(matrix_first_sub(1:1676,1:608)));
C2 = mean(mean((matrix_second_sub(1:1676,1:608))));
C3 = mean(mean((matrix_three_sub(1:1676,1:608))));
C4 = mean(mean((matrix_four_sub(1:1676,1:608))));
C5 = mean(mean((matrix_five_sub(1:1676,1:608))));
C6 = mean(mean((matrix_six_sub(1:1676,1:608))));
D1 = std2(matrix_first_sub);
D2 = std2(matrix_second_sub);
D3 = std2(matrix_three_sub);
D4 = std2(matrix_four_sub);
D5 = std2(matrix_five_sub);
D6 = std2(matrix_six_sub);

















